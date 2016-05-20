<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.ice.*"%>
    <%@ page import="java.sql.*" %>
    <% 
    	String gameid = request.getParameter("id");
    	String userPageNum = request.getParameter("userPageNum");
    	if (gameid == null)
    		response.sendRedirect(".");
		

    	int positionRows = 0;
    	if(userPageNum==null || userPageNum.isEmpty()){
    		userPageNum = "1";
    		positionRows = (Integer.parseInt(userPageNum) - 1) * 5;
    		System.out.println(positionRows);
    	}
    			
    	else{
    		positionRows = (Integer.parseInt(userPageNum) - 1) * 5;
    		System.out.println(positionRows);
    	}
    	
    	
    	int rows = 0;
    	int totalPageNum=0;
    	int result = 0;
    %>
    
    <%
    connectToMysql connection = new connectToMysql(MyConstants.url);
	ResultSet rs = connection.preparedQuery("SELECT * FROM game_comment WHERE gameid=?",gameid);
	
	try {
		
		while(rs.next()){
			rows++;
		}
		
		
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} %>
	
<%
//System.out.println(rows);

	if(rows % 5 !=0){
		totalPageNum = rows/5 + 1;
		//System.out.println(totalPageNum);//Pages to display	
	}

	else{
		totalPageNum = rows/5;
		//System.out.println(totalPageNum);//Pages to display
	}	


%>	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<script type="text/javascript" src="js/rating.js"></script>
<link rel="stylesheet" href="css/rating.css" type="text/css" media="screen" title="Rating CSS">	
<link rel="stylesheet" href="css/comment.css" type="text/css">
    <script type="text/javascript">
        $(function(){
            $('.rate').rating();
        });
    </script>
<title> | SP Games Store</title>
</head>
<body>
<%@ include file="navbar.jsp"%>
<div class="container main-content" style="padding: 30px 0">
	<div class="row">
		<div id="jumbo" class="col-sm-8">
			<img src="http://placehold.it/1920x1080?text=No+Image+Available" alt="..." class="img-responsive"/>
		</div>
		<div class="col-sm-4" id="description">
			<div class="page-header ice-header">
				<h1>ಠ_ಠ</h1>
			</div>
			<div class="row">
				<div class="col-md-3">Company:</div>
				<div class="col-md-9 company">You are not supposed to be here</div>
			</div>
			<div class="row">
				<div class="col-md-3">Release:</div>
				<div class="col-md-9 releasedate"></div>
			</div>
			<div class="row">
				<div class="col-md-3">Description:</div>
				<div class="col-md-9 description"></div>
			</div>
			<div class="row">
				<div class="col-md-3">Genres:</div>
				<div class="col-md-9 genres"></div>
			</div>

		</div>
	</div>
	<div class="row panel panel-default" style="margin: 20px 0">
		<div class="panel-body">
			<h3 id="buy-gamename" style="margin-top: 0; display: inline-block">ಠ_ಠ</h3>
			<div class="btn-toolbar pull-right">
				<div class="btn-group platforms" data-toggle="buttons"></div>
				<div class="btn-group" style="display:block" data-toggle="tooltip" data-placement="right" title="Coming Soon">
  					<button type="button" class="btn btn-success" id="buy">Buy New</button>
					<button type="button" class="btn btn-default price">$??.??</button>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<h2>Comments</h2>
		<hr />

<script>
$(document).ready(function() {
    $.getJSON("api/gamecomments?q-gameid=<%=gameid%>&positionRows=<%=positionRows%>", function(data) {
        console.log(data);
        $.each(data.results, function(index, value) {
        	var stars= "";
        	for (var i=1; i <= value.rating; i++){
        		stars = stars + "<span class=\"glyphicon glyphicon-star\" aria-hidden=\"true\"></span>"	
        	}
            $('#comment').append("<div class=\"col-sm-1\"><div class=\"thumbnail\"><img class=\"img-responsive user-photo\" src=\"https://ssl.gstatic.com/accounts/ui/avatar_2x.png\"></div></div><div class=\"panel panel-default\"><div class=\"panel-heading\">" + "<strong>"+ value.author+"</strong>" +" <span class=\"text-muted\"> commented on " + value.date + "</span>" +" " + stars + "</div>" + "<div class=\"panel-body\"> " + value.comment + "</div> </div>");
        	
        });
    });
});
</script>

<div id="comment">


