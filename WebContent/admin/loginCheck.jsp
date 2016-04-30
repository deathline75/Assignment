<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.*"%>
	<%
		String sUserName = request.getParameter("txtUserName");
		String sPasswd = request.getParameter("txtPassword");
		Class.forName("org.gjt.mm.mysql.Driver").newInstance();
		String url = "jdbc:mysql://188.166.238.151/ead";
		Connection connection = DriverManager.getConnection(url, "root", "iloveeadxoxo");
		String sql = "select * from user where username='" + sUserName + "' and userpwd = '" + sPasswd + "'";
		Statement stmt = connection.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next()) {
			out.println("Login success");
		} else {
			out.println("Login Fail");
		}
		rs.close();
		stmt.close();
		connection.close();
	%>
</body>
</html>