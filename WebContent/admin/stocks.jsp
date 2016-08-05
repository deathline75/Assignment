<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.ice.crud.*, java.sql.*,java.util.*, com.ice.util.*, com.ice.api.*" %>
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
<title>Stocks | SP Games Store Admin</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container main-content">
		<h1 class="col-sm-9" style="padding: 0;">Stock Management</h1>
		<div class="col-sm-3" style="margin: 20px 0 10px;">
			<form class="form-inline" role="search">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search">
				</div>
				<button type="submit" class="btn btn-default">Search</button>
			</form>
		</div>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>#</th>
					<th>Game Title</th>
					<th>Price</th>
					<th>Quantity</th>
				</tr>
			</thead>
			<tbody>
				<%
				
					for (Game g: games) {
				%>
				<tr>
					<td><%= g.getId() %></td>
					<td><%= g.getTitle() %></td>
					<td><%= String.format("$%.2f", g.getPrice()) %></td>
					<td uid="<%=g.getId()%>"><%= g.getQuantity() %></td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
	<%@ include file="../footer.html"%>
	
	<script>
	
	function changeTotext(obj) //2
	{ 
	    var tdValue = obj.innerText; 
	    obj.innerText = ""; 
	    var txt = document.createElement("input"); 
	    txt.type = "text"; 
	    txt.value = tdValue; 
	    txt.id = "_text_000000000_"; 
	    txt.setAttribute("className","text"); 
	    obj.appendChild(txt); 
	    txt.select();
	} 
	function cancel(obj,tableid) //4
	{ 
	    var txtValue = document.getElementById("_text_000000000_").value; 
	    obj.innerText = txtValue; 
	    var tableid = tableid;
	        $.ajax({
	        	  type: "POST",
	        	  url: "EditStock",
	        	  data: {"gameid":tableid,
	        			"quantity":txtValue

	        	  },
	        	  success: function(data, textStatus, jqXHR) {
	        	    console.log("Success!!");
	        	  }
	        	}); 
	  

	} 

	document.ondblclick = function()  //1
	{ 
	    if (event.srcElement.tagName.toLowerCase() == "td") 
	    { 
	        changeTotext(event.srcElement); 
	    } 
	     
	} 
	document.onmouseup = function() //3
	{ 
	    if (document.getElementById("_text_000000000_") && event.srcElement.id != "_text_000000000_") 
	    { 
	        var obj = document.getElementById("_text_000000000_").parentElement; 
	        var tableid =document.getElementById("_text_000000000_").parentNode.getAttribute("uid");
	        var tableid2 =document.getElementById("_text_000000000_").parentNode.getAttribute("uid2");
	        cancel(obj,tableid); 
	    }
	} 
</script>
</body>
</html></body>
</html>