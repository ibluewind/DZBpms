/**
 * Angular Calendar Controller
 */
App
.controller('miniCalendarController', ['calendarService', function(calendarService) {
	
	var self = this;
	var today = new Date();
	
	self.currentDate = new Date();
	self.currentDate.setDate(1);
	
	self.calendar = calendarService.getCalendar(today);
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
		self.calendar = calendarService.getCalendar(self.currentDate);
	};
	
	self.gotoNextMonth = function() {
		self.currentDate.setMonth(self.currentDate.getMonth() + 1);
		self.calendar = calendarService.getCalendar(self.currentDate);
	};
}])
.controller('calendarController', ['calendarService', function(calendarService) {
	var self = this;
	var today = new Date();
	
	self.currentDate = new Date();
	self.currentDate.setDate(1);
	
	self.calendar = calendarService.getCalendar(today);
	self.calendarTitle = self.currentDate.getFullYear() + '년 ' + (self.currentDate.getMonth() + 1) + '월 ';
	self.isCurrentMonth = function(d) {
		return d.getMonth() == self.currentDate.getMonth();
	};
	
	/**
	 * 이전 다음 버튼의 동작은 현재 캘린더의 모양에 따라 처리 내용이 달라져야 한다.
	 * 월 단위 캘린더는 월별 이동
	 * 주 단위 캘린더는 주별 이동
	 * 일 단위 캘린더는 일별 이동
	 */
	self.gotoPrev = function() {
		// .calendar-view에서 현재 캘린더 종류 찾기
		var calType = $('.calendar-view:visible').attr('id');
		
		if (calType == 'monthView') {
			
		} else if (calType == 'weekView') {
			
		} else if (calType == 'dayView') {
			
		}
		self.currentDate.setMonth(self.currentDate.getMonth() - 1);
		self.calendar = calendarService.getCalendar(self.currentDate);
		self.calendarTitle = self.currentDate.getFullYear() + '년 ' + (self.currentDate.getMonth() + 1) + '월 ';
	};
	
	self.gotoNext = function() {
		self.currentDate.setMonth(self.currentDate.getMonth() + 1);
		self.calendar = calendarService.getCalendar(self.currentDate);
		self.calendarTitle = self.currentDate.getFullYear() + '년 ' + (self.currentDate.getMonth() + 1) + '월 ';
	};
	
	self.goToday = function() {
		self.currentDate = new Date();
		self.calendar = calendarService.getCalendar(self.currentDate);
		self.calendarTitle = self.currentDate.getFullYear() + '년 ' + (self.currentDate.getMonth() + 1) + '월 ';
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
	
	self.calendarViewChange = function(typeId) {
		$('.calendar-view').hide();
		
		if (typeId == '#dayView') {
			self.calendarTitle = self.currentDate.getFullYear() + '년 ' + (self.currentDate.getMonth() + 1) + '월 ' + self.currentDate.getDate() + '일';
		} else if (typeId == '#weekView') {
			var sunDay = angular.copy(self.currentDate);
			var satDay = angular.copy(self.currentDate);
			
			sunDay.setDate(sunDay.getDate() - sunDay.getDay());
			satDay.setDate(satDay.getDate() + (6 - satDay.getDay()));
			
			self.calendarTitle = sunDay.getFullYear() + '년 ' + (sunDay.getMonth() + 1) + '월 ' + sunDay.getDate() + '일'
							   + ' ~ ' + satDay.getFullYear() + '년 ' + (satDay.getMonth() + 1) + '월 ' + satDay.getDate() + '일';
		} else {
			self.calendarTitle = self.currentDate.getFullYear() + '년 ' + (self.currentDate.getMonth() + 1) + '월 ';
		}
		
		$(typeId).show();
		$(typeId).find('.scroll-container').height($(window).innerHeight() - $(typeId).offset().top - 2);
	};
}]);