<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,java.security.*"%>
    <%
	session.invalidate();
	Cookie token = new Cookie("token", null);
	token.setMaxAge(0);
	response.addCookie(token);
	session = request.getSession();
	String lastpage = (String) (session.getAttribute("lastpage") == null ? "." : session.getAttribute("lastpage"));
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Refresh" content="5;url=.">
<%@ include file="head.html"%>

<title>Logout | SP Games Store</title>
</head>
<body>
<%@ include file="navbar.jsp"%>
<% session.setAttribute("lastpage", lastpage); %>
<div class="container main-content">
		<div class="page-header ice-header">
			<h1>You have successfully logged out. <small>You will be redirected back to the store page.</small></h1>
		</div>
		<p><a href="login.jsp">Click here to log in again.</a></p>
		<p><a href=".">Click here if you are not redirected within 5 seconds.</a>
</div>
	<%@ include file="footer.html"%>
</body>
</html>