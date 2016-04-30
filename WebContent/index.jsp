<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
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
		<div class="page-header">
			<h2>Genres</h2>
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
	</div>
	<%@ include file="footer.html"%>
</body>
</html>