'use strict';

/**
 * 결재에 대한 자료 구조는 두 가지로 분리한다.
 * 1. Document
 * 	Document는 결재 양식에 대한 정보이면, 양식 모양(템플릿)과 양식 필드, 문서 요약 정보 (approve_summary)로 구성된다.
 * 	전체적인 구조는 다음과 같다.
 * 	document
 * 	document.form : Form.java에 해당한다.
 * 	document.form.fields : FormField.java에 해당하며 배열 형태이다.
 * 	document.summary : ApproveSummary.java에 해당한다.
 * 
 * 2. Approve
 * Approve는 실제 결재 진행에 필요한 정보이며, 결재라인(ApproveLine)과 결재함(ApproveTray) 정보로 구성된다.
 * 전체적인 구조는 다음과 같다.
 * approve
 * approve.line : ApproveLine.java에 해당하며 배열 형태이다.
 * approve.tray : ApproveTray.java에 해당하며 배열 형태 또는 단독 오브젝트이다.
 */
App
.controller('editAppController', ['approveStatus', 'approveTrayType', 'approveService', 'userService', 'selectUserModal', 'deleteConfirm', 'insertCommentModal', '$rootScope', '$routeParams', '$location',
	function(approveStatus, approveTrayType, approveService, userService, selectUserModal, deleteConfirm, insertCommentModal, $rootScope, $routeParams, $location) {

	// 결재 문서 작성
	var self = this;
	var formId = '';
	var appId = '';
	var action = $routeParams.action;
	var document = {}, approve = {};
	var history = {};
	var prevUrl = $rootScope.prevUrl || '/list_app';
	
	self.edit = false;
	self.proc = false;
	self.owner = true;
	
	if (action == 'regist') {
		formId = $routeParams.id;
		appId = '';
		self.edit = true;
	} else if (action == 'edit' || action == 'proc') {
		formId = '';
		appId = $routeParams.id;
	}
	
	console.log('action = ' + action + ', appId = ' + appId + ', formId = ' + formId);
	
	if (action == 'edit')	self.edit = true;		// 수정 가능
	if (action == 'proc')	self.proc = true;		// 수정 불가, 결재 가능
	
	self.user = userService.getLoggedInUser();
	
	history.historyId = '';
	history.appId = '';
	history.comment = '';
	history.created = '';
	history.userId = self.user.userId;
	
	if (action == 'regist') {
		// 결재 양식 정보 조회
		approveService.getDocumentInformation(formId)
		.then(
			function(results) {
				document.form = results[0].data;
				document.form.formId = formId;
				document.form.fields = approveService.parseFormField(results[1].data);
				document.summary = {};
				
				approve.lines = results[2].data;
				
				console.log('DEBUG: document: ', document);
				console.log('DEBUG: approve: ', approve);
				
				self.form = document.form;
				self.form.fields = document.form.fields;
				self.approveLine = approve.lines;
				
				/**
				 * 양식 기본 필드 설정
				 */
				self.form.fields['userName'] = self.user.lastName + self.user.firstName;
				self.form.fields['deptName'] = self.user.deptPositions[0].deptName;
				self.form.fields['positionName'] = self.user.deptPositions[0].positionName;
			},
			function(err) {
				console.error('Error while fetching document form information');
			}
		);
	} else {
		// 저장된 결재 문서 정보 조회
		console.log('get saved document information');
		approveService.getSavedDocumentInformation(appId)
		.then(
			function(results) {
				console.log('results: ', results);
				
				document.summary = results[0].data;
				document.form = results[1].data;
				document.form.appId = document.summary.appId;
				document.form.formId = document.summary.formId;
				document.form.fields = approveService.parseFormField(results[2].data);
				
				approve.trays = results[3].data;
				approve.lines = results[4].data;
				
				self.summary = document.summary;
				self.form = document.form;
				self.form.fields = document.form.fields;
				
				self.approveTrays = approve.trays;
				self.approveLine = approve.lines;
				
				if (self.user.userId != self.summary.userId)	self.owner = false;
				history.appId = self.summary.appId;
			},
			function(err) {
				console.error('Error while fetching Approve Document Information');
			}
		);
	}
	
	self.dateDiff = function(start, end) {
		if (start == "" || end == "")	return 0;
		var milliDay = 1000 * 60 * 60 * 24;
		var days = Math.floor((new Date(end) - new Date(start)) / milliDay) + 1;
		
		return days < 0 ? 0 : days;
	};
	
	self.removeField = function(clause, index) {
		self.form.fields['fieldRows'][clause].splice(index, 1);
	};
	
	self.addField = function(clause) {
		var fields = {};
		for (var prop in self.form.fields['fieldRows'][clause][0]) {
			fields[prop] = "";
		}
		self.form.fields['fieldRows'][clause].push(fields);
	}
	
	self.cancelApprove = function() {
		console.log('prevUrl: ' + $rootScope.prevUrl);
		$location.path($rootScope.prevUrl);
	};
	
	self.addApproveLine = function(index) {
		var line = {};
		
		selectUserModal.show()
		.then(
			function(user) {
				console.log('user: ', user);
				if (user.id == -9999)	return false;
				
				line.appId = '';
				line.lineId = '';
				line.approvalId = user.userId;
				line.approvalName = user.lastName + user.firstName;
				line.approvalPosition = user.deptPositions[0].positionName;
				line.modified = '';
				line.seq = index;
				line.status = 'P';
				
				self.approveLine.splice(index, 0, line);
			}
		);
	};
	
	self.deleteApproveLine = function(index) {
		self.approveLine.splice(index, 1);
	};
	
	function saveApproveDocument(status) {
		document.form.appId = '';
		document.form.formFields = approveService.makeFormField(self.form.fields);
		
		// ApproveSummary 부터 저장한 후, FromFields를 저장한다.
		history.status = status;
		
		if (action == 'regist') {
			var summary = {};
			summary.appId= '';
			summary.formId = formId;
			summary.userId = self.user.userId;
			summary.created = '';
			summary.modified = '';
			summary.title = getFormTitle();
			summary.status = status;
			
			document.summary = summary;
			
			return approveService.saveApproveDocument(document, approve, history, status);
		}
		else if (action == 'edit')
			return approveService.updateApproveDocument(document, approve, history, status);
	}
	
	/**
	 * 결재 저장은 작성자만 수행할 수 있는 기능이다.
	 * 상신 이후에는 결재 저장을 수행할 수 있는 방법이나 플로우가 없다.
	 */
	self.saveApprove = function() {
		// 결재 임시 저장
		saveApproveDocument(approveStatus.SAVED)
		.then(
			function(data) {
				console.log('saved successfully: ', data);
			},
			function(err) {
				console.error('Error while saving Approve document');
			}
		);
		
		$location.path(prevUrl);
	};
	
	/**
	 * 사용자의 결재라인 정보를 이용하여 결재함 목록을 생성한다.
	 */
	function makeApproveTrays(appId) {
		var trays = [];
		
		for (var i = 0; i < approve.lines.length; i++) {
			var tray = {};
			
			tray.appId = appId
			tray.userId = approve.lines[i].approvalId;
			tray.modified = '';
			
			if (i == 0)
				tray.type = approveTrayType.COMPLETED;		// 작성자 본인은 완료함
			else if (i == 1)
				tray.type = approveTrayType.UNDECIDE;		// 다음 결재자는 미결함
			else
				tray.type = approveTrayType.EXPECTED;		// 그 외의 결재자는 예정함
			
			trays.push(tray);
		}
		return trays;
	}
	
	/**
	 * 작성자가 작성한 문서를 상신하거나, 결재자가 상신된 문서를 결재한다.
	 */
	self.submitApprove = function() {
		var	trays = [];
		if (action == 'regist' || action == 'edit') {
			saveApproveDocument(approveStatus.PROCESSING)
			.then(
				function(data) {
					// 결재함을 등록한다.
					var trays = makeApproveTrays(data.appId);
					approveService.saveTray(trays)
					.then(
						function(result) {
							console.log('save approve trays successfully: ', result);
						},
						function(err) {
							console.error('Error while saving approve trays');
						}
					);
				},
				function(err) {
					console.error('Error while submit approve document');
					return;
				}
			);
		} else {
			// action == 'proc'
			// 결재자가 결재하는 경우
			// 결재자의 결재함 정보를 수정하고, 결재라인 정보를 수정한다.
			// 다음 결재자의 결재함 정보 수정과 결재 완료에 대한 후 처리는 WAS에서 처리한다.
			var line = getUserApproveLine();
			approveService.submitApprove(line)
			.then(
				function(data) {
					var preUrl = $rootScope.prevUrl || '/list_app';
					$location.path($rootScope.prevUrl);
				},
				function(err) {
					console.error('Error while submit Approve');
				}
			);
		}
		
		$location.path(prevUrl);
	};
	
	/**
	 * 결재 문서 삭제
	 * 결재 문서 삭제는 사용자가 결재 문서 저장 후, 상신 전에 삭제할 수 있다.
	 */
	self.removeApprove = function() {
		var appId = self.summary.appId;
		
		if (!appId) {
			// 작성중이던 문서이므로 목록화면으로 이동한다.
			$location.path(prevUrl);
		} else {
			deleteConfirm.show()
			.then(
				function(answer) {
					if (answer == 'yes') {
						approveService.removeApprove(appId)
						.then(
							function(summary) {
								$location.path(prevUrl);
							},
							function(err) {
								console.error('Error while deleting approve document');
							}
						);
					}
				}
			);
		}
	};
	
	/**
	 * 결재 문서 보류
	 * 보류는 결재자가 결재를 미루는 명령으로, 기한은 정해지지 않는다.
	 * 결재자의 보류함에 결재 문서가 노출된다.
	 * 
	 * 결재자가 결재 문서를 보류하면, 결재 요약 정보(approve_summary)와 결재함 정보 (approve_tray)에 보류로 상태를 업데이트한다.
	 * 결재 이력 정보(approve_history)에 의견을 저장한다.
	 */
	self.deferApprove = function() {
		document.form.formFields = approveService.makeFormField(self.form.fields);
		
		// 결재를 보류할 때는 반드시 의견을 입력해야 한다.
		insertCommentModal.setTitle('결재 보류');
		insertCommentModal.setContent('보류 의견을 입력하십시오.');
		insertCommentModal.show()
		.then(
			function(comment) {
				history.comment = comment;
				
				approveService.deferApprove(self.user.userId, document, approve, history)
				.then(
					function(results) {
						console.log('Deferred document ' + results[0].appId + ' successfully');
						$location.path(prevUrl);
					},
					function(err) {
						console.error('Error while saving defered approve document');
					}
				);
			},
			function(err) {
				console.error('Error while show comment modal window');
			}
		);
	}
	
	function getUserApproveLine() {
		var line = {};
		for (var i = 0; i < self.approveLine.length; i++) {
			if (self.approveLine[i].approvalId == self.user.userId) {
				line = self.approveLine[i];
				break;
			}
		}
		
		console.log('user line: ', line);
		return line;
	}
	
	self.cancelApprove = function() {
		$location.path('/list_app');
	}
	
	function saveHistory(history) {
		approveService.saveApproveHistory(history)
		.then(
			function(data) {
				console.log('Saved approve history: ', data);
			},
			function(err) {
				console.error('Error while saving approve history');
			}
		);
	}
	
	function saveApproveLine(appId, status) {
		
		for (var i = 0; i < self.approveLine.length; i++) {
			self.approveLine[i].appId = appId;
			self.approveLine[i].status = status;
		}
		
		console.log('approveLine: ', self.approveLine);
		
		approveService.saveApproveLine(self.approveLine)
		.then(
			function(lines) {
				self.approveLine = lines;
				console.log('Save Approve line successfully');
				console.log('lines: ', lines);
			},
			function(err) {
				console.error('Error while saving Approve Lines');
			}
		);
	}
	
	function saveApproveFormField(form) {
		console.log('save form fields: ', form);
		
		// formField 저장
		approveService.saveApproveFormFields(form)
		.then(
			function(result) {
				console.log('saved successfully result: ', result);
			},
			function(err) {
				console.error('Error while saving Approve Form Fields information');
			}
		);
	}
	
	function getFormTitle() {
		var title = '';
		
		if (angular.isUndefined(self.form.fields['title'])) {
			title = self.form.title;
		} else {
			title = self.form.fields['title'];
		}
		
		return title;
	}
}])
.controller('listAppController', ['approveService', 'userService', 'approveStatus', '$rootScope',
                                  function(approveService, userService, approveStatus, $rootScope) {
	var self = this;
	self.forms = [];
	self.summaries = [];
	self.user = {};
	
	$rootScope.$on('$locationChangeSuccess', function(e, newUrl, oldUrl, newState, oldState) {
		$rootScope.prevUrl = oldUrl.substring(oldUrl.indexOf('#') + 1);
	});
	self.user = userService.getLoggedInUser();
	
	approveService.getFormList()
	.then(
		function(forms) {
			self.forms = forms;
		},
		function(err) {
			console.error('Error whie fetching form liist');
		}
	);
	
	approveService.getApproveSummaryList(self.user.userId)
	.then(
		function(list) {
			self.summaries = list;
			console.log('self.summaries: ', self.summaries);
		},
		function(err) {
			console.error('Error while fetching approve summary list');
		}
	);
	
	//-- 상태 필터 --//
	self.filterSaved = function(summary) {
		return summary.status == approveStatus.SAVED;
	};
	
	self.filterProcessing = function(summary) {
		return (summary.status != approveStatus.SAVED && summary.status != approveStatus.FINISH);
	};
}])
.controller('undecideAppController', ['approveService', 'approveStatus', 'approveTrayType', '$rootScope',
                                       function(approveService, approveStatus, approveTrayType, $rootScope) {
	var self = this;
	var prevUrl = '';
	
	self.documents = [];
	
	$rootScope.$on('$locationChangeSuccess', function(e, newUrl, oldUrl, newState, oldState) {
		prevUrl = oldUrl.substring(oldUrl.indexOf('#') + 1);
		$rootScope.prevUrl = prevUrl;
	});
	
	approveService.getTray(approveTrayType.UNDECIDE)
	.then(
		function(list) {
			console.log(list);
			self.documents = list;
		},
		function(err) {
			console.error('Error while fetching undecide tray list;')
		}
	);
}])
.controller('deferAppController', [function() {
	
}])
.controller('decidedAppController', [function() {
	
}])
.controller('completedAppController', [function() {
	
}])
.controller('expectAppController', ['approveService', 'approveTrayType', '$rootScope',
                                    function(approveService, approveTrayType, $rootScope) {
	var self = this;
	
	self.documents = [];
	
	$rootScope.$on('$locationChangeSuccess', function(e, newUrl, oldUrl, newState, oldState) {
		$rootScope.prevUrl = oldUrl.substring(oldUrl.indexOf('#') + 1);
	});
	
	approveService.getTray(approveTrayType.EXPECTED)
	.then(
		function(list) {
			self.documents = list;
		},
		function(err) {
			console.error('Error while fetching expected tray list');
		}
	);
}])
.controller('manageAppLineController', [function() {
	
}]);