App
.config(['$routeProvider', function($routeProvider) {
	$routeProvider
	.when('/regist_form', {
		templateUrl: '/bpms/admin/form/regist',
		controller: 'registController as ctrl'
	})
	.when('/edit_form/:id', {
		templateUrl: '/bpms/admin/form/regist',
		controller: 'registController as ctrl'
	});
}]);