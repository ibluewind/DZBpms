<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Login Form</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css" />
<style>

html{
	background-color:#2F2F2F;
}

body, #mainWrapper {
	height: 100%;
	background-image: -webkit-gradient(
	linear,
	right bottom,
	right top,
	color-stop(0, #EDEDED),
	color-stop(0.08, #EAEAEA),
	color-stop(1, #2F2F2F),
	color-stop(1, #AAAAAA)
);
background-image: -o-linear-gradient(top, #EDEDED 0%, #EAEAEA 8%, #2F2F2F 100%, #AAAAAA 100%);
background-image: -moz-linear-gradient(top, #EDEDED 0%, #EAEAEA 8%, #2F2F2F 100%, #AAAAAA 100%);
background-image: -webkit-linear-gradient(top, #EDEDED 0%, #EAEAEA 8%, #2F2F2F 100%, #AAAAAA 100%);
background-image: -ms-linear-gradient(top, #EDEDED 0%, #EAEAEA 8%, #2F2F2F 100%, #AAAAAA 100%);
background-image: linear-gradient(to top, #EDEDED 0%, #EAEAEA 8%, #2F2F2F 100%, #AAAAAA 100%);
}

body, #mainWrapper, .form-control{
	font-size:12px!important;
}

#mainWrapper {
	/*height: 720px; Without explicit px values, % in children's does not work*/
	height: 100vh; /*with Viewport-Percentage, we can handles all devices screens  */
	padding-left:10px;
	padding-right:10px;
	padding-bottom:10px;
}

.login-container {
    margin-top: 100px;
    background-color: #efefef;
    width: 40%;
    left: 30%;
    position: absolute;
    border-radius: 4px;
}

.login-card {
    width: 80%;
    margin: auto;
}
.login-form {
    padding: 10%;
}

.form-container {
  position:fiexd;
  width:50%;
  margin-left: 20px;
  margin-top: 20px;
  margin-bottom: 20px;
  padding: 20px;
  background-color: #E8E1E1;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.floatRight{
	float:right;
	margin-right: 18px;
}

.has-error{
	color:red;
}

.success{
  position:fiexd;
  width:50%;
  margin-left: 50px;
  margin-top:20px;
  padding: 20px;
  background-color: #E8E1E1;
  border: 1px solid #ddd;
  border-radius: 4px;
}

</style>
</head>
<body>
	<div id="mainWrapper" class="container">
		<div class="login-container">
			<div class="login-card">
				<div class="login-form">
					<c:url var="loginUrl" value="/login"/>
					<form action="${loginUrl}" method="post" class="form-horizontal">
						<c:if test="${param.error != null}">
							<div class="alert alert-danger">
								<p>Invalid username and password.</p>
							</div>
						</c:if>
						<c:if test="${param.logout != null}">
							<div class="alert alert-success">
								<p>You have been logged out successfully.</p>
							</div>
						</c:if>
						<div class="input-group input-sm">
							<label for="userid" class="input-group-addon"><i class="fa fa-user"></i></label>
							<input type="text" id="userid" name="userid" placeholder="Enter your email" class="form-control" required/>
						</div>
						<div class="input-group input-sm">
							<label for="password" class="input-group-addon"><i class="fa fa-lock"></i></label>
							<input type="password" id="password" name="password" class="form-control" placeholder="Enter password"/>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<div class="form-actions">
							<input type="submit" class="btn btn-block btn-primary btn-default" value="Login"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>