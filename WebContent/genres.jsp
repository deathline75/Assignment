<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% String genreids = request.getParameter("id"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="head.html"%>

<title>Genres | SP Games Store</title>
</head>
<body>
<%@ include file="navbar.jsp"%>
<div class="container">
	<div class="col-md-10 main-content" id="genrecontent">
		<div class="page-header ice-header">
			<h1>Browse by Genre</h1>
		</div>
		<ul class="media-list" id="games-list">
			
		</ul>
	</div>
	<div class="col-md-2 hidden-xs hidden-sm">
		<ul id="genrenav" class="nav nav-stacked affix">
			<li><h4>Genres</h4></li>
		</ul>
	</div>
</div>
<%@ include file="footer.html"%>
<script>
	$(document).ready(function() {
		$('#games-list').html('<h3>Loading...</h3>');
		$.getJSON("api/genres", function(data) {
			if (data.responseCode == 0) {
				var checkedGenres = "<%= genreids %>";
				if (checkedGenres != "null") {
					checkedGenres = checkedGenres.split(',').map(Number);
					$.getJSON("api/gamegenre?q-genre=" + checkedGenres.join(','), function(data) {
						if (data.responseCode == 0) {
							ayylmao(data);
						} else {
							$('#games-list').html('<h3>No results found.</h3>');
						}
					});
				} else {
					$.getJSON("api/games", function(data) {
						if (data.responseCode == 0) {
							ayylmao(data);
						}
					});
				}
				$.each(data.results, function(index, value) {
					if (Array.isArray(checkedGenres) && $.inArray(value.id, checkedGenres) > -1)
						$('#genrenav').append("<li><label><input class=\"genre-checkbox\" type=\"checkbox\" value=\"" + value.id + "\" checked> " + value.name + "</label></li>");
					else
						$('#genrenav').append("<li><label><input class=\"genre-checkbox\" type=\"checkbox\" value=\"" + value.id + "\"> " + value.name + "</label></li>");
				});
				$(':checkbox').change(function() {
					var checkedVals = $('.genre-checkbox:checkbox:checked').map(function() {
					    return this.value;
					}).get();
					if (checkedVals.length > 0) {
						history.pushState("", document.title, "genres.jsp?id=" + checkedVals.join(','));
						$('#games-list').html('<h3>Loading...</h3>');
						$.getJSON("api/gamegenre?q-genre=" + checkedVals.join(','), function(data) {
							if (data.responseCode == 0) {
								ayylmao(data);
							} else {
								$('#games-list').html('<h3>No results found.</h3>');
							}
						});
					} else {
						history.pushState("", document.title, "genres.jsp");
						$('#games-list').html('<h3>Loading...</h3>');
						$.getJSON("api/games", function(data) {
							if (data.responseCode == 0) {
								ayylmao(data);
							} else {
								$('#games-list').html('<h3>No results found.</h3>');
							}
						});
					}
				});
			}
		});

	});
	
	function platformSupport(value) {
		var retv = "";
		if (value.supportWin) {
			retv += "<span class=\"label label-info\">Windows</span> ";
		} if (value.supportMac) { 
			retv += "<span class=\"label label-info\">OS X</span> ";
		} if (value.supportLinux) { 
			retv += "<span class=\"label label-info\">Linux</span> ";
		} if (value.supportXbox) { 
			retv += "<span class=\"label label-info\">Xbox One</span> ";
		} if (value.supportPs4) { 
			retv += "<span class=\"label label-info\">PS4</span> ";
		} if (value.supportWiiu) { 
			retv += "<span class=\"label label-info\">Wii-U</span>";
		}
		return retv;
	}
	
	function ayylmao (data) {
		$('#games-list').html('');
		if (data.results.length > 0) {
			$.each(data.results, function(index, value) {
				$('#games-list').append('<li class="media" id="game-' + value.id + 
						'"><div class="media-left"><img src="http://placehold.it/128x50" alt="..." width="128" height="50"></div><div class="media-body media-middle"><h4 class="media-heading">' + value.title + 
						'</h4><p>Platforms: ' + platformSupport(value) + 
						'</p></div><div class="media-right media-middle"><span class="label label-success">$' + value.price.toFixed(2) + 
						'</span></div></li>');
				$.getJSON("api/gameimages?q-gameid=" + value.id + "&q-imageuse=0", function(data2) {
					if (data2.responseCode == 0) {
						$('#game-' + value.id + ' .media-left').html('<img src="data:' + data2.results[0].mimeType + ';base64,' + data2.results[0].b64imagedata + 
						'" alt="..." width="128" height="50"/>');
					}
				});
			});
		} else {
			$('#games-list').html('<h4>No results found.</h4>');
		}
		$('#games-list li').click(function (e) {
			window.location.href = "game.jsp?id=" + $(this).attr('id').split('-')[1];
		});
	}
</script>
</body>
</html>