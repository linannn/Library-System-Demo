<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link href="css/font-awesome.css" rel="stylesheet">
<link
	href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic'
	rel='stylesheet' type='text/css'>
<script>
	function login() {
		var userId = document.getElementById("userInfo");
		var postId = document.getElementById("Id");
		postId.value = userId.value;
		return true;
	}
</script>
</head>
<body class="login-bg">
	<div class="login-body">
		<div class="login-heading">
			<h1>Login</h1>
		</div>
		<div class="login-info">


			<form action="actionLogin" id="loginForm" method="post">
				<input type="hidden" name="userId" id="Id" />

				<div class="form-group">
					<label for="userInfo" class="control-label">UserID</label> 
					<input class="form-control" id="userInfo" name="user.ID">
				</div>

				<div class="form-group">
					<label for="userPwd" class="control-label">Password</label> 
					<input class="form-control" name="user.passwd">
				</div>
				
  <s:select 
    list="#{'borrower':'borrower', 'librarian':'librarian'}" 
    name="user.userTag" 
    value="borrower" />
				<button type="submit" class="btn btn-primary btn-lg btn-block"
					onclick="return login()">login</button>
				<div class="signup-text">
					<a href="register.jsp">Don't have an account? Create now</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>