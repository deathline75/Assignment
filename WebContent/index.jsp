<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.ice.*, com.ice.api.*, java.sql.*, java.util.*, java.net.*, java.io.*" %>
	<%! connectToMysql connection = new connectToMysql(MyConstants.url); %>
	<%
		// This page predates the API times, therefore everything here is a mess.
		// Tread lightly
		// All the top genres
		Vector<Genre> topgenres = new Vector<Genre>();
		ResultSet rs2 = connection.query("SELECT g.genreid, g.genrename FROM genre g, game_genre gg WHERE g.genreid = gg.genreid GROUP BY gg.genreid ORDER BY count(gg.genreid) DESC LIMIT 8");
		while (rs2.next()) {
			topgenres.add(new Genre(rs2.getInt(1), rs2.getString(2)));
		}
		rs2.close();
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
				    	</ul>
				    </div>
    				<div role="tabpanel" class="tab-pane" id="pc">
				    	<ul class="media-list">
				    	</ul>
				    </div>
    				<div role="tabpanel" class="tab-pane" id="ps4">
				    	<ul class="media-list">
				    	</ul>
    				</div>
    				<div role="tabpanel" class="tab-pane" id="xbone">
				    	<ul class="media-list">
				    	</ul>
				    </div>
    				<div role="tabpanel" class="tab-pane" id="wiiu">
				    	<ul class="media-list">
				    	</ul>
				    </div>
			</div>
		</div>
		<div class="col-sm-4" style="padding-right:0;">
			<div class="thumbnail">
				
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
	<script id="thumb-temp" type="text/x-handlebars-template">
		<img src="{{b64imagedata}}" alt="{{title}}" width="350" height="350">
		<div class="caption">
			<h3>{{title}}</h3>
			<p>{{description}}</p>
			<a href="game.jsp?id={{id}}" class="btn btn-primary active" role="button">More Info <span class="glyphicon glyphicon-circle-arrow-right" aria-hidden="true"></span></a>
		</div>
	</script>
	<script id="jumbo-temp" type="text/x-handlebars-template">
		<div class="item" id="carousel-item-{{i}}">
			<a href="game.jsp?id={{id}}"><img src="{{b64imagedata}}" alt="{{title}}" width="1920" height="1080"></a>
			<div class="carousel-caption ice-carousel-caption">
				<h3><a href="game.jsp?id={{id}}">{{title}}</a></h3>
				<p>{{company}}</p>
			</div>
		</div>
	</script>
	<script id="media-list-temp" type="text/x-handlebars-template">
		<li class="media" id="game-{{id}}-{{platform}}">
			<div class="media-left media-middle">
				<img src="http://placehold.it/128x50" alt="..." width="128" height="50">
			</div>
			<div class="media-body">
				<h4 class="media-heading">{{title}}</h4>
				<p class="hidden-xs"> Platforms:
					{{#if win}}<span class="label label-info">Windows</span>{{/if}}
					{{#if mac}}<span class="label label-info">OS X</span>{{/if}}
					{{#if linux}}<span class="label label-info">Linux</span>{{/if}}
					{{#if xbox}}<span class="label label-info">Xbox One</span>{{/if}}
					{{#if ps4}}<span class="label label-info">PS4</span>{{/if}}
					{{#if wiiu}}<span class="label label-info">Wii-U</span>{{/if}}
				</p>
				<p class="hidden-xs genres">
					Genres: 
				</p>
			</div>
		</li>
	</script>
	<script>
		$(document).ready(function() {
			
			$.getJSON("api/games", function(data) {
				if (data.responseCode == 0) {
					
					var random = Math.floor(Math.random() * data.results.length);
					var rnggame = data.results[random];
					var thumbnailtemplate = $('#thumb-temp').html();
					var compiledthumbnailtemplate = Handlebars.compile(thumbnailtemplate);
					var renderedthumbnail = compiledthumbnailtemplate({id: rnggame.id, title: rnggame.title,	description: rnggame.description, b64imagedata: "http://placehold.it/350x350"});
					$('.thumbnail').append(renderedthumbnail);
					loadimage(rnggame.id, 2, ".thumbnail > img");
					
					
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
					
					for (var j = 0; j < 5; j++) {
						processMediaElement(data.results[j], "all");
					}
					
				} else {
				}
			});
			
			$.getJSON("api/games?q-support-win=1&q-support-mac=1&q-support-linux=1&limit=5", function(data) {
				for (var i = 0; i < data.results.length; i++) {
					processMediaElement(data.results[i], "pc");
				}
			});
			$.getJSON("api/games?q-support-xbox=1&limit=5", function(data) {
				for (var i = 0; i < data.results.length; i++) {
					processMediaElement(data.results[i], "xbone");
				}
			});
			$.getJSON("api/games?q-support-ps4=1&limit=5", function(data) {
				for (var i = 0; i < data.results.length; i++) {
					processMediaElement(data.results[i], "ps4");
				}
			});
			$.getJSON("api/games?q-support-wiiu=1&limit=5", function(data) {
				for (var i = 0; i < data.results.length; i++) {
					processMediaElement(data.results[i], "wiiu");
				}
			});
			
			setTimeout(function() {
				$('#games-list li').click(function (e) {
					window.location.href = "game.jsp?id=" + $(this).attr('id').split('-')[1];
				});
				
			}, 2000);
			
		});
		
		function processMediaElement(game, platform) {
			var template = $('#media-list-temp').html();
			var compiledtemplate = Handlebars.compile(template);
			var rendered = compiledtemplate({platform: platform, id: game.id, title: game.title, win: game.supportWin, mac: game.supportMac, linux: game.supportLinux, xbox: game.supportXbox, ps4: game.supportPs4, wiiu: game.supportWiiu});
			$('#' + platform + ' > .media-list').append(rendered);
			getgenres(game.id, "#game-" + game.id + "-" + platform + " > .media-body > .genres")
			loadimage(game.id, 0, "#game-" + game.id + "-" + platform + " > .media-left > img");
		}
		
		function loadimage(gameid, imageuse, imageloc) {
			$.getJSON("api/gameimages?q-gameid=" + gameid + "&q-imageuse=" + imageuse, function(data2) {
				if (data2.responseCode == 0) {
					$(imageloc).attr("src", "data:" + data2.results[0].mimeType + ';base64,' + data2.results[0].b64imagedata);
				}

			});
		}
		
		function getgenres(gameid, genreloc) {
			$.getJSON("api/gamegenre?q-gameid=" + gameid, function(data3) {
				if (data3.responseCode == 0) {
					var j = data3.results.length < 6 ? data3.results.length : 6;
					for (var i = 0; i < j; i++)
						$(genreloc).append('<span class="label label-primary"><a href="genres.jsp?id=' + data3.results[i].id + '">' + data3.results[i].name + '</a></span> ');
				}
			});
		}
	</script>
</body>
</html>