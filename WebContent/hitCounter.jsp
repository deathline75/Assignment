<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="hitCounter" method="POST">
<input type="submit" value="ToWholeSite">
</form>

<form action="hitCounterGame" method = "POST">
<input type="hidden" name="gameid" value ="2">
<input type="submit" value="ToGame">
</form>
</body>
</html>