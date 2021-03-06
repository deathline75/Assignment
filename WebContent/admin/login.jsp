<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="java.sql.*, com.ice.*,com.ice.api.*,com.ice.util.*" %>
<%
	if (session.getAttribute("username") != null)
		response.sendRedirect(".");
	String failed = null;
	if (request.getParameter("g-recaptcha-response") == "") {
		failed = "Retry your captcha.";
	} else if (request.getParameter("username") != null && request.getParameter("password") != null) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		DatabaseConnect connection = new DatabaseConnect(MyConstants.url);
		ResultSet rs = connection.preparedQuery("Select * from user where username=? and userpwd=?",username,password);
		if (rs.next()) {
			connection.close();
			if (VerifyUtils.verify(request.getParameter("g-recaptcha-response"))) {
				session.setAttribute("username", username);
				response.sendRedirect(".");
			} else {
				failed = "Retry your captcha.";
			}
		} else {
			failed = "Invalid username or password.";
			connection.close();
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>

<title>Admin Login | SP Games Store Admin</title>
</head>
<body>
	<nav class="navbar navbar-fixed-top ice-nav">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href=".">SP Games Store Admin</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav ice-nav-ul">
				<li><a href="../">Main Page</a></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<div class="container main-content">
		<%
			if (failed != null) {
				out.println("<div class=\"alert alert-danger\" role=\"alert\">" + failed + "</div>");
				out.println("<script>grecaptcha.reset();</script>");
			}
		%>
		<h1 class="col-sm-offset-3">Admin Login</h1>
		<form class="form-horizontal ice-admin-login-form col-sm-offset-3" method="post">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-1 control-label">Username</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="inputUsername"
						placeholder="Username" required name="username" autofocus>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-1 control-label">Password</label>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="inputPassword" placeholder="Password" required name="password">
				</div>
			</div>
			<div class="g-recaptcha col-sm-offset-1" data-sitekey="6LctkR4TAAAAAPQYqGQkmeaczaReQwT0qkC-tagZ" style="margin-bottom: 15px"></div>
			<div class="form-group">
				<div class="col-sm-offset-1 col-sm-10">
					<button type="submit" class="btn btn-default">Sign in</button>
				</div>
			</div>
		</form>
	</div>
	<%@ include file="../footer.html"%>
</body>
</html>