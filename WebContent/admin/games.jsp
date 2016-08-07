<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.ice.*, java.sql.*, java.util.*, com.ice.api.*,com.ice.crud.*" %>
<%
	if (session.getAttribute("username") == null)
		response.sendRedirect("login.jsp");

	CRUDGame dbGame = new CRUDGame();
	ArrayList<Game> games = dbGame.getGames();
	dbGame.close();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>Games | SP Games Store Admin</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container main-content">
		<h1 class="col-sm-8" style="padding: 0;">Games Management</h1>
		<div class="col-sm-3" style="margin: 20px 0 10px;">
			<form class="form-inline" role="search">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search" disabled>
				</div>
				<button type="submit" class="btn btn-default" disabled>Search</button>
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
					<th>Quantity</th>
					<th>Edit Data</th>
				</tr>
			</thead>
			<tbody>
				<%
				
					for (Game g: games) {
				%>
				<tr>
					<td><%= g.getId() %></td>
					<td><%= g.getTitle() %></td>
					<td><%= g.getCompany() %></td>
					<td><%= String.format("$%.2f", g.getPrice()) %></td>
					<td><%= g.getQuantity() %></td>
					<td>
						<a href="#" class="btn btn-info btn-xs" data-toggle="modal" data-target="#ice-modal" data-action="View" data-gameid="<%=g.getId()%>">Info</a> 
						<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#ice-modal" data-action="Edit" data-gameid="<%=g.getId()%>">Edit</a>
						<a href="#" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#ice-modal" data-action="Delete" data-gameid="<%=g.getId()%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
		<script>
		// Modal handling. It was before we realised that jQuery has ajax as well. Oh well.
		$(document).ready(function() {
			$('#ice-modal').on('show.bs.modal', function (event) {
    			var button = $(event.relatedTarget);
    			var action = button.data("action");
    			var gameid = button.data("gameid");
    			var modal = $(this);
    			var xhttp = new XMLHttpRequest();
    			xhttp.onreadystatechange = function() {
					if (xhttp.readyState == 4 && xhttp.status == 200) {
    			    	modal.find(".modal-content").html(xhttp.responseText);
    			    }
    			};
    			xhttp.open("GET", "games-modal.jsp?action=" + action + "&gameid=" +gameid, true);
    			modal.find(".modal-content").html('<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button><h4 class="modal-title" id="exampleModalLabel">Loading...</h4></div>');
        		xhttp.send();
    		})
		});
    		
    	</script>
		<div class="modal fade" id="ice-modal" tabindex="-1" role="dialog" aria-labelledby="iceModalLabel">
  			<div class="modal-dialog" role="document">
    			<div class="modal-content">
    			</div>
  			</div>
		</div>
	</div>
	<%@ include file="../footer.html"%>
</body>
</html>