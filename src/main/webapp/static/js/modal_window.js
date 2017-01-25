App
.config(function($modalProvider) {
	angular.extend($modalProvider.defaults, { html: true });
})
.service('deleteConfirm', ['$modal', '$rootScope', '$q', function($modal, $rootScope, $q) {
	var scope = $rootScope.$new();
	var deferred;
	
	scope.title = '!!주의!!';
	scope.content = '삭제하시겠습니까?';
	scope.answer = function(res) {
		deferred.resolve(res);
		confirm.hide();
	};
	
	var confirm = $modal({templateUrl:'/bpms/common/confirm_modal', scope: scope, show: false});
	var parentShow = confirm.show;
	confirm.show = function() {
		deferred = $q.defer();
		parentShow();
		return deferred.promise;
	};
	
	return confirm;
}])
.service('confirmModal', ['$modal', '$rootScope', '$q', function($modal, $rootScope, $q) {
	var scope = $rootScope.$new();
	var deferred;
	
	scope.title = '';
	scope.content = '';
	scope.answer = function(res) {
		deferred.resolve(res);
		confirm.hide();
	};
	
	var confirm = $modal({templateUrl:'/bpms/common/confirm_modal', scope: scope, show: false});
	var parentShow = confirm.show;
	confirm.show = function() {
		deferred = $q.defer();
		parentShow();
		return deferred.promise;
	};
	
	confirm.setTitle = function(title) {
		scope.title = title;
	};
	
	confirm.setContent = function(content) {
		scope.content = content;
	};
	
	return confirm;
}])
.service('warningModal', ['$modal', '$rootScope', '$q', function($modal, $rootScope, $q) {
	var scope = $rootScope.$new();
	var deferred;
	
	scope.title = '';
	scope.content = '';
	scope.answer = function(res) {
		deferred.resolve(res);
		modal.hide();
	};
	
	var modal = $modal({templateUrl: '/bpms/common/warning_modal', scope: scope, show: false});
	var	parentShow = modal.show;
	modal.show = function() {
		deferred = $q.defer();
		parentShow();
		return deferred.promise;
	};
	
	modal.setTitle = function(title) {
		scope.title = title;
	};
	modal.setContent = function(content) {
		scope.content = content;
	}
	
	return modal;
}])
.service('selectDepartment', ['TreeService', '$modal', '$rootScope', '$http', '$q',
                              function(TreeService, $modal, $rootScope, $http, $q) {
	var scope = $rootScope.$new();
	var deferred;
	scope.dept = {};
	
	scope.answer = function(res) {
		if (res == 'no') {
			scope.dept = {id: -9999, name:'', depth: -1};
		}
		
		console.log('Selected Dept: ', scope.dept);
		deferred.resolve(scope.dept);
		modal.hide();
	};
	
	scope.treeConfig = {
		core: {
			multiple: false,
			animation: true,
			error: function(error) {
				console.log(angular.toJson(error));
			}
		},
		version: 1
	};
	scope.treeData = [];
	
	// company id는 global 변수 company에서 가져온다.
	// 이 부분은 좀더 고민을 해봐야 겠다.
	function getTree() {
		if (TreeService.data.length  > 0) {
			console.log('alreay tree data');
			scope.treeData = TreeService.data;
			console.log('treeData: ', scope.treeData);
			return;
		}
		TreeService.getDepartmentTree(company.id)
		.then(
			function(d) {
				console.log('data: ', d);
				scope.treeData = d;
				scope.treeConfig.version++;
				TreeService.store(scope.treeConfig, scope.treeData);
			},
			function(err) {
				console.error('Error while fetching department tree data');
			}
		);
		
		console.log('treeData: ', scope.treeData);
	}
	
	scope.selectDept = function(e, data) {
		if (scope.selectedDeptId === data.node.id) {
			data.instance.deselect_node(data.node);
			scope.selectedDeptId = "";
			return;
		} else {
			scope.dept = {id:data.node.id, name:data.node.text, depth:data.node.original.depth + 1};
		}
	};
	
	var modal = $modal({templateUrl: '/bpms/common/department_modal', scope: scope, show:false});
	var parentShow = modal.show;
	modal.show = function() {
		deferred = $q.defer();
		modal.$promise.then(function() {
			getTree();
			parentShow();
		});
		return deferred.promise;
	};
	
	return modal;
}])
.service('selectPosition', ['$modal', '$rootScope', '$http', '$q', function($modal, $rootScope, $http, $q) {
	var scope = $rootScope.$new();
	var deferred;
	
	scope.positions = [];
	scope.position = {};
	
	console.log('selectPosition');
	
	scope.answer = function(res) {
		if (res == 'no')
			scope.position = {id:-9999, name:''};

		deferred.resolve(scope.position);
			
		modal.hide();
	};
	
	scope.selectPosition = function(id, name) {
		scope.position = {id: id, name: name};
	};
	
	$http.get('/bpms/rest/position')
	.then(
		function(response) {
			scope.positions = response.data;
		},
		function(err) {
			$q.reject(err);
		}
	);
	
	var modal = $modal({templateUrl:'/bpms/common/position_modal', scope: scope, show: false});
	var parentShow = modal.show;
	modal.show = function() {
		deferred = $q.defer();
		modal.$promise.then(parentShow);
		return deferred.promise;
	};
	
	return modal;
}])
.service('authCodeEdit', ['$modal', '$rootScope', '$http', '$q', function($modal, $rootScope, $http, $q) {
	var scope = $rootScope.$new();
	var deferred;
	
	scope.auth = {};
	scope.answer = function(res) {
		if (res == 'no')
			scope.auth = {authId: -9999, roleName: '', comment: ''};
		
		console.log('Authcode : ', scope.auth);
		deferred.resolve(scope.auth);
		modal.hide();
	};
	
	var modal = $modal({templateUrl: '/bpms/admin/auth/regist_auth', scope: scope, show: false});
	var parentShow = modal.show;
	modal.show = function(auth) {
		deferred = $q.defer();
		if (auth === undefined)
			auth = {authId: '', roleName: '', comment: ''};
		scope.auth = auth;
		parentShow();
		return deferred.promise;
	};
	
	return modal;
}])
.service('positionEdit', ['$modal', '$rootScope', '$q', function($modal, $rootScope, $q) {
	var scope = $rootScope.$new();
	var deferred;
	
	scope.position = {};
	var modal = $modal({templateUrl: '/bpms/admin/position/regist_position', scope: scope, show: false});
	var parentShow = modal.show;
	
	scope.answer = function(res) {
		if (res == 'no')
			scope.position = {id: -9999, name: '', type: '', seq: -1};
		
		deferred.resolve(scope.position);
		modal.hide();
	};
	
	modal.show = function(position) {
		deferred = $q.defer();
		if (position === undefined)
			position = {id:'', name: '', type: '', seq: ''};
		
		scope.position = position;
		parentShow();
		return deferred.promise;
	};
	
	return modal;
}])
.service('companyEdit', ['$modal', '$rootScope', '$q', function($modal, $rootScope, $q) {
	var scope = $rootScope.$new();
	var deferred;
	
	scope.company = {};
	var modal = $modal({templateUrl: '/bpms/admin/company/regist_company', scope: scope, show: false});
	var parentShow = modal.show;
	
	scope.answer = function(res) {
		if (res == 'no')
			scope.company = {id: -9999, name: '', ceo: ''};
		
		deferred.resolve(scope.company);
		modal.hide();
	};
	
	modal.show = function(company) {
		deferred = $q.defer();
		if (company === undefined)
			company = {id: '', name: '', ceo: ''};
		
		scope.company = company;
		parentShow();
		return deferred.promise;
	};
	
	return modal;
}])
.service('selectUserModal', ['TreeService', 'UserService', '$modal', '$rootScope', '$q',
                        function(TreeService, UserService, $modal, $rootScope, $q) {
	var scope = $rootScope.$new();
	var deferred;
	var modal = $modal({templateUrl: '/bpms/common/select_user', scope: scope, show: false});
	var parentShow = modal.show;
	
	scope.treeConfig = {
		core: {
			multiple: false,
			animation: true,
			error: function(error) {
				console.log(angular.toJson(error));
			}
		},
		version:1
	};
	scope.treeData = [];
	
	TreeService.getDepartmentTree(company.id)
	.then(
		function(data) {
			scope.treeData = data;
			scope.treeConfig.version++;
		}
	);
	
	scope.workerList = [];
	scope.selectedDeptId = "";
	scope.selectDept = function(e, data) {
		if (scope.selectedDeptId === data.node.id) {
			data.instance.deselect_node(data.node);
			scope.selectedDeptId = "";
			return;
		} else {
			scope.selectedDeptId = data.node.id;
			UserService.getListByDeptId(scope.selectedDeptId)
			.then(
				function(data) {
					scope.workerList = data;
				},
				function(err) {
					$q.reject(err);
				}
			);
		}
	};
	
	scope.selectUser = function(user) {
		console.log('selectUser: ', user)
		scope.user = user;
	};
	
	scope.worker = {id: '', name: ''};
	scope.answer = function(res) {
		if (res == 'no') {
			scope.user = {id: -9999, name: ''};
		}
		
		deferred.resolve(scope.user);
		modal.hide();
		scope.workerList = [];
	};
	
	modal.show = function(users) {
		if (!angular.isUndefined(users))
			scope.workerList = users;
		
		deferred = $q.defer();
		parentShow();
		return deferred.promise;
	};
	
	return modal;
}])
.service('insertCommentModal', ['$modal', '$rootScope', '$q', function($modal, $rootScope, $q) {
	var scope = $rootScope.$new();
	var deferred;
	
	var modal = $modal({templateUrl: '/bpms/common/comment_modal', scope: scope, show: false});
	var parentShow = modal.show;
	
	scope.answer = function(res) {
		console.log('comment = ' + res);
		deferred.resolve(res);
		modal.hide();
	};
	
	modal.show = function() {
		deferred = $q.defer();
		parentShow();
		return deferred.promise;
	};
	
	scope.title = '';
	scope.content = '';
	scope.comment = '';
	
	modal.setTitle = function(title) {
		scope.title = title;
	};
	
	modal.setContent = function(content) {
		scope.content = content;
	};
	
	return modal;
}])
.service('historyModal', ['taskService', '$modal', '$rootScope', '$q', function(taskService, $modal, $rootScope, $q) {
	var scope = $rootScope.$new();
	
	var modal = $modal({templateUrl: '/bpms/task_history_modal', scope: scope, show: false});
	var parentShow = modal.show;

	modal.show = function(historyId) {
		taskService.getHistoryDetail(historyId)
		.then(
			function(history) {
				console.log(history);	
				scope.history = history;
			},
			function(err) {
				$q.reject(err);
				scope.history = {};
				console.error('Error while fetching task history information');
			}
		);
		
		parentShow();
	};
	
	return modal;
}]);