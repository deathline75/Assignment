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

		<%-- Start of error and success messages --%>
		<% if (session.getAttribute("error") != null) {%>
		<div class="alert alert-danger" role="alert">
			<strong>Error!</strong> <%= session.getAttribute("error") %>
		</div>
		<% session.removeAttribute("error");} %>
		<% if (session.getAttribute("success") != null) {%>
		<div class="alert alert-success" role="alert">
			<strong>Success!</strong> <%= session.getAttribute("success") %>
		</div>
		<% session.removeAttribute("success");} %>
		<%-- End of error and success messages --%>

		<div class="page-header ice-header">
			<h1>Profile Settings</h1>
		</div>
		<ul class="nav nav-pills nav-stacked col-md-3" role="tablist">
			<li role="presentation" class="active"><a href="#basic" aria-controls="basic" role="pill" data-toggle="pill">Basic Information</a></li>
  			<li role="presentation"><a href="#mail" aria-controls="mail" role="pill" data-toggle="pill">Mailing Address</a></li>
  			<li role="presentation"><a href="#security" aria-controls="security" role="pill" data-toggle="pill">Security</a></li>
		</ul>
		
		<div class="tab-content col-md-9">
			<div role="tabpanel" class="tab-pane active" id="basic">
				<form class="panel panel-default form-horizontal" method="post" action="Settings">
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
							<label for="inputContact" class="col-sm-3 control-label">Contact: </label>
							<div class="col-sm-9">
								<input type="number" class="form-control" id="inputContact" placeholder="91234567" required name="contact" data-toggle="tooltip" data-placement="right" title="Must be 8 digits only" value="<%= user.getContact() %>">
							</div>
						</div>
  					</div>
  					<input type="hidden" name="action" value="1">
  					<div class="panel-footer" style="text-align: right"><button class="btn btn-default" type="submit">Update</button></div>
				</form>
				<form class="panel panel-default form-horizontal" method="post" action="Settings">
  					<div class="panel-heading">
	    				<h3 class="panel-title">Change Email</h3>
  					</div>
  					<div class="panel-body">
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
  					<input type="hidden" name="action" value="2">
  					<div class="panel-footer" style="text-align: right"><button class="btn btn-default" type="submit">Update</button></div>
				</form>
			</div>
			<div role="tabpanel" class="tab-pane" id="mail">
				<form class="panel panel-default form-horizontal" method="post" action="Settings">
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
  					<input type="hidden" name="action" value="3">
  					<div class="panel-footer" style="text-align: right"><button class="btn btn-default" type="submit">Update</button></div>
				</form>
			</div>
			<div role="tabpanel" class="tab-pane" id="security">
				<form class="panel panel-warning form-horizontal" method="post" action="Settings">
					<div class="panel-heading">
	    					<h3 class="panel-title">Change Password</h3>
  					</div>
	  				<div class="panel-body">
						<div class="form-group">
							<label for="inputCPassword" class="col-sm-3 control-label">Current Password: </label>
							<div class="col-sm-9">
								<input type="password" class="form-control" id="inputCPassword" placeholder="Password" required name="password">
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword" class="col-sm-3 control-label">New Password: </label>
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
  					<input type="hidden" name="action" value="4">
  					<div class="panel-footer" style="text-align: right;background-color:#fcf8e3;border-top:#faebcc"><button class="btn btn-warning" type="submit">Update</button></div>
				</form>
				<form class="panel panel-danger form-horizontal" method="post" action="Settings">
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
  					<input type="hidden" name="action" value="5">
  					<div class="panel-footer" style="text-align: right;background-color:#f2dede"><button class="btn btn-danger" type="submit">Deactivate</button></div>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
	<script>
	function matchesRegex(element, regex, cfmElement) {
		if (cfmElement != null)
			cfmElement.trigger('change');
		if (element.val().match(regex) == null) {
			element.parent().parent().addClass("has-error");
			element.parent().parent().removeClass("has-success");
			return false;
		} else {
			element.parent().parent().addClass("has-success");
			element.parent().parent().removeClass("has-error");
			return true;
		}
	}
	$('[data-toggle="tooltip"]').tooltip()
	$('#inputPassword').on('change paste keyup', function(){
		matchesRegex($(this), /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,16}$/, $('#inputCfmPasswordR'));
	});
	$('#inputCfmPassword').on('change paste keyup', function(){
		matchesRegex($(this), new RegExp('^' + $('#inputPassword').val() + '$'), null);
	});
	$('#inputEmail').on('change paste keyup', function(){
		matchesRegex($(this), /^(.+?@.+?(\..+)+?){0,254}$/, $('#inputCfmEmailR'));
	});
	$('#inputCfmEmail').on('change paste keyup', function(){
		matchesRegex($(this), new RegExp('^' + $('#inputEmail').val() + '$'), null);
	});
	$('#inputName').on('change paste keyup', function(){
		matchesRegex($(this), /^[\w ]{0,45}$/, null);
	});
	$('#inputAddr1, #inputAddr2').on('change paste keyup', function(){
		matchesRegex($(this), /^.{0,255}$/, null);
	});
	$('#inputContact').on('change paste keyup', function(){
		matchesRegex($(this), /^\d{8}$/, null);
	});
	
	</script>
</body>
</html>