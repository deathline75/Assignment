<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="com.ice.*"%>
<%
	if (session.getAttribute("username") == null)
		response.sendRedirect("login.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>SP Games Store Administration</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container">
		<div class="page-header">

			<h1>
				Welcome back,
				<%=username%>! <small>Last login: <%
				connectToMysql connection = new connectToMysql(MyConstants.url);
				ResultSet rs = connection.preparedQuery("Select lastLogin from user where username=?", username);
				if (rs.next()) {
					String lastLogin = rs.getString("lastLogin");
					out.print(lastLogin);
					connection.close();
				}
			%></small>
			</h1>


			<%
				java.util.Date date = new java.util.Date();
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String currentTime = sdf.format(date);
				connection.preparedUpdate("update user set lastLogin=? where username=?", date, username);
			%>
		</div>
	</div>
	<%@ include file="../footer.html"%>
</body>
</html>