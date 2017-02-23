App
.controller('registController', ['formService', 'fileService', 'deleteConfirm', 'warningModal', 'selectDepartment', '$routeParams', '$window',
	function(formService, fileService, deleteConfirm, warningModal, selectDepartment, $routeParams, $window) {
	var self = this;
	var id = $routeParams.id;
	self.formFile = [];
	self.form = {};
	self.edit = false;
	self.hasFormFile = true;
	
	if (!angular.isUndefined(id)) {
		self.edit = true;
		
		formService.get(id)
		.then(
			function(form) {
				self.form = form;
				console.log('form: ', self.form);
			},
			function(err) {
				console.error('Error while fetching form information');
			}
		);
		
		fileService.getFormFile(id)
		.then(
			function(files) {
				// List형태의 결과를 받지만, 양식은 항상 하나의 파일만 등록되어 있다.
				self.formFile = files;
				if (files.length == 0)
					self.hasFormFile = false;
				else {
					fileService.hasFormFile = true;
					fileService.uploadCompleted = true;
				}
			},
			function(err) {
				console.error('Error while fetching file file');
			}
		);
	}
	
	/**
	 * 처리부서 선택 화면 표시
	 * 처리부서는 필요한 경우에만 표시된다.
	 * 부서 선택 창을 사용하기 위해서는 common_tree.js가 필요하고, 페이지에 회사 정보(company)가 정의되어야 한다. (복잡하다... )
	 */
	self.selectProcessDepartment = function() {
		selectDepartment.show()
		.then(
			function(dept) {
				if (dept.id != -9999) {
					self.form.procDept = dept.id;
					self.form.procDeptName = dept.name;
				}
			},
			function(err) {
				console.error('Error while showing selectDepartment modal window');
			}
		);
	};
	
	self.deleteProcessDepartment = function() {
		self.form.procDept = '';
		self.form.procDeptName = '';
	}
	
	self.submit = function() {
		if (!fileService.hasFormFile) {
			warningModal.setTitle('!!확인!!');
			warningModal.setContent('양식 파일이 등록되지 않았습니다.');
			warningModal.show()
			.then(
				function(res) {
					return false;
				},
				function(err) {
					return false;
				}
			);
			return false;
		}
		
		if (!fileService.uploadCompleted) {
			warningModal.setTitle('!!확인!!');
			warningModal.setContent('양식 파일이 업로드되지 않았습니다.');
			warningModal.show()
			.then(
				function(res) {
					fileService.uploadCompleted = false;
					return false;
				},
				function(err) {
					return false;
				}
			);
			return false;
		}
		
		if (self.edit) {
			updateForm();
		} else {
			self.form.id = fileService.uploadedFile;
			saveForm();
		}
	};
	
	function updateForm() {
		console.log('update form: ', self.form);
		// 양식 파일을 업로드 한다. 단, 양식 파일이 수정되지 않았으면 업로드 하지 않는다.
		// 양식 파일은 self.formFile.length == 0이면 파일이 삭제되고 수정된 양식이다.
		formService.update(self.form)
		.then(
			function(form) {
				if (self.formFile.length == 0)
					saveFormFileToAttachFileTable();
				$window.location = '/bpms/admin/form';
			},
			function(err) {
				console.error('Error while updating form information');
			}
		);
	}
	
	function saveForm() {
		console.log('self.form :', self.form);
		formService.save(self.form)
		.then(
			function(form) {
				console.log('successfully form: ', form);
				self.form = form;
				// save form file to attach_file table
				saveFormFileToAttachFileTable();
				
				// parsing form file and save form_field table
				saveFormFieldTable();
				
				//$window.location = '/bpms/admin/form';
			},
			function(err) {
				console.error('Error while saving form');
			}
		);
	}
	
	self.deleteFormFile = function() {
		deleteConfirm.show()
		.then(
			function(res) {
				if (res == 'yes')
					deleteFormFile();
			},
			function(err) {
				console.error('Error show delete confirm modal window');
			}
		);
	}
	
	function deleteFormFile() {
		console.log('formFile: ', self.formFile);
		// 서버에서 첨부 파일을 삭제한다.
		fileService.deleteFormFile(self.formFile[0].name)
		.then(
			function(file) {
				self.formFile = [];
				self.hasFormFile = false;
			},
			function(err) {
				console.error('Error while deleting form file');
			}
		);
	}
	
	/**
	 * file_attach table에 양식 파일을 등록한다.
	 */
	function saveFormFileToAttachFileTable() {
		var filePath = fileService.uploadedFile;
		var path = filePath.substr(0, filePath.lastIndexOf("/") + 1);
		var name = filePath.substr(path.length, filePath.length);
		var file = {
			attachId: '',
			type: fileService.fileType,
			path: path,
			name: name,
			originName: fileService.originFileName,
			mainId: self.form.id,
			size: fileService.fileSize
		}
		
		fileService.saveFormFile(file)
		.then(
			function(files) {
				console.log('saved form file successfully: ', files);
			},
			function(err) {
				console.log('Error while saving form file to database table');
			}
		);
	}
	
	function saveFormFieldTable() {
		formService.saveFormField(self.form.id)
		.then(
			function(formFields) {
				console.log('formFields: ', formFields);
			},
			function(err) {
				console.error('Error while save form field');
			}
		);
	}
}])
.controller('listController', ['formService', 'deleteConfirm', '$location', function(formService, deleteConfirm, $location) {
	var self = this;
	self.forms = [];
	
	function getFormList() {
		formService.list()
		.then(
			function(list) {
				self.forms = list;
			},
			function(err) {
				console.error('Error while fetching form list');
			}
		);
	}
	
	getFormList();
	
	self.add = function() {
		$location.path("/regist_form");
	};
	
	function spliceForms(id) {
		for (var i = 0; i < self.forms.length; i++) {
			if (self.forms[i].id == id) {
				self.forms.splice(i, 1);
				break;
			}
		}
	}
	
	function deleteForm(id) {
		formService.remove(id)
		.then(
			function(form) {
				// self.forms[]에서 해당 아이디 삭제
				spliceForms(id);
			},
			function(err) {
				console.error('Error while deleting form');
			}
		);
	}
	
	self.remove = function(id) {
		console.log('remove: ' + id);
		deleteConfirm.show()
		.then(
			function(res) {
				if (res == 'yes')	deleteForm(id);
			},
			function() {
				console.error('Error while show delete confirm modal window');
			}
		);
	};
	
	self.edit = function(id) {
		console.log('/edit_form/' + id);
		$location.path("/edit_form/" + id);
	}
}]);