<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>Games | SP Games Store Administration</title>
</head>
<body>
<%@ include file="navbar.jsp"%>
<%
/*
SQL:
	one game map to Many genre. Compulsory.
	on delete no action.
*/

/*
	Input default img.
*/

/*
	Import upload func.API.
*/

String gameTitle =request.getParameter("gameTitle");
String company =request.getParameter("company");
String releaseDate =request.getParameter("releaseDate");
java.util.Date releasedate = new java.util.Date();
java.text.SimpleDateFormat asd = new java.text.SimpleDateFormat("yyyy-MM-dd");
releaseDate = asd.format(releasedate);
String description =request.getParameter("description");

double price = Double.parseDouble(request.getParameter("price"));

String imgLocation =request.getParameter("imgLocation");

String preowned = request.getParameter("preowned");

String supportWin =request.getParameter("supportWin");

out.print(supportWin);

String supportMac =request.getParameter("supportMac");
String supportXBOX =request.getParameter("supportXBOX");
String supportLinux =request.getParameter("supportLinux");
String supportWinPS4 =request.getParameter("supportWinPS4");
String supportWIIU =request.getParameter("supportWIIU");

%>

	<div class="container">
	<h1 class="col-sm-8" style="padding: 0;">Add Game</h1>
			<div class="col-sm-3" style="margin: 20px 0 10px;">
		</div>
	</div>
	
	<form method="post">
	Game Title:<input type="text" name="gameTitle">
	<br />
	Company:<input type="text" name="company">
	<br />
	releaseDate:<input type="date" name="releaseDate">
	<br />
	Description:<input type="text" name="description">
	<br />
	Price:<input type="text" name="price">
	<br />
	imgLocation:<input type="url" name="imgLocation">
	<br />
	Preowned:<input type="checkbox" name="preowned">
	<br />
	Platform:
	win:<input type="checkbox" name="supportWin"><br />
	Mac:<input type="checkbox" name="supportMac"><br />
	Xbox:<input type="checkbox" name="supportXBOX"><br />
	Linux:<input type="checkbox" name="supportLinux"><br />
	PS4:<input type="checkbox" name="supportWinPS4"><br />
	WIIU:<input type="checkbox" name="supportWIIU"><br />
	
	<input type="submit" value="kelvinsuckaTRANNYDICK">
	
	</form>
	

<%@ include file="../footer.html"%>
</body>
</html>