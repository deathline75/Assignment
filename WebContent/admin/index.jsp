<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="com.ice.*"%>
<%
	if (session.getAttribute("username") == null)
		response.sendRedirect("login.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>SP Games Store Administration</title>


</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container main-content">
		<div class="page-header">

			<h1>
				Welcome back,
				<%=username%>! <small>Last login: <%
				connectToMysql connection = new connectToMysql(MyConstants.url);
				ResultSet rs = connection.preparedQuery("Select lastLogin from user where username=?", username);
				//ResultSet rs1 = connection.preparedQuery("select SUM(COUNT) from game_hitcounter");
				ResultSet rs2 = connection.preparedQuery("select gametitle,SUM(COUNT) from game_hitcounter gh,game g where gh.gameid = g.gameid group by g.gameid");
				if (rs.next()) {
					String lastLogin = rs.getString("lastLogin");
					out.print(lastLogin);
					//rs.close();
				}
/* 				String totalCount="";
				if(rs1.next()){
					totalCount = rs1.getString(1);
					System.out.println(totalCount);
					//rs.close();
				} */
			%></small>
			</h1>


			<%
				java.util.Date date = new java.util.Date();
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String currentTime = sdf.format(date);
				connection.preparedUpdate("update user set lastLogin=? where username=?", date, username);
				//connection.close();
			%>
			
			
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
			
	<script type="text/javascript">

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});
      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);
      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'HitCounter');
        data.addColumn('number', 'Game!!');
        
        data.addRows([
          <%while(rs2.next()){
        	%>
        	["<%=rs2.getString("gametitle")%>",<%=rs2.getString(2)%>],
        	<%
          }%>
          ['Test', 1]
        ]);

        // Set chart options
        var options = {'title':'Popularity of Different games.',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
</script>
			
				<div id="chart_div"></div>
		</div>
	</div>
	<%@ include file="../footer.html"%>
</body>
</html>