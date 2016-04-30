<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
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
				    	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ipsum nisl, auctor vel eleifend finibus, consectetur ut nulla. Nulla vulputate a tellus in fringilla. Mauris aliquam lorem non mauris euismod luctus. Morbi in purus sodales, maximus lacus sed, fermentum dolor. Proin enim nulla, dictum nec ex nec, sagittis faucibus nulla. Fusce eu auctor lorem. Sed hendrerit cursus quam et sodales. Mauris sodales varius metus, nec dapibus enim commodo et. Vestibulum quis quam mauris. Aenean ut leo in odio laoreet rutrum a rutrum massa. Sed mattis orci quis velit varius dignissim. Etiam eget tortor malesuada, malesuada nisi sit amet, accumsan velit.
				    </div>
    				<div role="tabpanel" class="tab-pane" id="pc">
    					Aliquam lorem nunc, sagittis a orci ut, luctus condimentum massa. Sed in tempor purus, sed tempor felis. Cras congue felis et lacus cursus, eget auctor est vulputate. Vestibulum sollicitudin semper felis nec pellentesque. Nullam congue euismod lacus ut placerat. Vivamus efficitur, risus id mollis condimentum, lacus justo tincidunt ante, quis tempor nunc nisl et ligula. Etiam eu pulvinar felis, et consequat urna. Ut ultrices neque nec dui auctor tempus. Cras bibendum quam sed hendrerit tempor. Morbi congue ligula sit amet erat faucibus, vel pharetra elit suscipit. Nullam molestie porttitor porttitor. Nullam finibus pharetra ligula dapibus egestas. Donec sodales posuere ipsum, eget condimentum augue congue elementum. Vestibulum eget tincidunt elit.
    				</div>
    				<div role="tabpanel" class="tab-pane" id="ps4">
    					Quisque quis sapien quis leo pellentesque dignissim sed at tortor. Donec nibh ex, eleifend non enim vel, mattis fermentum ante. Nullam pretium tellus metus, vel suscipit enim sollicitudin nec. Etiam elementum quis augue et viverra. Curabitur vitae bibendum purus. Aenean eu volutpat est. Etiam vitae convallis dolor, a hendrerit velit. Fusce in augue lacinia, varius ipsum at, tempus elit. In a odio sed orci semper viverra ut et massa. Curabitur ac urna velit. Suspendisse auctor urna vitae consectetur blandit. Integer ut risus commodo, rutrum tellus et, commodo augue.
    				</div>
    				<div role="tabpanel" class="tab-pane" id="xbone">
    					Maecenas viverra porttitor massa, quis efficitur nibh dapibus id. Curabitur volutpat arcu nec neque vehicula scelerisque. Suspendisse elit est, viverra eget aliquam eget, placerat mollis libero. Nunc lobortis metus at ornare ultrices. Donec quis erat neque. Donec non orci iaculis, fermentum ligula sit amet, pulvinar risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Ut pellentesque viverra rutrum. Nulla euismod nisl ac ipsum molestie mollis. Proin suscipit vel dolor nec tristique.
					</div>
    				<div role="tabpanel" class="tab-pane" id="wiiu">
    					Aenean ac feugiat dolor. Sed mollis scelerisque tortor ut bibendum. Aenean dolor odio, pharetra quis ante at, efficitur ultrices arcu. Nullam vitae lacus metus. Etiam non consectetur tortor. Donec condimentum purus sagittis aliquam cursus. Aliquam consectetur vestibulum purus, sed varius dolor lacinia et. Mauris eu varius nisl.
					</div>
			</div>
		</div>
		<div class="col-sm-4" style="padding-right:0;">
			<div class="thumbnail">
				<img src="http://placehold.it/350x350" alt="...">
				<div class="caption">
					<h3>Game Title</h3>
					<p>Etiam id dolor vitae magna volutpat pellentesque ut vitae dui. Vestibulum pharetra eu tellus ac venenatis. Duis sit amet odio porta, fermentum metus id, venenatis orci. Vestibulum aliquet porta erat, vitae placerat mauris finibus et. Phasellus in volutpat lacus. Interdum et malesuada fames ac ante ipsum primis in faucibus. In iaculis, dui at pulvinar egestas, quam libero auctor purus, nec elementum sapien arcu in eros. Donec consequat cursus quam ut fringilla. Aenean posuere sollicitudin mi eget auctor.</p>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
	
</body>
</html>