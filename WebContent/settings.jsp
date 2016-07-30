<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.ice.*, com.ice.api.*, java.sql.*, java.util.*, java.net.*, java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>Settings | SP Games Store</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<%
	if (user == null) {
		response.sendRedirect(".");
		return;
	}
	%>
	<div class="container main-content">
		<div class="page-header ice-header">
			<h1>Settings</h1>
		</div>
		<div class="col-md-8" style="padding-left: 0px">
			<form class="panel panel-default form-horizontal">
  				<div class="panel-heading">
    				<h3 class="panel-title">Basic Information</h3>
  				</div>
  				<div class="panel-body">
					<div class="form-group">
						<label for="inputName" class="col-sm-3 control-label">Name: </label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="inputName" placeholder="Name" required name="name" value="<%= user.getName() %>">
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail" class="col-sm-3 control-label">Email Address: </label>
						<div class="col-sm-9">
							<input type="email" class="form-control" id="inputEmail" placeholder="Email Address" required name="email"  value="<%= user.getEmail() %>">
						</div>
					</div>
					<div class="form-group">
						<label for="inputCfmEmail" class="col-sm-3 control-label">Confirm Email: </label>
						<div class="col-sm-9">
							<input type="email" class="form-control" id="inputCfmEmail" placeholder="Email Address" required name="cfmEmail" autocomplete="off">
						</div>
					</div>
  				</div>
  				<div class="panel-footer" style="text-align: right"><button class="btn btn-default" type="submit">Update</button></div>
			</form>
			<form class="panel panel-default form-horizontal">
				<div class="panel-heading">
    				<h3 class="panel-title">Change Password</h3>
  				</div>
	  			<div class="panel-body">
					<div class="form-group">
						<label for="inputPassword" class="col-sm-3 control-label">Password: </label>
						<div class="col-sm-9">
							<input type="password" class="form-control" id="inputPassword" placeholder="Password" required name="password">
						</div>
					</div>
					<div class="form-group">
						<label for="inputCfmPassword" class="col-sm-3 control-label">Confirm Password: </label>
						<div class="col-sm-9">
							<input type="password" class="form-control" id="inputCfmPassword" placeholder="Confirm Password" required name="cfmPassword" autocomplete="off">
						</div>
					</div>
	  			</div>
  				<div class="panel-footer" style="text-align: right"><button class="btn btn-default" type="submit">Update</button></div>
			</form>
			<form class="panel panel-default form-horizontal">
  				<div class="panel-heading">
    				<h3 class="panel-title">Mailing Address</h3>
  				</div>
	  			<div class="panel-body">
					<div class="form-group">
						<label for="inputAddr1" class="col-sm-3 control-label">Mail Address 1: </label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="inputAddr1" placeholder="123 Main Street" required name="addr1" value="<%= user.getMailaddr()[0] %>">
						</div>
					</div>
					<div class="form-group">
						<label for="inputAddr2" class="col-sm-3 control-label">Mail Address 2: </label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="inputAddr2" placeholder="#12-345" required name="addr2" value="<%= user.getMailaddr()[1] %>">
						</div>
					</div>
	  			</div>
  				<div class="panel-footer" style="text-align: right"><button class="btn btn-default" type="submit">Update</button></div>
			</form>
			<form class="panel panel-danger form-horizontal">
  				<div class="panel-heading">
    				<h3 class="panel-title">Deactivate Account</h3>
  				</div>
	  			<div class="panel-body">
	  				The button below will deactivate your account <strong>permanently!</strong> We will not be held responsible for your actions.
	  				<hr/>
					<div class="form-group">
						<label for="inputCfmPassword" class="col-sm-3 control-label">Confirm Password: </label>
						<div class="col-sm-9">
							<input type="password" class="form-control" id="inputCfmPassword" placeholder="Confirm Password" required name="cfmPassword" autocomplete="off">
						</div>
					</div>
	  			</div>
  				<div class="panel-footer" style="text-align: right;background-color:#f2dede"><button class="btn btn-danger" type="submit">Deactivate</button></div>
			</form>
		</div>	
		<div class="col-md-4">
		</div>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>