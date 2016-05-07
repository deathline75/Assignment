<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
		<div class="page-header">
			<h1>Browse by Genre</h1>
		</div>
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
		$.getJSON("api/genres", function(data) {
			if (data.responseCode == 0) {
				$.each(data.results, function(index, value) {
					$('#genrenav').append("<li><label><input type=\"checkbox\" name=\"" + value.id + "\"> " + value.name + "</label></li>");
				});
			}
		});
	});
</script>
</body>
</html>