<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>Authority Codes Management</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="<c:url value='/static/css/'/>angular-motion.css"/>

</head>
<body ng-app="bpmApp">
	<div class="container-fluid" ng-controller="mainController as ctrl">
		<%@ include file="adminMenu.jsp" %>
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">권한 코드 관리</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>NAME</th>
							<th>COMMENT</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="auth in ctrl.authorities">
							<td><span ng-bind="auth.roleName"></span></td>
							<td><span ng-bind="auth.comment"></span></td>
							<td>
								<button type="button" class="btn btn-primary" ng-click="ctrl.edit(auth)">Edit</button>
								<button type="button" class="btn btn-danger" ng-click="ctrl.remove(auth.authId)">Delete</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="panel-footer">
				<button type="button" class="btn btn-default" ng-click="ctrl.add()"><span class="glyphicon glyphicon-plys"></span>Add</button>
			</div>
		</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-animate.min.js"></script>
<script src="<c:url value='/static/js/'/>angular-strap.js"></script>
<script src="<c:url value='/static/js/'/>angular-strap.tpl.js"></script>
<script src="<c:url value="/static/js/admin/auth/app.js"/>"></script>
<script src="<c:url value="/static/js/modal_window.js"/>"></script>
<script src="<c:url value="/static/js/admin/auth/app_service.js"/>"></script>
<script src="<c:url value="/static/js/admin/auth/app_controller.js"/>"></script>
</body>
</html>