<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String id = request.getParameter("txtUserName");
		String password = request.getParameter("txtPassword");
		try {

			//Load Driver
			Class.forName("com.mysql.jdbc.Driver");
			//Define Connection
			String connURL = "jdbc:mysql://188.166.238.151/ead?user=root&password=iloveeadxoxo";
			//Establish connection
			Connection conn = DriverManager.getConnection(connURL);
			//String sqlStr ="select * from login where where userid='"+id+"'and password'"+password+"'";
			String sqlStr = "Select * from user where username=? and userpwd=?";
			
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			pstmt.setString(1, id);
			pstmt.setString(2, password);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				response.sendRedirect("adminIndex.jsp");
			} else {
				response.sendRedirect("login.jsp");
			}
			conn.close(); 
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>