<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link href="css/font-awesome.css" rel="stylesheet">
<link
	href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic'
	rel='stylesheet' type='text/css'>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register</title>
</head>
<body class="login-bg">
	<div class="login-body">
		<div class="login-heading">
			<h1>Sign up</h1>
		</div>
		<div class="login-info">
			<ul class="nav nav-tabs">
				<li class="active" ><a href="#borrower" data-toggle="tab">Borrower</a></li>
				<li ><a href="#librarian"  data-toggle="tab">Librarian</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active" id="borrower">
					<form action="actionRegister.action" method="post">
						<input type="hidden" name="user.userTag" value="borrower" />
						<div class="form-group">
							<label for="inputUserID" class="control-label">UserID</label> <input
								class="form-control" name="user.ID">
						</div>
						<div class="form-group">
							<label for="inputPassword" class="control-label">Password</label>
							<input class="form-control" name="user.passwd">
						</div>
						<div class="form-group">
							<label for="inputPassword" class="control-label">E-mail</label> <input
								class="form-control" name="user.email">
						</div>
						<div class="form-group">
							<label for="inputPassword" class="control-label">Name</label> <input
								class="form-control" name="user.name">
						</div>
						<input type="submit" name="Sign In" value="Sign up">
					</form>
				</div>
				<div class="tab-pane" id="librarian">
					<form action="actionRegister.action" method="post">
						<input type="hidden" name="user.userTag" value="librarian" />
						<div class="form-group">
							<label for="inputUserID" class="control-label">UserID</label> <input
								class="form-control" name="user.ID">
						</div>
						<div class="form-group">
							<label for="inputPassword" class="control-label">Password</label>
							<input class="form-control" name="user.passwd">
						</div>
						<div class="form-group">
							<label for="inputPassword" class="control-label">Name</label> <input
								class="form-control" name="user.name">
						</div>
						<input type="submit" name="Sign In" value="Sign up">
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="signup-text">
		<a href="login.jsp">Already have an account? Login here.</a>
	</div>
</body>
</html>