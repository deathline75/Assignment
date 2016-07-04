<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.ice.*, com.ice.api.*, java.sql.*, java.util.*, java.net.*, java.io.*" %>
	<%! connectToMysql connection = new connectToMysql(MyConstants.url); %>
	<%
		// This page predates the API times, therefore everything here is a mess.
		// Tread lightly
		
		// Outdated ArrayList
		Vector<Game> games = new Vector<Game>();
		ResultSet rs = connection.query("SELECT * FROM game");
		// Adding everything into the vector
		while (rs.next()) {
			games.add(new Game(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14)));
		}
		rs.close();
		
		// Mapping the genre's name into it's genre id.
		Map<Integer, String> genres = new HashMap<Integer, String>();
		ResultSet rs1 = connection.query("SELECT * FROM genre");
		// Putting them into the HashMap
		while(rs1.next()) {
			genres.put(rs1.getInt(1), rs1.getString(2));
		}
		rs1.close();
		
		// All the top genres
		Vector<Genre> topgenres = new Vector<Genre>();
		ResultSet rs2 = connection.query("SELECT g.genreid, g.genrename FROM genre g, game_genre gg WHERE g.genreid = gg.genreid GROUP BY gg.genreid ORDER BY count(gg.genreid) DESC LIMIT 8");
		while (rs2.next()) {
			topgenres.add(new Genre(rs2.getInt(1), rs2.getString(2)));
		}
		rs2.close();
		
		// Grab some random games
		Game random = games.get(new Random().nextInt(games.size()));
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
	<div class="container main-content">
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
				
			</div>
		</div>
		<div>
		<div class="page-header">
			<h2>Top Genres</h2>
		</div>
		<% for (Genre g: topgenres) {%>
		<div class="col-sm-3 col-xs-6 ice-genre">
			<a href="genres.jsp?id=<%= g.getId() %>"><%= g.getName() %></a>
		</div>
		<% } %>
		<p class="text-right ice-view-all"><strong><a href="genres.jsp">>>> View all genres</a></strong></p>
		</div>
		<div class="col-sm-8" style="padding:0;">
			<ul class="nav nav-tabs" id="popular-games" role="tablist" style="margin-bottom: 15px">
			    <li role="presentation" class="active"><a href="#all" aria-controls="all" role="tab" data-toggle="tab">All</a></li>
    			<li role="presentation"><a href="#pc" aria-controls="pc" role="tab" data-toggle="tab">PC</a></li>
    			<li role="presentation"><a href="#ps4" aria-controls="ps4" role="tab" data-toggle="tab">PS4</a></li>
    			<li role="presentation"><a href="#xbone" aria-controls="xbone" role="tab" data-toggle="tab">Xbox One</a></li>
    			<li role="presentation"><a href="#wiiu" aria-controls="wiiu" role="tab" data-toggle="tab">Wii U</a></li>
			</ul>
			<div class="tab-content" id="games-list">
				    <div role="tabpanel" class="tab-pane active" id="all">
				    	<ul class="media-list">
				    		<%
				    		// I am so sorry...
				    		// It just iterates through the first 5 games or less in the list
				    		for (int i = 0; i < (games.size() > 5 ? 5 : games.size()); i++) { 
				    			Game game = games.get(i);
				    		%>
				    		<li class="media" id="game-<%= game.getId() %>-all">
				    			<div class="media-left media-middle">
				    			<%
				    			// Encoding the image into base64 and displaying them
				    			// HTML supports Base64 encoded images apparently.
				    			// Eg: <img src="data:image/jpeg;base64,b64data">
				    			ResultSet imageResult = connection.preparedQuery("SELECT * FROM game_image WHERE gameid=? AND imageuse=0", game.getId());
				    			String imgSrc = "http://placehold.it/128x50";
				    			if (imageResult.next()) {
				    				byte[] imageIS = imageResult.getBytes(3);
				    				String mimeType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(imageIS));
				    				if (mimeType.startsWith("image")) {
				    					String b64encoded = new String(Base64.getEncoder().encode(imageIS), "UTF-8");
				    					imgSrc = "data:" + mimeType + ";base64," + b64encoded;
				    				}
				    			}
				    			imageResult.close();
				    			%>
				    				<img src="<%= imgSrc %>" alt="..." width="128" height="50">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p class="hidden-xs"> Platforms: 
										<%
										if (game.isSupportWin())
											out.print("<span class=\"label label-info\">Windows</span> ");
				    					if (game.isSupportMac())
											out.print("<span class=\"label label-info\">OS X</span> ");
				    					if (game.isSupportLinux())
											out.print("<span class=\"label label-info\">Linux</span> ");
										if (game.isSupportXbox())
											out.print("<span class=\"label label-info\">Xbox One</span> ");
										if (game.isSupportPs4())
											out.print("<span class=\"label label-info\">PS4</span> ");
										if (game.isSupportWiiu())
											out.print("<span class=\"label label-info\">Wii-U</span> ");
										%>
									</p>
									<p class="hidden-xs">
										Genres: 
										<%
											ResultSet gameGenres = connection.preparedQuery("SELECT genreid FROM game_genre WHERE gameid=? LIMIT 6", game.getId());
											while (gameGenres.next()) {
										%>
												<span class="label label-primary"><a href="genres.jsp?id=<%= gameGenres.getInt(1) %>"><%= genres.get(gameGenres.getInt(1)) %></a></span>
										<% } gameGenres.close(); %>
									</p>
				    			</div>
				    		</li>
				    		<% } %>
				    	</ul>
				    </div>
    				<div role="tabpanel" class="tab-pane" id="pc">
				    	<ul class="media-list">
				    		<% for (int i = 0, y = (games.size() > 5 ? 5 : games.size()); i < y; i++) { 
				    			Game game = games.get(i);
				    			if (!game.isSupportLinux() && !game.isSupportMac() && !game.isSupportWin()) {
				    				// I actually have no idea what is this.
				    				// It was meant to fix some enumeration problem.
				    				if (games.size() - i > y - i && games.size() > 5)
				    					y++;
				    				continue;
				    			}
				    		%>
				    		<li class="media" id="game-<%= game.getId() %>-pc">
				    			<div class="media-left media-middle">
				    			<%
				    			ResultSet imageResult = connection.preparedQuery("SELECT * FROM game_image WHERE gameid=? AND imageuse=0", game.getId());
				    			String imgSrc = "http://placehold.it/128x50";
				    			if (imageResult.next()) {
				    				byte[] imageIS = imageResult.getBytes(3);
				    				String mimeType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(imageIS));
				    				if (mimeType.startsWith("image")) {
				    					String b64encoded = new String(Base64.getEncoder().encode(imageIS), "UTF-8");
				    					imgSrc = "data:" + mimeType + ";base64," + b64encoded;
				    				}
				    			}
				    			imageResult.close();
				    			%>
				    				<img src="<%= imgSrc %>" alt="..." width="128" height="50">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p class="hidden-xs"> Platforms: 
										<%
										if (game.isSupportWin())
											out.print("<span class=\"label label-info\">Windows</span> ");
				    					if (game.isSupportMac())
											out.print("<span class=\"label label-info\">OS X</span> ");
				    					if (game.isSupportLinux())
											out.print("<span class=\"label label-info\">Linux</span> ");
										if (game.isSupportXbox())
											out.print("<span class=\"label label-info\">Xbox One</span> ");
										if (game.isSupportPs4())
											out.print("<span class=\"label label-info\">PS4</span> ");
										if (game.isSupportWiiu())
											out.print("<span class=\"label label-info\">Wii-U</span> ");
										%>
									</p>
									<p class="hidden-xs">
										Genres: 
										<%
											ResultSet gameGenres = connection.preparedQuery("SELECT genreid FROM game_genre WHERE gameid=? LIMIT 6", game.getId());
											while (gameGenres.next()) {
										%>
												<span class="label label-primary"><a href="genres.jsp?id=<%= gameGenres.getInt(1) %>"><%= genres.get(gameGenres.getInt(1)) %></a></span>
										<% } gameGenres.close();%>
									</p>
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
				    		<li class="media" id="game-<%= game.getId() %>-ps4">
				    			<div class="media-left media-middle">
				    			<%
				    			ResultSet imageResult = connection.preparedQuery("SELECT * FROM game_image WHERE gameid=? AND imageuse=0 LIMIT 6", game.getId());
				    			String imgSrc = "http://placehold.it/128x50";
				    			if (imageResult.next()) {
				    				byte[] imageIS = imageResult.getBytes(3);
				    				String mimeType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(imageIS));
				    				if (mimeType.startsWith("image")) {
				    					String b64encoded = new String(Base64.getEncoder().encode(imageIS), "UTF-8");
				    					imgSrc = "data:" + mimeType + ";base64," + b64encoded;
				    				}
				    			}
				    			imageResult.close();
				    			%>
				    				<img src="<%= imgSrc %>" alt="..." width="128" height="50">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p class="hidden-xs"> Platforms: 
										<%
										if (game.isSupportWin())
											out.print("<span class=\"label label-info\">Windows</span> ");
				    					if (game.isSupportMac())
											out.print("<span class=\"label label-info\">OS X</span> ");
				    					if (game.isSupportLinux())
											out.print("<span class=\"label label-info\">Linux</span> ");
										if (game.isSupportXbox())
											out.print("<span class=\"label label-info\">Xbox One</span> ");
										if (game.isSupportPs4())
											out.print("<span class=\"label label-info\">PS4</span> ");
										if (game.isSupportWiiu())
											out.print("<span class=\"label label-info\">Wii-U</span> ");
										%>
									</p>
									<p class="hidden-xs">
										Genres: 
										<%
											ResultSet gameGenres = connection.preparedQuery("SELECT genreid FROM game_genre WHERE gameid=? LIMIT 6", game.getId());
											while (gameGenres.next()) {
										%>
												<span class="label label-primary"><a href="genres.jsp?id=<%= gameGenres.getInt(1) %>"><%= genres.get(gameGenres.getInt(1)) %></a></span>
										<% } gameGenres.close();%>
									</p>
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
				    		<li class="media" id="game-<%= game.getId() %>-xbone">
				    			<div class="media-left media-middle">
				    			<%
				    			ResultSet imageResult = connection.preparedQuery("SELECT * FROM game_image WHERE gameid=? AND imageuse=0", game.getId());
				    			String imgSrc = "http://placehold.it/128x50";
				    			if (imageResult.next()) {
				    				byte[] imageIS = imageResult.getBytes(3);
				    				String mimeType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(imageIS));
				    				if (mimeType.startsWith("image")) {
				    					String b64encoded = new String(Base64.getEncoder().encode(imageIS), "UTF-8");
				    					imgSrc = "data:" + mimeType + ";base64," + b64encoded;
				    				}
				    			}
				    			imageResult.close();
				    			%>
				    				<img src="<%= imgSrc %>" alt="..." width="128" height="50">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p class="hidden-xs"> Platforms: 
										<%
										if (game.isSupportWin())
											out.print("<span class=\"label label-info\">Windows</span> ");
				    					if (game.isSupportMac())
											out.print("<span class=\"label label-info\">OS X</span> ");
				    					if (game.isSupportLinux())
											out.print("<span class=\"label label-info\">Linux</span> ");
										if (game.isSupportXbox())
											out.print("<span class=\"label label-info\">Xbox One</span> ");
										if (game.isSupportPs4())
											out.print("<span class=\"label label-info\">PS4</span> ");
										if (game.isSupportWiiu())
											out.print("<span class=\"label label-info\">Wii-U</span> ");
										%>
									</p>
									<p class="hidden-xs">
										Genres: 
										<%
											ResultSet gameGenres = connection.preparedQuery("SELECT genreid FROM game_genre WHERE gameid=? LIMIT 6", game.getId());
											while (gameGenres.next()) {
										%>
												<span class="label label-primary"><a href="genres.jsp?id=<%= gameGenres.getInt(1) %>"><%= genres.get(gameGenres.getInt(1)) %></a></span>
										<% } gameGenres.close();%>
									</p>
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
				    		<li class="media" id="game-<%= game.getId() %>-wiiu">
				    			<div class="media-left media-middle">
				    			<%
				    			ResultSet imageResult = connection.preparedQuery("SELECT * FROM game_image WHERE gameid=? AND imageuse=0", game.getId());
				    			String imgSrc = "http://placehold.it/128x50";
				    			if (imageResult.next()) {
				    				byte[] imageIS = imageResult.getBytes(3);
				    				String mimeType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(imageIS));
				    				if (mimeType.startsWith("image")) {
				    					String b64encoded = new String(Base64.getEncoder().encode(imageIS), "UTF-8");
				    					imgSrc = "data:" + mimeType + ";base64," + b64encoded;
				    				}
				    			}
				    			imageResult.close();
				    			%>
				    				<img src="<%= imgSrc %>" alt="..." width="128" height="50">
				    			</div>
				    			<div class="media-body">
				    				<h4 class="media-heading"><%= game.getTitle() %></h4>
				    				<p class="hidden-xs"> Platforms: 
										<%
										if (game.isSupportWin())
											out.print("<span class=\"label label-info\">Windows</span> ");
				    					if (game.isSupportMac())
											out.print("<span class=\"label label-info\">OS X</span> ");
				    					if (game.isSupportLinux())
											out.print("<span class=\"label label-info\">Linux</span> ");
										if (game.isSupportXbox())
											out.print("<span class=\"label label-info\">Xbox One</span> ");
										if (game.isSupportPs4())
											out.print("<span class=\"label label-info\">PS4</span> ");
										if (game.isSupportWiiu())
											out.print("<span class=\"label label-info\">Wii-U</span> ");
										%>
									</p>
									<p class="hidden-xs">
										Genres: 
										<%
											ResultSet gameGenres = connection.preparedQuery("SELECT genreid FROM game_genre WHERE gameid=? LIMIT 6", game.getId());
											while (gameGenres.next()) {
										%>
												<span class="label label-primary"><a href="genres.jsp?id=<%= gameGenres.getInt(1) %>"><%= genres.get(gameGenres.getInt(1)) %></a></span>
										<% } gameGenres.close();%>
									</p>
				    			</div>
				    		</li>
				    		<%	} %>
				    	</ul>
				    </div>
			</div>
		</div>
		<div class="col-sm-4" style="padding-right:0;">
			<div class="thumbnail">
			<% 
			ResultSet imageResult = connection.preparedQuery("SELECT * FROM game_image WHERE gameid=? AND imageuse=2", random.getId());
			String imgSrc = "http://placehold.it/350x350";
			if (imageResult.next()) {
				byte[] imageIS = imageResult.getBytes(3);
				String mimeType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(imageIS));
				if (mimeType.startsWith("image")) {
					String b64encoded = new String(Base64.getEncoder().encode(imageIS), "UTF-8");
					imgSrc = "data:" + mimeType + ";base64," + b64encoded;
				}
			}
			imageResult.close();
			%>
				<img src="<%= imgSrc %>" alt="..." width="350" height="350">
				<div class="caption">
					<h3><%= random.getTitle() %></h3>
					<p><%= random.getDescription() %></p>
					<a href="game.jsp?id=<%= random.getId() %>" class="btn btn-primary active" role="button">More Info <span class="glyphicon glyphicon-circle-arrow-right" aria-hidden="true"></span></a>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
	<script id="jumbo-temp" type="text/x-handlebars-template">
		<div class="item" id="carousel-item-{{i}}">
			<a href="game.jsp?id={{id}}"><img src="{{b64imagedata}}" alt="{{title}}" width="1920" height="1080"></a>
			<div class="carousel-caption ice-carousel-caption">
				<h3><a href="game.jsp?id={{id}}">{{title}}</a></h3>
				<p>{{company}}</p>
			</div>
		</div>
	</script>
	<script>
		$(document).ready(function() {
			$('#games-list li').click(function (e) {
				window.location.href = "game.jsp?id=" + $(this).attr('id').split('-')[1];
			});
			
			$.getJSON("api/games", function(data) {
				if (data.responseCode == 0) {
					for (var i = 0; i < 3; i++) {
						var random = Math.floor(Math.random() * data.results.length);
						var game = data.results[random];
						var b64imagedata = "http://placehold.it/1920x1080?text=No+Image+Available";
						var id = game.id;
						var title = game.title;
						var company = game.company;
						
						var template = $('#jumbo-temp').html();
						var compiledtemplate = Handlebars.compile(template);
						var rendered = compiledtemplate({id: id, title: title, company: company, b64imagedata: b64imagedata, i: i});
						$('.carousel-inner').append(rendered);
						loadimage(id, 1, '#carousel-item-' + i + ' > a > img');
					}
					$('.carousel-inner .item:first-child').addClass('active');
				} else {
				}
			});
		});
		
		function loadimage(gameid, imageuse, imageloc) {
			$.getJSON("api/gameimages?q-gameid=" + gameid + "&q-imageuse=" + imageuse, function(data2) {
				if (data2.responseCode == 0) {
					$(imageloc).attr("src", "data:" + data2.results[0].mimeType + ';base64,' + data2.results[0].b64imagedata);
				}

			});
		}
	</script>
</body>
</html>