<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="com.ice.*"%>

<%
	int result = -10;
	if (request.getParameter("continue") != null || request.getParameter("redirect") != null) {
		String genreTitle = request.getParameter("genreTitle");
		connectToMysql connection = new connectToMysql(MyConstants.url);
 		result = connection.preparedUpdate("insert into genre(genrename) values(?)", genreTitle);
				
		if (result > 0 && request.getParameter("redirect") != null)
			response.sendRedirect("genres.jsp");
			
		connection.close();
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>Games | SP Games Store Administration</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>

	<div class="container">
		<%
			if (result > 0) {
				out.println("<div class=\"alert alert-success\" role=\"alert\"><strong>Success!</strong> The new genre has been added.</div>");
			} else if (result > -2) {
				out.println("<div class=\"alert alert-danger\" role=\"alert\"><strong>Oh no!</strong> An erorr occurred while trying to add the new genre.</div>");
			}
		%>
		<div class="page-header ice-header">
			<h1>Add a Genre</h1>
		</div>
		<form class="form-horizontal" method="post">
			<div class="form-group">
				<label for="genreTitle" class="col-sm-2 control-label">Genre Title: </label>
    			<div class="col-sm-4">
      				<input type="text" class="form-control" id="genretitle" placeholder="Genre Title" name="genreTitle" />
    			</div>
			</div>
  			<div class="form-group">
    			<div class="col-sm-offset-2 col-sm-1">
      				<button type="submit" class="btn btn-primary" name="redirect">Add Genre</button>
    			</div>
       			<div class="col-sm-9">
      				<button type="submit" class="btn btn-default" name="continue">Keep Adding Genre</button>
    			</div>
  			</div>
		</form>
	</div>


	<%@ include file="../footer.html"%>
</body>
</html>