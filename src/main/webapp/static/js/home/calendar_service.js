App
.service('calendarService', function() {
	this.getCalendar = function(currentDate) {
		var numOfWeeks = getNumberOfWeeks(currentDate);
		var calendar = new Array(numOfWeeks);
		var date = new Date(currentDate.getTime());
		
		for (var i = 0; i < numOfWeeks; i++)
			calendar[i] = new Array(7);
		
		date.setDate(1);
		date.setDate(1 - date.getDay());
		
		for (var i = 0; i < numOfWeeks; i++) {
			for (var j = 0; j < 7; j++) {
				calendar[i][j] = new Date(date.getTime());
				date.setDate(date.getDate() + 1);
			}
		}
		
		return calendar;
	};
	
	function getNumberOfWeeks(currentDate) {
		var date = new Date(currentDate.getTime()), next;
		date.setDate(1);
		next = new Date(currentDate.getTime());
		next.setDate(1);
		next.setMonth(date.getMonth() + 1);
		next.setDate(0);
		
		return Math.ceil((date.getDay() + next.getDate()) / 7);
	}
})
.service('peekCalendarPopover', ['$q', '$popover', '$rootScope', function($q, $popover, $rootScope) {

	var today = new Date();
	var scope = $rootScope.$new();
	var peekCal = $popover($('#peekCalendar'), {
												contentTemplate: '/bpms/home/peekcalendar',
												trigger: 'manual',
												scope:scope,
												autoClose:true,
												html: true,
												placement:'bottom'
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
}]);