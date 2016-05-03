<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.ice.*"%>
<%@ page import="java.util.*"%>
<%
	String action = request.getParameter("action");
	String gameid = request.getParameter("gameid");
	connectToMysql connection = new connectToMysql(MyConstants.url);
	ResultSet rs = connection.preparedQuery("Select * from game where gameid=?", gameid);
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

		connection.close();
%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
	<h4 class="modal-title" id="exampleModalLabel"><%=action%>:
		<%=gameTitle%></h4>
</div>
<div class="modal-body">
	<%
		if (action.equalsIgnoreCase("view")) {
	%>
	<p>
		<span class="label label-primary">Company:</span>
		<%=company%></p>
	<p>
		<span class="label label-success">Release Date:</span>
		<%=releaseDate%></p>
	<p>
		<span class="label label-default">Description:</span> <br /><%=description%></p>
	<p>
		<span class="label label-info">Price:</span>
		<%=String.format("$%.2f", Double.parseDouble(price))%></p>
	<p>
		<span class="label label-warning">Preowned:</span>
		<%=preowned.equals("1") ? "Yes" : "No"%></p>
	<p>
		<span class="label label-danger">Supported Platforms:</span>
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
	</p>
	<%
		} else if (action.equalsIgnoreCase("edit")) {
	%>
	<form class="form-horizontal" method="post"
		enctype="multipart/form-data">
		<div class="form-group">
			<label for="gametitle" class="col-sm-3 control-label">Game
				Title*: </label>
			<div class="col-sm-8">
				<input type="text" class="form-control" id="gametitle"
					placeholder="Game Title" value="<%=gameTitle%>" name="gameTitle" />
			</div>
		</div>
		<div class="form-group">
			<label for="gamecompany" class="col-sm-3 control-label">Company*:
			</label>
			<div class="col-sm-8">
				<input type="text" class="form-control" id="gamecompany"
					placeholder="Company" value="<%=company%>" name="company" />
			</div>
		</div>
		<div class="form-group">
			<label for="gamereleasedate" class="col-sm-3 control-label">Release
				Date*: </label>
			<div class="col-sm-5">
				<input type="date" class="form-control" id="gamereleasedate"
					placeholder="Release Date" value="<%=releaseDate%>"
					name="releaseDate" />
			</div>
		</div>
		<div class="form-group">
			<label for="gamedescription" class="col-sm-3 control-label">Description*:
			</label>
			<div class="col-sm-9">
				<textarea class="form-control" id="gamedescription"
					placeholder="Description" name="description" rows="4"><%=description%> </textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="gameprice" class="col-sm-3 control-label">Price*:
			</label>
			<div class="col-sm-4 input-group" style="padding: 0 15px;">
				<span class="input-group-addon">$</span> <input type="number"
					class="form-control" id="gameprice" placeholder="59.90"
					value="<%=price%>" name="price" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="gamepreownedgame">
				Preowned Game:</label>
			<div class="control-label col-sm-1" style="text-align: left;">
				<input type="checkbox" name="preOwned" id="gamepreownedgame"
					<%=preowned.equals("1") ? "checked" : ""%>>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"> Platforms:</label>
			<div class="col-sm-9 container-fluid" style="padding: 0;">
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="windows"
						name="supportWin" <%=supportWin.equals("1") ? "checked" : ""%>>
						Windows
					</label>
				</div>
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="osx"
						name="supportMac" <%=supportMac.equals("1") ? "checked" : ""%>>
						OS X
					</label>
				</div>
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="linux"
						name="supportLinux" <%=supportLinux.equals("1") ? "checked" : ""%>>
						Linux
					</label>
				</div>
			</div>
			<div class="col-sm-offset-3 col-sm-9 container-fluid"
				style="padding: 0;">
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="xbone"
						name="supportXBOX" <%=supportXBOX.equals("1") ? "checked" : ""%>>
						Xbox One
					</label>
				</div>
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="ps4"
						name="supportPS4" <%=supportPS4.equals("1") ? "checked" : ""%>>
						PS4
					</label>
				</div>
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="wiiu"
						name="supportWIIU" <%=supportWIIU.equals("1") ? "checked" : ""%>>
						Wii-U
					</label>
				</div>
			</div>
		</div>
	</form>
	<%
		} else if (action.equalsIgnoreCase("delete")) {
	%>
	<p>
		Are you sure you want to delete <b><%=gameTitle%></b> ?
	</p>

	<%
		}
	%>


</div>
<div class="modal-footer">
	<%
		if (action.equalsIgnoreCase("Edit")) {
	%>
	<button type="submit" class="btn btn-primary" name="submit">Edit Game</button>
	<%
		} else if (action.equalsIgnoreCase("delete")) {
	%>
	<button type="submit" class="btn btn-danger" name="submit">Delete Game</button>
	<%
		}
	%>
	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	<%
		}
	%>
</div>