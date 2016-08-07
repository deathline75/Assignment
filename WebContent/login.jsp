<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,java.security.*,javax.xml.bind.*"%>
    <%
    	SecureRandom random = new SecureRandom();
    	byte[] token = new byte[128];
    	random.nextBytes(token);
    	String tokenString = DatatypeConverter.printBase64Binary(token);
    	session.setAttribute("logintoken", tokenString);
    	String lastpage = (String) (session.getAttribute("lastpage") == null ? "." : session.getAttribute("lastpage"));
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="head.html"%>

<title>Sign In | SP Games Store</title>
</head>
<body>
<%@ include file="navbar.jsp"%>
<% session.setAttribute("lastpage", lastpage); %>
<div class="container main-content">
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
	<h1>Join us with our community!</h1>
	<div class="row">
		<div class="col-md-6">
			<h3>Sign In</h3>
			<hr/>
			<form class="form-horizontal ice-admin-login-form" method="post" action="Login">
				<div class="form-group">
					<label for="inputEmail" class="col-sm-2 control-label">Email: </label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="inputEmail" placeholder="Email" required name="email" autofocus>
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="col-sm-2 control-label">Password: </label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="inputPassword" placeholder="Password" required name="password">
					</div>
				</div>
				<input type="hidden" name="logintoken" value="<%= tokenString %>">
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default">Sign in</button>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-6">
			<h3>Register</h3>
			<hr/>
			<form class="form-horizontal ice-admin-login-form" method="post" action="Register">
				<div class="form-group">
					<label for="inputName" class="col-sm-3 control-label">Name: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputName" placeholder="Name" required name="name" data-toggle="tooltip" data-placement="right" title="Maximum 45 alphanumberic and space characters">
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmailR" class="col-sm-3 control-label">Email Address: </label>
					<div class="col-sm-9">
						<input type="email" class="form-control" id="inputEmailR" placeholder="Email Address" required name="email" data-toggle="tooltip" data-placement="right" title="Must contain a '@' and a '.'">
					</div>
				</div>
				<div class="form-group">
					<label for="inputCfmEmailR" class="col-sm-3 control-label">Confirm Email: </label>
					<div class="col-sm-9">
						<input type="email" class="form-control" id="inputCfmEmailR" placeholder="Email Address" required name="cfmEmail"  autocomplete="off">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="inputPasswordR" class="col-sm-3 control-label">Password: </label>
					<div class="col-sm-9">
						<input type="password" class="form-control" id="inputPasswordR" placeholder="Password" required name="password" auto-complete="new-password" data-toggle="tooltip" data-placement="right" title="Must contain 8 to 16 uppercase, lowercase and numbers only">
					</div>
				</div>
				<div class="form-group">
					<label for="inputCfmPasswordR" class="col-sm-3 control-label">Confirm Password: </label>
					<div class="col-sm-9">
						<input type="password" class="form-control" id="inputCfmPasswordR" placeholder="Confirm Password" required name="cfmPassword" autocomplete="new-password">
					</div>
				</div>
				<hr />
				<div class="form-group">
					<label for="inputAddr1" class="col-sm-3 control-label">Mail Address 1: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputAddr1" placeholder="123 Main Street" required name="addr1">
					</div>
				</div>
				<div class="form-group">
					<label for="inputAddr2" class="col-sm-3 control-label">Mail Address 2: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputAddr2" placeholder="#12-345" required name="addr2">
					</div>
				</div>
				<div class="form-group">
					<label for="inputContact" class="col-sm-3 control-label">Contact: </label>
					<div class="col-sm-9">
						<input type="number" class="form-control" id="inputContact" placeholder="91234567" required name="contact" data-toggle="tooltip" data-placement="right" title="Must be 8 digits only">
					</div>
				</div>
				<hr />
				<div class="g-recaptcha col-sm-offset-3" data-sitekey="6LctkR4TAAAAAPQYqGQkmeaczaReQwT0qkC-tagZ" style="margin-bottom: 15px"></div>
				<div class="form-group">
					<div class="col-sm-offset-3 col-sm-9">
						<button type="submit" class="btn btn-default" id="btnRegister">Register</button>
					</div>
				</div>
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
	$('#inputPasswordR').on('change paste keyup', function(){
		matchesRegex($(this), /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,16}$/, $('#inputCfmPasswordR'));
	});
	$('#inputCfmPasswordR').on('change paste keyup', function(){
		matchesRegex($(this), new RegExp('^' + $('#inputPasswordR').val() + '$'), null);
	});
	$('#inputEmailR').on('change paste keyup', function(){
		matchesRegex($(this),  /^(.+?@.+?(\..+)+?){0,254}$/, $('#inputCfmEmailR'));
	});
	$('#inputCfmEmailR').on('change paste keyup', function(){
		matchesRegex($(this), new RegExp('^' + $('#inputEmailR').val() + '$'), null);
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