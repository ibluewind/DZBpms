<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Department List</title>
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
							<th>NAME</th>
							<th>PARENT</th>
							<th>COMPANY</th>
							<th width="100"></th>
							<th width="100"></th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${deptList}" var="dept">
						<tr>
							<td>${dept.name}</td>
							<td>${dept.parentName}</td>
							<td>${dept.companyName}</td>
							<td><button class='btn btn-primary btn-sm' onclick='editDepartment(${dept.id});'>Edit</button></td>
							<td><button class='btn btn-danger btn-sm' onclick='deleteConfirm(${dept.id});'>Delete</button>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="well well-sm"><span class="glyphicon glyphicon-plus"></span><a href="<c:url value="/dept/new/company-${companyId}"/>">Add New Department</div>
	</div>
	<script>
		function editDepartment(id) {
			console.log('editDepartment id = ' + id);
			window.location.href = "<c:url value='/dept/edit/'/>" + id;
			return false;
		}
		function deleteConfirm(id) {
			BootstrapDialog.confirm({
				title: 'WARNING',
				message: 'Warning! Delete Selected Department!',
				type: BootstrapDialog.TYPE_WARNING,
				closable: true,
				btnOKLabel: 'Delete',
				btnOKClass: 'btn-warning',
				callback: function(result) {
					if (result) {
						window.location.href="<c:url value='/dept/delete/'/>" + id;
					} 
				}
			});
			return false;
		}
	</script>
</body>
</html>