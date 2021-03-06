<%
String username = "";
if (session.getAttribute("username") != null)
	username = (String) session.getAttribute("username");
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
      <a class="navbar-brand" href=".">SP Games Store Admin</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav ice-nav-ul">
        <li><a href="games.jsp">Games</a></li>
        <li><a href="genres.jsp">Genres</a></li>
        <li><a href="stocks.jsp">Stocks</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="../">Main Page</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Signed in as <%= username %> <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="logout.jsp">Logout</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>