<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% String genreids = request.getParameter("id"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="head.html"%>

<title>Sign In | SP Games Store</title>
</head>
<body>
<%@ include file="navbar.jsp"%>
<div class="container main-content">
	<h1>Join us with our community!</h1>
	<div class="row">
		<div class="col-md-6">
			<h3>Sign In</h3>
			<hr/>
			<form class="form-horizontal ice-admin-login-form" method="post" action="login">
				<div class="form-group">
					<label for="inputEmail" class="col-sm-2 control-label">Email: </label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="inputEmail" placeholder="Email" required name="email" autofocus>
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="col-sm-2 control-label">Password: </label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="inputPassword" placeholder="Password" required name="password">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default">Sign in</button>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-6">
			<h3>Register</h3>
			<hr/>
			<form class="form-horizontal ice-admin-login-form" method="post" action="register">
				<div class="form-group">
					<label for="inputEmail" class="col-sm-3 control-label">Email Address: </label>
					<div class="col-sm-9">
						<input type="email" class="form-control" id="inputEmail" placeholder="Email Address" required name="email" >
					</div>
				</div>
				<div class="form-group">
					<label for="inputCfmEmail" class="col-sm-3 control-label">Confirm Email: </label>
					<div class="col-sm-9">
						<input type="email" class="form-control" id="inputCfmEmail" placeholder="Email Address" required name="cfmEmail" >
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="inputPassword" class="col-sm-3 control-label">Password: </label>
					<div class="col-sm-9">
						<input type="password" class="form-control" id="inputPassword" placeholder="Password" required name="password">
					</div>
				</div>
				<div class="form-group">
					<label for="inputCfmPassword" class="col-sm-3 control-label">Confirm Password: </label>
					<div class="col-sm-9">
						<input type="password" class="form-control" id="inputCfmPassword" placeholder="Confirm Password" required name="cfmPassword">
					</div>
				</div>
				<hr />
				<div class="form-group">
					<label for="inputNickname" class="col-sm-3 control-label">Nickname: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputNickname" placeholder="Nickname" required name="nickname">
					</div>
				</div>
				<hr />
				<div class="g-recaptcha col-sm-offset-3" data-sitekey="6LctkR4TAAAAAPQYqGQkmeaczaReQwT0qkC-tagZ" style="margin-bottom: 15px"></div>
				<div class="form-group">
					<div class="col-sm-offset-3 col-sm-9">
						<button type="submit" class="btn btn-default">Register</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
	<%@ include file="footer.html"%>
</body>
</html>