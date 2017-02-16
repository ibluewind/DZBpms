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
.controller('editAppController', ['approveStatus', 'approveTrayType', 'approveService', 'userService', 'selectUserModal', 'deleteConfirm', 'insertCommentModal', 'confirmModal', '$rootScope', '$routeParams', '$filter', '$location', '$alert',
	function(approveStatus, approveTrayType, approveService, userService, selectUserModal, deleteConfirm, insertCommentModal, confirmModal, $rootScope, $routeParams, $filter, $location, $alert) {

	// 결재 문서 작성
	var self = this;
	var formId = '';
	var appId = '';
	var action = $routeParams.action;
	var document = {}, approve = {};
	var history = {};
	var prevUrl = $rootScope.prevUrl || '/list_app';
	
	self.histories = [];
	self.edit = false;
	self.proc = false;
	self.owner = true;
	self.canEditLine = false;
	self.changedLine = false;
	
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
				
				setApproveLineType('R');
				
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
				
				self.histories = results[5].data;
				self.summary = document.summary;
				self.form = document.form;
				self.form.fields = document.form.fields;
				
				self.approveTrays = approve.trays;
				self.approveLine = approve.lines;
				
				if (self.user.userId != self.summary.userId) {
					// 결재자가 결재문서를 확인한 경우 결재 이력을 저장한다.
					history.appId = self.summary.appId;
					history.status = approveStatus.CHECKED;
					approveService.saveApproveHistory(history);
					
					self.owner = false;
				}
				history.appId = self.summary.appId;
				
				// 처리부서로 전달된 경우, 결재라인 길이와 결재함 길이가 다르다.
				console.log('tray: ', self.approveTrays);
				console.log('lines: ', self.approveLine);
				if (self.approveTrays.length > self.approveLine.length) {
					// 문서 담당자가 아닌 경우에는 아래 코드를 진행하지 않는다.
					// 문서 담당자의 결재라인을 조회하여 추가한다.
					approveService.getApproveLine(document.form.formId)
					.then(
						function(lines) {
							console.log('Process lines: ', lines);
							// 조회된 결재라인을 기존 결재라인에 추가하되 type을 'P'로 변경한다.
							// 또한, 추가된 결재라인의 결재 문서 아이디를 설정한다.
							for (var i = 0; i < lines.length; i++) {
								lines[i].type = 'P';
								lines[i].appId = document.summary.appId;
								self.approveLine.push(lines[i]);
							}
							
							self.canEditLine = true;
						},
						function(err) {
							console.error('Error while fetching approve lines of processing department');
						}
					);
				}
			},
			function(err) {
				console.error('Error while fetching Approve Document Information');
			}
		);
	}
	
	function setApproveLineType(type) {
		for (var i = 0; i < approve.lines.length; i++)
			approve.lines[i].type = type;
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
	
	/**
	 * 결재라인 추가/삭제 후에 seq를 재 정리한다.
	 */
	function resetApproveLine(type) {
		var idx = 0;
		for (var i = 0; i < self.approveLine.length; i++) {
			if (self.approveLine[i].type != type)	continue;
			self.approveLine[i].seq = idx++;
		}
	}
	
	self.addApproveLine = function(index, type) {
		var line = {};
		
		selectUserModal.show()
		.then(
			function(user) {
				console.log('user: ', user);
				if (user.id == -9999)	return false;
				
				self.changedLine = true;
				
				line.appId = document.summary.appId;
				line.lineId = '';
				line.approvalId = user.userId;
				line.approvalName = user.lastName + user.firstName;
				line.approvalPosition = user.deptPositions[0].positionName;
				line.modified = '';
				line.seq = index;
				line.status = 'P';
				line.type = type;
				
				// 처리부서 결재라인을 변경하는 경우라면, 의뢰부서 결재라인 길이에 더해야한다.
				if (type == 'P')	index = $filter('filter')(self.approveLine, {type: 'R'}).length + index;
				self.approveLine.splice(index, 0, line);
				
				resetApproveLine(type);
			}
		);
	};
	
	self.deleteApproveLine = function(index, type) {
		// 처리부서 결재라인을 변경하는 경우라면, 의뢰부서 결재라인 길이에 더해야한다.
		if (type == 'P')	index = $filter('filter')(self.approveLine, {type: 'R'}).length + index;
		self.approveLine.splice(index, 1);
		self.changedLine = true;
		
		resetApproveLine(type);
	};
	
	function saveApproveDocument(status) {
		document.form.formFields = approveService.makeFormField(self.form.fields);
		
		// ApproveSummary 부터 저장한 후, FromFields를 저장한다.
		history.status = status;
		
		// 결재라인이 추가되었거나 삭제되었을 수 있으므로 결재라인 순번을 재정리한다.
		// 결재라인은 의뢰부서와 처리부서를 분리하여 정리하여야 함.
		if (self.canEditLine) {
			// 처리부서 결재 라인을 정리
			var idx = 0;
			for (var i = 0; i < approve.lines.length; i++) {
				if (approve.lines[i].type == 'P') {
					idx = i;
					break;
				}
			}
			
			var seq = 0;
			for (var i = idx; i < approve.lines.length; i++) {
				approve.lines[i].seq = seq;
				if (seq == 0)
					approve.lines[i].status = approveStatus.FINISH;
				else
					approve.lines[i].status = status;
				seq++;
			}
		} else {
			// 의뢰부서 결재 라인을 정리하는 것이지만, 작성자가 저장이나 상신하는 경우이므로 전체 결재라인을 정리해도 됨.
			for (var i = 0; i < approve.lines.length; i++) {
				approve.lines[i].seq = i;
				
				// 작성자가 상신하는 경우, 작성자의 결재 상태는 완료이다.
				if (status == approveStatus.PROCESSING && i == 0)
					approve.lines[i].status = approveStatus.FINISH;
				else
					approve.lines[i].status = status;
			}
		}
		
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
		else if (action == 'edit') {
			console.log('update approve document');
			console.log('document: ', document);
			console.log('approve: ', approve);
			console.log('history: ', history);
			console.log('status: ', status);
			return approveService.updateApproveDocument(document, approve, history, status);
		} else {
			// 처리부서에서 승인 하는 경우이다.
			// 처리부서에서의 승인 처리는 결재라인을 추가하여 등록하고, 결재함을 처리한다.
			return;
		}
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
	function makeApproveTrays(appId, lines) {
		var trays = [];
		
		for (var i = 0; i < lines.length; i++) {
			var tray = {};
			
			tray.appId = appId
			tray.userId = lines[i].approvalId;
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
					var trays = makeApproveTrays(data.appId, approve.lines);
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
			// 결재자가 결재하는 경우. 또는 처리부서에서 문서 담당자가 결재 문서를 승인하는 경우.
			// 결재자의 결재함 정보를 수정하고, 결재라인 정보를 수정한다.
			// 다음 결재자의 결재함 정보 수정과 결재 완료에 대한 후 처리는 WAS에서 처리한다.
			
			if (self.canEditLine) {
				// 처리부서 문서 담당자가 승인하는 경우에는 결재 라인과 결재함 만 추가로 등록하면 된다.
				saveApproveDocument(approveStatus.PROCESSING);	// 결재라인만 정리한다.
				var lines = $filter('filter')(approve.lines, {type: 'P'});
				console.log('process lines: ', lines);
				
				var trays = makeApproveTrays(document.summary.appId, lines);

				// 처리부서의 결재라인과 결재함을 등록한다.
				approveService.processApproveDocument(lines, trays, history)
				.then(
					function(result) {
						console.log('Save processing department document successfully');
					},
					function(err) {
						console.error('Error while saving process department document');
					}
				);
			} else {
				var line = getUserApproveLine();
				var summary = document.summary;
				
				approveService.submitApprove(summary, line, history)
				.then(
					function(data) {
						$location.path(prevUrl);
					},
					function(err) {
						console.error('Error while submit Approve');
					}
				);
			}
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
	
	self.statusName = function(history) {
		var status = history.status;
		var statusName = "Unknown";
		
		switch(status) {
		case approveStatus.CHECKED:
			statusName = "확인";
			break;
		case approveStatus.SAVED:
			statusName = "저장";
			break;
		case approveStatus.DEFERRED:
			statusName = "보류";
			break;
		case approveStatus.REJECT:
			statusName = "반려";
			break;
		case approveStatus.PROCESSING:
			if (history.userId == document.summary.userId)		// 작성자인경우
				statusName = "상신";
			else
				statusName = "승인";
			break;
		case approveStatus.FINISH:
			statusName = "결재완료";
			break;
		}
		
		return statusName;
	};
	
	// 현재 결재라인을 사용자 지정 결재라인으로 저장
	self.saveCustomApproveLine = function(type) {
		confirmModal.setTitle("결재라인저장");
		confirmModal.setContent("현재 결재라인을 저장하시겠습니까?");
		confirmModal.show()
		.then(
			function(answer) {
				if (answer == "no")		return false;
				var lines = $filter('filter')(approve.lines, {type: type});
				console.log('lines: ', lines);
				approveService.saveCustomApproveLine(document.form.formId, lines)
				.then(
					function(data) {
						console.log('saved custom approve line: ', data);
						$alert({
							title: '저장 완료',
							content: '현재 결재 라인을 사용자 지정 결재라인으로 저장하였습니다.',
							placement: 'top',
							type: 'info',
							show: true
						});
					},
					function(err) {
						console.error('Error while saving custom approve lines');
					}
				);
			},
			function(err) {
				console.error('Error while show confirm modal window');
			}
		);
	}
	
	/**
	 * fileters
	 */
	self.onlyRequestApproveLine = function(line) {
		return line.type == 'R';
	}
	
	self.onlyProcessingApproveLine = function(line) {
		return line.type == 'P';
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
.controller('viewAppController', ['approveService', '$routeParams', '$rootScope', '$location',
									function(approveService, $routeParams, $rootScope, $location) {
	// 결재 문서의 단순 열람을 위한 콘트롤러
	// 본인이 상신한 결재, 기결함, 예결함, 완료함에 있는 결재 문서는 단순 열람만 가능하다.
	var self = this;
	var appId = $routeParams.appId;
	var document = {}, approve = {}, histories = [];
	var prevUrl = $rootScope.prevUrl || '/list_app';
	
	console.log('prevUrl: ', prevUrl);
	
	/**
	 * 모든 결재 명령에 대한 조겅늘 false로 하여, 취소만 가능하게 한다.
	 */
	self.edit = false;
	self.proc = true;
	self.owner = true;
	self.canEditLine = false;
	
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
			
			self.histories = results[5].data;
			self.summary = document.summary;
			self.form = document.form;
			self.form.fields = document.form.fields;
			
			self.approveTrays = approve.trays;
			self.approveLine = approve.lines;
		},
		function(err) {
			console.error('Error while fetching Approve Document Information');
		}
	);
	
	self.cancelApprove = function() {
		$location.path(prevUrl);
	}
	
	/**
	 * fileters
	 */
	self.onlyRequestApproveLine = function(line) {
		return line.type == 'R';
	}
	
	self.onlyProcessingApproveLine = function(line) {
		return line.type == 'P';
	}
}])
.controller('trayAppController', ['approveService', 'approveStatus', 'approveTrayType', '$routeParams', '$rootScope',
                                       function(approveService, approveStatus, approveTrayType, $routeParams, $rootScope) {
	var self = this;
	var prevUrl = '';
	var type = $routeParams.type;
	
	self.documents = [];
	
	$rootScope.$on('$locationChangeSuccess', function(e, newUrl, oldUrl, newState, oldState) {
		prevUrl = oldUrl.substring(oldUrl.indexOf('#') + 1);
		console.log('prevUrl: ' + prevUrl);
		$rootScope.prevUrl = prevUrl;
	});
	
	console.log('type: ', type);
	approveService.getTray(type)
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
.controller('completedAppController', ['approveService', '$routeParams', function(approveService, $routeParams) {
	var self = this;
	var appId = $routeParams.appId;
	
	console.log('appId: ' + appId);
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
.controller('manageAppLineController', ['approveService', function(approveService) {
	var self = this;
	
	self.summaries = [];
	self.summary = {};
	self.customAppLines = [];
	
	approveService.getCustomApproveLineSummaryList()
	.then(
		function(data) {
			self.summaries = data;
			console.log('summaries: ', self.summaries);
		},
		function(err) {
			console.error('Error while fetching custom approve line summary list');
		}
	);
	
	self.editSummaryInfo = function(lineId) {
		approveService.getCustomApproveLineInfo(lineId)
		.then(
			function(results) {
				self.summary = results[0].data;
				console.log('summary: ', self.summary);
				self.customAppLines = results[1].data;
				console.log('lines: ', self.customAppLines);
			},
			function(err) {
				console.error('Error while fetching custom approve line information'); 
			}
		);
	};
}]);