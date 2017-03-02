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
	self.isCurrentMonth = function(d) {
		return d.getMonth() == self.currentDate.getMonth();
	};
	
	self.gotoPrevMonth = function() {
		self.currentDate.setMonth(self.currentDate.getMonth() - 1);
		self.calendar = calendarService.getCalendar(self.currentDate);
	};
	
	self.gotoNextMonth = function() {
		self.currentDate.setMonth(self.currentDate.getMonth() + 1);
		self.calendar = calendarService.getCalendar(self.currentDate);
	};
	
	self.isToday = function(d) {
		var today = new Date();
		var res = false;
		
		if (today.getDate() == d.getDate())		res = true;
		console.log(res);
		return res;
	};
	
	self.isCurrentMonth = function(d) {
		return d.getMonth() == self.currentDate.getMonth();
	};
}]);