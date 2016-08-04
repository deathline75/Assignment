<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
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
			response.sendRedirect("login.jsp");
			return;
		}
	%>
	

<div class="container main-content">
	<h1>Confirmation Page</h1>
	<div class="col-md-7" style="padding-left:0">		
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Game Title</th>
					<th>Price</th>
					<th>Quantity</th>
				</tr>
			</thead>
			<tbody>
				<%
				
					for (ShopCartItem item : (ArrayList<ShopCartItem>) session.getAttribute("cartitems")) {
				%>
					<td><%= item.getGame().getTitle() %></td>
					<td><%= String.format("$%.2f", item.getGame().getPrice()) %></td>
					<td><%= item.getQuantity() %></td>
				</tr>
				<% } %>
			</tbody>
		</table>
		</div>
		<div class="col-md-5" style="border: 1">
			<h3>Your Details</h3>
			<hr/>
			<form class="form-horizontal ice-admin-login-form" method="post" action="PurchaseItems">
				<div class="form-group">
					<label for="inputName" class="col-sm-3 control-label">Name: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputName" placeholder="Name" required name="name" data-toggle="tooltip" data-placement="right" title="Maximum 45 alphanumberic and space characters" value=<%=user.getName() %>>
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="inputAddr1" class="col-sm-3 control-label">Address 1: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputAddr1" placeholder="123 Main Street" required name="addr1" value=<%=user.getMailaddr()[0]%>>
					</div>
				</div>
				<div class="form-group">
					<label for="inputAddr2" class="col-sm-3 control-label">Address 2: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputAddr2" placeholder="#12-345" required name="addr2" value=<%=user.getMailaddr()[1] %>>
					</div>
				</div>
				<div class="form-group">
					<label for="inputContact" class="col-sm-3 control-label">Contact: </label>
					<div class="col-sm-9">
						<input type="number" class="form-control" id="inputContact" placeholder="91234567" required name="contact" data-toggle="tooltip" data-placement="right" title="Must be 8 digits only" value=<%=user.getContact() %>>
					</div>
				</div>
				<hr>
				<div class="form-group">
					<label for="inputContact" class="col-sm-3 control-label">Credit Card: </label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="inputCreditCard" placeholder="4628888888888888" required name="ccnumb" data-toggle="tooltip" data-placement="right" title="16 digits" >
						</div>
						<div class="col-sm-3">
						<input type="password" class="form-control" id="CVV" placeholder="888" required name="CVV" data-toggle="tooltip" data-placement="right" title="Must be 3 digits">
						</div>
				</div>
				<hr />
				<div class="form-group">
					<div class="col-sm-offset-3 col-sm-9">
							
				<input type="submit" class="btn btn-default" value="Purchase">

					</div>
				</div>
			</form>
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
	
	$('#inputName').on('change paste keyup', function(){
		matchesRegex($(this), /^[a-zA-Z ]+$/, null);
	});
	
	$('#inputAddr1').on('change paste keyup', function(){
		matchesRegex($(this), /^.+$/, null);
	});
	$('#inputAddr2').on('change paste keyup', function(){
		matchesRegex($(this), /^.+$/, null);
	});
	$('#inputContact').on('change paste keyup', function(){
		matchesRegex($(this), /^\d{8}$/, null);
	});
	$('#inputCreditCard').on('change paste keyup', function(){
		matchesRegex($(this), /^\d{16}$/, null);
	});
	$('#CVV').on('change paste keyup', function(){
		matchesRegex($(this), /^\d{3}$/, null);
	});

	
	</script>
</body>
</html>