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
	<!-- Modal -->
	<div class="modal fade" id="deptSelectModal" tabindex="-1" role="dialog" aria-labelledby="deptSelectModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="deptSelectModalLabel">Department Select</h4>
	      </div>
	      <div class="modal-body">
	      	<div id="deptTree"></div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="assignDepartment();">OK</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="container-fluid">
		<nav class="navbar nav-default">
			<div class="container-fluid">
			<span class="navbar-text navbar-left glyphicon glyphicon-list"><a href="<c:url value="/dept/list/${department.companyId}"/>">To List</a></span>
			<c:choose>
				<c:when test="${edit}">
					<span class="navbar-text navbar-right glyphicon glyphicon-plus"><a href="<c:url value="/dept/new/${department.id}"/>">Add New Department</a></span>
				</c:when>
			</c:choose>
			</div>
		</nav>
		<div class="well lead">Department Registration Form</div>
		<form:form method="POST" modelAttribute="department" class="form-horizontal" acceptCharset="UTF-8" target="_top">
			<form:input type="hidden" path="id" id="id"/>
			<form:input type="hidden" path="pId" id="pId"/>
			<form:input type="hidden" path="deptId" id="deptId"/>
			<form:input type="hidden" path="useYN" id="useYN"/>
			<form:input type="hidden" path="companyId" id="companyId"/>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="pId">Parent</label>
					<div class="col-md-7">
						<form:input path="parentName" type="text" id="parentName" class="form-control input-sm" readonly="true"/>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="name">Name</label>
					<div class="col-md-7">
						<form:input type="text" path="name" id="name" class="form-control input-sm"/>
						<div class="has-error">
							<form:errors path="name" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="companyId">Company</label>
					<div class="col-md-7">
						<form:input path="companyName" type="text" id="companyName" class="form-control input-sm" readonly="true"/>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-actions col-md-12 floatRight">
					<c:choose>
						<c:when test="${edit}">
							<input type="submit" value="Update" class="btn btn-primary btn-sm"/>
							<button type='button' class="btn btn-danger btn-sm" onclick="deleteDepartment();">Delete</button>
						</c:when>
						<c:otherwise>
							<input type="submit" value="Register" class="btn btn-primary btn-sm"/>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</form:form>
	</div>
	<script>
		var pId;
		var parentName;
		
		$('#parentName').on('click', function(e, data) {
			$('#deptSelectModal').modal('show');
		});
		
		$('#deptTree').jstree({
			'core': {
				'data': {
					'url': function () {
						return 'http://localhost:8080/bpms/dept/tree/${department.companyId}';
					},
					'data': function (node) {
						return { 'id' : node.id };
					}
				}
			},
			'plugins': ['wholerow'],
			'multiple': false
		})
		.on("changed.jstree", function (e, node) {
			pId = node.instance.get_node(node.selected[0]).id;
			parentName = node.instance.get_node(node.selected[0]).text;
		})
		.bind("loaded.jstree", function(e, data) {
			$(this).jstree("open_all");
		});
		
		function assignDepartment() {
			$('#pId').val(pId);
			$('#parentName').val(parentName);
			$('#deptSelectModal').modal('hide');
		}
		
		function deleteDepartment() {
			BootstrapDialog.confirm({
				title: 'WARNING',
				message: 'Warning! Delete Selected Department!',
				type: BootstrapDialog.TYPE_WARNING,
				closable: true,
				btnOKLabel: 'Delete',
				btnOKClass: 'btn-warning',
				callback: function(result) {
					if (result) {
						window.parent.location.href="<c:url value='/dept/delete/'/>" + $('#id').val();
					} 
				}
			});
			return false;
		}
		
	</script>
</body>
</html>