</div>
<script>
function validateForm() {
    var x = document.forms["addcomment"]["author"].value;
    var y = document.forms["addcomment"]["rating"].value;
    var z = document.forms["addcomment"]["comment"].value;
    if (x == null || x == "") {
        alert("Please input your Author");
        return false;
    }
    else if(y == null || y==""){
        alert("Please input your Rating");
        return false;
    }
    else if(z == null || z==""){
        alert("Please input your Comment");
        return false;
    }
}
</script>
		<form action=AddComment method="post" name="addcomment" onsubmit="return validateForm()" id="addcomment">
     		<div class="rate">
        		<input type="radio" name="rating" class="rating" value="1" />
        		<input type="radio" name="rating" class="rating" value="2" />
        		<input type="radio" name="rating" class="rating" value="3" />
        		<input type="radio" name="rating" class="rating" value="4" />
        		<input type="radio" name="rating" class="rating" value="5" />
      		</div>
      		<input type="hidden" name="gameid" value="<%=gameid %>">
      		<div class="col-sm-3">
      		<p>
      		<input type="text" name="author" class="form-control" placeholder="YourName" aria-describedby="basic-addon1" class="form-group">
      		</p>
      		</div>
      		<div class="col-sm-10" class="form-group">
      		<textarea type="text" name="comment" class="form-control" placeholder="Your Comment Here" aria-describedby="basic-addon1" rows="9"></textarea>
			</div>
			<div class="form-group" class="col-sm-3">
			<input type="submit" class="btn btn-default" value="Submit">
			</div>
			
			<nav>
			
  <ul class="pagination">
    <%
    for(int i=1;i<=totalPageNum;i++){%>
    <% if(Integer.parseInt(userPageNum)==i){
    	%>
    <li class="active"><a href="game.jsp?id=<%=gameid%>&userPageNum=<%=i%>"><%=i%></a></li>	<%
    }else{%>
    	<li><a href="game.jsp?id=<%=gameid%>&userPageNum=<%=i%>"><%=i%></a></li>	
    <%} %>
    <%
    }
    %>
     </ul>
</nav>
			
				<div class="g-recaptcha"
				data-sitekey="6LctkR4TAAAAAPQYqGQkmeaczaReQwT0qkC-tagZ"
				style="margin-bottom: 15px"></div>	
		</form>
		<div id="comments">
			<h4 class="text-muted">Comments are disabled as this is a preowned game.</h4>
		</div>
	</div>
</div>
<%@ include file="footer.html" %>
<script>
	$(document).ready(function() {
		$(function () {
			  $('[data-toggle="tooltip"]').tooltip()
			})
		var gameid = <%= gameid %>;	
		$.getJSON("api/games?q-gameid=" + gameid, function(data) {
			if (data.responseCode == 0) {
				var gamedata = data.results[0];
				document.title = gamedata.title + " | SP Games Store";
				$('.page-header > h1').text(gamedata.title);
				$('#buy-gamename').text('Buy: ' + gamedata.title);
				$('.company').text(gamedata.company);
				$('.releasedate').text(gamedata.releaseDate);
				$('.description').text(gamedata.description);
				$('.price').text('$' + gamedata.price.toFixed(2));
				if (gamedata.supportWin) {
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformWin" autocomplete="off" val="win"> Windows </label>');
				} if (gamedata.supportMac) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformMac" autocomplete="off" val="mac"> OS X </label>');
				} if (gamedata.supportLinux) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformLinux" autocomplete="off" val="linux"> Linux </label>');
				} if (gamedata.supportXbox) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformXbox" autocomplete="off" val="xbox"> Xbox One </label>');
				} if (gamedata.supportPs4) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformPS4" autocomplete="off" val="ps4"> PS4 </label>');
				} if (gamedata.supportWiiu) { 
					$('.platforms').append('<label class="btn btn-primary"><input type="radio" name="platforms" id="platformWiiu" autocomplete="off" val="wiiu"> Wii-U </label>');
				}
				if (gamedata.preowned) {
					$('#buy').text('Buy Preowned');
					$('#buy').removeClass('btn-success');
					$('#buy').addClass('btn-warning');
					$("#addcomment").css("display","none");
				} else {
					$("#comments").css("display","none");
				}
			}
		});
		$.getJSON("api/gameimages?q-gameid=" + gameid + "&q-imageuse=1", function(data) {
			if (data.responseCode == 0) {
				$('#jumbo').html('<img src="data:' + data.results[0].mimeType + ';base64,' + data.results[0].b64imagedata + 
				'" alt="..." class="img-responsive"/>');
			}
		});
		$.getJSON("api/gamegenre?q-gameid=" + gameid, function(data) {
			if (data.responseCode == 0) {
				$.each(data.results, function(index, value) {
					$('.genres').append('<span class="label label-primary"><a href="genres.jsp?id=' + value.id + '">' + value.name + '</a></span> ');
				});
			}
		});
	});
</script>


</body>
</html>