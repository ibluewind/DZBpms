<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>Select User's Authorities</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container-fluid">
		<div class="pannel pannel-default">
			<div class="pannel-heading"><h4>Select User's Authority</h4></div>
			<div class="pannel-body">
			<c:url value="/user/new/save/${departmentId}" var="formAction"/>
			<form:form method="POST" modelAttribute="user" action="${formAction}" target="_self">
				<table class="table table-stripe">
					<thead>
						<tr>
							<th>NAME</th>
							<th>COMMNET</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${authorities}" var="auth">
							<tr>
								<td>${auth.roleName}</td>
								<td>${auth.comment}</td>
								<td><input type="checkbox" name="authId" value="${auth.id}" class="form-control input-sm"/>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="well">
					<input type="submit" value="Register" class="btn btn-primary btn-sm"/>
				</div>
			</form:form>
			</div>
		</div>
	</div>
</body>
</html>