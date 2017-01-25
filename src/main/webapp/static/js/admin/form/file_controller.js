App
.controller('fileController', ['$scope', '$cookies', 'FileUploader', 'fileService', 'warningModal',
			function($scope, $cookies, FileUploader, fileService, warningModal) {
	var self = this;
	var uploader = $scope.uploader = new FileUploader({
		url: '/bpms/file/form/upload',
		headers: {
			'X-XSRF-TOKEN': $cookies.get('XSRF-TOKEN')
		},
		queueLimit: 1
	});
	self.readyToUpload = false;
	
	uploader.filters.push({
		name: 'customFilter',
		fn: function(item, options) {
			console.log('item: ', item)
			console.log('options: ', options);
			return this.queue.length <= 1;
		}
	});
	
	self.remove = function(item) {
		if (item.isUploaded) {
			fileService.deleteFile()
			.then(
				function(name) {
					fileService.uploadCompleted = false;
			    	fileService.hasFormFile = false;
					console.log('successfully deleted');
				},
				function(err) {
					console.error('Error while deleting form file');
				}
			);
		}
		
		item.remove();
		uploader.clearQueue();
		$('#formFile').val("");		// <input type="file">의 내용을 지우지 않으면 같은 파일은 선택되지 않는다.
		self.readyToUpload = false;
	};
	
	// CALLBACKS
    uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
    };
    uploader.onAfterAddingFile = function(fileItem) {
    	/**
    	 * jsp 파일만 업로드 되도록 한다.
    	if (fileItem.file.type.indexOf("text") < 0) {
    		warningModal.setTitle("!!경고!!");
    		warningModal.setContent("텍스트 또는 HTML 형식의 파일을 업로드하십시오.");
    		warningModal.show()
    		.then(
    			function(res) {
    				self.remove(fileItem);
    				return false;
    			},
    			function(err) {
    				return false;
    			}
    		);
    		
    		return false;
    	}
    	**/
    	var fileName = fileItem.file.name;
    	var fileExt = fileName.substring(fileName.lastIndexOf("."), fileName.length);
    	
    	console.log('fileExt: ' + fileExt);
    	if (fileExt != ".jsp") {
    		warningModal.setTitle("!!경고!!");
    		warningModal.setContent("텍스트 또는 HTML 형식의 파일을 업로드하십시오.");
    		warningModal.show()
    		.then(
    			function(res) {
    				self.remove(fileItem);
    				return false;
    			},
    			function(err) {
    				return false;
    			}
    		);
    		
    		return false;
    	}
    	fileService.originFileName = fileItem.file.name;
    	fileService.fileSize = fileItem.file.size;
    	fileService.fileType = fileItem.file.type;
    	fileService.uploadCompleted = false;
    	fileService.hasFormFile = true;
    	self.readyToUpload = true;
    };
    uploader.onAfterAddingAll = function(addedFileItems) {
    	console.log('onAfterAddingAll');
    };
    uploader.onBeforeUploadItem = function(item) {
    	console.log('onBeforeUploadItem');
    };
    uploader.onProgressItem = function(fileItem, progress) {
    	console.log('onProgressItem');
    };
    uploader.onProgressAll = function(progress) {
    	console.log('onProgressAll');
    };
    uploader.onSuccessItem = function(fileItem, response, status, headers) {
    	console.log('onSuccessItem :', response[0]);
    };
    uploader.onErrorItem = function(fileItem, response, status, headers) {
    };
    uploader.onCancelItem = function(fileItem, response, status, headers) {
    };
    uploader.onCompleteItem = function(fileItem, response, status, headers) {
    	console.log('onCompletItem: ' + response[0]);
    	fileService.uploadedFile = response[0];
    };
    uploader.onCompleteAll = function() {
    	console.log('conCompleteAll');
    	fileService.uploadCompleted = true;
    };
}])