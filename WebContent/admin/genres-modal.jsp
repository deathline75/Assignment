<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.ice.*"%>
<%@ page import="java.util.*"%>
<%
	String action = request.getParameter("action");
	String gameid = request.getParameter("genreid");
	connectToMysql connection = new connectToMysql(MyConstants.url);
	ResultSet rs = connection.preparedQuery("Select * from game where gameid=?", gameid);
	if (rs.next()) {
		String gameTitle = rs.getString("genreid");
		connection.close();
%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
	<h4 class="modal-title" id="exampleModalLabel"><%=action%>:Genre</h4>
</div>
<div class="modal-body">
	<%
		if (action.equalsIgnoreCase("add")) {
			
			
			
		}
%>

</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	<%
		}
	%>
</div>