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
	<div class="modal fade" id="positionSelectModal" tabindex="-1" role="dialog" aria-labelledby="positionSelectModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="positionSelectModalLabel">Position Select</h4>
				</div>
				<div class="modal-body">
					<table class="table table-striped">
					<thead>
						<th>NAME</th>
						<th>TYPE</th>
						<th></th>
					</thead>
					<tbody>
					<c:forEach items="${positions}" var="position">
						<tr>
							<td>${position.name}</td>
							<td>
								<c:choose>
									<c:when test="${position.type == 'P'}">직급</c:when>
									<c:otherwise>직책</c:otherwise>
								</c:choose>
							</td>
							<td><label><input type="radio" name="positionId" value="${position.id}" onclick="setPosition('${position.id}', '${position.name}')"/>${position.name}</label></td>
						</tr>
					</c:forEach>
					</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" onclick="assignPosition();">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<nav class="navbar nav-default">
			<span class="navbar-text navbar-left glyphicon glyphicon-list"><a href="<c:url value="/user/list/${department.id}"/>">To List</a></span>
		</nav>
		<div class="well lead">User Registration Form (Assign Department)</div>
		<c:url value="/user/new/authAssign/${departmentId}" var="formUrl"/>
		<form:form method="POST" modelAttribute="user" class="form-horizontal" action="${formUrl}" acceptCharset="UTF-8" target="_self">
			<form:input type="hidden" path="id" id="id"/>
			<form:input type="hidden" path="state" id="state"/>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="userId">USER ID</label>
					<div class="col-md-9">
						<form:input path="userId" type="text" id="userId" class="form-control input-sm" readonly="true"/>
						<div class="has-error">
							<form:errors path="userId" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="firstName">Firstname</label>
					<div class="col-md-9">
						<form:input type="text" path="firstName" id="firstName" class="form-control input-sm" readonly="true"/>
						<div class="has-error">
							<form:errors path="firstName" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="lastName">Lastname</label>
					<div class="col-md-9">
						<form:input path="lastName" type="text" id="lastName" class="form-control input-sm" readonly="true"/>
						<div class="has-error">
							<form:errors path="lastName" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<div  id="departmentInfo">
				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-2 control-lable">Assigned Department</label>
						<div class="col-md-3">
							<input type="hidden" name="deptId" value="${department.id}"/>
							<input type="text" name="deptName" class="form-control input-sm" value="${department.name}" onclick="showDepartmentSelectModal(event);"/>
						</div>
						<label class="col-md-2 control-lable">Select Position</label>
						<div class="col-md-3">
							<input type="hidden" name="positionId"/>
							<input type="text" name="positionName" class="form-control input-sm" onclick="showPositionSelectModal(event);"/>
						</div>
						<div class="col-md-2">
							<button type="button" class="btn btn-default btn-sm" onclick="addDepartmentForm();"><span class="glyphicon glyphicon-plus"></span></button>
						</div>
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
		function addDepartmentForm() {
			var $template = $('#departmentInfo').find('.row').last().clone();
			var $row = $('<div>').addClass('row');
			
			console.log($template.html());
			$template.find("input[name='deptId']").val("");
			$template.find("input[name='deptName']").val("").bind("click", function() {
				showDepartmentSelectModal();
			});
			
			$template.find("input[name='positionId']").val("");
			$template.find("input[name='positionName']").val("").bind("click", function() {
				showPositionSelectModal();
			});
			
			if ($template.find("button").length <= 1) {
				var	$removeBtn = $('<button>').attr('type', 'button').addClass("btn btn-default btn-sm");
				var $removeSpan = $('<span>').addClass("glyphicon glyphicon-minus");
				$removeBtn.append($removeSpan);
				$removeBtn.appendTo($template.find('button').parent());
			}
			
			//제거버튼 이벤트 핸들러
			$template.find('button').last().bind("click", function(e) {
				$targetRow = $(e.target).parents('.row');
				$targetRow.remove();
			});
			
			$template.appendTo($row).appendTo('#departmentInfo');
		}
		
		var deptId;
		var deptName;
		
		var $targetDeptId;
		var $targetDeptName;
		
		function showDepartmentSelectModal(event) {
			$targetDeptName = $(event.target);
			$targetDeptId = $targetDeptName.siblings("input[name='deptId']");
			$('#deptSelectModal').modal();
		}
		
		function assignDepartment() {
			$targetDeptName.val(deptName);
			$targetDeptId.val(deptId);
			$('#deptSelectModal').modal('hide');
		}
		
		var	positionId;
		var positionName;
		
		var	$targetPositionId;
		var $targetPositionName;
		
		function showPositionSelectModal(event) {
			$targetPositionName = $(event.target);
			$targetPositionId = $targetPositionName.siblings("input[name='positionId']");
			$('#positionSelectModal').modal();
		}
		
		function setPosition(id, name) {
			positionId = id;
			positionName = name;
		}
		
		function assignPosition() {
			$targetPositionName.val(positionName);
			$targetPositionId.val(positionId);
			$('#positionSelectModal').modal('hide');
		}
		
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
			deptId = node.instance.get_node(node.selected[0]).id;
			deptName = node.instance.get_node(node.selected[0]).text;
		})
		.bind("loaded.jstree", function(e, data) {
			$(this).jstree("open_all");
		});
	</script>
</body>
</html>