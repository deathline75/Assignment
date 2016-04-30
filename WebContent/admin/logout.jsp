<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	session.invalidate();
	Cookie token = new Cookie("token", null);
	token.setMaxAge(0);
	response.addCookie(token);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Refresh" content="5;url=../">
<%@ include file="head.html"%>
<title>Logout | SP Games Store Administration</title>
</head>
<body>
	<nav class="navbar navbar-default ice-nav">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href=".">SP Games Administration Page</a>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<div class="container">
		<div class="page-header ice-header">
			<h1>You have successfully logged out. <small>You will be redirected back to the store page.</small></h1>
		</div>
		<p><a href="login.jsp">Click here to log in again.</a></p>
		<p><a href="../">Click here if you are not redirected within 5 seconds.</a>
	</div>
	<%@ include file="../footer.html"%>
</body>
</html>