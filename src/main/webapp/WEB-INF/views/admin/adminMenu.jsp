<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <span><a class="navbar-brand" href="<c:url value="/home"/>">BPMS</a></span>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
		<li><a href="<c:url value="/admin/company/"/>">Companies</a>
		<li><a href="<c:url value="/admin/dept/"/>">Departments</a>
		<li><a href="<c:url value="/admin/users/"/>">Users</a>
		<li><a href="<c:url value="/admin/form/"/>">Form</a>
		<li class="dropdown">
			<a id="codemenu" href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">Codes<span class="caret"></span></a>
			<ul class="dropdown-menu" role="menu" aria-labelledby="codemenu">
				<li role="presentation"><a role="menuitem" tabindex="-1" href="<c:url value="/admin/authority"/>">User Authority</a></li>
				<li role="presentation"><a role="menuitem" tabindex="-1" href="<c:url value="/admin/position"/>">User Position</a></li>
			</ul>
		</li>
      </ul>
      <span class="navbar-text navbar-right"><a href="<c:url value="/logout"/>">Logout</a></span>
    </div>
  </div>
</nav>