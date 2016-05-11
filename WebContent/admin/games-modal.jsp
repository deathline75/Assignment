<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.ice.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
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

		rs.close();
		
		ResultSet genrers = connection.preparedQuery("SELECT * FROM genre WHERE genreid IN (SELECT genreid FROM game_genre WHERE gameid=?)", gameid);
		Map<Integer, String> genres = new HashMap<Integer, String>();
		while (genrers.next()) {
			genres.put(genrers.getInt(1), genrers.getString(2));
		}
		genrers.close();
		
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
		<span class="label label-primary">Genres:</span> 
		<% if (genres.isEmpty()) { %>
			<span class="label label-danger">No genres found :( </span>
		<% } else { for (String x : genres.values()) {%>
			<span class="label label-info"><%= x %></span>
		<% }} %>
	</p>
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
						out.print("<span class=\"label label-info\">Linux</span> ");
					if (supportPS4.equals("1"))
						out.print("<span class=\"label label-info\">PS4</span> ");
					if (supportWIIU.equals("1"))
						out.print("<span class=\"label label-info\">WIIU</span> ");
		%>
	</p>
	<%
			// TODO: Cleanup
			ResultSet imageResult = connection.preparedQuery("SELECT * FROM game_image WHERE gameid=?", gameid);
			if (imageResult.next()) {
				byte[] imageIS = imageResult.getBytes(3);
				String mimeType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(imageIS));
				if (mimeType.startsWith("image")) {
					String b64encoded = new String(Base64.getEncoder().encode(imageIS), "UTF-8");
	%>
	<p>
		<span class="label label-info">Image:</span> <br />
		<img src="data:<%= mimeType %>;base64,<%= b64encoded %>" class="img-responsive"/>
	</p>
	<%
				}
			}
			imageResult.close();
		} else if (action.equalsIgnoreCase("edit")) {
	%>
	<form class="form-horizontal" method="post" id="EditGame" action="EditGame" enctype="multipart/form-data" >
		<div class="form-group">
		<input type="hidden" name="gameid" value="<%=gameid%>" />
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
				<input type="text" class="form-control" id="company"
					placeholder="Company" value="<%=company%>" name="company" />
			</div>
		</div>
		<div class="form-group">
			<label for="gamereleasedate" class="col-sm-3 control-label">Release
				Date*: </label>
			<div class="col-sm-5">
				<input type="date" class="form-control" id="releaseDate"
					placeholder="Release Date" value="<%=releaseDate%>"
					name="releaseDate" />
			</div>
		</div>
		<div class="form-group">
			<label for="sel2" class="col-sm-3 control-label">Genre*: </label>
    		<div class="col-sm-9">
    			<select multiple="multiple" class="form-control" id="sel2" name="genre">
    				<% ResultSet rs2 = connection.preparedQuery("SELECT genreid,genrename FROM genre");
		    		while (rs2.next()) { %>
    				<option value="<%=rs2.getInt(1)%>" <%= genres.containsKey(rs2.getInt(1)) ? "selected" : "" %>><%=rs2.getString(2)%></option>
      				<% } rs2.close(); %>
      			</select>
      			<script>
      				$('#sel2').select2();
      			</script>
    		</div>
		</div>
		<div class="form-group">
			<label for="gamedescription" class="col-sm-3 control-label">Description*:
			</label>
			<div class="col-sm-9">
				<textarea class="form-control" id="description"
					placeholder="Description" name="description" rows="4"><%=description%> </textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="gameprice" class="col-sm-3 control-label">Price*:
			</label>
			<div class="col-sm-4 input-group" style="padding: 0 15px;">
				<span class="input-group-addon">$</span> <input type="number"
					class="form-control" id="price" placeholder="59.90"
					value="<%=price%>" name="price" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="gamepreownedgame">
				Preowned Game:</label>
			<div class="control-label col-sm-1" style="text-align: left;">
				<input type="checkbox" name="preOwned" id="preOwned"
					<%=preowned.equals("1") ? "checked" : ""%>>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"> Platforms:</label>
			<div class="col-sm-9 container-fluid" style="padding: 0;">
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="windows" id="supportWin"
						name="supportWin" <%=supportWin.equals("1") ? "checked" : ""%>>
						Windows
					</label>
				</div>
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="osx" id="supportMac"
						name="supportMac" <%=supportMac.equals("1") ? "checked" : ""%>>
						OS X
					</label>
				</div>
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="linux" id="supportLinux"
						name="supportLinux" <%=supportLinux.equals("1") ? "checked" : ""%>>
						Linux
					</label>
				</div>
			</div>
			<div class="col-sm-offset-3 col-sm-9 container-fluid"
				style="padding: 0;">
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="xbone" id="supportXBOX"
						name="supportXBOX" <%=supportXBOX.equals("1") ? "checked" : ""%>>
						Xbox One
					</label>
				</div>
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="ps4" id="supportPS4"
						name="supportPS4" <%=supportPS4.equals("1") ? "checked" : ""%>>
						PS4
					</label>
				</div>
				<div class="control-label col-sm-3" style="text-align: left;">
					<label> <input type="checkbox" value="wiiu" id="supportWIIU"
						name="supportWIIU" <%=supportWIIU.equals("1") ? "checked" : ""%>>
						Wii-U
					</label>
				</div>
			</div>
		</div>
		<hr />
			<div class="form-group">
				<label for="gamethumbnail" class="col-sm-3 control-label">Game Thumbnail: </label>
    			<div class="col-sm-9">
    				<input type="file" style="padding-top: 7px;" id="gamethumbnail" name="gamethumbnail" accept="image/*" aria-describedby="helpBlockThumbnail">
    			</div>
    			<span id="helpBlockThumbnail" class="help-block col-sm-offset-3 col-sm-9">Recommended dimensions: 128 x 64. Will not override if no upload.</span>
			</div>
			<div class="form-group">
				<label for="gamejumbo" class="col-sm-3 control-label">Game Jumbotron: </label>
    			<div class="col-sm-9">
    				<input type="file" style="padding-top: 7px;" id="gamejumbo" name="gamejumbo" accept="image/*" aria-describedby="helpBlockJumbo">
    			</div>
    			<span id="helpBlockJumbo" class="help-block col-sm-offset-3 col-sm-9">Recommended dimensions: 1920 x 1080. Will not override if no upload.</span>
			</div>
			<div class="form-group">
				<label for="gamepromo" class="col-sm-3 control-label">Game Promotion: </label>
    			<div class="col-sm-9">
    				<input type="file" style="padding-top: 7px;" id="gamepromo" name="gamepromo" accept="image/*" aria-describedby="helpBlockPromo">
    			</div>
    			<span id="helpBlockPromo" class="help-block col-sm-offset-3 col-sm-9">Recommended dimensions: 350 x 350. Will not override if no upload.</span>
			</div>
	</form>
	<%
		} else if (action.equalsIgnoreCase("delete")) {
	%>
	<form action=DeleteGame method="post" id="deleteGame">
	<p>
		Are you sure you want to delete <b><%=gameTitle%></b> ?
		<input type="hidden" name="gameid" value="<%=gameid%>" />
	</p>
	</form>
	<%
		}
	%>


</div>
<div class="modal-footer">
	<%
		if (action.equalsIgnoreCase("Edit")) {
	%>
	<button type="submit" class="btn btn-primary" name="submit" form="EditGame">Edit Game</button>
	<%
		} else if (action.equalsIgnoreCase("delete")) {
	%>
	<button type="submit" class="btn btn-danger" name="submit" form="deleteGame">Delete Game</button>
	<%
		}
	%>
	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	<%
		}
	%>
</div>