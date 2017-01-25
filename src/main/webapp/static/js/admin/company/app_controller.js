App
.controller('mainController', ['companyService', 'companyEdit', 'deleteConfirm', function(companyService, companyEdit, deleteConfirm) {
	var self = this;
	self.companies = [];
	
	function getCompanyList() {
		companyService.getCompanies()
		.then(
			function(data) {
				self.companies = data;
			},
			function(err) {
				console.error('Error while fetching company list');
			}
		);
	};
	
	getCompanyList();
	
	self.edit = function(company) {
		var com = angular.copy(company)
		companyEdit.show(com)
		.then(
			function(data) {
				if (data.id == -9999)		return false;
				companyService.updateCompany(data)
				.then(
					getCompanyList,
					function(err) {
						console.error('Error while updating company information');
					}
				);
			},
			function(err) {}
		);
	};
	
	self.remove = function(id) {
		deleteConfirm.show()
		.then(
			function(res) {
				if (res == 'yes') {
					companyService.deleteCompany(id)
					.then(
						getCompanyList,
						function(err) {
							console.error('Error while deleting company information');
						}
					);
				}
			}
		);
	};
	
	self.add = function() {
		companyEdit.show()
		.then(
			function(data) {
				if (data.id === -9999)		return false;
				companyService.addCompany(data)
				.then(
					getCompanyList,
					function(err) {
						console.error('Error while creating company information');
					}
				);
			}
		);
	}
}]);