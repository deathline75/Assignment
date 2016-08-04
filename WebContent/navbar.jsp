<%@page import="com.ice.api.*, com.ice.*, java.util.*" %>
<%
	User user = (User) session.getAttribute("user");
	session.setAttribute("lastpage", request.getRequestURI());
%>
<nav class="navbar navbar-fixed-top ice-nav navbar-default">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href=".">SP Games Store</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav ice-nav-ul">
        <li><a href="games.jsp">Games</a></li>
        <li><a href="genres.jsp">Genres</a></li>
      </ul>
      <ul class="nav navbar-nav ice-nav-ul navbar-right">
      	<li>
      		<form class="navbar-form" role="search" action="games.jsp">
        		<div class="form-group">
          			<input type="text" class="form-control search-bar" placeholder="Search" name="q">
          			<input type="hidden" name="inclusive" value="on" />
        		</div>
        		<button type="submit" class="btn btn-default">Submit</button>
      		</form>
      	</li>
      	<% if (user == null) { %>
      		<li><a href="login.jsp"><span class="glyphicon glyphicon-user"></span> Sign In / Register </a></li>
      	<% } else { %>
      	<%
      		if (session.getAttribute("cartitems") == null) {
      			CRUDCartItem dbItems = new CRUDCartItem();
      			session.setAttribute("cartitems", dbItems.getItems(user));
      			dbItems.close();
      		}
  			int itemsInCart = ((ArrayList<ShopCartItem>) session.getAttribute("cartitems")).size();
      	%>
      		<li><a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Cart (<%= itemsInCart %>)</a></li>
      		<li class="dropdown">
      			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-user"></span> <%= user.getName() %> <span class="caret"></span></a>
      			<ul class="dropdown-menu">
            		<li><a href="history.jsp">History</a></li>
            		<li><a href="settings.jsp">Settings</a></li>
            		<li role="separator" class="divider"></li>
            		<li><a href="logout.jsp">Logout</a></li>
          		</ul>
      		</li>
      	<% } %>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>