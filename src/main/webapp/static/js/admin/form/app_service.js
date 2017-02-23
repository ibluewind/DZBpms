App
.service('formService', ['$http', '$q', function($http, $q) {
	this.save = function(form) {
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/form/', form)
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
	
	this.list = function() {
		var deferred =  $q.defer();
		
		$http.get('/bpms/rest/form')
		.then(
			function(response) {
				console.log(response.data);
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.remove = function(id) {
		var deferred = $q.defer();
		
		$http.delete('/bpms/rest/form/' + id)
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
	
	this.get = function(id) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/form/' + id)
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
	
	this.update = function(form) {
		var deferred = $q.defer();
		
		$http.put('/bpms/rest/form', form)
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
	
	this.saveFormField = function(id) {
		var deferred = $q.defer();
		
		console.log('saveFormField: ', id);
		
		$http.post('/bpms/rest/form/field/', id)
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