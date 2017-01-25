<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>User List</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js"></script>
</head>
<body>
	<div id="deleteConfirmModal"></div>
	<div class="container-fluid">
		<div class="panel panel-default">
			<div class="pannel-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>USERID</th>
							<th>LASTNAME</th>
							<th>FIRSTNAME</th>
							<th width="100"></th>
							<th width="100"></th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${userList}" var="user">
						<tr>
							<td>${user.userId}</td>
							<td>${user.lastName}</td>
							<td>${user.firstName}</td>
							<td><button class='btn btn-primary btn-sm' onclick='editUserInfo(${user.id});'>Edit</button></td>
							<td><button class='btn btn-danger btn-sm' onclick='deleteConfirm(${user.id});'>Delete</button>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="well well-sm"><span class="glyphicon glyphicon-plus"></span><a href="<c:url value="/user/new/${deptId}"/>">Add New User</div>
	</div>
	<script>
		function editUserInfo(id) {
			console.log('user id = ' + id);
			window.location.href = "<c:url value='/user/edit/'/>" + id;
			return false;
		}
		function deleteConfirm(id) {
			BootstrapDialog.confirm({
				title: 'WARNING',
				message: 'Warning! Delete Selected User!',
				type: BootstrapDialog.TYPE_WARNING,
				closable: true,
				btnOKLabel: 'Delete',
				btnOKClass: 'btn-warning',
				callback: function(result) {
					if (result) {
						window.location.href="<c:url value='/user/delete/'/>" + id;
					} 
				}
			});
			return false;
		}
	</script>
</body>
</html>