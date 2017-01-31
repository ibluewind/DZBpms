'use strict';

App.service('approveService', ['$http', '$q', '$filter',
                            function($http, $q, $filter) {
	
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
		return $http.get('/bpms/rest/approve/line/' + formId)
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
		return $http.post('/bpms/rest/approve/line/save', lines)
		.then(
			function(response) {
				return response.data;
			},
			function(err) {
				$q.reject(err);
			}
		);
	};
	
	this.updateApproveLine = function(appId, lines) {
		return $http.put('/bpms/rest/approve/line/' + appId, lines)
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
		return $http.get('/bpms/rest/approve/line/save/' + appId)
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
			fieldInfo = $http.get('/bpms/rest/approve/formFields/' + appId);
		
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
		
		$http.post('/bpms/rest/approve/formField', form)
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
		
		$http.get('/bpms/rest/approve/formFields/' + appId)
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
		return $http.get('/bpms/rest/approve/summary/get/' + appId)
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
		$http.get('/bpms/rest/approve/summary/' + userId + '/')
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
	 * 결재 양식 정보를 조회한다. (결재 문서 신규 작성시)
	 * 1. 결재 양식 정보
	 * 2. 결재 양식 필드 정보
	 * 3. 결재 라인 정보
	 */
	this.getFormInformation = function(formId) {
		var deferred = $q.defer();
		var formInfo = $http.get('/bpms/rest/form/' + formId),
			formFields = $http.get('/bpms/rest/form/field/' + formId),
			appLines = $http.get('/bpms/rest/approve/line/' + formId);
		
		$q.all([formInfo, formFields, appLines])
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
	 * 3. 저장된 결재 라인 정보 (approve_line)
	 */
	this.getApproveDocumentInformation = function(appId) {
		var	deferred = $q.defer();
		var summary = $http.get('/bpms/rest/approve/summary/get/' + appId),
			formInfo = $http.get('/bpms/rest/approve/form/' + appId),
			fieldInfo = $http.get('/bpms/rest/approve/formFields/' + appId),
			appLine = $http.get('/bpms/rest/approve/line/save/' + appId);
		
			$q.all([summary, formInfo, fieldInfo, appLine])
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
	 * 결재 문서를 삭제한다. 삭제할 Table: approve_form_field, approve_line, approve_summary
	 */
	this.cancelApprove = function(appId) {
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
					
					// 분류된 claus를 resulst['fieldRows'][currentClause]에 넣는다.
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
	 * 사용자의 결재함 정보 조회
	 */
	/*
	 * 미결함, 완료함, 기결함, 예정함 등 조회
	 */
	this.getTray = function(type) {
		return $http.get('/bpms/rest/approve/tray/box/' + type)
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
		return $http.get('/bpms/rest/approve/tray/box/user/' + appId)
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
}]);