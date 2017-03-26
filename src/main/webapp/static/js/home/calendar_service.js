App
.service('calendarService', ['calendarType', '$http', '$q', function(calendarType, $http, $q) {
	this.scheduleList = [];
	this.orgScheduleList = [];
	this.filterOptions = {
		own: false,
		task: true,
		vocation: true,
		personal: true
	};
	
	this.currentDate;
	
	this.getCalendar = function(currentDate, type) {
		var numOfWeeks = getNumberOfWeeks(currentDate, type);
		var calendar = new Array(numOfWeeks);
		var date = new Date(currentDate.getTime());
		
		this.currentDate = currentDate;
		
		// type에 맞춰서 달력을 가져온다.
		for (var i = 0; i < numOfWeeks; i++)
			calendar[i] = new Array();
		
		console.log('type: ', type);
		// 월, 주에 따른 처리 필요.
		if (type == calendarType.MONTH) {
			date.setDate(1);
			date.setDate(1 - date.getDay());
			date.setHours(0, 0, 0, 0);			// milliseconds까지 0으로 설정해야 한다.
		} else if (type == calendarType.WEEK) {
			date.setDate(date.getDate() - date.getDay());
		}
		
		for (var i = 0; i < numOfWeeks; i++) {
			for (var j = 0; type != calendarType.DAY && j < 7; j++) {
				calendar[i][j] = new Date(date.getTime());
				date.setDate(date.getDate() + 1);
			}
		}
		
		return calendar;
	};
	
	this.getScheduleList = function(start, end) {
		var deferred = $q.defer();
		console.log('start: ', start + ', end: ', end);
		$http.get('/bpms/rest/schedule', {params:{start: start.getTime(), end: end.getTime()}})
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.getSchedule = function(id) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/schedule/' + id)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	function getNumberOfWeeks(currentDate, type) {
		var date = new Date(currentDate.getTime()), next;
		
		if (type != calendarType.MONTH)	return 1;
		
		date.setDate(1);
		next = new Date(currentDate.getTime());
		next.setDate(1);
		next.setMonth(date.getMonth() + 1);
		next.setDate(0);
		
		return Math.ceil((date.getDay() + next.getDate()) / 7);
	}
}])
.service('peekCalendarPopover', ['$q', '$popover', '$rootScope', function($q, $popover, $rootScope) {

	var today = new Date();
	var scope = $rootScope.$new();
	var peekCal = $popover($('#peekCalendar'),
							{
								contentTemplate: '/bpms/home/peekcalendar',
								trigger: 'manual',
								scope:scope,
								autoClose:true,
								html: true,
								placement:'auto bottom'
							});
	var deferred;
	
	scope.currentYear = today.getFullYear();
	
	scope.prevYear = function() {
		scope.currentYear--;
	};
	
	scope.nextYear = function() {
		scope.currentYear++;
	};
	
	scope.selectMonth = function(month) {
		var date = new Date();
		
		date.setMonth(month);
		date.setYear(scope.currentYear);
		date.setDate(1);
		
		deferred.resolve(date);
		peekCal.hide();
	};
	
	var parentShow = peekCal.show;
	peekCal.show = function(currentDate) {
		scope.currentYear = currentDate.getFullYear();
		deferred = $q.defer();
		parentShow();
		return deferred.promise;
	};
	
	return peekCal;
}])
.directive('schedulePopover', ['$popover', '$http', '$q', '$rootScope', '$filter', 'calendarService', 'calendarType', 'deleteConfirm',
								function($popover, $http, $q, $rootScope, $filter, calendarService, calendarType, deleteConfirm) {
	return {
		restrict: 'A',
		link: function(scope, element, attr) {
			scope.schedule = {};
			var pop = $popover(element, {
				contentTemplate: '/bpms/home/registschedule',
				container: 'body',
				trigger: 'manual',
				autoClose:true,
				html: true,
				placement:'auto left',
				scope:scope,
				onShow: function() { element.addClass('selected');},
				onHide: function() { element.removeClass('selected'); initVariables();}
			}),
			list = $popover(element, {
				contentTemplate: '/bpms/home/listschedule',
				container: 'body',
				trigger: 'manual',
				autoClose:true,
				html: true,
				placement:'auto top',
				scope:scope,
				onShow: function() { element.addClass('selected');},
				onHide: function() { element.removeClass('selected'); initVariables();}
			});
			
			initVariables();
			
			function initVariables() {
				scope.schedule = {};
				scope.edit = true;
				scope.schedule.wholeDay = false;
			}
			
			function updateSchedule($target) {
				scope.edit = false;
				
				var schedule = {};
				var scheduleId = $target.data('schedule');
				
				calendarService.getSchedule(scheduleId)
				.then(
					function(data) {
						scope.schedule = data;
						console.log('schedule: ', scope.schedule);
						
						if (Math.ceil((data.endDate - data.startDate)/1000/60/60) >= 24)
							scope.schedule.wholeDay = true;	// 하루종일 일정
					},
					function(err) {
						$q.reject(err);
					}
				);
			}
			
			function insertSchedule(date, hours) {
				scope.schedule.startDate = new Date(date.getTime());
				scope.schedule.endDate = new Date(date.getTime());
				scope.schedule.content = "";
				scope.schedule.title = "";
				
				if (hours) {
					hours = hours.split(':');
					scope.schedule.startDate.setHours(hours[0], hours[1], hours[2]);
					scope.schedule.endDate = new Date(scope.schedule.startDate.getTime());
					scope.schedule.endDate.setMinutes(scope.schedule.startDate.getMinutes() + 30);
				} else {
					scope.schedule.startDate.setHours(9, 0, 0);
					scope.schedule.endDate.setHours(10, 0, 0);
				}
			}
			
			function showSchedules(date) {
				calendarService.getScheduleList(date, date)
				.then(
					function(list) {
						console.log('list: ', list);
						scope.list = list;
					},
					function(err) {
						console.error('Error while fetching schedule list');
					}
				);
			}
			
			scope.showPopover = function($event, date, hours) {
				var $target = $($event.target);
				var tagName = $target.get(0).tagName;
				
				console.log('target: ', $target);
				
				if (tagName == 'A' || tagName == 'TD') {
					updateSchedule($target);
					//$event.stopPropagation();
				} else if (tagName == 'SPAN' || (tagName == 'DIV' && $target.hasClass("time-content"))) {
					insertSchedule(date, hours);
					//$event.stopPropagation();
				} else if (tagName == 'ABBR' && $target.hasClass("info")) {
					showSchedules(date);
					list.show();
					$('.popover .arrow').hide();
					return false;
//					/$event.stopPropagation();
				} else {
					return false;
				}
					
				pop.show();
				$('.popover .arrow').hide();
			};
			
			function setSchedule() {
				console.log('title: ', scope.schedule.title + ', startDate: ', scope.schedule.startDate + ', endDate = ', scope.schedule.endDate);
				scope.schedule.type = "P";
				
				if (scope.schedule.wholeDay) {
					scope.schedule.startDate = new Date(scope.schedule.startDate);
					scope.schedule.endDate = new Date(scope.schedule.endDate);
					
					scope.schedule.startDate.setHours(0, 0, 0, 0);
					scope.schedule.endDate.setHours(23, 50, 0, 0);
				}
			}
			
			scope.saveSchedule = function() {
				setSchedule();
				console.log('schedule : ', scope.schedule);
				
				if (scope.schedule.id) {
					$http.put('/bpms/rest/schedule', scope.schedule)
					.then(
						function(response) {
							$rootScope.$broadcast('changeSchedule');
						},
						function(err) {
							$q.reject(err);
						}
					);
				} else {
					$http.post('/bpms/rest/schedule', scope.schedule)
					.then(
						function(response) {
							$rootScope.$broadcast('changeSchedule');
						},
						function(err) {
							$q.reject(err);
						}
					);
				}
				
				scope.closePopover();
			};
			
			scope.updateSchedule = function() {
				console.log('schedule: ', scope.schedule);
				scope.edit = true;
			};
			
			scope.deleteSchedule = function(id) {
				console.log('schedule: ', scope.schedule);
				deleteConfirm.show()
				.then(
					function(ans) {
						if (ans == 'yes') {
							console.log('id: ', id);
							$http.delete('/bpms/rest/schedule/' + id)
							.then(
								function(response) {
									$rootScope.$broadcast('changeSchedule');
								},
								function(err) {
									$q.reject(err);
								}
							);
						}
					},
					function(err) {
						console.log('Error while show delete confirm modal window');
					}
				);
				
				scope.closePopover();
			};
			
			scope.closePopover = function() {
				pop.hide();
			};
			
			scope.timeFilter = function(s) {
				if (Math.ceil((s.endDate - s.startDate)/1000/60/60) == 24)
					return "종일";
				return $filter('date')(s.startDate, 'HH시mm분');
			};
		}	// end of link:
	};
}]);