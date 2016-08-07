<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import ="java.sql.*, com.ice.*,com.ice.api.*,com.ice.util.*"%>
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
				DatabaseConnect connection = new DatabaseConnect(MyConstants.url);
				ResultSet rs = connection.preparedQuery("Select lastLogin from user where username=?", username);
				//ResultSet rs1 = connection.preparedQuery("select SUM(COUNT) from game_hitcounter");
				ResultSet rs2 = connection.preparedQuery("select gametitle,SUM(COUNT) Count from game_hitcounter gh,game g where gh.gameid = g.gameid group by g.gameid order by Count DESC");
				if (rs.next()) {
					String lastLogin = rs.getString("lastLogin");
					out.print(lastLogin);
					rs.close();
				}
			%></small>
			</h1>


			<%
				java.util.Date date = new java.util.Date();
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String currentTime = sdf.format(date);
				connection.preparedUpdate("update user set lastLogin=? where username=?", date, username);
				connection.close();
			%>
			
			
     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(drawChart2);
	  function drawChart () {
		    $.ajax({
		        url: "../api/hitcounters",
		        dataType: "json",
		        success: function (jsonData) {
		        	console.log(jsonData);
		            var data = new google.visualization.DataTable();
		            // assumes "word" is a string and "count" is a number
		            data.addColumn('string', 'GameTitle');
		            data.addColumn('number', 'HitCounts');

		            for (var i = 0; i < jsonData.length; i++) {
		                data.addRow([jsonData[i].element, jsonData[i].hitCounter]);
		            }

		            var options = {
		                title: 'Popularity spreadsheet',
		                is3D: true
		            };
		            var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
		            chart.draw(data, options);
		        }
		    });
		    
		}
	  
	  
	  function drawChart2 () {
		    $.ajax({
		        url: "../api/hitcounters?day",
		        dataType: "json",
		        success: function (jsonData) {
		        	console.log(jsonData);
		            var data = new google.visualization.DataTable();
		            // assumes "word" is a string and "count" is a number
		            data.addColumn('string', 'GameTitle');
		            data.addColumn('number', 'HitCounts');

		            for (var i = 0; i < jsonData.length; i++) {
		                data.addRow([jsonData[i].element, jsonData[i].hitCounter]);
		            }

		            var options = {
		                title: 'Daily Hitcounter',
		                is3D: true
		            };
		            var chart = new google.visualization.AreaChart(document.getElementById('chart_div2'));
		            chart.draw(data, options);
		        }
		    });
		    
		}
    </script>
			
		<div id="chart_div" style="width: 900px; height: 500px;"></div>
		</div>
		<div id="chart_div2" style="width: 900px; height: 500px;"></div>
		</div>
	</div>
	<%@ include file="../footer.html"%>
</body>
</html>