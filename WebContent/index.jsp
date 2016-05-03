<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="com.ice.*" %>
	<%@ page import="com.ice.api.*" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="java.util.*" %>
	<%! connectToMysql connection = new connectToMysql(MyConstants.url); %>
	<%
		Vector<Game> games = new Vector<Game>();
		ResultSet rs = connection.query("SELECT * FROM game");
		while (rs.next()) {
			games.add(new Game(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14)));
		}
		connection.close();
	%>
	
<!-- TODO: REMOVE ALL STYLE TAGS AND MIGRATE THEM TO CSS FILES. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>

<title>Welcome to SP Games Store</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container">
		<div class="page-header ice-header">
			<h1>
				Welcome to SP Games Store! <small>We sell games I guess...</small>
			</h1>
		</div>
		<div id="ice-carousel-index" class="carousel slide"
			data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators ice-carousel-indicators">
				<li data-target="#ice-carousel-index" data-slide-to="0"
					class="active"></li>
				<li data-target="#ice-carousel-index" data-slide-to="1"></li>
				<li data-target="#ice-carousel-index" data-slide-to="2"></li>
			</ol>
			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img src="img/609173.jpg" alt="Dark Souls 3">
					<div class="carousel-caption ice-carousel-caption">
						<h3>Dark Souls 3</h3>
						<p>Out now</p>
					</div>
				</div>
				<div class="item">
					<img src="img/ogimage.img.jpg" alt="Mirror's Edge Catalyst">
					<div class="carousel-caption ice-carousel-caption">
						<h3>Mirror's Edge Catalyst</h3>
						<p>Coming Soon</p>
					</div>
				</div>
				<div class="item">
					<img src="img/maxresdefault.jpg" alt="Cities Skylines">
					<div class="carousel-caption ice-carousel-caption">
						<h3>Cities Skylines</h3>
						<p>New expansion coming soon</p>
					</div>
				</div>
			</div>
		</div>
		<div>
		<div class="page-header">
			<h2>Top Genres</h2>
		</div>
		<div class="col-sm-3 col-xs-6 ice-genre">
			Horror
		</div>
		<div class="col-sm-3 col-xs-6 ice-genre">
			Adventure
		</div>
		<div class="col-sm-3 col-xs-6 ice-genre">
			Survival
		</div>
		<div class="col-sm-3 col-xs-6 ice-genre">
			First-Person Shooter
		</div>
		<div class="col-sm-3 col-xs-6 ice-genre">
			Casual
		</div>
		<div class="col-sm-3 col-xs-6 ice-genre">
			Massively Multiplayer
		</div>
		<div class="col-sm-3 col-xs-6 ice-genre">
			Simulation
		</div>
		<div class="col-sm-3 col-xs-6 ice-genre">
			Role-Playing Games
		</div>
		<p class="text-right ice-view-all"><strong><a href="#">>>> View all genres</a></strong></p>
		</div>
		<div class="col-sm-8" style="padding:0;">
			<ul class="nav nav-tabs" id="popular-games" role="tablist" style="margin-bottom: 15px">
			    <li role="presentation" class="active"><a href="#all" aria-controls="all" role="tab" data-toggle="tab">All</a></li>
    			<li role="presentation"><a href="#pc" aria-controls="pc" role="tab" data-toggle="tab">PC</a></li>
    			<li role="presentation"><a href="#ps4" aria-controls="ps4" role="tab" data-toggle="tab">PS4</a></li>
    			<li role="presentation"><a href="#xbone" aria-controls="xbone" role="tab" data-toggle="tab">Xbox One</a></li>
    			<li role="presentation"><a href="#wiiu" aria-controls="wiiu" role="tab" data-toggle="tab">Wii U</a></li>
			</ul>
			<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="all">
				    	<ul class="media-list">
				    		<% for (int i = 0; i < (games.size() > 5 ? 5 : games.size()); i++) { 
				    			Game game = games.get(i);
				    		%>
				    		<li class="media">
				    			<div class="media-left">
				    				<img src="http://placehold.it/128x64" alt="...">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p><%= game.getDescription().substring(0, (game.getDescription().length() > 200 ? 200 : game.getDescription().length())) %></p>
				    			</div>
				    		</li>
				    		<%	} %>
				    	</ul>
				    </div>
    				<div role="tabpanel" class="tab-pane" id="pc">
				    	<ul class="media-list">
				    		<% for (int i = 0, y = (games.size() > 5 ? 5 : games.size()); i < y; i++) { 
				    			Game game = games.get(i);
				    			if (!game.isSupportLinux() && !game.isSupportMac() && !game.isSupportWin()) {
				    				if (games.size() - i > y - i && games.size() > 5)
				    					y++;
				    				continue;
				    			}
				    		%>
				    		<li class="media">
				    			<div class="media-left">
				    				<img src="http://placehold.it/128x64" alt="...">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p><%= game.getDescription().substring(0, (game.getDescription().length() > 200 ? 200 : game.getDescription().length())) %></p>
				    			</div>
				    		</li>
				    		<%	} %>
				    	</ul>
				    </div>
    				<div role="tabpanel" class="tab-pane" id="ps4">
				    	<ul class="media-list">
				    		<% for (int i = 0, y = (games.size() > 5 ? 5 : games.size()); i < y; i++) { 
				    			Game game = games.get(i);
				    			if (!game.isSupportPs4()) {
				    				if (games.size() - i > y - i && games.size() > 5)
				    					y++;
				    				continue;
				    			}
				    		%>
				    		<li class="media">
				    			<div class="media-left">
				    				<img src="http://placehold.it/128x64" alt="...">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p><%= game.getDescription().substring(0, (game.getDescription().length() > 200 ? 200 : game.getDescription().length())) %></p>
				    			</div>
				    		</li>
				    		<%	} %>
				    	</ul>
    				</div>
    				<div role="tabpanel" class="tab-pane" id="xbone">
				    	<ul class="media-list">
				    		<% for (int i = 0, y = (games.size() > 5 ? 5 : games.size()); i < y; i++) { 
				    			Game game = games.get(i);
				    			if (!game.isSupportXbox()) {
				    				if (games.size() - i > y - i && games.size() > 5)
				    					y++;
				    				continue;
				    			}
				    		%>
				    		<li class="media">
				    			<div class="media-left">
				    				<img src="http://placehold.it/128x64" alt="...">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p><%= game.getDescription().substring(0, (game.getDescription().length() > 200 ? 200 : game.getDescription().length())) %></p>
				    			</div>
				    		</li>
				    		<%	} %>
				    	</ul>
				    </div>
    				<div role="tabpanel" class="tab-pane" id="wiiu">
				    	<ul class="media-list">
				    		<% for (int i = 0, y = (games.size() > 5 ? 5 : games.size()); i < y; i++) { 
				    			Game game = games.get(i);
				    			if (!game.isSupportWiiu()) {
				    				if (games.size() - i > y - i && games.size() > 5)
				    					y++;
				    				continue;
				    			}
				    		%>
				    		<li class="media">
				    			<div class="media-left">
				    				<img src="http://placehold.it/128x64" alt="...">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p><%= game.getDescription().substring(0, (game.getDescription().length() > 200 ? 200 : game.getDescription().length())) %></p>
				    			</div>
				    		</li>
				    		<%	} %>
				    	</ul>
				    </div>
			</div>
		</div>
		<div class="col-sm-4" style="padding-right:0;">
			<div class="thumbnail">
				<img src="http://placehold.it/350x350" alt="...">
				<div class="caption">
					<h3>Game Title</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ullamcorper ligula vel velit fringilla ornare. Morbi interdum velit enim, eget maximus neque lobortis quis. Duis.</p>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
	
</body>
</html>