/**
 * schedule list에 있는 내용을 일정 타입에 맞는 형식으로 표시한다.
 * 일정에 대한 타입별 모양은 class에 미리 정의한다. 기본 클래스명은 .schedule-bar이고
 * #monthView, #weekView, #dayView에 따라 변형되며, 각 타입별로 위치와 크기가 변형된다.
 */
var CALENDAR, calendarType;
var renderingCalendar = function(schedules, calendar) {
	var type = $('.calendar-view:visible').attr('id');
	
	CALENDAR = calendar;
	calendarType = angular.injector(['ng', 'bpmApp']).get('calendarType');		// calencarType constant 호출

	// 일정막대 초기화
	$('abbr.schedule-bar').remove();
	
	for (var i = 0; i < schedules.length; i++) {
		var s = schedules[i];
		var start = new Date(s.startDate);
		var end = new Date(s.endDate);
		var $scheduleBar = $('<abbr>').addClass('schedule-bar ' + s.type);
		var $target = findTargetElement(start);
		var left, right, top, width, height, lineHeight, dateDiff = 0, hourDiff = 0;
		var wholeDay = false;
		
		var numOfSchedules = getNumOfSchedulesAtDate(schedules, start, i);		// 중복되는 일정의 갯수
		var numOfChildren = 0;													// 같은 날 일정의 갯수 (루프를 돌 때마다 값이 변한다.)
		
		switch(type) {
		case calendarType.MONTHVIEW:
			left = start.getDay() * 14 + 1;
			right = (6 - end.getDay()) * 14;
			top = (getNumOfWeeks(start) - 1) * 140 + (20 * numOfSchedules) + numOfSchedules + 50;
			$scheduleBar.css({left: left + "%", right: right + "%", top: top + "px"});
			break;
		case calendarType.WEEKVIEW:
			dateDiff = Math.ceil((end.getTime() - start.getTime()) / (24 * 60 * 60 * 1000));
			hourDiff = Math.ceil((end.getTime() - start.getTime()) / 1000 / 60 / 60 * 60) / 30
			width = $target.width() * dateDiff;
			
			/**
			 * 종일 일정인지를 확인한다.
			 * 종일 일정인 경우에는 시간 구분에 표시않고, .schedule-bar-area에 표시한다.
			 * 일정의 위치는 .schedule-bar-area의 <span> 위치이고 같은 요일에 중복되는 일정에 대한 top 값을 구한다.
			 */
			if (hourDiff < 48) {
				height = 20 * hourDiff;
				lineHeight = 1.5 * hourDiff;
				wholeDay = false;
			}
			else {
				height = 20;
				wholeDay = true;
				lineHeight = 1.5;
				// 종일 일정인 경우에는 타임라인이 아닌 schedule-bar-area에 표시한다.
				$target = $($('#weekView .schedule-bar-area span')[start.getDay() + 1]);
				numOfChildren = $target.children('abbr').length;		// 같은 날짜칸에 있는 일정막대의 갯수
				top =  (numOfSchedules - numOfChildren) * 20 + numOfSchedules + "px";
			}
			
			$('#weekView .schedule-bar-area').height((numOfSchedules + 1) * 20 + numOfSchedules + "px");
			$scheduleBar.css({width: width + "px", height: height + "px", left:left + "%", "line-height":lineHeight + 'em', top:top, overflow:'hidden'});
			break;
		case calendarType.DAYVIEW:
			hourDiff = Math.ceil((end.getTime() - start.getTime()) / 1000 / 60 / 60 * 60) / 30
			width = $target.width();
			
			if (hourDiff >= 48) {
				$target = $('#dayView .schedule-bar-area');
				left = "12%";
				height = 20;
				lineHeight = 1.5;
			}
			else {
				height = 20 * hourDiff;
				lineHeight = 1.5 * hourDiff;
			}
			
			$scheduleBar.css({left:left, width:width + "px", height:height + "px", 'line-height':lineHeight + "em", top:top});
			break;
		}
		
		$scheduleBar.text(s.userName + ":" + s.title);
		$scheduleBar.attr("title", s.userName + ":" + s.title);
		
		$target.append($scheduleBar);
		
	}
	
	/**
	 * 일정 영역 높이 조정
	 */
	if (type != calendarType.MONTHVIEW) {
		var $container = $('#'+type).find('.scroll-container');
		$container.height($(window).innerHeight() - $container.offset().top - 2);	// 일정의 뷰의 높이 조정
	}
};

