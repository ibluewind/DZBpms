App
.config(['$routeProvider', function($routeProvider) {
	$routeProvider
	.when('/', {
		templateUrl: '/bpms/home/dashboard',
		controller: 'dashboardController as ctrl'
	})
	.when('/task_list', {
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
		templateUrl: '/bpms/app/list',
		controller: 'listAppController as ctrl'
	})
	.when('/regist_app/:id', {
		templateUrl: function(params) {
			return '/bpms/app/regist/' + params.id;
		},
		controller: 'editAppController as ctrl'
	})
	.when('/edit_app/:id', {
		templateUrl: function(params) {
			return '/bpms/app/edit/' + params.id;
		},
		controller: 'editAppController as ctrl'
	})
	.when('/proc_app/:appId', {
		templateUrl: function(params) {
			return '/bpms/app/edit/' + params.appId;
		},
		controller: 'editAppController as ctrl'
	})
	.when('/undecide_app', {
		templateUrl: '/bpms/app/undecide',
		controller: 'undecideAppController as ctrl'
	})
	.when('/defer_app', {
		templateUrl: '/bpms/app/defer',
		controller: 'deferAppController as ctrl'
	})
	.when('/completed_app', {
		templateUrl: '/bpms/app/completed',
		controller: 'completedAppController as ctrl'
	})
	.when('/decided_app', {
		templateUrl: '/bpms/app/decided',
		controller: 'decidedAppControlelr as ctrl'
	})
	.when('/expect_app', {
		templateUrl: '/bpms/app/expect',
		controller: 'expectAppController as ctrl'
	})
	.when('/man_appline', {
		templateUrl: '/bpms/app/manappline',
		controller: 'manageAppLineController as ctrl'
	})
	.otherwise({redirectTo: '/'});
}])
.config(['$datepickerProvider', function($datepickerProvider) {
	angular.extend($datepickerProvider.defaults, {
		dateFormat: 'yyyy/MM/dd',
		startWeek: 0
	})
}]);