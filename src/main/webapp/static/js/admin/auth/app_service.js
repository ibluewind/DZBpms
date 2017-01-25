App
.service('authService', ['$http', '$q', function($http, $q) {
	this.getList = function() {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/auth')
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
	
	this.getAuthCode = function(authId) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/auth/' + authId)
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
	
	this.addAuthCode = function(auth) {
		var deferred = $q.defer();
		
		console.log('ADD AUTH : ', auth);
		$http.post('/bpms/rest/auth/', auth)
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
	
	this.deleteAuthCode = function(authId) {
		var deferred = $q.defer();
		
		$http.delete('/bpms/rest/auth/' + authId)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject();
			}
		);
		
		return deferred.promise;
	}
}]);