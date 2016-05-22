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
<title>Genres | SP Games Store Admin</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container main-content">
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
					<input type="text" class="form-control" placeholder="Search" disabled>
				</div>
				<button type="submit" class="btn btn-default" disabled>Search</button>
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
					ResultSet rs = connection.preparedQuery("SELECT * FROM genre");
					while (rs.next()) {
						int genreid = rs.getInt(1);
				%>
				<tr>
					<td class="col-md-1"><%=rs.getInt(1)%></td>
					<td class="col-md-9" data-toggle="tooltip" title="Double click to Edit" data-placement="left" data-delay='{"show":"500"' data-container="body" class="genreEdit" uid="<%=rs.getInt(1)%>"><%=rs.getString(2)%></td>
					<td class="col-md-2">
						<a href="#" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#ice-modal" data-action="Delete" data-genreid="<%=rs.getInt(1)%>">Delete</a>
					</td>
				</tr>
				<% } connection.close(); %>
			</tbody>
		</table>
	</div>
	<div class="modal fade" id="ice-modal" tabindex="-1" role="dialog" aria-labelledby="iceModalLabel">
  		<div class="modal-dialog" role="document">
    		<div class="modal-content">
    		</div>
  		</div>
	</div>
<script>
		$(document).ready(function() {
			$('#ice-modal').on('show.bs.modal', function (event) {
    			var button = $(event.relatedTarget);
    			var action = button.data("action");
    			var genreid = button.data("genreid");
    			var modal = $(this);
    			var xhttp = new XMLHttpRequest();
    			xhttp.onreadystatechange = function() {
					if (xhttp.readyState == 4 && xhttp.status == 200) {
    			    	modal.find(".modal-content").html(xhttp.responseText);
    			    }
    			};
    			xhttp.open("GET", "genres-modal.jsp?action=" + action + "&genreid=" +genreid, true);
    			modal.find(".modal-content").html('<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button><h4 class="modal-title" id="exampleModalLabel">Loading...</h4></div>');
        		xhttp.send();
    		});

			$(document).ready(function(){
			    $('[data-toggle="tooltip"]').tooltip(); 
			});
		});
		
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
		        	  url: "EditGenre",
		        	  data: {"genreid":tableid,
		        			"genrename":txtValue 
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
		        cancel(obj,tableid); 
		    }
		} 
    		
</script>
	<%@ include file="../footer.html"%>
</body>
</html>