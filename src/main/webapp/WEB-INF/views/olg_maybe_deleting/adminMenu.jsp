<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <span class="navbar-brand"><a href="<c:url value="/admin"/>">Admin</a></span>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
		<li><a href="<c:url value="/company/list"/>" role="button">Companies</a>
		<li><a href="<c:url value="/admin/dept"/>" role="button">Departments</a>
		<li><a href="<c:url value="/admin/users"/>" role="button">Users</a>
		<li class="dropdown">
			<a id="process" href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" arai-expanded="false">Processes<span class="caret"></span></a>
			<ul class="dropdown-menu" role="menu" aria-labelledby="process">
				<li role="presentation"><a role="menuitem" tabindex="-1" href="<c:url value="/admin/form/builder"/>">Form Builder</a></li>
				<li role="presentation"><a role="meunitem" tabindex="-1" href="<c:url value="/admin/process/list"/>">Process List</a></li>
			</ul>
		<li class="dropdown">
			<a id="codemenu" href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">Codes<span class="caret"></span></a>
			<ul class="dropdown-menu" role="menu" aria-labelledby="codemenu">
				<li role="presentation"><a role="menuitem" tabindex="-1" href="<c:url value="/admin/user/authCode"/>">User Authority</a></li>
				<li role="presentation"><a role="menuitem" tabindex="-1" href="<c:url value="/admin/user/positionCode"/>">User Position</a></li>
			</ul>
      </ul>
      <span class="navbar-text navbar-right"><a href="#">Logout</a></span>
    </div>
  </div>
</nav>