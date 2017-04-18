App.service('chartService', ['$http', '$q', function($http, $q) {
	
	this.getReportData = function() {
		var deferred = $q.defer();
		var results = [];
		
		/*
		results[0] = [];		// chart data
		results[1] = [];		// chart label
		
		results[0][0] = [3, 1, 1, 5, 2];
		results[0][1] = [7, 0, 4, 2, 3];
		results[0][2] = [1, 2, 1, 0, 3];
		
		results[1] = ['인터넷개발팀', '모바일개발팀', '시너지개발팀', 'IT시스템팀', 'IT협력팀'];
		*/
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
}]);