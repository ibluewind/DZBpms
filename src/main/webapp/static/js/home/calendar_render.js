/**
 * schedule list에 있는 내용을 일정 타입에 맞는 형식으로 표시한다.
 * 일정에 대한 타입별 모양은 class에 미리 정의한다. 기본 클래스명은 .schedule-bar이고
 * #monthView, #weekView, #dayView에 따라 변형되며, 각 타입별로 위치와 크기가 변형된다.
 */
var renderingSchedule = function(schedules) {
	var type = $('.calendar-view:visible').attr('id');
	var calendarType = angular.injector(['ng', 'bpmApp']).get('calendarType');		// calencarType constant 호출
	
	for (var i = 0; i < schedules.length; i++) {
		var s = schedules[i];
		var start = new Date(s.startDate);
		var end = new Date(s.endDate);
		var $scheduleBar = $('<p>').addClass('schedule-bar ' + s.type);
		var $target = findTargetElement(start);
		var left, right, top, width, height, lineHeight, dateDiff = 0, hourDiff = 0;
		var wholeDay = false;
		
		var numOfSchedules = getNumOfSchedulesAtDate(schedules, start, i);
		
		switch(type) {
		case calendarType.MONTHVIEW:
			left = start.getDay() * 14;
			right = (6 - end.getDay()) * 14;
			top = (getNumOfWeeks(start) - 1) * 140 + (20 * numOfSchedules) + numOfSchedules + 50;
			$scheduleBar.css({left: left + "%", right: right + "%", top: top + "px"});
			break;
		case calendarType.WEEKVIEW:
			dateDiff = Math.ceil((end.getTime() - start.getTime()) / (24 * 60 * 60 * 1000));
			hourDiff = Math.ceil((end.getTime() - start.getTime()) / 1000 / 60 / 60 * 60) / 30
			width = $target.width() * dateDiff;
			
			if (hourDiff < 48) {
				height = 20 * hourDiff;
				lineHeight = 1.5 * hourDiff;
				wholeDay = false;
			}
			else {
				height = 20;
				left = (start.getDay() + 1) * 12;
				wholeDay = true;
				lineHeight = 1.5;
				$target = $('#weekView .title-line');
				top = numOfSchedules * 20 + numOfSchedules + "px";
			}
			
			$target.height(44 + (numOfSchedules * 20) + numOfSchedules + "px");
			$scheduleBar.css({width: width + "px", height: height + "px", left:left + "%", "line-height":lineHeight + 'em', top:top, overflow:'hidden'});
			break;
		case calendarType.DAYVIEW:
			hourDiff = Math.ceil((end.getTime() - start.getTime()) / 1000 / 60 / 60 * 60) / 30
			console.log('hourDiff = ' + hourDiff);
			width = $target.width();
			
			if (hourDiff >= 48) {
				height = 20;
				lineHeight = 1.5;
				top = "44px";
			}
			else {
				height = 20 * hourDiff;
				lineHeight = 1.5 * hourDiff;
			}
			
			
			$scheduleBar.css({width:width + "px", height:height + "px", 'line-height':lineHeight + "em", top:top});
			break;
		}
		
		$scheduleBar.text(left + ":" + start.getDay() + ", "+ s.userName + ":" + s.title);
		
		console.log($target);
		$target.append($scheduleBar);
	}
};

var getNumOfWeeks = function(date) {
	var firstDay = angular.copy(date);
	
	firstDay.setDate(1);
	return Math.ceil((firstDay.getDay() + date.getDate()) / 7);
};

var getNumOfSchedulesAtDate = function(schedules, date, idx) {
	var number = 0;
	
	for (var i = 0; i < idx; i++) {
		var s = schedules[i];
		
		if (s.startDate <= date.getTime() && date.getTime() <= s.endDate) {
			number++;
		}
	}
	
	return number;
}

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