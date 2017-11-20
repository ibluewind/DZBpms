App.controller('chartController', ['chartService', '$location', '$rootScope', function(chartService, $location, $rootScope) {
	
	var self = this;
	self.chartSeries = ['진행중', '완료', '지연'];
	self.chartColors = ['#4286f4', '#1df7cf', '#f7204b'];	/* 진행중, 완료, 지연 */

	/*
	 * 부서장이나 팀장인 경우에만 데이터를 가져오도록 서버에서 처리한다.
	 */
	chartService.getReportData()
	.then(
		function(results) {
			console.log("results: ", results);
			if (results == "")	return;
			self.chartData = results[0];
			self.chartLabels = results[1];
			self.chartIds = results[2];
		},
		function(err) {
			console.error('Error while fetching task report data');
		}
	);
	
	function getIdByName(name) {
		var idx = self.chartLabels.indexOf(name);
		return self.chartIds[idx];
	}
	
	self.onClick = function(points, evenvt) {
		console.log(points, event);
		var name = points[0]._model.label;
		var id = getIdByName(name);
		var regex = "^[_a-z0-9]+(.[_a-z0-9]+)*@(?:\\w+\\.)+\\w+$";
		
		console.log('id: ' + id);
		if (id.match(regex) == null) {
			console.log('fetch chart data for individual person');
			chartService.getReportDataById(id)
			.then(
				function(results) {
					self.chartData = results[0];
					self.chartLabels = results[1];
					self.chartIds = results[2];
				},
				function(err) {
					console.error('Error while fetching report data');
				}
			);
		} else {
			console.log('location to user task list');
			$rootScope.$apply(function() {
				// 왜 $apply()를 이용해야 $location.path()가 적용되는건지 알 수가 없다.
				// 다른 controller에서는 그냥 $location.path()가 잘 동작하는데... ㅡㅡ;
				$location.path('/task_list/' + name);
			});
		}
	};
}]);