/**
 * 현재 보이는 달력에서 몇번째 주인가를 확인해야한다.
 * 일정이 속한 월의 주를 계산하게되면, 마지막 주에 있는 일정은 다음달 첫번째 주에 표시되어야 하는데
 * 다음달의 마지막 주의 위치에 표시되게 된다.
 */
var getNumOfWeeks = function(date) {
	var type = $('.calendar-view:visible').attr('id');
	var numOfWeeks = 0;
	
	if (type != calendarType.MONTHVIEW)		return 1;
	
	for (;numOfWeeks < CALENDAR.length; numOfWeeks++) {
		if (CALENDAR[numOfWeeks][0].getTime() <= date.getTime() && date.getTime() <= CALENDAR[numOfWeeks][6].getTime()) {
			break;
		}
	}
	return numOfWeeks + 1;
};

/**
 * date에 일정이 몇개인지 카운트 한다.
 * 단, 시:분:초는 비교 대상에서 제외하여야 한다. 시:분:초까지 비교하면 같은 날짜의 일정이지만, 고려되지 않을 수 있다.
 */
var getNumOfSchedulesAtDate = function(schedules, date, idx) {
	var number = 0;
	
	for (var i = 0; i < idx; i++) {
		var s = schedules[i];
		
		s.startDate = resetHoursMinutesSeconds(s.startDate);
		s.endDate = resetHoursMinutesSeconds(s.endDate);
		
		if (s.startDate <= date.getTime() && date.getTime() <= s.endDate) {
			number++;
		}
	}

	return number;
}

var resetHoursMinutesSeconds = function(date) {
	date = new Date(date);
	date.setHours(0);
	date.setMinutes(0);
	date.setSeconds(0);
	
	return date;
}

/**
 * 시작 일정이 표시될 엘레먼트를 달력 종류별로 찾는다.
 */
var findTargetElement = function(start) {
	var type = $('.calendar-view:visible').attr('id');
	var firstDay = angular.copy(start);
	var numOfWeeks, numOfDays, numOfHours, $target = null;
	
	firstDay.setDate(1);
	numOfWeeks = getNumOfWeeks(start);
	numOfDays = start.getDay();
	numOfHours = Math.floor(start.getHours() * 2 + (start.getMinutes() / 30));
	
	switch(type) {
	case calendarType.MONTHVIEW:
		/*
		 * 월별 일정은 몇번째 주 무슨 요일인지로 타멧을 찾는다.
		 */
		$target = $($($('#monthView .calendar-row')[numOfWeeks]).find('span')[numOfDays]);
		break;
	case calendarType.WEEKVIEW:
		/*
		 * .time-line은 주별, 일별 일정에서 사용하므로 현재 보여지는 .time-line에서 해당 요일을 찾는다.
		 * 요일 구분은 <td>로 되어 있으므로 요일 순번의 <td>를 찾고, 일정 시작 시간의 위치를 찾는다.
		 */
		$target = $($($('.time-line:visible td')[numOfDays + 1]).find('.time-content')[numOfHours]);
		break;
	case calendarType.DAYVIEW:
		/*
		 * 일별 일정은 시간만 표시하므로 시간을 구분하는 .time-content의 순번을 찾는다.
		 */
		$target = $($('.time-line:visible .time-content')[numOfHours]);
		break;
	}
	
	return $target;
};