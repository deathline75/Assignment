<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.ice.*"%>
<%@ page import="java.sql.*"%>
<%
	if (session.getAttribute("username") == null)
		response.sendRedirect("login.jsp");
%>

<%
connectToMysql connection = new connectToMysql(MyConstants.url);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="head.html"%>
<title>Genres | SP Games Store Administration</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container">
		<h1 class="col-sm-8" style="padding: 0;">Genres Management</h1>
		<div class="col-sm-3" style="margin: 20px 0 10px;">
			<form class="form-inline" role="search">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search">
				</div>
				<button type="submit" class="btn btn-default">Search</button>
			</form>
		</div>
		<div class="col-sm-1" style="margin: 20px 0 10px;">
			<a href="./addGenre.jsp" role="button" class="btn btn-primary">Add Genre</a>
		</div>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>#</th>
					<th>GenreName</th>
					<th>Edit Data</th>
				</tr>
			</thead>
			<tbody>
				<%
				
					ResultSet rs = connection.preparedQuery("SELECT genreid,genrename FROM genre");
					while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getInt(1)%></td>
					<td class="col-md-6"><%=rs.getString(2)%></td>
					<td class="col-md-2">
						<a href="#" role="button"
						class="btn btn-primary btn-xs">Edit</a> <a href="#" role="button"
						class="btn btn-danger btn-xs">Delete</a>
						</div></td>
				</tr>
				<%
					}
					connection.close();
				%>

			</tbody>
		</table>

	</div>

	<%@ include file="../footer.html"%>
</body>
</html>