App.controller('chartController', ['chartService', function(chartService) {
	
	var self = this;
//	self.chartData = [];		/* 상태별 작업 현황 데이터 */
//	self.chartLabels = [];		/* 부서명 또는 사용자 명 */
	self.chartSeries = ['진행중', '완료', '지연'];
	self.chartColors = ['#4286f4', '#1df7cf', '#f7204b'];	/* 진행중, 완료, 지연 */
	
	self.chartData = [
		[3, 1, 1, 5, 0],
		[7, 0, 4, 2, 3],
		[1, 2, 1, 0, 3]		
	];
	
	self.chartLabels = ['인터넷개발팀', '모바일개발팀', '시너지개발팀', 'IT시스템팀', 'IT협력팀'];
	console.log('data: ', self.chartData);
	console.log('labels: ', self.chartLabels);
	/*
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
	*/
}]);