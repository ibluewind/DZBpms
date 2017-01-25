App
.service('fileService', ['$http', '$q', function($http, $q) {
	this.uploadCompleted = false;
	this.hasFormFile = false;
	this.uploadedFile = '';
	this.originFileName = '';
	this.fileType = '';
	this.fileSize = 0;
	
	this.deleteFile = function() {
		var deferred = $q.defer();
		
		console.log('deleting : ' + this.uploadedFile);
		
		$http({
			url: '/bpms/rest/form/file/' + this.uploadedFile,
			method: 'DELETE',
			responseType: 'text'
		}).then(
			function(response) {
				console.log(response.data);
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
				
		return deferred.promise;
	};
	
	this.saveFormFile = function(file) {
		var files = [];
		var deferred = $q.defer();
		
		console.log('file: ', file);
		files.push(file);
		$http.post('/bpms/rest/file', files)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
		
	};
	
	this.getFormFile = function(id) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/file/' + id)
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.deleteFormFile = function(name) {
		var deferred = $q.defer();
		
		$http.delete('/bpms/rest/file/' + name + '/')
		.then(
			function(response) {
				deferred.resolve(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
}]);