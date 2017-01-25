<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>Authority Codes Management</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js"></script>
</head>
<body>
	<div id="deleteConfirmModal"></div>
	<div id="addNewAuthorityCode" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dimiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">Add New Authority Code</h4>
				</div>
				<div class="modal-body">
				<c:url var="action_url" value="/admin/user/authCode/new"/>
					<form:form id='addNewAuthorityForm' method="POST" modelAttribute="authority" class="form-horizonal" action="${action_url}">
						<form:input type="hidden" path="id" id="id"/>
						<div class="row">
							<div class="form-group col-md-12">
								<label class="col-md-3 control-lable" for="roleName">ROLE NAME</label>
								<div class="col-md-7">
									<form:input path="roleName" type="text" id="roleName" class="form-control input-sm"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-12">
								<label class="col-md=3 control-lable" for="comment">COMMENT</label>
								<div class="col-md=7">
									<form:textarea path="comment" id="comment" class="form-control input-sm"/>
								</div>
							</div>
						</div>
					</form:form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary" onclick="javascript:saveAuthority();">Save</button>
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<%@ include file="adminMenu.jsp" %>
		<div class="panel panel-default">
			<div class="panel-body">
			<c:if test="${param.error != null}">
				<div class="alert alert-danger">
					<p>Something has error occurred by new Authority Code</p>
				</div>
			</c:if>
				<table class="table table-hover table-condensed">
					<thead>
						<tr>
							<th>NAME</th>
							<th>COMMENT</th>
							<th width="100"></th>
							<th width="100"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${authorities}" var="auth">
							<tr>
								<td>${auth.roleName}</td>
								<td>${auth.comment}</td>
								<td><button class="btn btn-primary btn-sm" onclick="javascript:editAuthority('${auth.id}', '${auth.roleName}', '${auth.comment}')">Edit</button></td>
								<td><button class="btn btn-danger btn-sm" onclick="javascript:deleteConfirm('${auth.id}');">Delete</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="well well-sm"><span class="glyphicon glyphicon-plus"></span><a href="javascript:addNewAuthCode();">Add New Authority</a></div>
			</div>
		</div>
	</div>
	<script>
		function addNewAuthCode() {
			$('#addNewAuthorityCode').modal();
		}
		
		function saveAuthority() {
			$('#addNewAuthorityForm').submit();
			$('#addNewAuthorityCode').modal('hide');
		}
		
		function editAuthority(id, roleName, comment) {
			$("input[name='id']").val(id);
			$("input[name='roleName']").val(roleName);
			$("textarea[name='comment']").val(comment);
			$("#addNewAuthorityForm").attr('action', '<c:url value="/admin/user/authCode/update"/>');
			
			$('#addNewAuthorityCode').modal();
		}
		function deleteConfirm(id) {
			BootstrapDialog.confirm({
				title: 'WARNING',
				message: 'Warning! Delete Selected Authority!',
				type: BootstrapDialog.TYPE_WARNING,
				closable: true,
				btnOKLabel: 'Delete',
				btnOKClass: 'btn-warning',
				callback: function(result) {
					if (result) {
						window.location.href="<c:url value='/admin/user/authCode/delete/'/>" + id;
					} 
				}
			});
			return false;
		}
	</script>
</body>
</html>