'use strict';

App
.service('UserService', ['$http', '$q', function($http, $q) {
	this.deptId = '';
	this.dept = {};
	this.users = [];
	
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
	
	this.getListByDeptId = function(deptId) {
		var deferred = $q.defer();
		this.deptId = deptId;
		
		$http.get('/bpms/rest/user/list/' + deptId)
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
	
	this.getUserById = function(id) {
		var deferred = $q.defer();
		console.log('getUserById : ' + id);
		$http.get('/bpms/rest/user/' + id + '/')
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
	
	this.updateUser = function(user, id) {
		var deferred = $q.defer();
		
		$http.put('/bpms/rest/user/' + id + '/', user)
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
	
	this.deleteUser = function(id) {
		var deferred = $q.defer();
		
		console.log('deleteUser ' + id);
		$http.delete('/bpms/rest/user/' + id +'/')
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
	
	this.addUser = function(user) {
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/user', user)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	}
}])
.service('AuthorityService', ['$http', '$q', function($http, $q) {
	this.getList = function() {
		var deferred = $q.defer();
		console.log('get Authority list');
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
	}
}]);