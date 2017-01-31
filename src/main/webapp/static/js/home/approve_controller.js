'use strict';

App
.controller('registAppController', ['approveStatus', 'approveService', 'userService', 'selectUserModal', '$routeParams', '$location',
	function(approveStatus, approveService, userService, selectUserModal, $routeParams, $location) {

	// 결재 문서 작성
	var self = this;
	var formId = '';
	var appId = '';
	var action = $routeParams.action;
	var history = {};
	
	history.historyId = '';
	history.appId = '';
	history.comment = '';
	history.created = '';
	history.userId = self.user.userId;
	
	self.edit = false;
	
	if (action == 'regist') {
		formId = $routeParams.id;
		appId = '';
		self.edit = true;
	} else if (action == 'edit' || action == 'proc') {
		formId = '';
		appId = $routeParams.id;
	}
	
	if (action == 'edit')	self.edit = true;
	
	self.form = {};
	self.form.fields = [];
	self.user = {};
	self.approveLine = [];
	self.summary = {};
	
	self.user = userService.getLoggedInUser();
	
	if (action == 'regist') {
		// 결재 양식 정보 조회
		approveService.getFormInformation(formId)
		.then(
			function(results) {
				self.form = results[0].data;
				self.form.fields = approveService.parseFormField(results[1].data);
				self.approveLine = results[2].data;
				
				self.form.fields['userName'] = self.user.lastName + self.user.firstName;
				self.form.fields['deptName'] = self.user.deptPositions[0].deptName;
				self.form.fields['positionName'] = self.user.deptPositions[0].positionName;
			},
			function(err) {
				console.error('Error while fetching document form information');
			}
		);
	} else {
		// 결재 문서 정보 조회
		approveService.getApproveDocumentInformation(appId)
		.then(
			function(results) {
				self.summary = results[0].data;
				self.form = results[1].data;
				self.form.fields = approveService.parseFormField(results[2].data);
				self.approveLine = results[3].data;
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
	
	self.saveApprove = function(status) {
		// 결재 임시 저장
		
		var formFields = approveService.makeFormField(self.form.fields);
		var form = {};
		
		form.appId = '';
		form.formId = formId;
		form.formFields = formFields;
		
		// ApproveSummary 부터 저장한 후, FromFields를 저장한다.
		var summary = {};
		summary.appId= '';
		summary.formId = formId;
		summary.userId = self.user.userId;
		summary.created = '';
		summary.modified = '';
		summary.title = getFormTitle();
		summary.status = status;
		
		history.status = status;
		
		approveService.saveApproveSummary(summary)
		.then(
			function(result) {
				form.appId = result.appId;
				history.appId = result.appId;
				
				saveApproveFormField(form);
				saveApproveLine(form.appId, status);
				
				saveHistory(history);
			},
			function(err) {
				console.error('Error while saving Approve Summary information');
			}
		);
		
		$location.path('/list_app');
	};
	
	/**
	 * 저장과 상신의 차이는 결재 문서 요약 정보의 상태로 판단한다.
	 * 상신하면, 다음 결재자의 미결함에 결재 문서를 저장한다.
	 */
	self.submitApprove = function() {
		// 결재 상신
		if (action == 'regist')
			self.saveApprove(approveStatus.PROCESSING);
		else if (action == 'edit'){
			// 이미 저장되어 있던 결재 문서를 상신
		} else {
			// action == 'proc'
			// 결재자가 결재하는 경우
		}
	};
	
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
.controller('editAppController', ['approveService', 'userService', 'approveStatus', 'confirmModal', 'selectUserModal', '$scope', '$routeParams', '$location', '$q', '$rootScope',
	function(approveService, userService, approveStatus, confirmModal, selectUserModal, $scope, $routeParams, $location, $q, $rootScope) {
	
	/**
	 * 작성자가 작성중인 결재 문서를 수정하는데 필요한 콘트롤러
	 */
	var self = this;
	var appId = $routeParams.appId;
	var	prevUrl = '';
	
	self.canApprove = false;
	self.canEdit = true;
	
	self.form = {};
	self.approveLine = [];
	self.summary = {}
	
	self.user = userService.getLoggedInUser();

	approveService.getApproveDocumentInformation(appId)
	.then(
		function(results) {
			self.summary = results[0].data;
			self.form = results[1].data;
			self.form.fields = approveService.parseFormField(results[2].data);
			self.approveLine = results[3].data;
		},
		function(err) {
			console.error('Error while fetching Approve Document Information');
		}
	);
	
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
	
	/**
	 * 결재 취소 또는 작성 취소. 결재함 목록으로 이동한다.
	 */
	self.cancelApprove = function() {
		console.log('prevUrl: ' + $rootScope.prevUrl);
		$location.path($rootScope.prevUrl);
	};
	
	self.removeApprove = function() {
		removeApprove();
	}
	
	self.saveApprove = function(status) {
		// 결재 임시 저장
		// 수정 화면이므로, 신규 저장이 아닌 업데이트어야 한다.
		
		var formFields = approveService.makeFormField(self.form.fields);	// formFields의 경우, 업데이트와 신규가 동시에 진행 될 수 있다. DAO에서 지우고 새로 넣는게 나을 듯...
		var form = {};
		form.appId = appId;
		form.formId = self.form.formId;
		form.formFields = formFields;
		
		// ApproveSummary 부터 저장한 후, FromFields를 저장한다.
		var summary = {};
		summary.appId= appId;
		summary.formId = form.formId;
		summary.userId = self.user.userId;
		summary.created = '';
		summary.modified = '';
		summary.title = getFormTitle();
		summary.status = status;
		
		approveService.updateApproveSummary(summary)
		.then(
			function(result) {
				// updateApproveSummary()를 호출하면, 기존의 approve_form_field 데이터는 삭제된다.
				saveApproveFormField(form);
				saveApproveLine(appId, status);
			},
			function(err) {
				console.error('Error while saving Approve Summary information');
			}
		);
		
		$location.path("/list_app");
	};
	
	self.submitApprove = function() {
		// 결재 상신
		self.saveApprove(approveStatus.PROCESSING);
	};
	
	function removeApprove() {
		confirmModal.setTitle('!! 주의 !!');
		confirmModal.setContent('작성 중이던 결재 문서가 삭제됩니다.');
		confirmModal.show()
		.then(
			function(ans) {
				if (ans == 'yes') {
					approveService.cancelApprove(appId)
					.then(
						function(summary) {
							$location.path('/list_app');
						},
						function(err) {
							console.error('Error while canceling Approve Document');
						}
					);
				}
			},
			function(err) {
				console.error('Error while show confirm modal window');
			}
		);
	}
	
	/**
	 * 저장되어 있는 결재 문서의 결재 라인을 재 저장하는 것이므로, update이다.
	 */
	function saveApproveLine(appId, status) {
		for (var i = 0; i < self.approveLine.length; i++) {
			self.approveLine[i].status = status;
		}
		
		approveService.updateApproveLine(appId, self.approveLine)
		.then(
			function(lines) {
				console.log('Save approve lines completed successfully');
			},
			function(err) {
				console.error('Error while updatind approve lines');
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
		
		console.log('form: ', self.form);
		if (angular.isUndefined(self.form.fields['title'])) {
			title = self.form.title;
		} else {
			title = self.form.fields['title'];
		}
		
		return title;
	}
}])
.controller('procAppController', ['approveService', 'userService', 'approveTrayType', '$routeParams', '$rootScope', '$location',
                                  function(approveService, userService, approveTrayType, $routeParams, $rootScope, $location) {
	/**
	 * 결재함에서 결재문서를 선택해서 결재를 진행하는 경우에 대한 콘트롤러
	 */
	var	self = this;
	var appId = $routeParams.appId;
	var user = {};
	var summary ={};
	var	approveTray = {};
	
	self.canApprove = true;
	self.canEdit = false;
	self.form = {};
	self.approveLine = [];
	
	user = userService.getLoggedInUser();
	
	approveService.getApproveDocumentInformation(appId)
	.then(
		function(results) {
			self.summary = results[0].data;
			self.form = results[1].data;
			self.form.fields = approveService.parseFormField(results[2].data);
			self.approveLine = results[3].data;
		},
		function(err) {
			console.error('Error while fetching Approve Document Information');
		}
	);
	
	approveService.getTrayForUserByApproveId(appId)
	.then(
		function(data) {
			approveTray = data;
			self.canApprove = checkCanApprove();
		},
		function(err) {
			console.error('Error while fetcing Approve Tray Information');
		}
	);
	
	/**
	 * 결재 승인
	 */
	self.submitApprove = function() {
		
	};
	
	/**
	 * 결재 취소
	 */
	self.cancelApprove = function() {
		$location.path($rootScope.prevUrl);
	};
	
	/**
	 * 결재 반려
	 */
	self.rejectApprove = function() {
		
	};
	
	/**
	 * 결재 보류
	 */
	self.deferApprove = function() {
		
	};
	
	/**
	 * 사용자가 결재를 진행할 수 있는 상태인지 체크
	 */
	function checkCanApprove() {
		var	check = false;
		
		console.log('user: ', user);
		/**
		 * 결재를 진행할 수 있는 조건은 현재 사용자가 결재자이며(이 부분은 이미 결재함을 통해서 진입을 했으므로 패스할 수 있다.),
		 * 현재 시점에서 사용자의 결재 순서가 일치해야 한다. (결재 순서는 결재 라인과 결재함 정보를 확인하여 처리할 수 있다.)
		 */
		for (var i = 0; i < self.approveLine.length; i++) {
			console.log('approveLine[' + i + ']:', self.approveLine[i]);
			
			if (user.userId == self.approveLine[i].approvalId) {
				check = true;
				break;
			}
		}
		
		console.log('approveTray: ', approveTray);
		
		if (check && (user.userId == approveTray.userId) && (approveTray.type == approveTrayType.UNDECIDE)) {
			check = true;
		} else {
			check = false;
		}
		
		return check;
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