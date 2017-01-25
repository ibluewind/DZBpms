'use strict';
App
.controller('dashboardController', ['taskService', 'taskStatus', 'userService', '$location',
function(taskService, taskStatus, userService, $location) {
	var self = this;
	
	self.user = {};
	self.tasks = [];
	
	self.user = userService.getLoggedInUser();
	
	taskService.listOfMyTask()
	.then(
		function(tasks) {
			self.tasks = tasks;
		},
		function(err) {
			console.error('Error while fetching list of tasks');
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