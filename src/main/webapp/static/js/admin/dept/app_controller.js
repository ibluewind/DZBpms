'use strict';

App
.config(['$routeProvider', function($routeProvider) {
	$routeProvider
	.when('/',
		{ template: '<h3>Work Area!</h3>' }
	)
	.when('/edit/:id',
		{
			templateUrl: '/bpms/admin/dept/edit',
			controller: 'deptController as ctrl'
		}
	)
	.otherwise({redirectTo: '/'});
}])
.controller('mainController', ['TreeService', '$scope', '$location', function(TreeService, $scope, $location) {
	var	self = this;
	$scope.company = company;
	$scope.treeConfig = {
		core: {
			multiple: false,
			animation: true,
			error: function(error) {
				console.log(angular.toJson(error));
			}
		},
		version:1
	};
	$scope.treeData = [];
	
	function getTree() {
		TreeService.getDepartmentTree($scope.company.id)
		.then(
			function(d) {
				console.log('tree: ', d);
				$scope.treeData = d;
				$scope.treeConfig.version++;
				TreeService.store($scope.treeConfig, $scope.treeData);
			},
			function(err) {
				console.log('Error while fetching department tree data');
			}
		);
	};
	
	getTree();
	
	self.changeCompany = function(id, name) {
		$scope.company = {};
		$scope.company.id = id;
		$scope.company.name = name;
		
		getTree();
		$location.path('/');
	};
	
	$scope.selectedDeptId = "";
	self.selectDept = function(e, data) {
		if ($scope.selectedDeptId === data.node.id) {
			data.instance.deselect_node(data.node);
			$scope.selectedDeptId = "";
			return;
		} else {
			$scope.selectedDeptId = data.node.id;
		}
		
		console.log(' $scope.selectedDeptId: ',  $scope.selectedDeptId + ', parent: ', data.node.parent);
		$location.path('/edit/' + $scope.selectedDeptId);
	};
}])
.controller('deptController', ['DepartmentService', 'UserService', 'TreeService', 'selectDepartment', 'selectUserModal', 'deleteConfirm', '$routeParams', '$location',
						function(DepartmentService, UserService, TreeService, selectDepartment, selectUserModal, deleteConfirm, $routeParams, $location) {
	var self = this;
	var id = $routeParams.id;
	self.edit = true;
	self.dept = {};
	self.users= [];
	self.masterManager = {};
	self.secondManager = {};
	self.docManagers = [];
	
	console.log('id = ' + id);
	
	DepartmentService.getDepartmentById(id)
	.then(
		function(d) {
			console.log('dept: ', d);
			self.dept = d;
			DepartmentService.dept = d;
		},
		function(err) {
			console.error('Error while fetching Department information');
		}
	);
	
	DepartmentService.getDocumentManagers(id)
	.then(
		function(managers) {
			console.log('managers: ', managers);
			for (var i = 0; i < managers.length; i++) {
				if (managers[i].type == 'M')
					self.masterManager = managers[i];
				else
					self.secondManager = managers[i];
			}
		}
	);
	
	self.selectParent = function() {
		selectDepartment.show()
		.then(
			function(dept) {
				if (dept.id != -9999) {
					self.dept.pId = dept.id;
					self.dept.parentName = dept.name;
					self.dept.depth = dept.depth;
				}
			},
			function(err) {
				console.error('Error while show Select Department Modal Window');
			}
		);
	};
	
	self.selectDocumentManager = function(type) {
		UserService.getListByDeptId(self.dept.deptId)
		.then(
			function(data) {
				self.users = data;
			},
			function(err) {
				console.error('Error while fetching user list');
			}
		);
		console.log('users: ', self.users);
		
		selectUserModal.show(self.users)
		.then(
			function(user) {
				if (user.id != -9999)
					setDocumentManager(type, user);
			},
			function(err) {
				console.error('Error while display select user modal window');
			}
		);
	};
	
	self.clearDocumentManager = function(type) {
		if (type == 'M') {
			self.masterManager = {};
		} else {
			self.secondManager = {};
		}
	}
	
	self.delete = function(id) {
		deleteConfirm.show()
		.then(
			function(res) {
				if (res == 'yes') {
					DepartmentService.deleteDepartment(id)
					.then(
						function(d) {
							// 부서 트리를 리로드한다.
							TreeService.removeDept(id);
							$location.path('/');
						},
						function(err) {
							console.log('Error while deleting Department Information');
						}
					);
				}
			},
			function(err) {
				console.log('Error while show Delete Confirm Modal Window');
			}
		);
	};
	
	self.add = function() {
		//현재 부서를 상위부서로하는 새로운 부서를 추가한다.
		self.dept.pId = self.dept.deptId;
		self.dept.deptId = '';
		self.dept.parentName = self.dept.name;
		self.dept.name = '';
		self.dept.depth = self.dept.depth + 1;
		self.edit = false;
	};
	
	self.submit = function() {
		if (self.edit) {
			// 수정된 부서를 업데이트한다.
			DepartmentService.updateDepartment(self.dept, self.dept.deptId)
			.then(
				function(d) {
					self.dept = d;
					updateDocumentManagers();
					TreeService.updateDept(self.dept);
				},
				function(err) {
					console.error('Error while Updating Department Information');
				}
			);
		} else {
			// 새로운 부서를 등록한다.
			DepartmentService.addDepartment(self.dept)
			.then(
				function(d) {
					self.dept = d;
					saveDocumentManagers();
					// 부서 트리를 갱신한다.
					TreeService.addDept(d);
				},
				function(err) {
					console.error('Error while creating Department Information');
				}
			);
		}
	};
	
	function setDocumentManager(type, user) {
		console.log('type: ' + type + ', user: ', user);
		
		if (type == 'M') {
			self.masterManager.deptId = self.dept.deptId;
			self.masterManager.userId = user.id;
			self.masterManager.userName = user.lastName + user.firstName;
			self.masterManager.type = type;
			console.log('master: ', self.masterManager);
		} else {
			self.secondManager.deptId = self.dept.deptId;
			self.secondManager.userId = user.id;
			self.secondManager.userName = user.lastName + user.firstName;
			self.secondManager.type = type;
			console.log('second: ', self.secondManager);
		}
	}
	
	function updateDocumentManagers() {
		self.docManagers = [];
		
		console.log('master: ', self.masterManager + ', second: ', self.secondManager);
		
		if (!angular.isUndefined(self.masterManager.userId))
			self.docManagers.push(self.masterManager);
		
		// 부 문서담당자는 없을 수 있다.
		if (!angular.isUndefined(self.secondManager.userId))
			self.docManagers.push(self.secondManager);
		
		console.log('docManagers: ', self.docManagers);
		if (self.docManagers.length == 0)			return;
		
		DepartmentService.updateDocumentManagers(self.docManagers)
		.then(
			function(managers) {
				return;
			},
			function(err) {
				console.error('Error while updating document managers information');
			}
		);
	}
	
	function saveDocumentManagers() {
		self.docManagers = [];
		
		if (!angular.isUndefined(self.masterManager.userId))
			self.docManagers.push(self.masterManager);
		
		if (!angular.isUndefined(self.secondManager.userId))
			self.docManagers.push(self.secondManager);
		
		console.log('docManagers: ', self.docManagers + ', length: ' + self.docManagers.length);
		if (self.docManagers.length == 0)		return;
		
		DepartmentService.saveDocumentManagers(self.docManagers)
		.then(
			function(managers) {
				return;
			},
			function(err) {
				console.error('Error while saving document managers information');
			}
		);
	}
}]);