'use strict';
App
.controller('dashboardController', ['taskService', 'taskStatus', 'userService', 'approveService', 'approveTrayType', '$location', '$rootScope',
function(taskService, taskStatus, userService, approveService, approveTrayType, $location, $rootScope) {
	var self = this;
	
	self.user = {};
	self.tasks = [];
	self.trays = [];
	
	self.user = userService.getLoggedInUser();
	
	$rootScope.$on('$locationChangeSuccess', function(e, newUrl, oldUrl, newState, oldState) {
		$rootScope.prevUrl = oldUrl.substring(oldUrl.indexOf('#') + 1);
	});
	
	taskService.listOfMyTask()
	.then(
		function(tasks) {
			self.tasks = tasks;
		},
		function(err) {
			console.error('Error while fetching list of tasks');
		}
	);
	
	approveService.getUserApproveTrays()
	.then(
		function(trays) {
			self.trays = trays;
		},
		function(err) {
			console.error('Error while fetching list of approve tray');
		}
	);
	
	// status filters
	self.filterProcess = function(task) {
		return task.status == taskStatus.PROCESS;
	};
	
	self.filterNewTask = function(task) {
		return task.status == taskStatus.NEW;
	};
	
	self.filterLate = function(task) {
		return task.status == taskStatus.LATE;
	};
	
	self.filterOwnTask = function(task) {
		return task.userId == self.user.userId;
	};
	
	// Approve tray filters
	self.undecideTrays = function(tray) {
		return tray.type == approveTrayType.UNDECIDE;
	};
	
	self.deferredTrays = function(tray) {
		return tray.type == approveTrayType.DEFER;
	};
	
	self.expectedTrays = function(tray) {
		return tray.type == approveTrayType.EXPECTED;
	};
	
	self.view = function(taskId) {
		$location.path('/view_task/' + taskId);
	};
	
	// 작업 생성자인 경우에는 수정 화면으로...
	self.edit = function(taskId) {
		$location.path('/edit_task/' + taskId);
	};
	
	self.canEdit = function(task) {
		if ((self.user.userId == task.userId) && (task.status == taskStatus.NEW || task.status == taskStatus.REJECT || task.status == taskStatus.DELEGATE))
			return true;
		else
			return false;
	};
}]);