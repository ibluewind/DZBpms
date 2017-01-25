/**
 * 항상 /static/js/app.js를 먼저 추가해야 한다.
 */
'use strict';

App
.service('TreeService', ['$http', '$q', function($http, $q) {
	this.config = {};
	this.data = [];
	
	this.store = function(config, data) {
		this.config = config;
		this.data = data;
	};
	
	this.getDepartmentTree = function(companyId) {
		var deferred = $q.defer();
		$http.get('/bpms/rest/dept/tree/' + companyId)
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
	
	this.removeDept = function(deptId) {
		for (var i = 0; i < this.data.length; i++) {
			if (this.data[i].id == deptId) {
				this.data.splice(i, 1);
				break;
			}
		}
		
		this.config.version++;
		return this.data;
	};
	
	this.addDept = function(dept) {
		var obj = {id: dept.deptId, parent: dept.pId, text: dept.name, state: {opened: true}};
		this.data.push(obj);
		this.config.version++;
		return this.data;
	};
	
	this.updateDept = function(dept) {
		console.log('update Tree : ', dept);
		for (var i = 0; i < this.data.length; i++) {
			if (this.data[i].id == dept.deptId) {
				console.log('data[' + i + '] :', this.data[i]);
				this.data[i].parent = dept.pId;
				this.data[i].text = dept.name;
				console.log('updated data[' + i + '] :', this.data[i]);
				break;
			}
		}
		
		this.config.version++;
		console.log('version: ' + this.config.version);
		return this.data;
	}
}])