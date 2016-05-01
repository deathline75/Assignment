<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
    <%@ page import="com.ice.*"%>
    
 <%
String gameTitle =request.getParameter("gameTitle");
String company =request.getParameter("company");
String releaseDate =request.getParameter("releaseDate");
String description =request.getParameter("description");
String price = request.getParameter("price");
String imgLocation =request.getParameter("imgLocation");
String preOwned = request.getParameter("preOwned");
if(preOwned!=null){
	//out.println("Clicked");
	preOwned = "1";
}
else{
	preOwned = "0";
	//out.println("Not clicked");
}
String supportWin =request.getParameter("supportWin");
if(supportWin!=null){
	//out.println("Clicked");
	supportWin = "1";
}
else{
	supportWin = "0";
	//out.println("Not clicked");
}
String supportMac =request.getParameter("supportMac");
if(supportMac!=null){
	//out.println("Clicked");
	supportMac = "1";
}
else{
	supportMac = "0";
	//out.println("Not clicked");
}
String supportXBOX =request.getParameter("supportXBOX");
if(supportXBOX!=null){
	//out.println("Clicked");
	supportXBOX = "1";
}
else{
	supportXBOX = "0";
	//out.println("Not clicked");
}
String supportLinux =request.getParameter("supportLinux");
if(supportLinux!=null){
	//out.println("Clicked");
	supportLinux = "1";
}
else{
	supportLinux = "0";
	//out.println("Not clicked");
}
String supportPS4 =request.getParameter("supportPS4");
if(supportPS4!=null){
	//out.println("Clicked");
	supportPS4 = "1";
}
else{
	supportPS4 = "0";
	//out.println("Not clicked");
}
String supportWIIU =request.getParameter("supportWIIU");
if(supportWIIU!=null){
	//out.println("Clicked");
	supportWIIU = "1";
}
else{
	supportWIIU = "0";
	//out.println("Not clicked");
}
%>



<%
connectToMysql connection = new connectToMysql(MyConstants.url);
//connection.preparedUpdate("insert into game(gametitle,company,releaseDate,description.price,imgLocation,preowned,supportWin,supportMac,supportXBOX,supportLinux,supportWinPS4,supportWIIU),values(?,?,?,?,?,?,?,?,?,?,?,?,?)",gameTitle,company,releaseDate,description,price,imgLocation,preOwned,supportWin,supportMac,supportXBOX,supportLinux,supportPS4,supportWIIU);
//connection.preparedUpdate("INSERT INTO user (username,userpwd) VALUES (?,?)",gameTitle,company);
connection.close();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>Games | SP Games Store Administration</title>
</head>
<body>
<%@ include file="navbar.jsp"%>

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
	releaseDate:<input type="text" name="releaseDate">
	<br />
	Description:<input type="text" name="description">
	<br />
	Price:<input type="text" name="price">
	<br />
	imgLocation:<input type="text" name="imgLocation">
	<br />
	Preowned:<input type="checkbox" name="preOwned">
	<br />
	Platform:
	win:<input type="checkbox" name="supportWin"><br />
	Mac:<input type="checkbox" name="supportMac"><br />
	Xbox:<input type="checkbox" name="supportXBOX"><br />
	Linux:<input type="checkbox" name="supportLinux"><br />
	PS4:<input type="checkbox" name="supportPS4"><br />
	WIIU:<input type="checkbox" name="supportWIIU"><br />
	
	<input type="submit" value="kelvinsuckaTRANNYDICK">
	
	</form>
	

<%@ include file="../footer.html"%>
</body>
</html>