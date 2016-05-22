<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
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
		<form class="form form-horizontal" method="get">
			<div class="input-group">
  				<input type="text" id="big-search" class="form-control search-bar" aria-label="..." placeholder="Search" name="q">
  				<div class="input-group-btn">
    			<!-- Buttons -->
    				<button type="submit" class="btn btn-primary">Search</button>
    				<button type="button" class="btn btn-default" data-toggle="collapse" data-target="#searchCollapse" aria-expanded="false" aria-controls="searchCollapse">Advance <span class="caret"></span></button>
	  			</div>
			</div>
			<div class="collapse" id="searchCollapse">
				<div class="well">
					<div class="form-group">
						<label for="sel2" class="col-sm-1 control-label">Genre: </label>
						<div class="col-sm-7">
							<!-- When you wished that Select2 would stop being dumb -->
							<select multiple="multiple" class="form-control" id="sel2" name="genre" style="width: 100%"></select>
						</div>
						<label class="col-sm-1 control-label" for="inclusive">Inclusive: </label>
						<div class="col-sm-1 control-label" style="text-align: left">
							<input type="checkbox" id="inclusive" name="inclusive" checked>
						</div>
						<label class="col-sm-1 control-label" for="preowned">Preowned: </label>
						<div class="col-sm-1 control-label" style="text-align: left">
							<input type="checkbox" id="preowned" name="preowned">
						</div>
<!-- 						<label class="col-sm-1 control-label">Depth: </label> -->
<!-- 						<div class="col-sm-1 control-label" style="text-align: left"> -->
<!-- 							<label><input type="radio" id="preowned" name="depth" value="0"> All</label> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-1 control-label" style="text-align: left"> -->
<!-- 							<label><input type="radio" id="preowned" name="depth" value="1"> Some</label> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-1 control-label" style="text-align: left"> -->
<!-- 							<label><input type="radio" id="preowned" name="depth" value="2"> Title</label> -->
<!-- 						</div> -->
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
			
			<% // Check if there is anything to search for. Otherwise just render all the games. 
			if (request.getParameter("q") == null) {%>
			$.getJSON("api/games", function(data) {
				if (data.responseCode == 0) {
					ayylmao(data);
				} else {
					$('#games-list').html('<h3>No results found.</h3>');
				}
			});
			<% } else {%>
			var q = "<%= request.getParameter("q") %>";
			var operator = <%= request.getParameter("inclusive") == null ? false : (request.getParameter("inclusive").equalsIgnoreCase("on") ? true : false) %>;
			var preowned = <%= request.getParameter("preowned") == null ? 0 : (request.getParameter("preowned").equalsIgnoreCase("on") ? 1 : 0) %>;
			var genre = "<%= request.getParameterValues("genre") == null ? "" : String.join(",", request.getParameterValues("genre")) %>";
			
			$('.search-bar').val(q);
			if (!operator) {
				$('#inclusive').prop('checked', false);
			} if (preowned) {
				$('#preowned').prop('checked', true);
			} if (genre || !operator || preowned) {
				$('#searchCollapse').collapse('show');
			}
			
			$.getJSON("api/gamesearch?q-gametitle=" + q + "&inclusive=" + operator + "&q-preowned=" + preowned + "&q-genreid=" + genre, function(data) {
				if (data.responseCode == 0) {
					ayylmao(data);
				} else {
					$('#games-list').html('<h3>No results found.</h3>');
				}
			});
			<% } %>
			function format(state) {
				return state.name || state.text;
			}
			
			// Initialize Select2 for the search.
			// See their documentation for more information
			$('#sel2').select2({
				  ajax: {
				    url: 'api/genres',
			        dataType: 'json',
				    delay: 250,
				    processResults: function(data) {
				    	return {
				    		results: data.results
				    	}
				    }
				  },
				templateSelection: format,
				templateResult: format,
				cache: true,
				allowClear: true,
				placeholder: 'Select a genre'
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
								'"><div class="media-left media-middle"><img src="http://placehold.it/128x50" alt="..." width="128" height="50"></div><div class="media-body"><h4 class="media-heading">' + value.title + 
								'</h4><p class="hidden-xs">Platforms: ' + platformSupport(value) + 
								'</p><p class="genres hidden-xs">Genres: </p></div><div class="media-right media-middle"><span class="label label-success">$' + value.price.toFixed(2) + 
								'</span></div></li>');
						if (value.preowned) {
							$('#game-' + value.id + ' .media-right span').removeClass('label-success');
							$('#game-' + value.id + ' .media-right span').addClass('label-warning');	
						}
						$.getJSON("api/gameimages?q-gameid=" + value.id + "&q-imageuse=0", function(data2) {
							if (data2.responseCode == 0) {
								$('#game-' + value.id + ' .media-left').html('<img src="data:' + data2.results[0].mimeType + ';base64,' + data2.results[0].b64imagedata + 
								'" alt="..." width="128" height="50"/>');
							}
						});
						$.getJSON("api/gamegenre?q-gameid=" + value.id, function(data3) {
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