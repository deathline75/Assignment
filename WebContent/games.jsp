<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="head.html"%>

<title>Games | SP Games Store</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container main-content">
		<form>
			<div class="input-group">
  				<input type="text" class="form-control" aria-label="...">
  				<div class="input-group-btn">
    			<!-- Buttons -->
    				<button type="button" class="btn btn-primary">Search</button>
    				<button type="button" class="btn btn-default" data-toggle="collapse" data-target="#searchCollapse" aria-expanded="false" aria-controls="searchCollapse">Advance <span class="caret"></span></button>
	  			</div>
			</div>
			<div class="collapse" id="searchCollapse">
				<div class="well">
					<div class="checkbox">
						<label>
      						<input type="checkbox"> Preowned
    					</label>
					</div>
				</div>
			</div>
		</form>
		<ul class="media-list" id="games-list">
			
		</ul>
	</div>
	<%@ include file="footer.html"%>
	<script>
		$(document).ready(function() {
			
			$.getJSON("api/games", function(data) {
				if (data.responseCode == 0) {
					ayylmao(data);
				} else {
					$('#games-list').html('<h3>No results found.</h3>');
				}
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
								'</p><p class="genres">Genres: </p></div><div class="media-right media-middle"><span class="label label-success">$' + value.price.toFixed(2) + 
								'</span></div></li>');
						$.getJSON("api/gameimages?q-gameid=" + value.id + "&q-imageuse=0", function(data2) {
							if (data2.responseCode == 0) {
								$('#game-' + value.id + ' .media-left').html('<img src="data:' + data2.results[0].mimeType + ';base64,' + data2.results[0].b64imagedata + 
								'" alt="..." width="128" height="50"/>');
							}
						});
						$.getJSON("api/gamegenre?q-gameid=" + value.id, function(data3) {
							console.log(data3);
							if (data3.responseCode == 0) {
								$.each(data3.results, function(index, value2) {
									$('#game-' + value.id + ' .genres').append('<span class="label label-primary"><a href="genres.jsp?id=' + value2.id + '">' + value2.name + '</a></span> ');
								});
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
		});
	</script>
</body>
</html>