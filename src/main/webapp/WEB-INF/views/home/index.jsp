<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Home Page</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//mgcrea.github.io/angular-strap/styles/libs.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css"/>
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-slider/5.8.7/rzslider.min.css"/>
<link rel="stylesheet" href="<c:url value='/static/css/'/>angular-motion.css"/>
<link rel="stylesheet" href="<c:url value='/static/css/'/>approve.css"/>
<link rel="stylesheet" href="<c:url value='/static/css/'/>calendar.css"/>
</head>
<body ng-app="bpmApp">
	<div class="container-fluid">
		<nav class="navbar navbar-default">
		  <div class="container-fluid">
		    <!-- Brand and toggle get grouped for better mobile display -->
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#menu_collapse">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		      <a class="navbar-brand" href="#/">BPMS&nbsp;<span class="small">${user.lastName}${user.firstName}-${user.deptPositions[0].deptName}</span></a>
		    </div>
		
		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="menu_collapse">
		      <ul class="nav navbar-nav">
		        <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/calendar"/>일정<span class="sr-only">(current)</span></a></li>
		        <li class="dropdown">
		          <a href="./" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">작업<span class="caret"></span></a>
		          <ul class="dropdown-menu" role="menu">
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/task_list">작업목록</a></li>
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/regist_task/-9999">작업등록</a></li>
		            <li class="divider"></li>
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/expect_task">작업 보고서</a></li>
		          </ul>
		        </li>
		        <li class="dropdown">
		          <a href="./" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">결재함<span class="caret"></span></a>
		          <ul class="dropdown-menu" role="menu">
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/list_app">결재등록</a></li>
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/approve_tray/U">미결함</a></li>
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/approve_tray/D">보류함</a></li>
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/approve_tray/F">기결함</a></li>
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/approve_tray/S">참조함</a></li>
		            <li class="divider"></li>
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/approve_tray/C">완료함</a></li>
		            <li class="divider"></li>
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/approve_tray/E">예정함</a></li>
		            <li class="divider"></li>
		            <li><a data-toggle="collapse" data-target="#menu_collapse" href="#/man_appline">결재라인관리</a></li>
		          </ul>
		        </li>
		        <li class="dropdown">
		        	<a href="./" class="dropdown-toggle" data-toggle="dropdown" role="button" arai-expanded="false">프로젝트 관리<span class="caret"></span></a>
		        	<ul class="dropdown-menu" role="menu">
		        		<li><a data-toggle="collapse" data-target="#menu_collapse" href="#/list_project">프로젝트 목록</a></li>
		        		<li><a data-toggle="collapse" data-target="#menu_collapse" href="#/project/regist">프로젝트 생성</a></li>
		        	</ul>
		        </li>
		      </ul>
		      <ul class="nav navbar-nav navbar-right">
		      	<li ng-controller="alertMessageController as msg"><a href="<c:url value='#/msgbox'/>"><span class="galyphicon glyphicon-envelope"></span><span class="badge">{{msg.unreadmessages.length}}</span></a></li>
		      	<li ng-controller="logoutController as ctrl"><a href="<c:url value="/logout"/>" ng-click="ctrl.clearSession()">Logout</a></li>
		      	<sec:authorize access="hasRole('ADMIN') and hasRole('DBA')">
		        <li><a href="<c:url value="/admin"/>">Admin</a></li>
		        </sec:authorize>
		      </ul>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>
		<div id="work-area" ng-view></div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-route.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-cookies.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-sanitize.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-animate.min.js"></script>
<script src="//mgcrea.github.io/angular-strap/dist/angular-strap.js" data-semver="v2.3.8"></script>
<script src="//mgcrea.github.io/angular-strap/dist/angular-strap.tpl.js" data-semver="v2.3.8"></script>
<script src="<c:url value="/static/js/angular-file-upload.js"/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<c:url value="/static/js/"/>ngJsTree.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-slider/5.8.7/rzslider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="<c:url value="/static/js/angular-chart.min.js"/>"></script>
<script>
	var company = {id: '${company.id}', name: '${company.name}', ceo: '${company.ceo}'};
</script>
<script src="<c:url value="/static/js/app.js"/>"></script>
<script src="<c:url value="/static/js/common_tree.js"/>"></script>
<script src="<c:url value="/static/js/modal_window.js"/>"></script>
<script src="<c:url value="/static/js/admin/user/app_service.js"/>"></script>
<script src="<c:url value="/static/js/home/app_configure.js"/>"></script>
<script src="<c:url value="/static/js/home/dashboard_controller.js"/>"></script>
<script src="<c:url value="/static/js/home/task_constant.js"/>"></script>
<script src="<c:url value="/static/js/home/task_service.js"/>"></script>
<script src="<c:url value="/static/js/home/task_controller.js"/>"></script>
<script src="<c:url value="/static/js/home/approve_constant.js"/>"></script>
<script src="<c:url value="/static/js/home/approve_service.js"/>"></script>
<script src="<c:url value="/static/js/home/approve_controller.js"/>"></script>
<script src="<c:url value="/static/js/home/calendar_constant.js"/>"></script>
<script src="<c:url value="/static/js/home/calendar_controller.js"/>"></script>
<script src="<c:url value="/static/js/home/calendar_service.js"/>"></script>
<script src="<c:url value="/static/js/home/calendar_render.js"/>"></script>
<script src="<c:url value="/static/js/home/chart_controller.js"/>"></script>
<script src="<c:url value="/static/js/home/chart_service.js"/>"></script>
<script src="<c:url value="/static/js/home/message_controller.js"/>"></script>
<script src="<c:url value="/static/js/home/message_service.js"/>"></script>
<script src="<c:url value="/static/js/home/project_controller.js"/>"></script>
<script src="<c:url value="/static/js/home/project_service.js"/>"></script>
</body>
</html>