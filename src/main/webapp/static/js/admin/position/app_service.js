App
.service('positionService', ['$http', '$q', function($http, $q) {
	this.getPositions = function() {
		var 	deferred = $q.defer();
		
		$http.get('/bpms/rest/position')
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject();
			}
		);
		
		return deferred.promise;
	};
	
	this.updatePosition = function(position, id) {
		var deferred = $q.defer();
		
		$http.put('/bpms/rest/position/' + id, position)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject();
			}
		);
		
		return deferred.promise;
	};
	
	this.addPosition = function(position) {
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/position', position)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject();
			}
		);
		
		return deferred.promise;
	};
	
	this.deletePosition = function(id) {
		var deferred = $q.defer();
		
		$http.delete('/bpms/rest/position/' + id)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject();
			}
		);
		
		return deferred.promise;
	};
}]);