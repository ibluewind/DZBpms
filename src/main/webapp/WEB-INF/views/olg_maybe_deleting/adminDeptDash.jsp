<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin - Departments Management</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<body>
	<div class="container-fluid">
	<%@ include file="adminMenu.jsp" %>
		<div class="row">
			<div class="col-md-3">
				<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-default dropdown-toggle btn-sm" type="button" id="companySelector" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						Company<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu" aria-labelledby="companySelector">
						<c:forEach items="${companies}" var="comp">
							<li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:displayCompanyname('${comp.id}', '${comp.name}');">${comp.name}</a></li>
						</c:forEach>
						</ul>
					</div>
					<input type="text" id="selected-company-name" class="form-control input-sm" arial-label="company" value="${company.name}"/>
				</div>
				<div id="deptTree"></div>
			</div>
			<div class="col-md-9">
				<iframe src="<c:url value="/dept/list/${company.id}"/>" id="deptWorkspace" style="border:0; display:block; width:100%; height:100%" frameborder="0" scrolling="no"></iframe>
			</div>
		</div>
	</div>
	<script>
		loadDepartmentTree('${company.id}');
		
		function loadDepartmentTree(companyId) {
			$.jstree.destroy();
			$('#deptTree').jstree({
				'core': {
					'data': {
						'url': function () {
							return 'http://localhost:8080/bpms/dept/tree/' + companyId;
						},
						'data': function (node) {
							return { 'id' : node.id };
						}
					}
				}
			})
			.on("changed.jstree", function (e, node) {
				var pid = node.instance.get_node(node.selected[0]).parent;
				var id = node.instance.get_node(node.selected[0]).id;
				
				if (pid == '#')		return false;
				var href = "<c:url value='/dept/edit/'/>" + id;
				console.log('href=' + href);
				$('#deptWorkspace').attr('src', href);
				$('#deptWorkspace').load(function() {
					$(this).height($(this).contents().find('body')[0].scrollHeight + 30);
				});
			})
			.bind("loaded.jstree", function(e, data) {
				$(this).jstree("open_all");
			});
		}
		
		$('#deptWorkspace').load(function() {
			$(this).height($(this).contents().find('body')[0].scrollHeight + 30);
		});
		
		function displayCompanyname(companyId, companyName) {
			console.log('id = ' + companyId + ', name = ' + companyName);
			$('#selected-company-name').val(companyName);
			loadDepartmentTree(companyId);
			$('#deptWorkspace').attr('src', "<c:url value='/dept/list/'/>" + companyId);
		}
	</script>
</body>
</html>