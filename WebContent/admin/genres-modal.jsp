<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.ice.*, java.util.*,com.ice.api.*,com.ice.util.*"%>
<%
	String action = request.getParameter("action");
	String genreid = request.getParameter("genreid");
	DatabaseConnect connection = new DatabaseConnect(MyConstants.url);
	ResultSet rs = connection.preparedQuery("Select * from genre where genreid=?", genreid);
	if (rs.next()) {
		String genrename = rs.getString("genrename");
		connection.close();
%>

<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
	<h4 class="modal-title" id="exampleModalLabel"><%=action%>:
		<%=genrename%></h4>
</div>

<div class="modal-body">
	<% if (action.equalsIgnoreCase("delete")) { %>
	<form action=DeleteGenre method="post" id="deleteGenre">
		<p>
		Are you sure you want to delete <b><%=genrename%></b> ?
		<input type="hidden" name="genreid" value="<%=genreid%>" />
		</p>
	</form>
	<% } %>
</div>

<div class="modal-footer">
	<% if (action.equalsIgnoreCase("delete")) { %>
	<button type="submit" class="btn btn-danger" name="submit" form="deleteGenre">Delete Game</button>
	<% } %>
	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	<% } %>
</div>