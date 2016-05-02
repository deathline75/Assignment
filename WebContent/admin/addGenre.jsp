<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="com.ice.*"%>

<%
	int result = -10;
	if (request.getParameter("continue") != null || request.getParameter("redirect") != null) {
		String gameTitle = request.getParameter("gameTitle");
		String company = request.getParameter("company");
		String releaseDate = request.getParameter("releaseDate");
		String description = request.getParameter("description");
		String price = request.getParameter("price");
		String imgLocation = request.getParameter("imgLocation");
		String preOwned = request.getParameter("preOwned");
		connectToMysql connection = new connectToMysql(MyConstants.url);
		//connection.preparedUpdate("insert into game(gametitle) values(?),",gameTitle);
/* 		result = connection.preparedUpdate(
				"insert into game(gametitle,company,releaseDate,description,price,imgLocation,preowned,supportWin,supportMac,supportXBOX,supportLinux,supportPS4,supportWIIU) values(?,?,?,?,?,?,?,?,?,?,?,?,?)",
				gameTitle, company, releaseDate, description, price, imgLocation, preOwned, supportWin, supportMac,
				supportXBOX, supportLinux, supportPS4, supportWIIU); */
				
		if (result > 0 && request.getParameter("redirect") != null)
			response.sendRedirect("games.jsp");
			
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
				out.println("<div class=\"alert alert-success\" role=\"alert\"><strong>Success!</strong> The new game has been added.</div>");
			} else if (result > -2) {
				out.println("<div class=\"alert alert-danger\" role=\"alert\"><strong>Oh no!</strong> An erorr occurred while trying to add the new game.</div>");
			}
		%>
		<div class="page-header ice-header">
			<h1>Add a Game</h1>
		</div>
		<form class="form-horizontal" method="post">
			<div class="form-group">
				<label for="gametitle" class="col-sm-2 control-label">Genre Title: </label>
    			<div class="col-sm-4">
      				<input type="text" class="form-control" id="genretitle" placeholder="Genre Title" name="genreTitle" />
    			</div>
			</div>
			<div class="form-group">
				<label for="gamecompany" class="col-sm-2 control-label">Company: </label>
    			<div class="col-sm-4">
      				<input type="text" class="form-control" id="gamecompany" placeholder="Company" name="company" />
    			</div>
			</div>
			<div class="form-group">
				<label for="gamereleasedate" class="col-sm-2 control-label">Release Date: </label>
    			<div class="col-sm-2">
      				<input type="date" class="form-control" id="gamereleasedate" placeholder="Release Date" name="releaseDate" />
    			</div>
			</div>
			<div class="form-group">
				<label for="gamedescription" class="col-sm-2 control-label">Description: </label>
    			<div class="col-sm-7">
      				<textarea class="form-control" id="gamedescription" placeholder="Description" name="description" rows="4"></textarea>
    			</div>
			</div>
			<div class="form-group">
				<label for="gameprice" class="col-sm-2 control-label">Price: </label>
    			<div class="col-sm-2 input-group" style="padding: 0 15px;">
    				<span class="input-group-addon">$</span>
      				<input type="number" class="form-control" id="gameprice" placeholder="59.90" name="price" />
    			</div>
			</div>
			<div class="form-group">
				<label for="gameimglocation" class="col-sm-2 control-label">Image Location: </label>
    			<div class="col-sm-4">
      				<input type="text" class="form-control" id="gameimglocation" placeholder="/img/games/game.png" name="imgLocation" />
    			</div>
			</div>
			<div class="form-group">
        		<label class="col-sm-2 control-label" for="gamepreownedgame"> Preowned Game:</label>
        		<div class="control-label col-sm-1" style="text-align: left;">
        			<input type="checkbox" name="preOwned" id="gamepreownedgame"> 
    			</div>
  			</div>
			<div class="form-group">
        		<label class="col-sm-2 control-label"> Platforms:</label>
        		<div class="col-sm-10 container-fluid" style="padding: 0;">
        			<div class="control-label col-sm-2" style="text-align: left;">
        				<label>
  							<input type="checkbox" value="windows" name="supportWin"> Windows
						</label>
					</div>
					<div class="control-label col-sm-2" style="text-align: left;">
						<label>
  							<input type="checkbox" value="osx" name="supportMac"> OS X
						</label>
					</div>
					<div class="control-label col-sm-2" style="text-align: left;">
						<label>
  							<input type="checkbox" value="linux" name="supportLinux"> Linux
						</label>
    				</div>
    			</div>
    			<div class="col-sm-offset-2 col-sm-10 container-fluid" style="padding: 0;">
    				<div class="control-label col-sm-2" style="text-align: left;">
    			    	<label>
  							<input type="checkbox" value="xbone" name="supportXBOX"> Xbox One
						</label>
					</div>
					<div class="control-label col-sm-2" style="text-align: left;">
						<label>
	  						<input type="checkbox" value="ps4" name="supportPS4"> Playstation 4
						</label>
					</div>
					<div class="control-label col-sm-2" style="text-align: left;">
						<label>
  							<input type="checkbox" value="wiiu" name="supportWIIU"> Wii-U
						</label>
    				</div>
    			</div>
  			</div>
  			<div class="form-group">
    			<div class="col-sm-offset-2 col-sm-1">
      				<button type="submit" class="btn btn-primary" name="redirect">Add Game</button>
    			</div>
       			<div class="col-sm-9">
      				<button type="submit" class="btn btn-default" name="continue">Keep Adding Games</button>
    			</div>
  			</div>
		</form>
	</div>


	<%@ include file="../footer.html"%>
</body>
</html>