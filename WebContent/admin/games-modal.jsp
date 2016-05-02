<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.ice.*"%>
<%@ page import="java.util.*"%>
<%
	String action = request.getParameter("action");
	String gameid = request.getParameter("gameid");
	System.out.println(gameid);
%>

<%
	connectToMysql connection = new connectToMysql(MyConstants.url);
	ResultSet rs = connection.preparedQuery(
			"Select gametitle,company,releaseDate,description,price,imgLocation,preowned,supportWin,supportMac,supportXBOX,supportLinux,supportPS4,supportWIIU from game where gameid=?",
			gameid);
	if (rs.next()) {
		String gameTitle = rs.getString("gameTitle");
		String company = rs.getString("company");
		String description = rs.getString("description");
		String releaseDate = rs.getString("releasedate");
		String price = rs.getString("price");
		String imgLocation = rs.getString("imglocation");
		String preowned = rs.getString("preowned");
		String supportWin = rs.getString("supportWin");
		String supportMac = rs.getString("supportMac");
		String supportXBOX = rs.getString("supportXBOX");
		String supportLinux = rs.getString("supportLinux");
		String supportPS4 = rs.getString("supportPS4");
		String supportWIIU = rs.getString("supportWIIU");

		System.out.print(gameTitle);
		connection.close();
%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
	<h4 class="modal-title" id="exampleModalLabel"><%=action%>
		<%=gameTitle%></h4>
</div>
<div class="modal-body">

	<div id="ViewInfo" style="display:none">
	<span class="label label-default">Description:</span> <br />
	<%=description%>
	<br /> <span class="label label-primary">Company:</span> <br />
	<%=company%><br /> <span class="label label-success">Releasedate:</span>
	<br />
	<%=releaseDate%><br /> <span class="label label-info">Price:</span> <br />
	<%=price%><br /> <span class="label label-warning">Preowned:</span> <br />
	<%
		if (preowned.equals("1")) {
				out.println("It's preowned");
			} else {
				out.println("It's not preowned");
			}
	%><br /> <span class="label label-danger">Supported Platforms:</span>
	<br />
	<%
		if (supportWin.equals("1"))
				out.print("<span class=\"label label-info\">Windows</span> ");
			if (supportMac.equals("1"))
				out.print("<span class=\"label label-info\">Mac</span> ");
			if (supportXBOX.equals("1"))
				out.print("<span class=\"label label-info\">XBOX</span> ");
			if (supportLinux.equals("1"))
				out.print("<span class=\"label label-info\">Linux</span>");
			if (supportPS4.equals("1"))
				out.print("<span class=\"label label-info\">PS4</span> ");
			if (supportWIIU.equals("1"))
				out.print("<span class=\"label label-info\">WIIU</span> ");
	%>
	</div>
	
		<%if(action.equals("View")){ 
	out.print("<script>document.getElementById(\"ViewInfo\").style.display=\"\";</script>");
		
	}
	
	%>

</div>
<div class="modal-footer">

	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	<button type="button" class="btn btn-primary" data-dismiss="modal">Ok</button>
</div>

<%
	}
%>