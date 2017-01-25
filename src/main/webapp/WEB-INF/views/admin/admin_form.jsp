<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Make Form</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css"/>
<link rel="stylesheet" href="<c:url value='/static/css/'/>angular-motion.css"/>
<style>
	[ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak {
		display: none !important;
	}
</style>
</head>
<body ng-app="bpmApp" ng-cloak>
	<div class="container-fluid">
		<%@ include file="adminMenu.jsp" %>
		<div class="row">
			<div class="col-md-4" ng-controller="listController as list">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-title">양식목록</div>
					</div>
					<div class="panel-body">
						<table class="table table-hover">
							<thead>
								<th>양식명</th>
								<th>작성자</th>
								<th>작성일자</th>
								<th></th>
							</thead>
							<tbody>
								<tr ng-repeat="form in list.forms">
									<td><a ng-click="list.edit(form.id)" style="cursor: pointer;">{{form.title}}</a></td>
									<td>{{form.creatorName}}</td>
									<td>{{form.created|date:'yyyy-MM-dd HH:mm:ss'}}
									<td>
										<button type="button" class="btn btn-danger btn-xs" ng-click="list.remove(form.id)"><span class="glyphicon glyphicon-trash"></span></button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="panel-footer">
						<button type="button" class="btn btn-default btn-sm" ng-click="list.add()">Add</button>
					</div>
				</div>
			</div>
			<div class="col-md-8" ng-view></div>
		</div>
	</div>
<script>
	var company = {id: '${company.id}', name: '${company.name}', ceo: '${company.ceo}'};
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-route.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-cookies.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-sanitize.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-animate.min.js"></script>
<script src="<c:url value='/static/js/'/>angular-strap.js"></script>
<script src="<c:url value='/static/js/'/>angular-strap.tpl.js"></script>
<script src="<c:url value="/static/js/angular-file-upload.js"/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<c:url value="/static/js/ngJsTree.js"/>"></script>
<script src="<c:url value="/static/js/admin/form/app.js"/>"></script>
<script src="<c:url value="/static/js/common_tree.js"/>"></script>
<script src="<c:url value="/static/js/admin/form/app_configure.js"/>"></script>
<script src="<c:url value="/static/js/modal_window.js"/>"></script>
<script src="<c:url value="/static/js/admin/form/file_service.js"/>"></script>
<script src="<c:url value="/static/js/admin/form/file_controller.js"/>"></script>
<script src="<c:url value="/static/js/admin/form/app_controller.js"/>"></script>
<script src="<c:url value="/static/js/admin/form/app_service.js"/>"></script>
</body>
</html>