<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,com.ice.*" %>
<%
	if (session.getAttribute("username") == null)
		response.sendRedirect("login.jsp");
	connectToMysql connection = new connectToMysql(MyConstants.url);
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
		<%
		if (request.getAttribute("result") != null) {
			int result = (int) request.getAttribute("result");
 			if (result > 0) {
				out.println("<div class=\"alert alert-success\" role=\"alert\"><strong>Success!</strong> The new game has been added.</div>");
			} else if (result > -2) {
				out.println("<div class=\"alert alert-danger\" role=\"alert\"><strong>Oh no!</strong> An erorr occurred while trying to add the new game.</div>");
			} else if (result > -3) {
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Please fill in all the required fields.</div>");
			}
		}
		%>
		<div class="page-header ice-header">
			<h1>Add a Game</h1>
		</div>
		<form class="form-horizontal" method="post" enctype="multipart/form-data" action="AddGame">
			<div class="form-group">
				<label for="gametitle" class="col-sm-2 control-label">Game Title*: </label>
    			<div class="col-sm-4">
      				<input type="text" class="form-control" id="gametitle" placeholder="Game Title" name="gameTitle" />
    			</div>
			</div>
			<div class="form-group">
				<label for="gamecompany" class="col-sm-2 control-label">Company*: </label>
    			<div class="col-sm-4">
      				<input type="text" class="form-control" id="gamecompany" placeholder="Company" name="company" />
    			</div>
			</div>
			<div class="form-group">
				<label for="gamereleasedate" class="col-sm-2 control-label">Release Date*: </label>
    			<div class="col-sm-2">
      				<input type="date" class="form-control" id="gamereleasedate" placeholder="Release Date" name="releaseDate" />
    			</div>
			</div>
			<div class="form-group">
				<label for="sel2" class="col-sm-2 control-label">Genre*: </label>
    			<div class="col-sm-6">
    				<select multiple="multiple" class="form-control" id="sel2" name="genre">
    					<% ResultSet rs = connection.preparedQuery("SELECT genreid,genrename FROM genre");
			    		while (rs.next()) { %>
    					<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
      					<% } connection.close();%>
      				</select>
      				<script>
      					$('#sel2').select2();
      				</script>
    			</div>
			</div>
			<div class="form-group">
				<label for="gamedescription" class="col-sm-2 control-label">Description*: </label>
    			<div class="col-sm-7">
      				<textarea class="form-control" id="gamedescription" placeholder="Description" name="description" rows="4"></textarea>
    			</div>
			</div>
			<div class="form-group">
				<label for="gameprice" class="col-sm-2 control-label">Price*: </label>
    			<div class="col-sm-2 input-group" style="padding: 0 15px;">
    				<span class="input-group-addon">$</span>
      				<input type="number" step="any" class="form-control" id="gameprice" placeholder="59.90" name="price" />
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
  			<hr />
			<div class="form-group">
				<label for="gamethumbnail" class="col-sm-2 control-label">Game Thumbnail: </label>
    			<div class="col-sm-10">
    				<input type="file" style="padding-top: 7px;" id="gamethumbnail" name="gamethumbnail" accept="image/*" aria-describedby="helpBlockThumbnail">
    			</div>
    			<span id="helpBlockThumbnail" class="help-block col-sm-offset-2 col-sm-10">Recommended dimensions: 128 x 64</span>
			</div>
			<div class="form-group">
				<label for="gamejumbo" class="col-sm-2 control-label">Game Jumbotron: </label>
    			<div class="col-sm-10">
    				<input type="file" style="padding-top: 7px;" id="gamejumbo" name="gamejumbo" accept="image/*" aria-describedby="helpBlockJumbo">
    			</div>
    			<span id="helpBlockJumbo" class="help-block col-sm-offset-2 col-sm-10">Recommended dimensions: 1920 x 1080</span>
			</div>
			<div class="form-group">
				<label for="gamepromo" class="col-sm-2 control-label">Game Promotion: </label>
    			<div class="col-sm-10">
    				<input type="file" style="padding-top: 7px;" id="gamepromo" name="gamepromo" accept="image/*" aria-describedby="helpBlockPromo">
    			</div>
    			<span id="helpBlockPromo" class="help-block col-sm-offset-2 col-sm-10">Recommended dimensions: 350 x 350</span>
			</div>
			<hr />
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