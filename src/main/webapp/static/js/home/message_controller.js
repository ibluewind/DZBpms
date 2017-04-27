/**
 * Message Controller는 시스템에서 생성된 메시지를 사용자 화면에 표시하고, 사용자가 수행한 액션을 서버에 반영한다.
 */
App
.controller('messageController', ['messageService', '$interval', function(messageService, $interval) {
	var self = this;
	self.messages = [];
	
	// 사용자가 로그인한 경우, 시스템에 저장된 메시지를 조회하여 표시한다.
	function getUnreadMessages() {
		messageService.getUnreadMessages()
		.then(
			function(messages) {
				self.messages = messages;
				messageService.messages = messages;
				for (idx in self.messages) {
					self.messages[idx].selected = false;
				}
				
				console.log('DEBUG : messages : ', self.messages);
			},
			function(err) {
				console.error('Error while fetching unread messages');
			}
		);
	}
	
	getUnreadMessages();
	
	$interval(getUnreadMessages, 300000);		// 5분 마다 새로운 메시지 확인
	
	self.selectAllMessages = function(event) {
		var checked = event.currentTarget.checked;
		
		for (idx in self.messages)
			self.messages[idx].selected = checked;
	};
	
	self.checkAtLeastOne = function() {
		if (self.messages.length < 1)	return false;
		for (idx in self.messages) {
			if (self.messages[idx].selected)		return true;
		}
		
		return false;
	};
	
	self.deleteMessage = function() {
		for (idx in self.messages) {
			if (self.messages[idx].selected) {
				var	id = self.messages[idx].id; 
				messageService.deleteMessage(id)
				.then(
					function(msg) {
						console.log('Deleted Message ' + id);
						self.messages.splice(idx, 1);
					},
					function(err) {
						console.error('Error while delete message id: ' + id);
					}
				);
			}
		}
	};
	
	function setReadedMessage() {
		messageService.setReadedAll()
		.then(
			function(result) {
				/* do nothing */
			},
			function(err) {
				console.error('Error while set message to readed all');
			}
		);
	}
}]);