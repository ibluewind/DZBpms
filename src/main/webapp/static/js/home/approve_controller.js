'use strict';

App
.controller('registAppController', ['approveStatus', 'approveService', 'userService', 'selectUserModal', '$routeParams', '$location',
	function(approveStatus, approveService, userService, selectUserModal, $routeParams, $location) {
	// 결재 문서 작성 (처음 작성을 시작)
	var self = this;
	var formId = $routeParams.formId;
	self.edit = true;
	self.submit = false;
	
	self.form = {};
	self.form.fields = [];
	self.user = {};
	self.approveLine = [];
	
	self.form.formId = formId;
	
	self.user = userService.getLoggedInUser();
	
	approveService.getFormInfo(formId)
	.then(
		function(result) {
			self.form = result;
		},
		function(err) {
			console.error('Error while fetching form information');
		}
	);
	
	// 사용자와 양식에 대한 결재 라인을 조회한다.
	// 사용자 정보는 WAS에서 조회하여 처리한다. controller에서는 양식 아이디만 제공한다.
	approveService.getApproveLine(formId)
	.then(
		function(lines) {
			self.approveLine = lines;
		},
		function(err) {
			console.error('Error while fetching approve lines');
		}
	);
	
	if (!angular.isUndefined(formId)) {
		approveService.getFormFields(formId)
		.then(
			function(fields) {
				self.form.fields = approveService.parseFormField(fields);
				self.form.fields['userName'] = self.user.lastName + self.user.firstName;
				self.form.fields['deptName'] = self.user.deptPositions[0].deptName;
				self.form.fields['positionName'] = self.user.deptPositions[0].positionName;
			},
			function(err) {
				console.error('Error while fetching form fields');
			}
		);
	} else {
		self.form.fields['fieldRows'] = [];
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
		$location.path('/list_app');
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
		
		approveService.saveApproveSummary(summary)
		.then(
			function(result) {
				form.appId = result.appId;
				saveApproveFormField(form);
				saveApproveLine(form.appId, status);
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
		self.saveApprove(approveStatus.PROCESSING);
	};
	
	self.cancelApprove = function() {
		$location.path('/list_app');
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
	
	//TODO 결재권한과 owner권한을 구분할 수 있게 처리한다.
	// approve_command.jsp에서 단순한 권한으로 명령 버튼을 설정할 수 있게한다.
	var self = this;
	var appId = $routeParams.appId;
	var	prevUrl = '';
	
	self.edit = true;
	self.submit = false;
	self.owner = false;
	self.form = {};
	self.approveLine = [];
	self.summary = {}
	
	self.user = userService.getLoggedInUser();

	approveService.getApproveSummary(appId)
	.then(
		function(summary) {
			self.summary = summary;
			if (summary.status == approveStatus.PROCESSING) {
				self.edit = false;
				self.submit = true;
			}
			if (self.user.userId == summary.userId)
				self.owner = true;
		},
		function(err) {
			console.error('Error while fetching Approve summary information');
		}
	);

	approveService.getApproveForm(appId)
	.then(
		function(results) {
			getSavedApproveLine(appId);
			self.form = results[0].data;
			self.form.fields = approveService.parseFormField(results[1].data);
		},
		function(err) {
			$q.reject(err);
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
	
	
	function getSavedApproveLine(appId) {
		approveService.getSavedApproveLine(appId)
		.then(
			function(lines) {
				console.log('lines: ', lines);
				self.approveLine = lines;
			},
			function(err) {
				console.error('Error while fetching saved approve lines');
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