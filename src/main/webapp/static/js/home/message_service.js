App
.service('messageService', ['$http', '$q', function($http, $q) {
	this.messages = [];
	this.unreadmessages = [];
	
	this.getUnreadMessages = function() {
		var	deferred = $q.defer();
		
		$http.get('/bpms/rest/message/unread')
		.then(
			function(response) {
				deferred.resolve(response.data);
				console.log('unreadmessages: ', response.data);
			},
			function (err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.getMessageList = function() {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/message')
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
	
	this.setReadMessage = function(message) {
		var deferred = $q.defer();
		message.readYn = 'Y';
		
		$http.put('/bpms/rest/message/', message)
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
	
	this.deleteMessage = function(id) {
		var deferred = $q.defer();
		
		$http.delete('/bpms/rest/message/' + id)
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
	
	this.listAllMessages = function() {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/message')
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
	
	this.getMessage = function(id) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/message/' + id)
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
	
	this.setReadAll = function() {
		$http.get('/bpms/rest/message/readAll')
		.then(
			function(response) {
				this.unreadmessages = [];		// 초기화
				console.log('unreadmessages: ', this.unreadmessages);
				console.log('response: ', response);
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
}]);