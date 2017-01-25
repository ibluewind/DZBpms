<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Make Form</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style>
	[ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak {
		display: none !important;
	}
</style>
</head>
<body ng-app="bpmApp" ng-cloak>
	<div class="container-fluid" ng-controller="mainController as ctrl">
		<%@ include file="../adminMenu.jsp" %>
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">양식 생성</div>
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-4">
						<h4>Form build menu</h4>
					</div>
					<div class="col-mg-8">
						<div role="tabpanel">
						  <!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a href="#draw" aria-controls="draw" role="tab" data-toggle="tab">Form</a></li>
							<li role="presentation"><a href="#preview" aria-controls="preview" role="tab" data-toggle="tab">Preview</a></li>
						</ul>
						
						<!-- Tab panes -->
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active" id="draw">
							<br/>
								<form name="form" class="form-horizontal">
									<div class="form-group">
										<label class="col-md-3 control-label" for="title">양식명</label>
										<div class="col-md-8">
											<input type="text" id="title" class="form-control" ng-model="ctrl.form.formName" required/>
										</div>
									
									</div>
									<div class="form-group">
										<label class="col-md-3 control-label" for="name">비고</label>
										<div class="col-md-8">
											<input type="text" id="remark" class="form-control" ng-model="ctrl.form.remark" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-3 control-label" for="content">양식내용</label>
										<div class="col-md-8">
											<textarea id="content" ng-model="ctrl.form.content" rows="30" style="width:100%;"></textarea>
										</div>
									</div>
								</form>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="preview">
								<div class="row">
									<div ng-bind-html="ctrl.form.content"></div>
								</div>
							</div>
						</div>
						
						</div>
					</div>
				</div>
			</div>
			<div class="panel-footer">
				<button type="button" class="btn btn-default btn-sm" ng-click="ctrl.add()">Add</button>
			</div>
		</div>
	</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-sanitize.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-animate.min.js"></script>
<script src="<c:url value='/static/js/'/>angular-strap.js"></script>
<script src="<c:url value='/static/js/'/>angular-strap.tpl.js"></script>
<script src="<c:url value="/static/js/admin/form/app.js"/>"></script>
<script src="<c:url value="/static/js/admin/form/app_controller.js"/>"></script>
</body>
</html>