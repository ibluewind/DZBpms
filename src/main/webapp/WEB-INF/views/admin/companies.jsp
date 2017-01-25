<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Company List</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container-fluid">
		<%@ include file="adminMenu.jsp" %>
		<div class="panel panel-default">
			<div class="pannel-heading"><span class="lead">List of Companies</span></div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>ID</th>
						<th>NAME</th>
						<th>CEO</th>
						<th width="100"></th>
						<th width="100"></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${companies}" var="company">
					<tr>
						<td>${company.id}</td>
						<td>${company.name}</td>
						<td>${company.ceo}</td>
						<td><a href="<c:url value="/company/edit/${company.id}"/>">Edit</a></td>
						<td><a href="<c:url value="/company/delete/${company.id}"/>">Delete</a>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="well">
			<a href="<c:url value="/company/new"/>">Add New Company</a>
		</div>
	</div>
</body>
</html>