App
.controller('registProject', ['selectUserModal', '$window', function(selectUserModal, $window) {
	var self = this;
	
	self.user = JSON.parse($window.sessionStorage.getItem("currentUser"));
	self.project = {};
	self.project.manager = self.user.lastName + self.user.firstName;
	console.log('manager = ', self.user);
	
	self.selectManager = function() {
		selectUserModal.show()
		.then(
			function(manager) {
				if (manager.id == -9999)	return false;
				
				self.project.managerId = manager.id;
				self.project.manager = manager.lastName + manager.firstName;
			},
			function(err) {
				console.error('Error while select manager');
			}
		);
	};
	
	self.project.period = 0;
	
}]);