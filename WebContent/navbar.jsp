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
      <form class="navbar-form navbar-right" role="search" action="games.jsp">
        <div class="form-group">
          <input type="text" class="form-control search-bar" placeholder="Search" name="q">
          <input type="hidden" name="inclusive" value="on" />
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>

    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>