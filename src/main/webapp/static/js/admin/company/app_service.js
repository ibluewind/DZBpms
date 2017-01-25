App
.service('companyService', ['$http', '$q', function($http, $q) {
	this.getCompanies = function() {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/company')
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
	
	this.updateCompany = function(company, id) {
		var deferred = $q.defer();
		
		$http.put('/bpms/rest/company/' + id, company)
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
	
	this.addCompany = function(company) {
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/company', company)
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
	
	this.deleteCompany = function(id) {
		var deferred = $q.defer();
		
		$http.delete('/bpms/rest/company/' + id)
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