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
		<%
			if (request.getAttribute("result") != null) {
				int code = (int) request.getAttribute("result");
				if (code > 0) {
					out.println("<div class=\"alert alert-success\" role=\"alert\"><strong>Success!</strong> The new genre <strong>'" + request.getParameter("genreTitle") + "'</strong> has been added.</div>");
				} else if (code > -2) {
					out.println("<div class=\"alert alert-danger\" role=\"alert\"><strong>Oh no!</strong> An erorr occurred while trying to add the new game.</div>");
				} else if (code > -3) {
					out.println("<div class=\"alert alert-danger\" role=\"alert\">Please fill in the field.</div>");
				} else if (code > -4) {
					out.println("<div class=\"alert alert-danger\" role=\"alert\"><strong>'" + request.getParameter("genreTitle") + "'</strong> is already in the database.</div>");
				}
			}
		%>
		<h1 class="col-sm-6" style="padding: 0;">Genres Management</h1>
		<div class="col-sm-3" style="margin: 20px 0 10px;">
			<form class="form-inline" role="search">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search">
				</div>
				<button type="submit" class="btn btn-default">Search</button>
			</form>
		</div>
		<div class="col-sm-3" style="margin: 20px 0 10px;">
			<form class="form-inline" method="post" action="AddGenre">
				<div class="form-group">
					<input type="text" class="form-control" id="inputAddGenre" placeholder="Genre Name" name="genreTitle">
				</div> 
				<button type="submit" class="btn btn-primary" name="a">Add</button>
			</form>
		</div>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>#</th>
					<th>Genre Name</th>
					<th>Edit</th>
				</tr>
			</thead>
			<tbody>
				<%
				
					ResultSet rs = connection.preparedQuery("SELECT genreid,genrename FROM genre");
					while (rs.next()) {
						int genreid = rs.getInt(1);
				%>
				<tr>
					<td class="col-md-1"><%=rs.getInt(1)%></td>
					<td class="col-md-9"><%=rs.getString(2)%></td>
					<td class="col-md-2">
						 <button type="submit" class="btn btn-primary btn-xs" name="submit" form="deleteGenre<%=genreid%>">Edit</button>
						 <form action="DeleteGenre" style="display: inline" method="post" id="deleteGenre<%=genreid %>">
						 	<input type="hidden" value="<%=genreid%>" name="genreid">
						 	<button type="submit" class="btn btn-danger btn-xs" name="submit" form="deleteGenre<%=genreid%>">Delete</button>
						</form>
					</td>
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