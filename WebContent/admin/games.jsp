<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.ice.*"%>
<%@ page import="java.sql.*"%>
<%
	if (session.getAttribute("username") == null)
		response.sendRedirect("login.jsp");

	connectToMysql connection = new connectToMysql(MyConstants.url);
	String gameid = request.getParameter("gameid");
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
		<h1 class="col-sm-8" style="padding: 0;">Games Management</h1>
		<div class="col-sm-3" style="margin: 20px 0 10px;">
			<form class="form-inline" role="search">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search">
				</div>
				<button type="submit" class="btn btn-default">Search</button>
			</form>
		</div>
		<div class="col-sm-1" style="margin: 20px 0 10px;">
			<a href="./addGame.jsp" role="button" class="btn btn-primary">Add Game</a>
		</div>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>#</th>
					<th>Game Title</th>
					<th>Company</th>
					<th>Price</th>
					<th>Edit Data</th>
				</tr>
			</thead>
			<tbody>
				<%
					ResultSet rs = connection.preparedQuery("SELECT gameid,gametitle,company,price FROM game");
					while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getInt(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getDouble(4)%></td>
					<td>
						<a href="#" class="btn btn-info btn-xs" data-toggle="modal" data-target="#ice-modal" data-action="info" data-gameid="<%=rs.getInt(1)%>">Info</a> 
						<a href="#" role="button" class="btn btn-primary btn-xs">Edit</a>
						<a href="#" role="button" class="btn btn-danger btn-xs">Delete</a>
					</td>
				</tr>
				<% } connection.close(); %>
			</tbody>
		</table>
		<%
		ResultSet rs1 = connection.preparedQuery("SELECT gameTitle,description FROM game where gameid=?", gameid);
		if (rs1.next()) {
			String gameTitle = rs1.getString("gameTitle");
			System.out.print(gameTitle);
			System.out.println(gameid);
		}
		%>
		<div class="modal fade" id="ice-modal" tabindex="-1" role="dialog" aria-labelledby="iceModalLabel">
  			<div class="modal-dialog" role="document">
    			<div class="modal-content">
      				<div class="modal-header">
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        				<h4 class="modal-title" id="exampleModalLabel">View Data</h4>
      				</div>
<!--       				<div class="modal-body">
        				<form>
          					<div class="form-group">
            					<label for="recipient-name" class="control-label">Recipient:</label>
            					<input type="text" class="form-control" id="recipient-name">
          					</div>
          					<div class="form-group">
            					<label for="message-text" class="control-label">Message:</label>
            					<textarea class="form-control" id="message-text"></textarea>
          					</div>
        				</form>
      				</div>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        				<button type="button" class="btn btn-primary">Send message</button>
      				</div> -->
    			</div>
  			</div>
		</div>
	</div>
	<%@ include file="../footer.html"%>
</body>
</html>