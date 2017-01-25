<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Department Management</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css"/>
<link rel="stylesheet" href="<c:url value='/static/css/'/>angular-motion.css"/>
<style>
	input[readonly] {
	cursor: pointer !important;
	}
	.deptName.ng-dirty.ng-invalid-required {
		border: solid 2px red;
	}
</style>
</head>
<body ng-app="bpmApp" ng-cloak>
	<div class="container-fluid">
	<%@ include file="adminMenu.jsp" %>
		<div class="row" ng-controller="mainController as ctrl">
			<div class="col-md-3">
				<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-default dropdown-toggle btn-sm" type="button" id="companySelector" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						Company<span class="caret"></span>
						</button>	
						<ul class="dropdown-menu" role="menu" aria-labelledby="companySelector">
						<c:forEach items="${companies}" var="comp">
							<li role="presentation"><a role="menuitem" tabindex="-1" ng-click="ctrl.changeCompany('${comp.id}', '${comp.name}');">${comp.name}</a></li>
						</c:forEach>
						</ul>
					</div>
					<input type="text" class="form-control input-sm" arial-label="company" ng-model="company.name"/>
				</div>
				<div js-tree="treeConfig" ng-model="treeData" tree="deptTree" tree-events="select_node:ctrl.selectDept"></div>
			</div>
			<div class="col-md-9">
				<div ng-view></div>
			</div>
		</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-route.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-animate.min.js"></script>
<script src="<c:url value='/static/js/'/>angular-strap.js"></script>
<script src="<c:url value='/static/js/'/>angular-strap.tpl.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<c:url value="/static/js/ngJsTree.js"/>"></script>
<script>
	var company = {id: '${company.id}', name: '${company.name}', ceo: '${company.ceo}'};
</script>
<script src="<c:url value="/static/js/admin/app.js"/>"></script>
<script src="<c:url value="/static/js/common_tree.js"/>"></script>
<script src="<c:url value="/static/js/modal_window.js"/>"></script>
<script src="<c:url value="/static/js/admin/dept/app_service.js"/>"></script>
<script src="<c:url value="/static/js/admin/user/app_service.js"/>"></script>
<script src="<c:url value="/static/js/admin/dept/app_controller.js"/>"></script>
</body>
</html>