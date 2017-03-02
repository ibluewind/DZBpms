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
});