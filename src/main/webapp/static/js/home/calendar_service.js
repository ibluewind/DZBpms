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
		
		$http.get('/bpms/rest/schedule', {params:{start: start, end: end}})
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
								placement:'auto bottom',
								animation: "am-flip-x"
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
.directive('schedulePopover', ['$popover', '$http', '$q', '$rootScope', 'calendarService', 'calendarType', 'deleteConfirm',
								function($popover, $http, $q, $rootScope, calendarService, calendarType, deleteConfirm) {
	return {
		restrict: 'A',
		link: function(scope, element, attr) {
			var schedule = {}, wholeDay = false;
			var pop = $popover(element, {
				contentTemplate: '/bpms/home/registschedule',
				container: 'body',
				trigger: 'manual',
				autoClose:true,
				html: true,
				placement:'auto left',
				animation: "am-flip-x",
				scope:scope,
				onShow: function() { element.addClass('selected');},
				onHide: function() { element.removeClass('selected');}
			});
			
			scope.eidt = false;
			
			function updateSchedule($target) {
				scope.edit = true;
				
				var schedule = {};
				var scheduleId = $target.data('schedule');
				
				calendarService.getSchedule(scheduleId)
				.then(
					function(data) {
						schedule = data;
						scope.scheduleId = scheduleId;
						scope.title = schedule.title;
						scope.startDate = schedule.startDate;
						scope.endDate = schedule.endDate;
						scope.content = schedule.content;
						
						if (Math.ceil((schedule.endDate.getTime() - schedule.startDate.getTime())/1000/60/60) == 24)
							wholeDay = true;	// 하루종일 일정
					},
					function(err) {
						$q.reject(err);
					}
				);
			}
			
			function insertSchedule(date, hours) {
				scope.startDate = new Date(date.getTime());
				scope.endDate = new Date(date.getTime());
				scope.content = "";
				scope.title = "";
				
				scope.hasHours = true;
					
				if (hours) {
					hours = hours.split(':');
					scope.startDate.setHours(hours[0], hours[1], hours[2]);
					scope.endDate = new Date(scope.startDate.getTime());
					scope.endDate.setMinutes(scope.startDate.getMinutes() + 30);
				} else {
					scope.startDate.setHours(9, 0, 0);
					scope.endDate.setHours(10, 0, 0);
				}
			}
			
			scope.showPopover = function($event, date, hours) {
				var $target = $($event.target);
				
				console.log('target: ', $target);
				
				if ($target.get(0).tagName == 'A')
					updateSchedule($target);
				else
					insertSchedule(date, hours);
				
				pop.show();
			};
			
			function setSchedule() {
				var s = {};
				
				s.title = $(title).val();			//??? 왜 이런지는 모르겠으나, 이렇게해야 입력된 내용을 가져 올 수 있다. 뭐지? (폼의 ID 값을 사용해서 값을 가져온다. 결론은 ng-model은 아무 의미가 없다...)
				s.startDate = $(start).val();
				s.endDate = $(end).val();
				s.type = "P";
				s.content = $(content).val();
				
				if (wholeDay) {
					s.startDate = new Date(s.startDate += " 00:00:00");
					s.endDate = new Date(s.endDate += " 23:50:00");
				} else {
					s.startDate = new Date(s.startDate += (" " + $(startHours).val() + ":00"));
					s.endDate = new Date(s.endDate += (" " + $(endHours).val() + ":00"));
				}
				
				return s;
			}
			
			scope.saveSchedule = function() {
				schedule = setSchedule();
				console.log('schedule : ', schedule);
				
				$http.post('/bpms/rest/schedule', schedule)
				.then(
					function(response) {
						$rootScope.$broadcast('changeSchedule');
					},
					function(err) {
						$q.reject(err);
					}
				);
				
				scope.closePopover();
			};
			
			scope.updateSchedule = function() {
				schedule = setSchedule();
				schedule.id = scope.scheduleId;
				
				$http.put('/bpms/rest/schedule', schedule)
				.then(
					function(response) {
						$rootScope.$broadcast('changeSchedule');
					},
					function(err) {
						$q.reject(err);
					}
				);
				
				scope.closePopover();
			};
			
			scope.deleteSchedule = function() {
				deleteConfirm.show()
				.then(
					function(ans) {
						if (ans == 'yes') {
							console.log('id: ', scope.scheduleId);
							$http.delete('/bpms/rest/schedule/' + scope.scheduleId)
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
		}
	};
}]);