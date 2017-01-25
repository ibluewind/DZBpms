'use strict';
App
.controller('mainController', ['positionService', 'positionEdit', 'deleteConfirm', function(positionService, positionEdit, deleteConfirm) {
	var self = this;
	
	self.positions = [];
	
	function getPositions() {
		positionService.getPositions()
		.then(
			function(data) {
				self.positions = data;
			},
			function(err) {
				console.log('Error while fetching positions');
			}
		);
	}
	
	getPositions();
	
	self.edit = function(position) {
		var pos = angular.copy(position);
		console.log(pos);
		positionEdit.show(pos)
		.then(
			function(data) {
				if (data.id == '-9999')		return false;
				
				positionService.updatePosition(data, position.id)
				.then(
					function(res) {
						for (var i = 0; i < self.positions.length; i++) {
							if (self.positions[i].id == res.id) {
								self.positions[i] = res;
								break;
							}
						}
					},
					function(err) {
						console.error('Error while updating position');
					}
				);
				
			},
			function(err) { }
		);
	};
	
	self.remove = function(id) {
		deleteConfirm.show()
		.then(
			function(res) {
				if (res == 'yes') {
					positionService.deletePosition(id)
					.then(
						getPositions,
						function(err) {
							console.error('Error while deleting position');
						}
					);
				}
			}
		);
	};
	
	self.add = function() {
		positionEdit.show()
		.then(
			function(position) {
				if (position.id == '-9999')		return false;
				positionService.addPosition(position)
				.then(
					getPositions,
					function(err) {
						console.error('Error while creating position');
					}
				);				
			},
			function(err) {}
		);
	};
}]);