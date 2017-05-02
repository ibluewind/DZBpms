'use strict';

App
.controller('viewTask', ['taskStatus', 'taskService', 'userService', 'warningModal', 'insertCommentModal', 'historyModal', 'confirmModal', 'selectUserModal', '$window', '$routeParams', '$location',
function(taskStatus, taskService, userService, warningModal, insertCommentModal, historyModal, confirmModal, selectUserModal, $window, $routeParams, $location) {
	var self = this;
	var taskId = $routeParams.taskId;
	
	self.user = {};
	self.task = {};
	self.orgTask = {};
	self.taskHistory = [];
	self.attachFiles = [];
	self.addAttach = false;
	self.iamWorker = false;
	self.task.action ='';
	self.statusName  ='';
	
	function getTask() {
		taskService.getByTaskId(taskId)
		.then(
			function(task) {
				console.log('viewTask: ', task);
				self.task = task;
				self.orgTask = angular.copy(self.task);
				self.statusName = taskService.getStatusName(self.task.status);
				
				// 담당자가 작업을 확인한 경우에는 상태를 '진행중'으로 변경한다.
				if (self.task.workerId == self.user.userId) {
					console.log('user: ', self.user);
					self.iamWorker = true;
					
					if (self.task.status == taskStatus.NEW || self.task.status == taskStatus.RESUBMIT || self.task.status == taskStatus.DELEGATE) {
						self.task.status = taskStatus.PROCESS;
						self.task.action = "작업확인";
						
						taskService.updateTask(self.task)
						.then(
							function(task) {
								self.task = task;
							},
							function(err) {
								console.error('Error while updating task information');
							}
						);
					} else if (self.task.status == taskStatus.HOLD) {
						confirmModal.setTitle('보류 작업');
						confirmModal.setContent('보류된 작업니다. 작업을 진행하시겠습니까?');
						confirmModal.show()
						.then(
							function(answer) {
								if (answer == 'yes') {
									// 작업 상태를 진행중으로 변경한다.
									// 작업 기한을 변경해야하는데...
									self.task.status = taskStatus.PROCESS;
									self.task.action = "보류 해제";
									taskService.updateTask(self.task)
									.then(
										function(task) {
											self.task = task;
										},
										function(err) {
											console.error('Error while updating task information');
										}
									);
								} else {
									self.iamWorker = false;
								}
							}
						);
					} else if (self.task.status == taskStatus.REJECT || self.task.status == taskStatus.FINISH || self.task.status == taskStatus.CANCEL) {
						// 반려, 취소, 완료된 문서는 수정할 수 없음.
						self.iamWorker = false;
					}
				}
			},
			function(err) {
				console.error('Error while fetching task information');
			}
		);
	}
	
	self.user = JSON.parse($window.sessionStorage.getItem("currentUser"));
	getTask();
	
	taskService.listTaskHistory(taskId)
	.then(
		function(histories) {
			self.taskHistory = histories;
		},
		function(err) {
			console.error('Error while fetching task histories');
		}
	);
	
	taskService.getAttachByTaskId(taskId)
	.then(
		function(attachFiles) {
			self.attachFiles = attachFiles;
		},
		function(err) {
			console.error('Error while fetching attached file list');
		}
	);
	
	// 작업 수정의 마지막 단계이다.
	function uploadAttachFile(taskId) {
		// 첨부 파일을 업로드한다.
		// 첨부 파일 정보는 taskService에 저장되어 있다.
		console.log(taskService.attachFiles);
		if (taskService.attachFiles.length > 0) {
			taskService.saveAttach(taskId)
			.then(
				function(data) {
					$location.path('/task_list');
				},
				function(err) {
					console.error('Error while saving attach files');
				}
			);
		} else {
			$location.path('/task_list');
			return;
		}
		
		taskService.clear();
	}
	
	self.update = function() {
		console.log('update: ', self.task);
		if (!taskService.isUploadCompleted) {
			warningModal.setTitle('!! 경고 !!');
			warningModal.setContent('첨부 파일이 모두 업로드되지 않았습니다.');
			warningModal.show()
			.then(
				function(answer) {
					return false;
				},
				function(err) {}
			);
			
			return false;
		}
		
		if (taskService.attachFiles.length > 0) {
			addAction("파일 첨부");
		}
			
		
		taskService.updateTask(self.task)
		.then(
			function(res) {
				uploadAttachFile(self.task.taskId);
			},
			function(err) {
				console.error('Error while updating Task');
			}
		);
	};
	
	// 반려, 취소, 위임에 대한 처리
	// 히스토리에 의견을 등록하고, 작업 상태를 변경한다.
	self.reject = function() {
		insertCommentModal.setTitle('반려의견입력');
		insertCommentModal.setContent('반려 의견을 입력하십시오.');
		insertCommentModal.show()
		.then(
			function(data) {
				self.task.status = taskStatus.REJECT;
				self.task.comment = data;
				addAction("작업 반려");
				self.update();
			},
			function(err) {
				concole.error('Error while input comment');
			}
		);
	};
	
	self.hold = function() {
		insertCommentModal.setTitle('보류사유입력');
		insertCommentModal.setContent('보류 사유를 입력하십시오.');
		insertCommentModal.show()
		.then(
			function(data) {
				self.task.status = taskStatus.HOLD;
				self.task.comment = data;
				addAction("작업 보류");
				self.update();
			},
			function(err) {
				concole.error('Error while input comment');
			}
		);
	};
	
	/**
	 * 작업 위임
	 * 위임할 사용자를 선택하면, 담당자가 변경되고 작업의 상태를 위임으로 변경한다.
	 * 위임된 작업은 현재 담당자에게 표시되지 않으며, 위임 받은 사용자는 작업을 진행할 수 있다.
	 * 이후, 작업에 대한 프로세는 동일하게 진행된다.
	 */
	self.delegate = function() {
		// 작업자 선택 모달
		selectUserModal.show()
		.then(
			function(worker) {
				if (worker.id == -9999)		return false;
				self.task.workerId = worker.id;
				self.task.workerName = worker.lastName + worker.firstName;
				
				// 위임 의견 입력
				insertCommentModal.setTitle('위임의견입력');
				insertCommentModal.setContent('위임 의견을 입력하십시오.');
				insertCommentModal.show()
				.then(
					function(data) {
						self.task.status = taskStatus.DELEGATE;
						self.task.comment = data;
						addAction("작업 위임");
						self.update();
					},
					function(err) {
						concole.error('Error while input comment');
					}
				);
			},
			function(err) {
				console.error('Error while opening select user modal window');
			}
		);
	};
	
	/**
	 * 작업을 취소한다. 작업 취소는 작성자만 할 수 있다.
	 */
	self.cancel = function() {
		insertCommentModal.setTitle('취소사유입력');
		insertCommentModal.setContent('취소 사유를 입력하십시오.');
		insertCommentModal.show()
		.then(
			function(data) {
				self.task.status = taskStatus.CANCEL;
				self.task.comment = data;
				addAction("작업 취소");
				taskService.updateTask(self.task)
				.then(
					function(task) {
						self.gotoList();
					},
					function(err) {
						console.error('Error while updating task');
					}
				);
			},
			function(err) {
				concole.error('Error while input comment');
			}
		);
	};
	
	self.getPriority = function() {
		switch(self.task.priority) {
		case 'H':
			return "상";
		case 'M':
			return "중";
		case 'L':
			return "하";
		case 'E':
			return "긴급";
		}
	};
	
	self.getOpened = function() {
		switch(self.task.opened) {
		case 'T':
			return "팀내 공개";
		case 'D':
			return "부서내 공개";
		case 'N':
			return "공개 안함";
		}
	};
	
	self.isOwner = function() {
		return self.user.userId == self.task.userId;
	};
	
	self.gotoList = function() {
		$location.path('/task_list');
	};
	
	self.detailHistory = function(historyId) {
		historyModal.show(historyId);
	};
	
	self.changeRate = function(sliderId, modelValue, highValue, pointerType) {
		console.log('orgTask: ', self.orgTask);
		if (self.orgTask.currentRate != modelValue) {
			if (self.task.action.search("진척율 변경") < 0)		addAction("진척율 변경");		// 중복 등록 방지
			if (self.orgTask.targetRate <= modelValue) {
				self.task.status = taskStatus.PROCESS;
			} else {
				self.task.status = taskStatus.LATE;
			}
		}
	};
	
	self.editTask = function() {
		console.log('editTask... constructing...');
	};
	
	function addAction(action) {
		if (self.task.action != "")
			self.task.action += ", ";
		
		self.task.action += action;
	}
}])
.controller('registTask', ['taskStatus', 'taskService', 'userService', 'selectUserModal', 'warningModal', 'insertCommentModal', 'historyModal', '$window', '$routeParams', '$location',
	function(taskStatus, taskService, userService, selectUserModal, warningModal, insertCommentModal, historyModal, $window, $routeParams, $location) {
	var self =this;
	var taskId = $routeParams.taskId;
	
	self.edit = false;
	
	self.task = {};
	self.orgTask = {};
	self.user = {};
	self.task.taskId = '';
	self.task.endDate = new Date();
	self.task.status = taskStatus.NEW;
	self.task.targetRate = 0;
	self.task.currentRate = 0;
	self.task.opened = 'N';
	self.task.action = '';
	self.attachFiles = taskService.attachFiles;
	self.taskHistory = [];
	
	self.user = JSON.parse($window.sessionStorage.getItem("currentUser"));
	self.task.userId = self.user.userId;
	self.task.userName = self.user.lastName + self.user.firstName;
	self.task.workerName = self.user.lastName + self.user.firstName;
	self.task.workerId = self.user.userId;
	
	if (taskId != -9999) {	// 신규 생성이 아닌 수정
		self.edit = true;
		getTask(taskId);
		getAttachFiles(taskId);
		getTaskHistory(taskId);
	}

	/**
	 * 담당자를 지정할 모달 윈도우를 띄운다.
	 */
	self.worker = {};
	self.selectWorker = function() {
		selectUserModal.show()
		.then(
			function(worker) {
				console.log('worker: ', worker);
				if (worker.id == -9999) return false;
				
				self.worker = worker;
				self.task.workerId = worker.userId;
				self.task.workerName = worker.lastName + worker.firstName;
			},
			function(err) {}
		);
	};
	
	// 작업 등록의 마지막 단계이다.
	// 항상 마지막에 호출되며, 첨부 파일이 있는 정보를 데이터베이스에 저장한다.
	function uploadAttachFile(taskId) {
		// 첨부 파일을 업로드한다.
		// 첨부 파일 정보는 taskService에 저장되어 있다.
		console.log(taskService.attachFiles);
		if (taskService.attachFiles.length > 0) {
			taskService.saveAttach(taskId)
			.then(
				function(data) {
					$location.path('/task_list');
				},
				function(err) {
					console.error('Error while saving attach files');
				}
			);
		} else {
			$location.path('/task_list');
			return;
		}
		
		taskService.clear();
	}
	
	/**
	 * 작업을 등록하거나, 반려된 작업을 재등록한다.
	 */
	self.submit = function() {
		
		if (!taskService.isUploadCompleted) {
			warningModal.setTitle('!! 경고 !!');
			warningModal.setContent('첨부 파일이 모두 업로드되지 않았습니다.');
			warningModal.show()
			.then(
				function(answer) {
					return false;
				},
				function(err) {}
			);
			
			return false;
		}

		if (!self.edit) {
			taskService.saveTask(self.task)
			.then(
				function(res) {
					// 첨부 파일이 있는 경우 첨부 파일 처리
					uploadAttachFile(res.taskId);
				},
				function(err) {
					console.error('Error while creating task');
				}
			);
		} else {
			/**
			 * 작업 등록이 아니면서 작업을 수정할 수 있는 경우는 반려된 작업이거나, 아직 작업을 담당자가 확인하지 않은 경우이다.
			 */
			if (taskService.attachFiles.length > 0) {
				addAction("파일 첨부");
			}
			
			console.log('update task: ', self.orgTask, self.task);
			// 반려 작업의 경우, 재전송처리한다.
			addAction("재전송");
			taskService.updateTask(self.task)
			.then(
				function(res) {
					uploadAttachFile(self.task.taskId);
				},
				function(err) {
					console.error('Error while updating Task');
				}
			);
		}
	};
	
	self.cancel = function() {
		insertCommentModal.setTitle('삭제사유입력');
		insertCommentModal.setContent('삭제 사유를 입력하십시오.');
		insertCommentModal.show()
		.then(
			function(data) {
				self.task.status = taskStatus.CANCEL;
				self.task.comment = data;
				addAction("작업 삭제");
				taskService.updateTask(self.task)
				.then(
					function(task) {
						self.gotoList();
					},
					function(err) {
						console.error('Error while updating task');
					}
				);
			},
			function(err) {
				concole.error('Error while input comment');
			}
		);
	};
	
	self.gotoList = function() {
		$location.path('/task_list');
	};
	
	self.detailHistory = function(historyId) {
		historyModal.show(historyId);
	};
	
	function getTask(taskId) {
		if (taskId === undefined)	return;
		
		taskService.getByTaskId(taskId)
		.then(
			function(task) {
				self.task = task;
				self.orgTask = angular.copy(self.task);
				console.log('orgTask', self.orgTask);
			},
			function(err) {
				console.error('Error while fetching task information');
			}
		);
	}
	
	function getAttachFiles(taskId) {
		if (taskId === undefined)	return;
		
		taskService.getAttachByTaskId(taskId)
		.then(
			function(attachFiles) {
				self.attachFiles = attachFiles;
			},
			function(err) {
				console.error('Error while fetching attach files');
			}
		);
		
		console.log('attachFiles: ' + self.attachFiles);
	}
	
	function getTaskHistory(taskId) {
		if (taskId === undefined)	return;
		
		taskService.listTaskHistory(taskId)
		.then(
			function(histories) {
				self.taskHistory = histories;
			},
			function(err) {
				console.error('Error while fetching task histories');
			}
		);
	}
	
	function addAction(action) {
		if (self.task.action != "")
			self.task.action += ", ";
		
		self.task.action += action;
	}
}])
.controller('taskList', ['taskStatus', 'taskService', 'userService', '$location', '$routeParams', '$window',
			function(taskStatus, taskService, userService, $location, $routeParams, $window) {
	var	self = this;
	var workerName = $routeParams.workerName;
	
	console.log('DEBUG: workerName = ' + workerName);
	self.tasks = [];
	self.user = {};
	
	self.user = JSON.parse($window.sessionStorage.getItem("currentUser"));
	
	self.isOwner = function(task) {
		return self.user.userId == task.userId;
	};
	
	self.isWorker = function(task) {
		return self.user.userId == task.workerId;
	};
	
	/**
	 * 내가 생성한 작업이고, 진행이 되지 않은 상태라면 수정할 수 있다.
	 */
	self.canEdit = function(task) {
		if (self.isOwner(task) && (task.status == taskStatus.NEW || task.status == taskStatus.REJECT || task.status == taskStatus.DELEGATE))
			return true;
		else
			return false;
	};
	
	self.workers = [];
	self.searchWorker = '';		// 담당자 선택
	
	if (!angular.isUndefined(workerName))
		self.searchWorker = workerName;
	
	function setWorkers(tasks) {
		self.workers.push('');
		$.each(tasks, function (index, t) {
			if ($.inArray(t.workerName, self.workers) < 0)
				self.workers.push(t.workerName);
		});
		
		console.log('workers: ', self.workers);
	}
	
	function getTaskList() {
		
		taskService.listOfMyTask()
		.then(
			function(data) {
				self.tasks = data;
				console.log('tasks: ', self.tasks);
				setWorkers(data);
			},
			function(err) {
				console.error('Error while fetching task list');
			}
		);
		/**
		if (angular.isUndefined(workerId)) {
			taskService.listOfMyTask()
			.then(
				function(data) {
					self.tasks = data;
					console.log('tasks: ', self.tasks);
					setWorkers(data);
				},
				function(err) {
					console.error('Error while fetching task list');
				}
			);
		} else {
			taskService.listOfWorkerTask(workerId)
			.then(
				function(data) {
					self.tasks = data;
				},
				function(err) {
					console.error('Error while fetching task list');
				}
			);
		}
		**/
	}
	
	getTaskList();
	
	self.view = function(taskId) {
		$location.path('/view_task/' + taskId);
	};
	
	// 작업 생성자인 경우에는 수정 화면으로...
	self.edit = function(taskId) {
		console.log('/edit_task/' + taskId);
		$location.path('/edit_task/' + taskId);
	};
	
	function updateTask(task) {
		taskService.updateTask(task)
		.then(
			getTaskList,
			function(err) {
				console.error('Error while updating task');
			}
		);
	}
	
	self.processRateDown = function(task) {
		task.currentRate -= 10;
		if (task.currentRate < 10)		task.currentRate = 0;
		if (task.currentRate < task.targetRate)
			task.status = taskStatus.LATE;
		else
			task.status = taskStatus.PROCESS;
		updateTask(task);
	};
	
	self.processRateUp = function(task) {
		task.currentRate += 10;
		if (task.currentRate >= 100)	task.currentRate = 100;
		if (task.currentRate < task.targetRate)
			task.status = taskStatus.LATE;
		else
			task.status = taskStatus.PROCESS;
		updateTask(task);
	};
	
	self.getStatusName = taskService.getStatusName;
	
	self.getStatusStyle = function(status) {
		var className = "";
		
		switch(status) {
		case 'R':
			className = "bg-info";
			break;
		case 'P':
			className = "";
			break;
		case 'C':
			className = "bg-danger";
			break;
		case 'D':
			className = "bg-warning";
		}
		
		return className;
	};
	
	// 상태 분류 필터
	self.searchStatus = '';
	self.statusFilter = function(task) {
		if (self.searchStatus == '')
			return true;
		return task.status == self.searchStatus;
	};
	self.workerFilter = function(task) {
		if (self.searchWorker == '')	return true;
		return task.workerName == self.searchWorker;
	};
}])
.controller('fileController', ['$scope', '$cookies', 'FileUploader', 'taskService', function($scope, $cookies, FileUploader, taskService) {
	var self = this;
	var uploader = $scope.uploader = new FileUploader({
		url: '/bpms/file/upload',
		headers: {
			// Spring Security는 POST 요청시에 CSRF Token을 요구한다.
			// AngularJs는 csrf token을 xsrf로 전송한다. angularfileupload는 헤더를 리셋하는거 같다.
			'X-XSRF-TOKEN':$cookies.get('XSRF-TOKEN')
		}
	});
	
	uploader.filters.push({
		name: 'customFilter',
		fn: function(item, options) {
			return this.queue.length < 10;
		}
	});
	
	self.remove = function(item) {
		var	delFile = '';

		for (var i = 0; i < taskService.attachFiles.length; i++) {
			if (item.file.name == taskService.attachFiles[i].originName) {
				delFile = taskService.attachFiles[i].name;
				taskService.attachFiles.splice(i, 1);
				console.log('remove : ' + item.file.name + ', ' + delFile);
				break;
			}
		}
		
		if (item.isUploaded) {
			// 실제 서버에서도 삭제한다.
			// 서버에는 UUID 로 저장되어 있으니, 삭제할 파일명은 attachFiles에 저장되어 있는 이름을 사용한다.
			console.log('deleteFile : ' + delFile);
			taskService.deleteAttach(delFile)
			.then(
				function(data) {
					console.log(data);
					console.info('deleted ' + delFile);
				},
				function(err) {
					console.error('Error while deleting file ' + delFile);
				}
			);
		}
		
		item.remove();
	}
	
	self.clearQueue = function() {
		for (var i = 0; i < uploader.queue.length; ) {
			self.remove(uploader.queue[i]);
		}
	}
	
	// CALLBACKS
    uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
    };
    uploader.onAfterAddingFile = function(fileItem) {
    	var file = {attachId:'', type: '', path:'', name:'', originName:'', mainId:'', modified:'', size:0};
    	
    	console.log('type', fileItem.file.type);
    	file.type = fileItem.file.type;
    	file.originName = fileItem.file.name;
    	file.size = fileItem.file.size;
    	
    	taskService.attachFiles.push(file);
    	console.log('taskService.attachFiles :', taskService.attachFiles);
    	taskService.isUploadCompleted = false;
    	console.log(taskService.isUploadCompleted)
    };
    uploader.onAfterAddingAll = function(addedFileItems) {
    };
    uploader.onBeforeUploadItem = function(item) {
    };
    uploader.onProgressItem = function(fileItem, progress) {
    };
    uploader.onProgressAll = function(progress) {
    };
    uploader.onSuccessItem = function(fileItem, response, status, headers) {
    	// attachFiles에서 같은 이름을 찾아서 서버에 저장된 이름을 저장한다.
    	// 멀티로 파일을 업로드하더라도 angularFileUploader는 각각의 파일을 하나씩 업로드한다.
    	for(var i = 0; i < taskService.attachFiles.length; i++) {
    		console.log('save ' + fileItem.file.name + ' to ' + response[0]);
    		var filePath = response[0];
    		var path = filePath.substr(0, filePath.lastIndexOf("/") + 1);
    		var name = filePath.substr(path.length, filePath.length);
    		
    		console.log('path: ' + path + ', name: ' + name);
    		if (fileItem.file.name == taskService.attachFiles[i].originName) {
    			taskService.attachFiles[i].path = path;
    			taskService.attachFiles[i].name = name;
    		}
    	}
    };
    uploader.onErrorItem = function(fileItem, response, status, headers) {
    };
    uploader.onCancelItem = function(fileItem, response, status, headers) {
    };
    uploader.onCompleteItem = function(fileItem, response, status, headers) {
    };
    uploader.onCompleteAll = function() {
    	if (uploader.getNotUploadedItems().length == 0) {
    		console.log('all file uploaded');
    		taskService.isUploadCompleted = true;
    	}
    };
}]);