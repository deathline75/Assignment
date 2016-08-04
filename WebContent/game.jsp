<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.ice.*, java.sql.*"%>
    <% 
    	// Parameter initialization
    	String gameid = request.getParameter("id");
    	String userPageNum = request.getParameter("userPageNum");
    	
    	// Check if Game ID exists
    	// Otherwise redirect to index page
    	if (gameid == null) {
    		response.sendRedirect(".");
    		return;
    	}

    	// Pagination is a nightmare
    	// This is to check and see which page should render
    	int positionRows = 0;
    	// If there is no current page number, just return the first page.
    	if (userPageNum == null || userPageNum.isEmpty()) {
    		userPageNum = "1";
    		positionRows = (Integer.parseInt(userPageNum) - 1) * 5;
    	} else {
    		positionRows = (Integer.parseInt(userPageNum) - 1) * 5;
    	}
    	
    	
    	int rows = 0;
    	int totalPageNum=0;
    	int result = 0;
    	connectToMysql connection = new connectToMysql(MyConstants.url);
    	ResultSet validGame = connection.preparedQuery("SELECT * FROM game WHERE gameid=?",gameid);
    	
    	if (!validGame.next()) {
    		connection.close();
    		response.sendRedirect(".");
    		return;
    	}
    	
    	validGame.close();
    	connection.preparedUpdate("insert into game_hitcounter(day,gameid,slot,count) value(CURRENT_DATE,?,RAND()*100,1) on duplicate key update count=count+1", gameid);
		ResultSet rs = connection.preparedQuery("SELECT * FROM game_comment WHERE gameid=?",gameid);
	
		try {
			while (rs.next())
				rows++;
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		connection.close();

		if (rows % 5 !=0) {
			totalPageNum = rows / 5 + 1;
		} else {
			totalPageNum = rows / 5;
		}	


%>	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<script type="text/javascript" src="js/rating.js"></script>
<link rel="stylesheet" href="css/rating.css" type="text/css" media="screen" title="Rating CSS">	
    <script type="text/javascript">
        $(function(){
            $('.rate').rating();
        });
        
        function changeQty(amount) {
        	if (isNaN(parseInt($('#qty').val())) || (parseInt($('#qty').val()) <= 0 && amount <= 0) || parseInt($('#qty').val()) < 0)
        		$('#qty').val(0)
        	else
        		$('#qty').val(parseInt($('#qty').val()) + amount);
        }
    </script>
<title> | SP Games Store</title>
</head>
<body>
<%@ include file="navbar.jsp"%>
<div class="container main-content" style="padding: 30px 0">

	<% if (session.getAttribute("error") != null) {%>
	<div class="alert alert-danger" role="alert">
		<strong>Error!</strong> <%= session.getAttribute("error") %>
	</div>
	<% session.removeAttribute("error");} %>
	
	<div class="row">
		<div id="jumbo" class="col-sm-8">
			<img src="http://placehold.it/1920x1080?text=No+Image+Available" alt="..." class="img-responsive"/>
		</div>
		<div class="col-sm-4" id="description">
			<div class="page-header ice-header">
				<h1>ಠ_ಠ</h1>
			</div>
			<div class="row">
				<div class="col-md-3">Company:</div>
				<div class="col-md-9 company">You are not supposed to be here</div>
			</div>
			<div class="row">
				<div class="col-md-3">Release:</div>
				<div class="col-md-9 releasedate"></div>
			</div>
			<div class="row">
				<div class="col-md-3">Description:</div>
				<div class="col-md-9 description"></div>
			</div>
			<div class="row">
				<div class="col-md-3">Genres:</div>
				<div class="col-md-9 genres"></div>
			</div>

		</div>
	</div>
	<div class="row panel panel-default" style="margin: 20px 0">
		<div class="panel-body">
			<h3 id="buy-gamename" style="margin-top: 0; display: inline-block">ಠ_ಠ</h3>
			<div class="btn-toolbar pull-right">
			<%if(user != null){ %>
				<!-- <div class="btn-group platforms" data-toggle="buttons"></div> -->
			     <form action="AddCartItem" method="post" id="AddCartItem" class="btn-group platforms" data-toggle="buttons">
      				<input type="hidden" name="gameid" value="<%=gameid%>">
      				<input type="text" class="form-control" placeholder="Qty" id="qty" name="quantity" value="0" style="display: block">
      			</form>
				
				<div class="input-group" style="width: 150px">
      				<div class="input-group-btn">
        				<button class="btn btn-default" type="button" onclick="changeQty(-1)"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span>&nbsp;</button>
      				</div>
      				<div class="input-group-btn">
        				<button class="btn btn-default" type="button" onclick="changeQty(1)"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;</button>
      				</div>
				</div>
				<div class="btn-group" style="display:block" data-toggle="tooltip" data-placement="right" title="Coming Soon">
				<form action="PurchaseItem" method="post">
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<%-- <input type="hidden" name="userid" value="<%=user.getId()%>"> --%>
  					<button type="submit" class="btn btn-success" id="buy">Buy New</button>
					<button type="submit" class="btn btn-info" form="AddCartItem">Add to Cart</button>
					<button type="button" class="btn btn-default price">$??.??</button>
				
				</form>
				</div>
				<%} else{%>
				<div class="btn-group platforms" data-toggle="buttons"></div>
				<div class="btn-group" style="display:block" data-toggle="tooltip" data-placement="right" title="Click to login!">
					<a href= "login.jsp" class="btn btn-success" role="button" id="buy">Buy New</a>
					<button type="button" class="btn btn-default price">$??.??</button>
				</div>
				<%} %>
			</div>
		</div>
	</div>
	<div class="row" style="margin: 0">
		<h2>Comments</h2>
		<hr />
		<div class="ayylmao">
			<h4 class="text-muted" id="comments">Comments are disabled as this is a preowned game.</h4>
			<form action=AddComment method="post" name="addcomment" onsubmit="return validateForm()" id="addcomment" class="form form-horizontal">
				<div class="form-group">
			    	<label class="col-sm-1 control-label" for="author">Name: </label>
      				<div class="col-sm-5">
      					<input type="text" name="author" class="form-control" placeholder="Name" aria-describedby="basic-addon1" class="form-group" id="author">
      				</div>
      				<label class="col-sm-1 control-label">Rating: </label>
     				<div class="rate col-sm-5 checkbox">
        				<input type="radio" name="rating" class="rating" value="1" />
        				<input type="radio" name="rating" class="rating" value="2" />
        				<input type="radio" name="rating" class="rating" value="3" />
        				<input type="radio" name="rating" class="rating" value="4" />
        				<input type="radio" name="rating" class="rating" value="5" />
      				</div>
      				<input type="hidden" name="gameid" value="<%=gameid %>">
				</div>
      			<div class="form-group">
      				<label class="col-sm-1 control-label" for="comment">Comment: </label>
      				<div class="col-sm-6">
      					<textarea type="text" name="comment" class="form-control" id="comment" placeholder="Comment" aria-describedby="basic-addon1" rows="5"></textarea>
      				</div>
				</div>
				<div class="form-group">
					<div class="g-recaptcha col-sm-offset-1 col-sm-11" data-sitekey="6LctkR4TAAAAAPQYqGQkmeaczaReQwT0qkC-tagZ"></div>
				</div>	
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-1">
						<input type="submit" class="btn btn-default" value="Submit">
					</div>
				</div>
			</form>
		</div>
		<div class="comment">
		</div>
			<ul class="pagination">
    		<% for(int i=1;i<=totalPageNum;i++){ 
    			if (Integer.parseInt(userPageNum)==i){ %>
    			<li class="active"><a href="game.jsp?id=<%=gameid%>&userPageNum=<%=i%>"><%=i%></a></li>	<%
    			} else {%>
    			<li><a href="game.jsp?id=<%=gameid%>&userPageNum=<%=i%>"><%=i%></a></li>	
    			<%} %>
    		<% } %>
    		</ul>
	</div>
</div>
<%@ include file="footer.html" %>
<script>
	$(document).ready(function() {
		// Initialize all tooltips
		$(function () {
			  $('[data-toggle="tooltip"]').tooltip()
			})
		// Get the game id
		var gameid = <%= gameid %>;
		
		// Using jQuery to get JSON data from /api/games
		$.getJSON("api/games?q-gameid=" + gameid, function(data) {
			if (data.responseCode == 0) {
				var gamedata = data.results[0];
				document.title = gamedata.title + " | SP Games Store";
				$('.page-header > h1').text(gamedata.title);
				$('#buy-gamename').text('Buy: ' + gamedata.title);
				$('.company').text(gamedata.company);
				$('.releasedate').text(gamedata.releaseDate);
				$('.description').text(gamedata.description);
				$('.price').text('$' + gamedata.price.toFixed(2));
				if (gamedata.supportWin) {
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformWin" autocomplete="off" value="win"> Windows </label>');
				} if (gamedata.supportMac) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformMac" autocomplete="off" value="mac"> OS X </label>');
				} if (gamedata.supportLinux) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformLinux" autocomplete="off" value="linux"> Linux </label>');
				} if (gamedata.supportXbox) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformXbox" autocomplete="off" value="xbox"> Xbox One </label>');
				} if (gamedata.supportPs4) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformPS4" autocomplete="off" value="ps4"> PS4 </label>');
				} if (gamedata.supportWiiu) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformWiiu" autocomplete="off" value="wiiu"> Wii-U </label>');
				}
				// Change some visuals if the game is preowned
				if (gamedata.preowned) {
					$('#buy').text('Buy Preowned');
					$('#buy').removeClass('btn-success');
					$('#buy').addClass('btn-warning');
					$("#addcomment").css("display","none");
				} else {
					$("#comments").css("display","none");
			    	$('.ayylmao').append("<hr/>");
				}
			}
		});
		
		// Render images using JSON
		$.getJSON("api/gameimages?q-gameid=" + gameid + "&q-imageuse=1", function(data) {
			if (data.responseCode == 0) {
				$('#jumbo').html('<img src="data:' + data.results[0].mimeType + ';base64,' + data.results[0].b64imagedata + 
				'" alt="..." class="img-responsive"/>');
			}
		});
		
		// Render game comments using JSON
	    $.getJSON("api/gamecomments?q-gameid=<%=gameid%>&positionRows=<%=positionRows%>", function(data) {
	    	$.each(data.results, function(index, value) {
	        	var stars= "";
	        	var panelcolor = "panel-default";
	        	for (var i=1; i <= value.rating; i++){
	        		stars = stars + "<span class=\"glyphicon glyphicon-star\" aria-hidden=\"true\"></span>"	
	        	}
	        	if (value.rating > 3)
	        		panelcolor = "panel-success";
	        	else if (value.rating < 3)
	        		panelcolor = "panel-danger";
	        	else
	        		panelcolor = "panel-warning";
	            $('.comment').append("<div class=\"col-sm-1\"><div class=\"thumbnail\"><img class=\"img-responsive user-photo\" src=\"https://ssl.gstatic.com/accounts/ui/avatar_2x.png\"></div></div><div class=\"panel " + panelcolor + "\"><div class=\"panel-heading\">" + "<strong>"+ value.author+"</strong>" +" <span class=\"text-muted\"> commented on " + value.date + "</span>" + "</div>" + "<div class=\"panel-body\"><p>Rating: " + stars + "</p><p>Comment: " + value.comment + "</p></div> </div>");
	        	
	        });
	    });
		
		// Render all the genres with JSON
		$.getJSON("api/gamegenre?q-gameid=" + gameid, function(data) {
			if (data.responseCode == 0) {
				$.each(data.results, function(index, value) {
					$('.genres').append('<span class="label label-primary"><a href="genres.jsp?id=' + value.id + '">' + value.name + '</a></span> ');
				});
			}
		});
	});
	
	// Some form validation for comments
	function validateForm() {
	    var x = document.forms["addcomment"]["author"].value;
	    var y = document.forms["addcomment"]["rating"].value;
	    var z = document.forms["addcomment"]["comment"].value;
	    if (x == null || x == "") {
	        alert("Please input your Author");
	        return false;
	    }
	    else if(y == null || y==""){
	        alert("Please input your Rating");
	        return false;
	    }
	    else if(z == null || z==""){
	        alert("Please input your Comment");
	        return false;
	    }
	}
	
	
</script>



</body>
</html>