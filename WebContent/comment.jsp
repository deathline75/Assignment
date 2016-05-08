<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js"></script>
<script type="text/javascript" src="js/rating.js"></script>
<link rel="stylesheet" href="css/rating.css" type="text/css" media="screen" title="Rating CSS">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
    <script type="text/javascript">
        $(function(){
            $('.rate').rating();
        });
    </script>
 
</head>
<body>
<%
String gameid = request.getParameter("gameid");
%>

<script>
$(document).ready(function() {
    $.getJSON("api/gamecomments?q-gameid=<%=gameid%>", function(data) {
        console.log(data);
        $.each(data.results, function(index, value) {
            $('#Hello').append("Author:" + value.author + "<br/>" + "Comment:<br/>" + value.comment + "<br/>");
        });
    });
});

</script>

<div id = "Hello">

</div>

     <form action=AddComment method="post">
     <div class="rate">
        <input type="radio" name="rating" class="rating" value="1" />
        <input type="radio" name="rating" class="rating" value="2" />
        <input type="radio" name="rating" class="rating" value="3" />
        <input type="radio" name="rating" class="rating" value="4" />
        <input type="radio" name="rating" class="rating" value="5" />
      </div>
      <input type="hidden" name="gameid" value="<%=gameid %>">
      Name:<input type="text" name="author"> <br/>
      Comment:<input type="text" name="comment"><br/>
		<input type="submit" value="Submit">
</form>





</body>
</html>