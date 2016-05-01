<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
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
String Company =request.getParameter("company");
String releaseDate =request.getParameter("date");
java.sql.Date result = java.sql.Date.valueOf(releaseDate); 
String Description =request.getParameter("description");
String Price =request.getParameter("price");
String image =request.getParameter("imageLoc");
String quantityString = request.getParameter("quantity");
int quantity=Integer.parseInt(quantityString);
String genre[]=request.getParameterValues("genre");


%>
</body>
</html>