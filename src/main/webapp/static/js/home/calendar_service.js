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
	
	this.getCalendar = function(currentDate, type) {
		var numOfWeeks = getNumberOfWeeks(currentDate, type);
		var calendar = new Array(numOfWeeks);
		var date = new Date(currentDate.getTime());
		
		// type에 맞춰서 달력을 가져온다.
		for (var i = 0; i < numOfWeeks; i++)
			calendar[i] = new Array();
		
		// 월, 주에 따른 처리 필요.
		date.setDate(1);
		date.setDate(1 - date.getDay());
		date.setHours(0, 0, 0, 0);			// milliseconds까지 0으로 설정해야 한다.
		
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
.directive('schedulePopover', ['$popover', '$http', '$q', function($popover, $http, $q) {
	return {
		restrict: 'A',
		link: function(scope, element, attr) {
			var pop = $popover(element, {
				contentTemplate: '/bpms/home/registschedule',
				trigger: 'manual',
				autoClose:true,
				html: true,
				placement:'auto top',
				animation: "am-flip-x",
				scope:scope
			});
			
			scope.showPopover = function(date) {
				console.log(date);
				scope.startDate = date;
				scope.endDate = date;
				scope.title = "제목";
				scope.content = "";
				pop.show();
			};
			
			scope.saveSchedule = function() {
				var schedule = {};
				
				schedule.title = scope.title;
				schedule.startDate = scope.startDate;
				schedule.endDate = scope.endDate;
				schedule.type = "P";
				schedule.content = scope.content;
				
				$http.post('/bpms/rest/schedule', schedule)
				.then(
					function(response) {
						console.log('saved schedule: ', response.data);
					},
					function(err) {
						$q.reject(err);
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