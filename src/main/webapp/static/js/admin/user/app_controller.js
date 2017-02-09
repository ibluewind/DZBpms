'use strict';

App
.config(['$routeProvider', function($routeProvider) {
	$routeProvider
	.when('/',
		{template: '<h4>Work Area</h4>'}
	)
	.when('/list/:deptId',
		{
			templateUrl: '/bpms/admin/user/list',
			controller: 'userController as ctrl'
		}
	)
	.when('/edit/:id',
		{
			templateUrl: '/bpms/admin/user/edit',
			controller: 'editUserController as ctrl'
		}
	)
	.when('/add',
		{
			templateUrl: '/bpms/admin/user/add',
			controller: 'addUserController as ctrl'
		}
	)
	.otherwise({redirectTo: '/'});
}])
.controller('mainController', ['TreeService', '$scope', '$location', function(TreeService, $scope, $location) {
	var self = this;
	
	// 부서 트리 설정
	$scope.company = company
	$scope.treeConfig = {
		core: {
			multiple: false,
			animation: true,
			error: function(error) {
				console.log(angular.toJson(error));
			}
		},
		version: 1
	};
	$scope.treeData = [];
	
	function getTree() {
		TreeService.getDepartmentTree($scope.company.id)
		.then(
			function(d) {
				$scope.treeData = d;
				$scope.treeConfig.version++;
				TreeService.store($scope.treeConfig, $scope.treeData);
			},
			function(err) {
				console.error('Error while fetching department tree data');
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
		
		$location.path('/list/' + $scope.selectedDeptId);
	};
}])
.controller('userController', ['UserService', 'deleteConfirm', '$routeParams', '$location', function(UserService, deleteConfirm, $routeParams, $location) {
	// user list, user information update controller
	var self = this;
	var deptId = $routeParams.deptId;
	self.users = [];
	self.dept = {};
	
	UserService.getDepartmentById(deptId)
	.then(
		function(d) {
			self.dept = d;
			UserService.dept = d;
		},
		function(err) {
			console.error('Error while fetching Department Information.');
		}
	);
	
	function getUserList() {
		UserService.getListByDeptId(deptId)
		.then(
			function(d) {
				console.log(d);
				UserService.users = d;
				self.users = UserService.users;
			},
			function(err) {
				console.error('Error while fetching users');
			}
		);
	}
	
	getUserList();
	
	self.edit = function(userId) {
		$location.path('/edit/' + userId);
	};
	
	self.remove = function(userId) {
		deleteConfirm.show().then(function(res) {
			if (res == 'yes') {
				UserService.deleteUser(userId)
				.then(
				getUserList,
				function(err) {
					console.error('Error while deleting user');
				});
			}
		});
	};
	
	self.add = function() {
		$location.path("/add");
	}
}])
.controller('editUserController', ['UserService', 'AuthorityService', 'selectDepartment', 'selectPosition', '$routeParams', '$location', function(UserService, AuthorityService, selectDepartment, selectPosition, $routeParams, $location) {
	console.log('editUserController');
	var	self = this;
	self.id = $routeParams.id;
	self.edit = true;
	self.user = {};
	self.authorities = [];
	self.selectedAuthorities = [];
	
	
	UserService.getUserById(self.id)
	.then(
		function(d) {
			console.log(d);
			self.user = d;
			self.selectedAuthorities = self.user.userAuthorities;
			console.log(self.selectedAuthorities);
		},
		function(err) {
			console.log('Error while fetching User');
		}
	);
	
	AuthorityService.getList()
	.then(
		function(d) {
			self.authorities = d;
		},
		function(err) {
			console.log('Error while fetching Authorities');
		}
	);
	
	self.resetPassword = function() {
		self.user.password = '';
	};
	
	//기존에 선택된 부서 정보를 저장하고 있어야 한다.
	self.selectDepartment = function(oldDeptId) {
		selectDepartment.show()
		.then(
			function(dept) {
				if (dept.id != -9999) {
					// 선택한 부서를 등록한다.
					for (var i = 0; i < self.user.deptPositions.length; i++) {
						if (self.user.deptPositions[i].deptId == oldDeptId) {
							self.user.deptPositions[i].deptId = dept.id;
							self.user.deptPositions[i].deptName = dept.name;
							break;
						}
					}
				}
			},
			function(err) {
				console.log('Error while show Select Department Modal Window');
			}
		);
	};
	
	self.selectPosition = function(index) {
		console.log('index = ' + index);
		console.log('deptPositions:', self.user.deptPositions);
		selectPosition.show()
		.then(
			function(d) {
				self.user.deptPositions[index].positionId = d.id;
				self.user.deptPositions[index].positionName = d.name;
				/**
				for (var i = 0; i < self.user.deptPositions.length; i++) {
					if (self.user.deptPositions[i].positionId == oldPositionId) {
						self.user.deptPositions[i].positionId = d.id;
						self.user.deptPositions[i].positionName = d.name;
						break;
					}
				}
				**/
			},
			function(err) {
				console.log('Error while show select Position Modal Window');
			}
		);
	};
	
	self.removeDepartPosition = function(deptId, positionId) {
		console.log('deptId = ' + deptId + ', positionId = ' + positionId);
		for (var i = 0; i < self.user.deptPositions.length; i++) {
			if (self.user.deptPositions[i].deptId == deptId && self.user.deptPositions[i].positionId == positionId) {
				self.user.deptPositions.splice(i, 1);
				break;
			}
		}
	};
	
	self.addDepartPosition = function() {
		self.user.deptPositions.push(
			{
				deptId : '',
				deptName: '',
				positionId: '',
				positionName: '',
				userId: self.user.userId
			}
		);
	};
	
	self.submit = function() {
		// {authId, roleName, comment}를 {userId, authId, roleName}으로 변경해야 한다.
		self.user.userAuthorities = [];
		for (var i = 0; i < self.selectedAuthorities.length; i++) {
			var auth = {userId: self.user.userId, authId: self.selectedAuthorities[i].authId, roleName: self.selectedAuthorities[i].roleName};
			self.user.userAuthorities.push(auth);
		}
		
		UserService.updateUser(self.user, self.user.userId)
		.then(
			function(res) {
				$location.path('/list/' + UserService.deptId);
			},
			function(err) {
				console.error('Error while updating user information');
			}
		);
	};
	
	self.cancel = function() {
		$location.path('/list/' + UserService.deptId);
	};
	
	self.searchUser = function() {
		console.log('search user modal window');
	}
}])
.controller('addUserController', ['UserService', 'AuthorityService', 'selectDepartment', 'selectPosition', '$location', function(UserService, AuthorityService, selectDepartment, selectPosition, $location) {
	var self = this;
	self.edit = false;
	self.user = {};
	self.user.companies = [company];
	self.user.deptPositions = [{
		deptId: UserService.dept.deptId,
		deptName: UserService.dept.name,
		positionId: '',
		positionName: '',
		userId: ''
	}];
	self.user.userAuthorities = [];
	
	self.user.state = 'Y';
	
	self.authorities = [];
	self.selectedAuthorities = [];
	
	
	AuthorityService.getList()
	.then(
		function(d) {
			self.authorities = d;
		},
		function(err) {
			console.log('Error while fetching Authorities');
		}
	);
	
	//기존에 선택된 부서 정보를 저장하고 있어야 한다.
	self.selectDepartment = function(oldDeptId) {
		selectDepartment.show()
		.then(
			function(dept) {
				if (dept.id != -9999) {
					// 선택한 부서를 등록한다.
					// 부서 등록시에 사용자 ID를 등록해준다.
					for (var i = 0; i < self.user.deptPositions.length; i++) {
						if (self.user.deptPositions[i].deptId == oldDeptId) {
							self.user.deptPositions[i].deptId = dept.id;
							self.user.deptPositions[i].deptName = dept.name;
							break;
						}
					}
				}
			},
			function(err) {
				console.log('Error while show Select Department Modal Window');
			}
		);
	};
	
	self.selectPosition = function(index) {
		console.log('index = ' + index);
		console.log('deptPostions: ', self.user.deptPositions);
		selectPosition.show()
		.then(
			function(d) {
				self.user.deptPositions[index].positionId = d.id;
				self.user.deptPositions[index].positionName = d.name;
				/**
				for (var i = 0; i < self.user.deptPositions.length; i++) {
					if (oldPositionId == '' || self.user.deptPositions[i].positionId == oldPositionId) {
						self.user.deptPositions[i].positionId = d.id;
						self.user.deptPositions[i].positionName = d.name;
						break;
					}
				}
				*/
			},
			function(err) {
				console.log('Error while show select Position Modal Window');
			}
		);
	};
	
	// 부서가 삭제될 때 마다 company를 삭제한다.
	self.removeDepartPosition = function(deptId, positionId) {
		self.user.companies.splice(0, 1);		// 항상 같은 회사에서 작업이 일어나므로 첫번째 요소를 제가한다.
		for (var i = 0; i < self.user.deptPositions.length; i++) {
			if (self.user.deptPositions[i].deptId == deptId && self.user.deptPositions[i].positionId == positionId) {
				self.user.deptPositions.splice(i, 1);
				break;
			}
		}
	};
	
	self.addDepartPosition = function() {
		// 부서가 추가될 때 마다, companies를 추가해야 할껄...
		self.user.companies.push(company);
		
		self.user.deptPositions.push(
			{
				deptId : '',
				deptName: '',
				positionId: '',
				positionName: '',
				userId: self.user.id
			}
		);
	};
	
	self.submit = function() {
		// 선택된 권한을 설정한다.
		console.log(self.selectedAuthorities);
		for (var i = 0; i < self.selectedAuthorities.length; i++) {
			var auth = {userId: self.user.userId, authId: self.selectedAuthorities[i].authId};
			self.user.userAuthorities.push(auth);
		}
		// 부서 직급 정보에 사용자 ID를 추가한다.
		for (var i = 0; i < self.user.deptPositions.length; i++) {
			self.user.deptPositions[i].userId = self.user.userId;
		}
		console.log('User : ', self.user);
		UserService.addUser(self.user)
		.then(
			function(d) {
				UserService.users.push(self.user);
				$location.path('/list/' + UserService.deptId);
			},
			function(err) {
				console.error('Error while creating User');
			}
		);
	};
	
	self.cancel = function() {
		$location.path('/list/' + UserService.deptId);
	};
}]);