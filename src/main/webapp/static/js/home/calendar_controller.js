/**
 * Angular Calendar Controller
 */
App
.controller('miniCalendarController', ['calendarService', 'calendarType', '$scope', '$rootScope', function(calendarService, calendarType, $scope, $rootScope) {
	
	var self = this;
	var today = new Date();
	
	self.currentDate = calendarService.currentDate = new Date();
	self.currentDate.setDate(1);
	self.filterOptions = calendarService.filterOptions;
	
	self.calendar = calendarService.getCalendar(today, calendarType.MONTH);
	self.isCurrentMonth = function(d) {
		return d.getMonth() == self.currentDate.getMonth();
	};
	self.isToday = function(d) {
		var today = new Date();
		var res = false;
		
		if (today.getDate() == d.getDate() && today.getMonth() == d.getMonth() && today.getYear() == d.getYear())		res = true;
		return res;
	};
	
	self.gotoPrevMonth = function() {
		self.currentDate.setMonth(self.currentDate.getMonth() - 1);
		self.calendar = calendarService.getCalendar(self.currentDate, calendarType.MONTH);
	};
	
	self.gotoNextMonth = function() {
		self.currentDate.setMonth(self.currentDate.getMonth() + 1);
		self.calendar = calendarService.getCalendar(self.currentDate, calendarType.MONTH);
	};
	
	self.selectDate = function($event, date) {
		console.log('date: ', date);
		$('.mini-calendar .calendar-cell').removeClass('selected');
		$($event.target).addClass('selected');
		calendarService.currentDate = date;
		$rootScope.$broadcast('changeCalendarView');
	};
	
	// Filters
	self.filterSchedule = function() {
		$rootScope.$broadcast('renderingCalendar');
	};
	
	/**
	 * 캘린더 보기 변경 처리
	 */
	$rootScope.$on('changeCalendarView', function() {
		if (self.currentDate.getMonth() != calendarService.currentDate.getMonth()) {
			self.currentDate = calendarService.currentDate
			self.calendar = calendarService.getCalendar(self.currentDate, calendarType.MONTH);
		}
	});
}])
.controller('calendarController', ['calendarService', 'calendarType', 'peekCalendarPopover', '$scope', '$rootScope', '$filter',
									function(calendarService, calendarType, peekCalendarPopover, $scope, $rootScope, $filter) {
	var self = this;
	var today = new Date();
	var calType = calendarType.MONTH;
	
	self.currentDate = calendarService.currentDate = new Date();
	self.scheduleList = [];
	self.weeks = [0, 1, 2, 3, 4, 5, 6];
	self.hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23];	// time-table의 ng-repeat를 위한 배열
	
	self.calendar = calendarService.getCalendar(today, calType);
	self.calendarTitle = self.currentDate.getFullYear() + '년 ' + (self.currentDate.getMonth() + 1) + '월 ';
	self.isCurrentMonth = function(d) {
		return d.getMonth() == self.currentDate.getMonth();
	};
	
	/**
	 * 일정의 시작화면은 항상 주단위 화면이다.
	 * 현재 주의 기간을 설정해서 일정 목록을 조회하여야 한다.
	 */
	var start = new Date();
	var end = new Date();
	start.setDate(start.getDate() - start.getDay());
	end.setDate(end.getDate() + (6 - end.getDay()));
	/*
	start.setDate(1);
	start.setDate(start.getDate() - start.getDay());
	
	end.setFullYear(end.getFullYear(), end.getMonth() + 1, 0);	// 해당 월의 마지막 날
	end.setDate(end.getDate() + (6 - end.getDay()));
	*/
	getScheduleList(start, end);
	setCalendarTitle();
	
	/**
	 * 일정 목록 가져오기
	 */
	function getScheduleList(start, end) {
		calendarService.getScheduleList(start, end)
		.then(
			function(list) {
				calendarService.scheduleList = list;
				calendarService.orgScheduleList = angular.copy(list);
				filteringScheduleList();
				renderingCalendar(self.scheduleList, self.calendar);
			},
			function(err) {
				console.error('Error while fetching schedule list');
			}
		);
	}
	
	/**
	 * 선택되어진 필터값으로 목록을 재정렬한다.
	 */
	function filteringScheduleList() {
		var list = angular.copy(calendarService.orgScheduleList);
		var plist = [], vlist = [], tlist = [];
		
		if (calendarService.filterOptions.own) {
			list = $filter('filter')(list, {userId: $rootScope.loggedInUser.userId});
		}
		
		if (calendarService.filterOptions.task)
			tlist = $filter('filter')(list, {type: 'T'});
		if (calendarService.filterOptions.vocation)
			vlist = $filter('filter')(list, {type: 'V'});
		if (calendarService.filterOptions.personal)
			plist = $filter('filter')(list, {type: 'P'});
		
		
		
		self.scheduleList = tlist.concat(vlist, plist);
	}
	/**
	 * 달력 보기 종류에 따라 표시할 제목을 달리한다.
	 */
	function setCalendarTitle() {
		var viewType = $('.calendar-view:visible').attr('id');
		
		switch (viewType) {
		case 'monthView':
			self.calendarTitle = self.currentDate.getFullYear() + '년 ' + (self.currentDate.getMonth() + 1) + '월 ';
			break;
		case 'weekView':
			var sunDay = angular.copy(self.currentDate);
			var satDay = angular.copy(self.currentDate);
			
			sunDay.setDate(sunDay.getDate() - sunDay.getDay());
			satDay.setDate(satDay.getDate() + (6 - satDay.getDay()));
			
			self.calendarTitle = sunDay.getFullYear() + '년 ' + (sunDay.getMonth() + 1) + '월 ' + sunDay.getDate() + '일'
			   + ' ~ ' + satDay.getFullYear() + '년 ' + (satDay.getMonth() + 1) + '월 ' + satDay.getDate() + '일';
			break;
		case 'dayView':
			self.calendarTitle = self.currentDate.getFullYear() + '년 ' + (self.currentDate.getMonth() + 1) + '월 ' + self.currentDate.getDate() + '일';
			break;
		}
	}
	
	/**
	 * 이전 다음 버튼의 동작은 현재 캘린더의 모양에 따라 처리 내용이 달라져야 한다.
	 * 월 단위 캘린더는 월별 이동
	 * 주 단위 캘린더는 주별 이동
	 * 일 단위 캘린더는 일별 이동
	 */
	self.gotoPrev = function() {
		// .calendar-view에서 현재 캘린더 종류 찾기
		var viewType = $('.calendar-view:visible').attr('id');
		var	start = new Date(), end = new Date();
		
		switch (viewType) {
		case calendarType.MONTHVIEW:
			self.currentDate.setDate(1);
			self.currentDate.setMonth(self.currentDate.getMonth() - 1);
			break;
		case calendarType.WEEKVIEW:
			self.currentDate.setDate(self.currentDate.getDate() - 7);
			break;
		case calendarType.DAYVIEW:
			self.currentDate.setDate(self.currentDate.getDate() - 1);
			break;
		}
		
		calendarService.currentDate = self.currentDate;
		$rootScope.$broadcast('changeCalendarView');
	};
	
	self.gotoNext = function() {
		var viewType = $('.calendar-view:visible').attr('id');
		
		switch (viewType) {
		case calendarType.MONTHVIEW:
			self.currentDate.setDate(1);
			self.currentDate.setMonth(self.currentDate.getMonth() + 1);
			break;
		case calendarType.WEEKVIEW:
			self.currentDate.setDate(self.currentDate.getDate() + 7);
			break;
		case calendarType.DAYVIEW:
			self.currentDate.setDate(self.currentDate.getDate() + 1);
			break;
		}
		
		calendarService.currentDate = self.currentDate;
		$rootScope.$broadcast('changeCalendarView');
	};
	
	self.goToday = function() {
		self.currentDate = new Date();
		calendarService.currentDate = self.currentDate;
		$rootScope.$broadcast('changeCalendarView');
	};
	
	self.isToday = function(d) {
		var today = new Date();
		var res = false;
		
		if (today.getDate() == d.getDate() && today.getMonth() == d.getMonth() && today.getYear() == d.getYear())		res = true;
		return res;
	};
	
	self.isCurrentMonth = function(d) {
		return d.getMonth() == self.currentDate.getMonth();
	};
	
	self.calendarViewChange = function($event, typeId) {
		var start, end;
		self.currentDate = new Date();
		
		$('.calendar-view').hide();
		
		// 선택된 버튼에 active 처리
		$('.btn-group .btn-default').removeClass('active');
		$($event.target).addClass("active");
		
		$('#'+typeId).show();
		
		calendarService.currentDate = self.currentDate;
		$rootScope.$broadcast('changeCalendarView');
	};
	
	self.peekCalendar = function() {
		peekCalendarPopover.show(self.currentDate)
		.then(
			function(date) {
				self.currentDate = date;
				// 월 단위 일정으로 표시한다.
				$('.calendar-view').hide();
				$('#monthView').show();
				calendarService.currentDate = self.currentDate;
				$rootScope.$broadcast('changeCalendarView');
			},
			function(err) {
				console.error('Error while display peek calendar popover');
			}
		);
	};
	
	
	/**
	 * 캘린더 타입이 변하거나, 캘린더의 날짜 이동이 발생하면 처리하는 이벤트이다.
	 * 시작, 종료 날짜를 캘린더 타입별로 구해서 self.calendar와 scheduleList를 반영한다.
	 */
	$rootScope.$on('changeCalendarView', function() {
		var type = $('.calendar-view:visible').attr('id');
		var start, end;
		
		$('.schedule-bar').remove();
		self.currentDate = calendarService.currentDate;
		
		start = new Date(self.currentDate.getTime());
		end = new Date(self.currentDate.getTime());
		
		switch(type) {
		case calendarType.MONTHVIEW:
			calType = calendarType.MONTH;
			
			start.setDate(1);
			self.currentDate = new Date(start.getTime());
			start.setDate(start.getDate() - start.getDay());
			
			end.setFullYear(end.getFullYear(), end.getMonth() + 1, 0);	// 해당 월의 마지막 날
			end.setDate(end.getDate() + (6 - end.getDay()));
			break;
		case calendarType.WEEKVIEW:
			calType = calendarType.WEEK;
			start.setDate(start.getDate() - start.getDay());
			end.setDate(end.getDate() + (6 - end.getDay()));
			self.currentDate = new Date(start.getTime());
			break;
		case calendarType.DAYVIEW:
			calType = calendarType.DAY;
			self.currentDate = new Date(start.getTime());
			break;
		}
		
		self.calendar = calendarService.getCalendar(self.currentDate, calType);
		getScheduleList(start, end);
		setCalendarTitle();
	});
	
	$rootScope.$on('changeSchedule', function() {
		$rootScope.$broadcast('changeCalendarView');
	});
	
	$rootScope.$on('renderingCalendar', function() {
		filteringScheduleList();
		renderingCalendar(self.scheduleList, self.calendar);
	});
}]);