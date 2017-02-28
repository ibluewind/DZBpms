/**
 * Angular Calendar Controller
 */
App
.controller('calendarController', [function() {
	
	var self = this;
	var date = new Date();
	var numOfWeeks = getNumOfWeeks();
	var calendar;
	
	date.setDate(1);		// 1일로 설정
	date.setDate(1-date.getDay());		// 1일이 있는 주의 첫번재 날짜 구하기
	
	
	function getNumOfWeeks() {
		var date = new Date(), last;
		
		date.setDate(1);
		last = new Date();
		last.setDate(1);
		last.setMotn(last.getMonth() + 1);
		last.setDate(0);		// 마직날 날짜로 설정
		
		return Math.ceil((date.getDay() + last.getDate()) / 7);
	}
}]);