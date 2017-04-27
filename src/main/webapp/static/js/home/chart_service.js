App.service('chartService', ['$http', '$q', function($http, $q) {
	
	this.getReportData = function() {
		var deferred = $q.defer();

		$http.get('/bpms/rest/task/chart')
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		return deferred.promise;
	};
	
	this.getReportDataById = function(id) {
		var deferred = $q.defer();
		
		// 사용자 ID를 사용할 수 있으므로 '/'로 마무리해주어야 한다.
		$http.get('/bpms/rest/task/chart/' + id + '/')
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
}]);