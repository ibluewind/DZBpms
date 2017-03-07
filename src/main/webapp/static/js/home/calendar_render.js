/**
 * schedule list에 있는 내용을 일정 타입에 맞는 형식으로 표시한다.
 * 일정에 대한 타입별 모양은 class에 미리 정의하고, schedule_month, schedule_week, schedule_day로 정의한다.
 */
var renderingSchedule = function(schedules) {
	for (var i = 0; i < schedules.length; i++) {
		var s = schedules[i];
		var start = new Date(s.startDate);
		var end = new Date(s.endDate);
		var $scheduleBar = $('<p>').addClass('schedule_bar');
		var $target = findTargetElement(start);
		var left = start.getDay() * 14
		var right = (6 - end.getDay()) * 14;
		var top = (getNumOfWeeks(start) - 1) * 140 + 50;
		
		console.log($target);
		
		$scheduleBar.text(s.title);
		$scheduleBar.css({left: left + "%", right: right + "%", top: top + "px"});
		console.log($scheduleBar);
		$target.prepend($scheduleBar);
	}
};

var getNumOfWeeks = function(date) {
	var firstDay = angular.copy(date);
	
	firstDay.setDate(1);
	return Math.ceil((firstDay.getDay() + date.getDate()) / 7);
};

var findTargetElement = function(start) {
	var type = $('.calendar-view:visible').attr('id');
	var firstDay = angular.copy(start);
	var numOfWeeks, numOfDays, numOfHours, $target = null;
	
	firstDay.setDate(1);
	numOfWeeks = getNumOfWeeks(start);
	numOfDays = start.getDay();
	numOfHours = Math.floor(start.getHours() * 2 + (start.getMinutes() / 30));
	
	switch(type) {
	case 'monthView':
		$target = $($($('.calendar-view .calendar-row')[numOfWeeks]).find('span')[numOfDays]);
		break;
	case 'weekView':
		$target = $($($('.time-line:visible td')[numOfDays + 1]).find('.time-content')[numOfHours]);
		break;
	case 'dayView':
		$target = $($('.time-line:visible .time-content')[numOfHours]);
		break;
	}
	
	return $target;
};