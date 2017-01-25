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
<style>
	form fieldset {
		display:none;
	}
	form .form-bottom .input-error {
		border-color: #19b9e7;
	}
</style>
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
			<span class="navbar-text navbar-left glyphicon glyphicon-list"><a href="<c:url value="/user/list/${departmentId}"/>">To List</a></span>
		</nav>
		<div class="well lead">User Registration Form</div>
		<c:choose>
			<c:when test="${edit}">
				<c:url value="/user/edit/save/${departmentId}" var="actionUrl"/>
			</c:when>
			<c:otherwise>
				<c:url value="/user/new/save/${departmentId}" var="actionUrl"/>
			</c:otherwise>
		</c:choose>
		
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2 form-box">
				<form:form role="form" method="POST" modelAttribute="user" class="form-horizontal" action="${actionUrl}" acceptCharset="UTF-8" target="_self">
				<form:input type="hidden" path="id" id="id"/>
					<fieldset>
					<div class="form-top">
						<div class="form-top-left">
							<h3>Step 1 / 3</h3>
							<p>User name and password:</p>
						</div>
					</div>
					<div class="form-bottom">
						<div class="form-group">
							<label class="control-lable" for="userId">USER ID</label>
							<form:input path="userId" type="text" id="userId" class="form-control input-sm" placeholder="Use chosun.com Email address"/>
							<div class="has-error">
								<form:errors path="userId" class="help-inline"/>
							</div>
						</div>
						<div class="form-group">
							<label class="control-lable" for="firstName">Firstname</label>
							<form:input type="text" path="firstName" id="firstName" class="form-control input-sm"/>
							<div class="has-error">
								<form:errors path="firstName" class="help-inline"/>
							</div>
						</div>
						<div class="form-group">
							<label class="control-lable" for="lastName">Lastname</label>
							<form:input path="lastName" type="text" id="lastName" class="form-control input-sm"/>
							<div class="has-error">
								<form:errors path="lastName" class="help-inline"/>
							</div>
						</div>
						<div class="form-group">
							<label class="control-lable" for="password">Password</label>
							<form:input path="password" type="password" id="password" class="form-control input-sm"/>
							<a id="passwordIncorrectPopover" data-toggle='popover' data-trigger='manual' data-content='Retype your password.'></a>
							<div class="has-error">
								<form:errors path="password" class="help-inline"/>
							</div>
						</div>
						<div class="form-group">
							<label class="control-lable" for="confirmPassword">Confirm Password</label>
							<input type="password" id="confirmPassword" class="form-control input-sm"/>
						</div>
					</div>
					<button type="button" class="btn btn-next">Next</button>
					</fieldset>
					<fieldset>
					<div class="form-top">
						<div class="form-top-left">
							<h3>Step 2 / 3</h3>
							<p>Assign Department and User's Authority
						</div>
					</div>
					
					<div class="form-bottom">
						<div class="form-group">
							<label class="control-lable" for="state">State</label>
							<form:select path="state" id="state" class="form-control">
								<option value="Y">Active</option>
								<option value="D">Deleted</option>
								<option value="R">Retired</option>
								<option value="L">Locked</option>
							</form:select>
						</div>
						<div id="departmentInfo">
						<c:choose>
							<c:when test="${edit == false}">
							<div class="form-group">
								<div class="col-md-5">
									<label class="control-lable" for="deptName">Department</label>
									<input type="hidden" name="deptId">
									<input type="text" class="form-control input-sm" name="deptName" onclick="showDepartmentSelectModal(event);">
								</div>
								<div class="col-md-5">
									<label class="control-lable" for="positionName">Position</label>
									<input type="hidden" name="positionId">
									<input type="text" class="form-control input-sm" name="positionName" onclick="showPositionSelectModal(event);">
								</div>
								<div class="col-md-2">
									<label>&nbsp;</label>
									<button type="button" class="btn btn-default btn-sm" onclick="addDepartmentForm();"><span class="glyphicon glyphicon-plus"></span></button>
								</div>
							</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${user.deptPositions}" var="deptPosition" varStatus="i">
									<div class="form-group">
								<div class="col-md-5">
									<label class="control-lable" for="deptName">Department</label>
									<input type="hidden" name="deptId" value="${deptPosition.deptId}">
									<input type="text" class="form-control input-sm" name="deptName" value="${deptPosition.deptName}" onclick="showDepartmentSelectModal(event);">
								</div>
								<div class="col-md-5">
									<label class="control-lable" for="positionName">Position</label>
									<input type="hidden" name="positionId" value="${deptPosition.positionId}">
									<input type="text" class="form-control input-sm" name="positionName" value="${deptPosition.positionName}" onclick="showPositionSelectModal(event);">
								</div>
								<div class="col-md-2">
									<label>&nbsp;</label>
									<button type="button" class="btn btn-default btn-sm" onclick="addDepartmentForm();"><span class="glyphicon glyphicon-plus"></span></button>
									<c:if test="${i.index > 0}">
									<button type="button" class="btn btn-default btn-sm" onclick="removeDepartmentForm();"><span class="glyphicon glyphicon-minus"></span></button>
									</c:if>
								</div>
							</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						</div>
					</div>
					<button type="button" class="btn btn-previous">Previous</button>
					<button type="button" class="btn btn-next">Next</button>
					</fieldset>
					<fieldset>
					<div class="form-top">
						<div class="form-top-left">
							<h3>3 / 3</h3>
							<p>Assign User Authority</p>
						</div>
					</div>
					<div class="form-bottom">
						<table class="table table-stripe">
							<thead>
								<tr>
									<th>NAME</th><th>COMMENT</th><th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${authorities}" var="auth">
									<tr>
										<td>${auth.roleName}</td>
										<td>${auth.comment}</td>
										<td><input type="checkbox" name="authId" value="${auth.id}" class="form-control input-sm"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<button type="button" class="btn btn-previous">Previous</button>
					<button type="submit" class="btn">Save</button>
					</fieldset>
				</form:form>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function () {
			$($("form fieldset")[0]).fadeIn('slow');
			<c:if test="${edit}">
				<c:forEach var="auth" items="${user.userAuthorities}">
					$("input:checkbox[name='authId']:checkbox[value='${auth.authId}']").prop("checked", true);
				</c:forEach>
			</c:if>
		});
		
		$('form input[type="text"], form input[type="password"]').on('focus', function() {
			$(this).removeClass('input-error');
		}).on('click', function() {
			$('#passwordIncorrectPopover').popover('hide');
		});
		
		$('form .btn-next').on('click', function() {
			var parent_fieldset = $(this).parents('fieldset');
			var	next_step = true;
			
			parent_fieldset.find('input[type="text"], input[type="password"]').each(function() {
				if ($(this).val() == '') {
					$(this).addClass('input-error');
					next_step = false;
				} else {
					$(this).removeClass('input-error');
				}
			});
			
			var passwords = $('input[type="password"]');
			if ($(passwords[0]).val() != $(passwords[1]).val()) {
				$('#passwordIncorrectPopover').popover({
					'placement':'right',
				}).popover('show');
				$(passwords[0]).val('');
				$(passwords[1]).val('');
				$(passwords[0]).focus();
				next_step = false;
			}
			
			console.log('next_step = ' + next_step);
			if (next_step) {
				parent_fieldset.fadeOut(400, function() {
					$(this).next().fadeIn();
				});
			}
		});
		
		$('form .btn-previous').on('click', function() {
			$(this).parents('fieldset').fadeOut(400, function() {
				$(this).prev().fadeIn();
			});
		});
		
		function addDepartmentForm() {
			var $template = $('#departmentInfo').find('.form-group').last().clone();
			var $row = $('<div>').addClass('form-group');
			
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
			$template.find('button').last().bind("click", removeDepartmentForm);
			
			$template.appendTo($row).appendTo('#departmentInfo');
		}
		
		function removeDepartmentForm() {
			$targetRow = $(window.event.target).parents('.form-group');
			$targetRow.remove();
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