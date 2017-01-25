App
.controller('mainController', ['authService', 'authCodeEdit', 'deleteConfirm', function(authService, authCodeEdit, deleteConfirm) {
	var self = this;
	
	self.authorities = [];
	
	function getAllAuthorities() {
		authService.getList()
		.then(
			function(d) {
				console.log(d);
				self.authorities = d;
			},
			function(err) {
				console.error('Error while fetching authority list');
			}
		);
	}
	
	getAllAuthorities();
	
	self.edit = function(auth) {
		var a = angular.copy(auth);
		authCodeEdit.show(a)
		.then(
			getAllAuthorities,
			function(err) {
				console.error('Error while update authCode');
			}
		);
	};
	
	self.add = function() {
		authCodeEdit.show()
		.then(
			function(auth) {
				console.log(auth);
				if (auth.authId != -9999) {
					// authority code 등록
					authService.addAuthCode(auth)
					.then(
						getAllAuthorities,
						function(err) {
							console.error('Error while creating authority');
						}
					);
				}
			},
			function(err) { }
		);
	};
	
	self.remove = function(authId) {
		deleteConfirm.show()
		.then(
			function(res) {
				if (res == 'yes') {
					authService.deleteAuthCode(authId)
					.then(
						getAllAuthorities,
						function(err) {
							console.error('Error while deleting authority');
						}
					);
				}
			},
			function(err) { }
		);
	};
}]);