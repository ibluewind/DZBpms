App
.config(['$routeProvider', function($routeProvider) {
	$routeProvider
	.when('/', {
		templateUrl: '/bpms/home/dashboard',
		controller: 'dashboardController as ctrl'
	})
	.when('/report', {
		templateUrl: '/bpms/home/report',
		controller: 'reportController as ctrl'
	})
	.when('/calendar', {
		templateUrl: '/bpms/home/calendar'
	})
	.when('/task_list', {
		templateUrl: '/bpms/home/task/list',
		controller: 'taskList as ctrl'
	})
	.when('/task_list/:workerName', {
		templateUrl: '/bpms/home/task/list',
		controller: 'taskList as ctrl'
	})
	.when('/view_task/:taskId', {
		templateUrl: '/bpms/home/task/view',
		controller: 'viewTask as ctrl'
	})
	.when('/regist_task/:taskId', {
		templateUrl: '/bpms/home/task/new',
		controller: 'registTask as ctrl'
	})
	.when('/edit_task/:taskId', {
		templateUrl: '/bpms/home/task/new',
		controller: 'registTask as ctrl'
	})
	.when('/delayed_task', {
		templateUrl: '/bpms/home/task/delayed'
	})
	.when('/expect_task', {
		templateUrl: '/bpms/home/task/expect'
	})
	.when('/list_app', {	// 초기 결재 작성 화면
		templateUrl: '/bpms/approve/list',
		controller: 'listAppController as ctrl'
	})
	.when('/regist_app/:id', {
		templateUrl: function(params) {
			return '/bpms/approve/regist/' + params.id;
		},
		controller: 'editAppController as ctrl'
	})
	.when('/edit_app/:id', {
		templateUrl: function(params) {
			return '/bpms/approve/edit/' + params.id;
		},
		controller: 'editAppController as ctrl'
	})
	.when('/view_app/:appId', {
		templateUrl: function(params) {
			return '/bpms/approve/edit/' + params.appId;
		},
		controller: 'viewAppController as ctrl'
	})
	.when('/approve_tray/:type', {
		templateUrl: function(params) {
			return '/bpms/approve/tray/list/' + params.type;
		},
		controller: 'trayAppController as ctrl'
	})
	.when('/man_appline', {
		templateUrl: '/bpms/approve/manappline',
		controller: 'manageAppLineController as ctrl'
	})
	.when('/msgbox', {
		templateUrl: '/bpms/msgbox',
		controller: 'messageController as ctrl'
	})
	.when('/project/regist', {
		templateUrl: '/bpms/home/regist_project',
		controller: 'registProject as ctrl'
	})
	.otherwise({redirectTo: '/'});
}])
.config(['$datepickerProvider', function($datepickerProvider) {
	angular.extend($datepickerProvider.defaults, {
		dateFormat: 'yyyy-MM-dd',
		startWeek: 0
	})
}]);