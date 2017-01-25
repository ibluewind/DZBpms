<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>Register Department page</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js"></script>
</head>
<body>
	<div class="container-fluid">
		<nav class="navbar nav-default">
			<span class="navbar-text navbar-left glyphicon glyphicon-list">&nbsp;<a href="<c:url value="/user/list/${department.id}"/>">To List</a></span>
		</nav>
		<div class="well lead">User Registration Form</div>
		<c:url value="/user/new/deptAssign/${department.id}" var="actionUrl"/>
		<form:form method="POST" modelAttribute="user" class="form-horizontal" action="${actionUrl}" acceptCharset="UTF-8" target="_self">
			<form:input type="hidden" path="id" id="id"/>
			<form:input type="hidden" path="state" id="state"/>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="userId">USER ID</label>
					<div class="col-md-7">
						<form:input path="userId" type="text" id="userId" class="form-control input-sm" placeholder="Use chosun.com Email address"/>
						<div class="has-error">
							<form:errors path="userId" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="firstName">Firstname</label>
					<div class="col-md-7">
						<form:input type="text" path="firstName" id="firstName" class="form-control input-sm"/>
						<div class="has-error">
							<form:errors path="firstName" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="lastName">Lastname</label>
					<div class="col-md-7">
						<form:input path="lastName" type="text" id="lastName" class="form-control input-sm"/>
						<div class="has-error">
							<form:errors path="lastName" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="password">Password</label>
					<div class="col-md-7">
						<form:input path="password" type="password" id="password" class="form-control input-sm"/>
						<div class="has-error">
							<form:errors path="password" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="confirmPassword">Confirm Password</label>
					<div class="col-md-7">
						<input type="password" id="confirmPassword" class="form-control input-sm"/>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-actions col-md-12 floatRight">
					<input type="submit" value="Next >>" class="btn btn-primary btn-sm"/>
				</div>
			</div>
		</form:form>
	</div>
	<script>
		
		
	</script>
</body>
</html>