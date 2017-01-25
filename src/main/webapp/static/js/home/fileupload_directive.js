App
.directive('fileUploader', ['$scope', '$cookies', 'FileUploader', function($scope, $cookies, FileUploader) {
	return {
		restrict: 'EA',
		template: '/bpms/common/fileupload',
		scope: {
			service: '=',
			uploader: '=',
			filters: '@fileters',
			remove: '&removeItem',
			clearQueue: '&clearQueue'
		}
	}
}]);