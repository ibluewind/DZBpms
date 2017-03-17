'use strict';

App.service('approveService', ['$http', '$q', '$filter', 'approveStatus', 'approveTrayType',
                            function($http, $q, $filter, approveStatus, approveTrayType) {
	/**
	 * 결재 양식 정보를 조회한다. (결재 문서 신규 작성시)
	 * 1. 결재 양식 정보
	 * 2. 결재 양식 필드 정보
	 * 3. 결재 라인 정보
	 */
	this.getDocumentInformation = function(formId) {
		var deferred = $q.defer();
		var func_form = $http.get('/bpms/rest/form/' + formId),
			func_fields = $http.get('/bpms/rest/form/field/' + formId),
			func_lines = $http.get('/bpms/rest/approve/lines/' + formId);
		
		$q.all([func_form, func_fields, func_lines])
		.then(
			function(results) {
				deferred.resolve(results);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	/**
	 * 결재 문서 정보를 한번에 조회한다. (저장된 문서 수정 또는 결재시)
	 * 1. 결재 요약 정보 (approve_summary)
	 * 2. 양식 정보 (approve_form, approve_form_field)
	 * 3. 결재함 정보???
	 * 3. 저장된 결재 라인 정보 (approve_line)
	 */
	this.getSavedDocumentInformation = function(appId) {
		var	deferred = $q.defer();
		var func_summary = $http.get('/bpms/rest/approve/summary/doc/' + appId),
			func_form = $http.get('/bpms/rest/approve/form/' + appId),
			func_fields = $http.get('/bpms/rest/approve/fields/' + appId),
			func_tray = $http.get('/bpms/rest/approve/tray/doc/' + appId),
			func_lines = $http.get('/bpms/rest/approve/lines/save/' + appId),
			func_histories = $http.get('/bpms/rest/approve/history/list/' + appId);
		
			$q.all([func_summary, func_form, func_fields, func_tray, func_lines, func_histories])
			.then(
				function(results) {
					deferred.resolve(results);
				},
				function(err) {
					$q.reject();
				}
			);
			
			return deferred.promise;
	};
	
	/**
	 * 사용자의 모든 결재함 정보를 조회한다.
	 * 대시보드에서 사용된다.
	 */
	this.getUserApproveTrays = function() {
		return $http.get('/bpms/rest/approve/tray')
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	}
	
	function saveApproveInformation(form, lines, history) {
		console.log('history: ', history);
		
		var func_fields = $http.post('/bpms/rest/approve/fields', form),
			func_lines = $http.post('/bpms/rest/approve/lines/save', lines),
			func_history = $http.post('/bpms/rest/approve/history', history);
		
		return $q.all([func_fields, func_lines, func_history])
		.then(
			function(results) {
				return results;
			},
			function(err) {
				$q.reject(err);
				return null;
			}
		);
	}
	
	/**
	 * 결재 문서 작성중 임시 저장
	 * 저장 대상은
	 * 1. 결재 요약 정보
	 * 2. 양식 필드 데이터
	 * 3. 결재 라인
	 */
	this.saveApproveDocument = function(document, approve, history, status) {
		// 결재 요약 정보를 먼저 저장한다. 요약 정보를 저장하면 WAS로 부터 결재 아이디를 부여 받아 나머지 데이터를 저장할 수 있다.
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/approve/summary', document.summary)
		.then(
			function(response) {
				deferred.resolve(response.data);
				
				document.summary = response.data;
				history.appId = document.form.appId = document.summary.appId;
				history.status = status;
				
				for (var i = 0; i < approve.lines.length; i++) {
					approve.lines[i].appId = document.summary.appId;
				}
				
				saveApproveInformation(document.form, approve.lines, history)
				.then(
					function(results) {
						console.log('Save Approve document successfully');
						return;
					},
					function(err) {
						$q.reject(err);
					}
				);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	/**
	 * 저장되어 있던 결재 문서를 수정하는 경우, 기존의 결재 요약 정보를 수정하고
	 * 결재 라인, 결재 양식 필드 정보를 삭제 후 재 등록한다.
	 * 결재함은 상신했을 때 생성되므로 결재함은 무시한다.
	 */
	this.updateApproveDocument = function(document, approve, history, status) {
		var deferred = $q.defer();
		
		// 상태 변경 전에, 반려 문서인 경우에 결재함 정보를 삭제한다.
		// 그래야 결재 정보를 수정한 후, 결재함 정보를 controller에서 새로 입력할 수 있다.
		if (document.summary.status == approveStatus.REJECT) {
			var tray = approve.trays[0];
			console.log('DELETE tray', tray);
			$http.delete('/bpms/rest/approve/tray/' + tray.userId + '/' + tray.appId)
			.then(
				function(response) {
					console.log('Delete approve tray information successfully');
				},
				function(err) {
					$q.reject(err);
					return;
				}
			);
		}
		
		document.summary.status = history.status = status;
		
		console.log('document: ', document);
		console.log('approve: ', approve);
		console.log('history: ', history);
		
		var appId = document.summary.appId;
		var update_field = $http.put('/bpms/rest/approve/fields', document.form),
			update_line = $http.put('/bpms/rest/approve/lines/' + appId, approve.lines),
			func_history = $http.post('/bpms/rest/approve/history', history);
		
		$http.put('/bpms/rest/approve/summary', document.summary)
		.then(
			function(response) {
				deferred.resolve(response.data);
				
				$q.all([update_field, update_line, func_history])
				.then(
					function (results) {
						console.log('Updated Approve document information successfully');
					},
					function(err) {
						$q.reject(err);
					}
				);
			},
			function(err) {
				$q.reject(err);
			}
		);
			
		return deferred.promise;
	};
	
	/**
	 * 처리부서의 문서 담당자가 결재 문서를 승인한다.
	 * 승인시 저장할 데이터는 추가된 결재라인과, 결재라인에 따른 결재함을 저장하여야 한다.
	 */
	this.processApproveDocument = function(lines, trays, history) {
		trays[0].status = approveTrayType.COMPLETED;
		history.status = approveStatus.PROCESSING;
		
		var deferred = $q.defer();
		var func_tray = $http.put('/bpms/rest/approve/tray', trays.shift()),
			func_trays = $http.post('/bpms/rest/approve/tray', trays),
			func_lines = $http.post('/bpms/rest/approve/lines/save', lines),
			func_history = $http.post('/bpms/rest/approve/history', history);
		
		console.log('lines: ', lines);
		console.log('trays: ', trays);
		console.log('history: ', history);
		
		$q.all([func_tray, func_trays, func_lines, func_history])
		
		// 문서 담당자의 결재함은 등록하지 않고, 완료로 수정되어야 한다.
		deferred.resolve(lines);
		return deferred.promise;
	};
	
	function findUserTray(userId, trays) {
		var tray;

		for (var i = 0; i < trays.length; i++) {
			if (trays[i].userId == userId) {
				tray = trays[i];
				break;
			}
		}
		
		return tray;
	}
	
	function findUserLines(userId, lines) {
		var line;
		
		for (var i = 0; i < lines.length; i++) {
			if (lines[i].approvalId == userId) {
				line = lines[i];
				break;
			}
		}
		
		return line;
	}
	
	/**
	 * 결재 보류 처리
	 * approve_summary의 상태와 approve_tray의 type을 변경한다.
	 */
	this.deferApprove = function(userId, document, approve, history) {
		var	tray = findUserTray(userId, approve.trays);
		var line = findUserLines(userId, approve.lines);
		
		document.summary.status = history.status = tray.type = line.status = approveStatus.DEFERRED;
		
		console.log('DEFERRED APPROVE DEBUG:');
		console.log('document: ', document);
		console.log('history: ', history);
		console.log('approve: ', approve);
		console.log('tray: ', tray);
		
		var func_summary = $http.put('/bpms/rest/approve/summary', document.summary),
			func_tray = $http.put('/bpms/rest/approve/tray', tray),
			func_line = $http.put('/bpms/rest/approve/lines/update', line),
			func_history = $http.post('/bpms/rest/approve/history', history);
		
		var deferred = $q.defer();
		
		$q.all([func_summary, func_tray, func_line, func_history])
		.then(
			function(results) {
				deferred.resolve(results);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	/**
	 * 결재 반려
	 * 결재의 모든 상태를 반려로 변경한다.
	 * 작성자가 수정할 수 있는 문서로 변경되어야 한다.
	 */
	this.rejectApprove = function(document, history) {
		var summary = document.summary;
		
		summary.status = history.status = approveStatus.REJECT;
		
		console.log('rejectApprove: summary: ', summary);
		console.log('rejectApprove: history: ', history);
		
		$http.post('/bpms/rest/approve/reject', summary)
		.then(
			function(response) {
				summary = response.data;
				$http.post('/bpms/rest/approve/history', history)
				.then(
					function(response) {
						console.log('Saved history successfully');
					},
					function(err) {
						$q.reject(err);
					}
				);
			},
			function(err) {
				$q.reject(err);
			}
			
		);
		
		return summary;
	};
	
	/**
	 * 결재 승인 처리
	 */
	this.submitApprove = function(summary, line, history) {
		summary.status = history.status = approveStatus.PROCESSING;
		
		var func_submit = $http.post('/bpms/rest/approve', line),
			func_history = $http.post('/bpms/rest/approve/history', history),
			func_summary = $http.put('/bpms/rest/approve/summary', summary),
			deferred = $q.defer();
		
		$q.all([func_submit, func_history])
		.then(
			function(results) {
				console.log('results: ', results[0].data);
				if (results[0].data != "") {
					console.log('summary: ', results[0].data);
				} else {
					console.log('summary: ', results[0].data);
				}
				deferred.resolve(results[0].data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.getFormList = function() {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/form')
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
	
	this.getFormInfo = function(formId) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/form/' + formId)
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
	
	/**
	 * 결재 양식에 따라 결재 라인을 생성한다. 1) 사용자가 해당 양식에 대한 결재 라인을 정의했는 체크 2) 시스템이 조직도를 참고하여
	 * 결재 라인을 생성.
	 * 
	 * 1), 2) 모두 WAS의 콘트롤러에서 처리한다.
	 */
	this.getApproveLine = function(formId) {
		return $http.get('/bpms/rest/approve/lines/' + formId)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				return $q.reject(err);
			}
		);
	};
	
	this.saveApproveLine = function(lines) {
		return $http.post('/bpms/rest/approve/lines/save', lines)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.saveCustomApproveLine = function(formId, lines) {
		return $http.post('/bpms/rest/approve/lines/custom/' + formId, lines)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	}
	
	this.updateApproveLine = function(appId, lines) {
		return $http.put('/bpms/rest/approve/lines/' + appId, lines)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.getCustomApproveLineSummaryList = function() {
		return $http.get('/bpms/rest/approve/lines/custom/summary')
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.getCustomApproveLineInfo = function(lineId) {
		var deferred = $q.defer();
		var func_summary = $http.get('/bpms/rest/approve/lines/custom/summary/' + lineId),
			func_lines = $http.get('/bpms/rest/approve/lines/custom/' + lineId);
		
		$q.all([func_summary, func_lines])
		.then(
			function(results) {
				deferred.resolve(results);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.saveCustomApproveLineInformation = function(summary, lines) {
		return $http.post('/bpms/rest/approve/lines/custom/summary', summary)
		.then(
			function (response) {
				summary = response.data;
				
				// 결재 라인에 lineId 등록
				for (var i  = 0; i < lines.length; i++)
					lines[i].lineId = summary.lineId;
				
				console.log('summary: ', summary);
				console.log('lines: ', lines);
				$http.post('/bpms/rest/approve/lines/custom/lines', lines)
				.then(
					function(response) {
						return response.data;
					},
					function(err) {
						$q.reject(err);
					}
				);
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.updateCustomApproveLineInformation = function(summary, lines) {
		return $http.put('/bpms/rest/approve/lines/custom/summary', summary)
		.then(
			function(response) {
				summary = response.data;
				
				$http.put('/bpms/rest/approve/lines/custom/lines', lines)
				.then(
					function(response) {
						return response.data;
					},
					function(err) {
						$q.reject(err);
					}
				);
				
				return summary;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.deleteCustomApproveLineInformation = function(lineId) {
		return $http.delete('/bpms/rest/approve/lines/custom/summary/' + lineId)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	/**
	 * 저장되었거나, 상신된 결재 문서의 결재 라인을 조회한다.
	 */
	this.getSavedApproveLine = function(appId) {
		return $http.get('/bpms/rest/approve/lines/save/' + appId)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.getApproveForm = function(appId) {
		var deferred = $q.defer(),
			formInfo = $http.get('/bpms/rest/approve/form/' + appId),
			fieldInfo = $http.get('/bpms/rest/approve/fields/' + appId);
		
		$q.all([formInfo, fieldInfo])
		.then(
			function(results) {
				deferred.resolve(results);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.getFormInfoByAppId = function(appId) {
		return $http.get('/bpms/rest/approve/form/' + appId)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				return $q.reject(err);
			}
		);
	};
	
	this.getFormFile = function(formId) {
		var deferred = $q.defer();
		
		$http.get('/bpms/file/form/' + formId)
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
	
	/**
	 * RESTful API에서 전달된 fields의 값을 폼 양식에 맞는 구조로 변경한다.
	 */
	this.getFormFields = function(formId) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/form/field/' + formId)
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
	
	this.saveApproveSummary = function(summary) {
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/approve/summary', summary)
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
	
	this.updateApproveSummary = function(summary) {
		var deferred = $q.defer();
		
		$http.put('/bpms/rest/approve/summary', summary)
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
	
	this.saveApproveFormFields = function(form) {
		var deferred = $q.defer();
		
		$http.post('/bpms/rest/approve/fields', form)
		.then(
			function(response) {
				console.log(response.data);
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		return deferred.promise;
	};
	
	this.getApproveFormFields = function(appId) {
		var deferred = $q.defer();
		
		$http.get('/bpms/rest/approve/fields/' + appId)
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
	
	this.getApproveSummary = function(appId) {
		console.log('appId: ', appId);
		return $http.get('/bpms/rest/approve/summary/doc/' + appId)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.getApproveSummaryList = function(userId) {
		var deferred = $q.defer();
		
		console.log('userId: ', userId);
		$http.get('/bpms/rest/approve/summary/user/' + userId + '/')
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
	
	/**
	 * 결재 문서를 삭제한다. 삭제할 Table: approve_form_field, approve_line, approve_summary, approve_trays
	 */
	this.removeApprove = function(appId) {
		return $http.delete('/bpms/rest/approve/' + appId)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.parseFormField = function(fields) {
		console.log('fields: ', fields);
		
		var result = [];
		var clause = [];
		// category별, clause별로 구분한다.
		// 양식 폼에서는 self.form.fields['name']의 형식으로 모델을 정의한다.
		var currentClause = -1;
		var catIdx = -1;
		
		var arrCats = [];
		var currentCat = -1;
		
		// full search.. 배열이 예제처럼 카테고리 별로 정렬되어 있으리라는 법은 없다.
		// array를 orderBy로 정리한 후 처리해도 되긴 할 것 같다.
		fields = $filter('orderBy')(fields, 'category');		// category별로 정렬
		result['fieldRows'] = [];
		
		for (var i = 0; i < fields.length; i++) {
			if (currentCat == fields[i].categoty) 	continue;
			
			currentCat = fields[i].category;
			var cats = $filter('filter')(fields, {category:currentCat});
			
			if (cats.length > 1) {
				// category를 기준으로 clause 별로 분류한다.
				var clauses = [];
				for (var j = 0; j < cats.length; j++) {
					if (currentClause == cats[j].clause) {
						continue;
					}
					else {
						currentClause = cats[j].clause;
						clause = ($filter('filter')(cats, {clause:currentClause}));
					}
					
					// 분류된 clause를 results['fieldRows'][currentClause]에 넣는다.
					var val = [];
					for (var k = 0; k < clause.length; k++) {
						val[clause[k].name] = clause[k].value;
					}
					
					clauses.push(val);
				}		// for (j);
				
				 i += cats.length - 1;
				result['fieldRows'].push(clauses);
			} else {
				// 단일 필드
				result[cats[0].name] = cats[0].value;
			}
		}
		
		console.log('result: ', result);
		return result;
	};
	
	this.makeFormField = function(fields) {
		var formFields = [];
		var field = {};
		var category = 0;
		var clause = 0;
		
		var i = 0, j = 0;
		for (var name in fields) {
			if (name == 'fieldRows') {
				// fieldRows는 2차원 배열 구조이다.
				// 1차원은 카테고리 구분을 의미하고 2차원은 clause로 분류된다.
				for (i = 0; i < fields[name].length; i++) {
					for (j = 0; j < fields[name][i].length; j++) {
						for (var prop in fields[name][i][j]) {
							field.category = category;
							field.clause = j;
							field.name = prop;
							field.value = fields[name][i][j][prop];
							formFields.push(field);
							field = {};
						}
					}
					category++;
				}
			} else {
				field.category = category++;
				field.clause = clause;
				field.name = name;
				field.value = fields[name];
				formFields.push(field);
				field = {};
			}
		}
		
		return formFields;
	};
	
	/**
	 * 후처리 진행
	 */
	this.runPostProcess = function(fields) {
		console.log('fileds: ', fields);
		console.log('fields: ', JSON.stringify(fields));
		return $http.post('/bpms/rest/approve/post',fields)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	/**
	 * 사용자의 결재함 정보 조회
	 */
	/*
	 * 미결함, 완료함, 기결함, 예정함 등 조회
	 */
	this.getTray = function(type) {
		return $http.get('/bpms/rest/approve/tray/type/' + type)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	/*
	 * 사용자의 특정 결재문서에 대한 결재함 조회
	 */
	this.getTrayForUserByApproveId = function(appId) {
		return $http.get('/bpms/rest/approve/tray/user/' + appId)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	/**
	 * 결재함 저장
	 */
	this.saveTray = function(trays) {
		console.log('save trays: ', trays);
		return $http.post('/bpms/rest/approve/tray', trays)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.saveApproveHistory = function(history) {
		return $http.post('/bpms/rest/approve/history', history)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.getStatusName = function(history) {
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
			if (history.userId == history.creatorId)		// 작성자인경우
				statusName = "상신";
			else
				statusName = "승인";
			break;
		case approveStatus.FINISH:
			statusName = "결재완료";
			break;
		}
		
		return statusName;
	}
}])
.service('selectFormModal', ['$modal', '$rootScope', '$http', '$q', function($modal, $rootScope, $http, $q) {

	var scope = $rootScope.$new();
	var modal = $modal({templateUrl: '/bpms/approve/form/select',
						scope: scope,
						show: false});
	var parentShow = modal.show;
	var deferred;
	
	scope.formList = [];
	scope.selectForm = function(form) {
		scope.form = form;
	};
	
	scope.answer = function(res) {
		if (res == 'no') {
			scope.form = {id:-9999, title:''};
		}
		
		deferred.resolve(scope.form);
		modal.hide();
	};
	
	modal.show = function() {
		deferred = $q.defer();
		
		$http.get('/bpms/rest/form')
		.then(
			function(response) {
				console.log('form list: ', response.data);
				scope.formList = response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
		
		parentShow();
		return deferred.promise;
	};
	
	return modal;
}]);