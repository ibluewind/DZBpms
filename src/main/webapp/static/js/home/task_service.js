'use strict';
App
.service('taskService', ['$http', '$q', function($http, $q) {
	this.attachFiles = [];
	this.isUploadCompleted = true;
	this.taskHistory = {
			historyId: '',
			taskId: '',
			comment: '',
			created: '',
			creator: '',
			worker: '',
			procRate: 0
		};
	
	this.clear = function() {
		this.attachFiles = [];
		this.isUploadCompleted = true;
		this.taskHistory = {
			historyId: '',
			taskId: '',
			comment: '',
			created: '',
			creator: '',
			worker: '',
			procRate: 0
		};
	};
	
	this.getHistoryDetail = function(historyId) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/task/history/details/' + historyId)
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
	
	this.saveTask = function(task) {
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/task', task)
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
	
	this.listOfMyTask = function() {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/task/user')
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
	
	this.getByTaskId = function(taskId) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/task/' + taskId)
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
	
	this.getAttachByTaskId = function(taskId) {
		var deferred = $q.defer();
		
		// 첨부 파일 목록을 조회한다.
		$http.get('/bpms/rest/file/' + taskId)
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
	
	this.updateTask = function(task) {
		var deferred = $q.defer();
		
		$http.put('/bpms/rest/task', task)
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
	
	this.saveAttach = function(taskId) {
		var deferred = $q.defer();
		
		for (var i = 0; i < this.attachFiles.length; i++) {
			this.attachFiles[i].modified = new Date();
			this.attachFiles[i].attachId = '';
			this.attachFiles[i].mainId = taskId;
		}
		
		$http.post('/bpms/rest/file', this.attachFiles)
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
	
	// 서버에서 파일을 삭제한다.
	this.deleteAttach = function(name) {
		var deferred = $q.defer();
		
		$http.delete('/bpms/rest/file/' + name + '/')
		.then(
			function(response) {
				console.log(response);
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.listTaskHistory = function(taskId) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/task/history/' + taskId)
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
	
	this.getStatusName = function(status) {
		var	name = '';

		switch(status) {
		case 'R':
			name = "반려";
			break;
		case 'P':
			name = "진행중";
			break;
		case 'C':
			name = "취소";
			break;
		case 'D':
			name = "위임";
			break;
		case 'F':
			name = "완료";
			break;
		case 'H':
			name = "보류";
			break;
		case 'L':
			name = "지연";
			break;
		case 'N':
			name = "신규";
			break;
		case 'S':
			name = "재전송";
			break;
		}
		
		return name;
	};
}])
.service('userService', ['$rootScope', '$http', '$q', function($rootScope, $http, $q) {
	
	this.getLoggedInUser = function() {
		var deferred = $q.defer();
		
		if (!angular.isUndefined($rootScope.loggedInUser)) {
			console.log('already stored logged user information');
			deferred.resolve($rootScope.loggedInUser);
		} else {
			$http.get('/bpms/rest/user')
			.then(
				function(response) {
					deferred.resolve(response.data);
				},
				function(err) {
					$q.reject();
				}
			);
		}
		
		return deferred.promise;
	};
}]);