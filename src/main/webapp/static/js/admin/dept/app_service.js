'use strict';

App
.service('DepartmentService', ['$http', '$q', function($http, $q) {
	
	this.getDepartmentById = function(id) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/dept/' + id)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				return $q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.updateDepartment = function(dept, id) {
		var deferred = $q.defer();
		
		$http.put('/bpms/rest/dept/' + id, dept)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				return $q.reject(err);
			}
		);
		return deferred.promise;
	};
	
	this.deleteDepartment = function(id) {
		var	deferred = $q.defer();
		
		$http.delete('/bpms/rest/dept/' + id)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				return $q.reject(err);
			}
		);
		return deferred.promise;
	};
	
	this.addDepartment= function(dept) {
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/dept', dept)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				return $q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.getDocumentManagers = function(id) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/dept/manager/' + id)
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
	
	this.saveDocumentManagers = function(managers) {
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/dept/manager', managers)
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
	
	this.updateDocumentManagers = function(managers) {
		var deferred = $q.defer();
		
		$http.put('/bpms/rest/dept/manager', managers)
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