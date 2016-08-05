<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>Confirmation Page | SP Games Store</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<%
		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		if (session.getAttribute("cartitems") == null || ((ArrayList<ShopCartItem>) session.getAttribute("cartitems")).isEmpty()) {
			response.sendRedirect(".");
			return;
		}
	%>
<div class="container main-content">
	
	<% if (session.getAttribute("error") != null) {%>
	<div class="alert alert-danger" role="alert">
		<strong>Error!</strong> <%= session.getAttribute("error") %>
	</div>
	<% session.removeAttribute("error");} %>
	
	<div class="page-header ice-header">
		<h1>Confirmation Page <small>Check the details carefully</small></h1>
	</div>
	<div class="col-md-7" style="padding-left:0">		
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Game Title</th>
					<th>Price</th>
					<th style="text-align:right;">Quantity</th>
					<th style="text-align:right;">Total</th>
				</tr>
			</thead>
			<tbody>
				<%
					double totalCost = 0;
					for (ShopCartItem item : (ArrayList<ShopCartItem>) session.getAttribute("cartitems")) {
						double cost = item.getQuantity() * item.getGame().getPrice();
						totalCost += cost;
				%>
				<tr>
					<td><%= item.getGame().getTitle() %></td>
					<td><%= String.format("$%.2f", item.getGame().getPrice()) %></td>
					<td style="text-align:right;"><%= item.getQuantity() %></td>
					<td style="text-align:right;"><%= String.format("$%.2f", cost) %></td>
				</tr>
				<% } %>
			</tbody>
			<tfoot>
				<tr>
					<td style="border-top-width: 2px"></td>
					<td style="border-top-width: 2px"></td>
					<td style="text-align:right;border-top-width: 2px"><strong>Total Cost:</strong></td>
					<td style="text-align:right;border-top-width: 2px"><strong><span id="priceTotal" class="large-bold-red"> <%=String.format("$%.2f",totalCost) %></span></strong></td>
				</tr>
			</tfoot>
		</table>
		</div>
		<div class="col-md-5" style="border: 1">
			<form class="form-horizontal ice-admin-login-form" method="post" action="PurchaseItems">
				<div class="form-group">
					<label for="inputName" class="col-sm-3 control-label">Name: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputName" placeholder="Name" required name="name" data-toggle="tooltip" data-placement="right" title="Maximum 45 alphanumberic and space characters" value="<%=user.getName() %>">
					</div>
				</div>
				<div class="form-group">
					<label for="inputAddr1" class="col-sm-3 control-label">Address 1: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputAddr1" placeholder="123 Main Street" required name="addr1" value="<%=user.getMailaddr()[0]%>">
					</div>
				</div>
				<div class="form-group">
					<label for="inputAddr2" class="col-sm-3 control-label">Address 2: </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputAddr2" placeholder="#12-345" required name="addr2" value="<%=user.getMailaddr()[1] %>">
					</div>
				</div>
				<div class="form-group">
					<label for="inputContact" class="col-sm-3 control-label">Contact: </label>
					<div class="col-sm-9">
						<input type="number" class="form-control" id="inputContact" placeholder="91234567" required name="contact" data-toggle="tooltip" data-placement="right" title="Must be 8 digits only" value=<%=user.getContact() %>>
					</div>
				</div>
				<div class="form-group">
					<label for="inputCreditCard" class="col-sm-3 control-label">Credit Card: </label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="inputCreditCard" placeholder="4628888888888888" required name="ccnumb" data-toggle="tooltip" data-placement="right" title="16 digits" autocomplete="cc-number" maxlength="16">
						</div>
						<div class="col-sm-3">
							<input type="password" class="form-control" id="CVV" placeholder="888" required name="CVV" data-toggle="tooltip" data-placement="right" title="Must be 3 digits" autocomplete="cc-csc" maxlength="3">
						</div>
				</div>
				<hr />
				<div class="form-group">
					<div class="col-sm-offset-3 col-sm-9">
						<button type="submit" class="btn btn-success" value="Purchase"><span class="glyphicon glyphicon-shopping-cart"></span> Purchase</button>
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
		matchesRegex($(this), /^\d{16}$/, $('#CVV'));
	});
	$('#CVV').on('change paste keyup', function(){
		matchesRegex($(this), /^\d{3}$/, null);
	});
	</script>
</body>
</html>