<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>Position Codes Management</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js"></script>
</head>
<body>
	<div id="deleteConfirmModal"></div>
	<div id="addNewPositionCode" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dimiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">Add New Position Code</h4>
				</div>
				<div class="modal-body">
				<c:url var="action_url" value="/admin/user/positionCode/new"/>
					<form:form id='addNewPositionForm' method="POST" modelAttribute="position" class="form-horizonal" action="${action_url}">
						<form:input type="hidden" path="id" id="id"/>
						<form:input type="hidden" path="code" id="code"/>
						<div class="row">
							<div class="form-group col-md-12">
								<label class="col-md-3 control-lable" for="roleName">POSITION NAME</label>
								<div class="col-md-7">
									<form:input path="name" type="text" id="name" class="form-control input-sm"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-12">
								<label class="col-md-3 control-lable" for="type">TYPE</label>
								<div class="col-md-7">
									<form:select path="type" id="type" class="form-control">
										<form:option value="P">직급</form:option>
										<form:option value="R">직책</form:option>
									</form:select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-12">
								<label class="col-md=3 control-lable" for="comment">ORDER SEQ.</label>
								<div class="col-md=7">
									<form:input path="seq" id="seq" class="form-control input-sm"/>
								</div>
							</div>
						</div>
					</form:form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary" onclick="javascript:savePosition();">Save</button>
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
					<p>Something has error occurred by new Position Code</p>
				</div>
			</c:if>
				<table class="table table-hover table-condensed">
					<thead>
						<tr>
							<th>NAME</th>
							<th>TYPE</th>
							<th>SEQ</th>
							<th width="100"></th>
							<th width="100"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${positions}" var="pos">
							<tr>
								<td>${pos.name}</td>
								<td>
								<c:choose>
									<c:when test="${pos.type == 'P'}">
									직급
									</c:when>
									<c:otherwise>
									직책
									</c:otherwise>
								</c:choose>
								</td>
								<td>${pos.seq}</td>
								<td><button class="btn btn-primary btn-sm" onclick="javascript:editPosition('${pos.id}', '${pos.code}', '${pos.name}', '${pos.type}', '${pos.seq}');">Edit</button></td>
								<td><button class="btn btn-danger btn-sm" onclick="javascript:deleteConfirm('${pos.id}');">Delete</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="well well-sm"><span class="glyphicon glyphicon-plus"></span><a href="javascript:addNewPosition();">Add New Position</a></div>
			</div>
		</div>
	</div>
	<script>
		function addNewPosition() {
			$('#addNewPositionCode').modal();
		}
		
		function savePosition() {
			$('#addNewPositionForm').submit();
			$('#addNewPositionCode').modal('hide');
		}
		
		function editPosition(id, code, name, type, seq) {
			$("input[name='id']").val(id);
			$("input[name='code']").val(code);
			$("input[name='name']").val(name);
			$("select[name='type']").val(type);
			$("input[name='seq']").val(seq);
			$("#addNewPositionForm").attr('action', '<c:url value="/admin/user/positionCode/update"/>');
			
			$('#addNewPositionCode').modal();
		}
		function deleteConfirm(id) {
			BootstrapDialog.confirm({
				title: 'WARNING',
				message: 'Warning! Delete Selected Position!',
				type: BootstrapDialog.TYPE_WARNING,
				closable: true,
				btnOKLabel: 'Delete',
				btnOKClass: 'btn-warning',
				callback: function(result) {
					if (result) {
						window.location.href="<c:url value='/admin/user/positionCode/delete/'/>" + id;
					} 
				}
			});
			return false;
		}
	</script>
</body>
</html>