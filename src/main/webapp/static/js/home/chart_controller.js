App.controller('chartController', ['chartService', '$rootScope', function(chartService, $rootScope) {
	
	var self = this;
//	self.chartData = [];		/* 상태별 작업 현황 데이터 */
//	self.chartLabels = [];		/* 부서명 또는 사용자 명 */
	self.chartSeries = ['진행중', '완료', '지연'];
	self.chartColors = ['#4286f4', '#1df7cf', '#f7204b'];	/* 진행중, 완료, 지연 */
	
	/*self.chartData = [
		[3, 1, 1, 5, 0],	 진행중 Data 
		[7, 0, 4, 2, 3],	 완료 Data 
		[1, 2, 1, 0, 3]		 지연 Data 
	];
	
	self.chartLabels = ['인터넷개발팀', '모바일개발팀', '시너지개발팀', 'IT시스템팀', 'IT협력팀'];
	console.log('data: ', self.chartData);
	console.log('labels: ', self.chartLabels);*/
	/*
	 * 부서장이나 팀장인 경우에만 데이터를 가져오도록 서버에서 처리한다.
	 * javascript에서 처리하려면 $rootScope.loggedInUser가 세팅되어야 하는데, dashboard_controller.js에서 사용자 정보를 가져오는 시간과
	 * chart_controller.js에서 사용자 정보를 조회하려는 시간이 맞지 않으면, 여기서는 사용자 정보가 undefined로 처리되므로 사용할 수 없다.
	 * 따라서, 사용자의 권한에 따른 처리는 서버에서 처리하도록 한다.
	 */
	chartService.getReportData()
	.then(
		function(results) {
			self.chartData = results[0];
			self.chartLabels = results[1];
			console.log('data: ', self.chartData);
			console.log('labels: ', self.chartLabels);
		},
		function(err) {
			console.error('Error while fetching task report data');
		}
	);
}]);