<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ice.*, com.ice.api.*,java.sql.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<script>
	function changeQty(amount,inputid) {
		if (isNaN(parseInt($(inputid).val())) || (parseInt($(inputid).val()) <= 0 && amount <= 0) || parseInt($(inputid).val()) < 0)
			$(inputid).val(0)
		else
			$(inputid).val(parseInt($(inputid).val()) + amount);
	}
	</script>
<%@ include file="head.html"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cart | SP Games Store</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container main-content">
		<%	if (session.getAttribute("error") != null) {%>
			<div class="alert alert-danger" role="alert">
				<strong>Error!</strong> <%= session.getAttribute("error") %>
			</div>
		<%	session.removeAttribute("error");} %>
		<%	if (session.getAttribute("success") != null) {%>
			<div class="alert alert-success" role="alert">
				<strong>Success!</strong> <%= session.getAttribute("success") %>
			</div>
		<%		session.removeAttribute("success");
			} 
			if (user == null) {
				response.sendRedirect(".");
				return;
			}
		%>
		<div class="page-header ice-header">
			<h1>Your Cart</h1>
		</div>
		<% if (session.getAttribute("cartitems") != null && !((ArrayList<ShopCartItem>) session.getAttribute("cartitems")).isEmpty()) { %>
		<form action="DeleteCartItem" method="post" id="deleteCartItem">
		</form>
		<form action="UpdateCartItem" method="post">
			<table id="cartTable" class="cart table" style="vertical-align: middle;">
				<thead>
					<tr>
						<!-- <th><input class="check-all check" type="checkbox" /></th> -->
						<th>Actions</th>
						<th>Game</th>
						<th>Platform</th>
						<th>Price</th>
						<th style="width: 150px">Quantity</th>
						<th  style="text-align:right">Total</th>
					</tr>
				</thead>
				<tbody>
					<%
					double total = 0;
						for (ShopCartItem it : (ArrayList<ShopCartItem>) session.getAttribute("cartitems")) {
							total += it.getQuantity() * it.getGame().getPrice();
							/* System.out.println(it.getGame().getTitle() + ": " + it.getQuantity()); */
					%>
					<tr>
						<%-- <td><input class="check-one check" type="checkbox" name="shopCartId" value="<%=it.getShopcartID() %>" /></td> --%>
						<td class="operation">
							<button type="submit" name="shopCartId" form="deleteCartItem" class="delete btn btn-sm btn-danger" value="<%=it.getShopcartID()%>"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> Delete</button>
						</td>
						<td class="goods"><%= it.getGame().getTitle()%></td>
						<td class="platforms">
								<% if (it.getPlatform().equals("win")) { %>
									Windows
								<% } else if (it.getPlatform().equals("mac")) {%>
									OS X
								<% } else if (it.getPlatform().equals("linux")) {%>
									Linux
								<% } else if (it.getPlatform().equals("xbox")) {%>
									Xbox One
								<% } else if (it.getPlatform().equals("ps4")) {%>
									PS4
								<% } else if (it.getPlatform().equals("wiiu")) {%>
									Wii-U
								<% } %>
						</td>
						<td class="number"><span><%= String.format("$%.2f",it.getGame().getPrice())%></span></td>
						<td>
							<div class="input-group">
								<div class="input-group-btn">
	        						<button class="btn btn-sm btn-default" type="button" onclick="changeQty(-1,'#qty-<%=it.getShopcartID()%>')"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span>&nbsp;</button>
	      						</div>
								<input type="number" class="number form-control input-sm qty" id="qty-<%=it.getShopcartID()%>" name="qty-<%=it.getShopcartID()%>" value="<%=it.getQuantity() %>" >
								<div class="input-group-btn">
        							<button class="btn btn-sm btn-default" type="button" onclick="changeQty(1,'#qty-<%=it.getShopcartID()%>')"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;</button>
      							</div>
							</div>
						</td>
						<td class="subtotal" style="text-align:right">
							<%= String.format("$%.2f", it.getGame().getPrice() * it.getQuantity()) %>
						</td>
					</tr>
					<%	} %>
				</tbody>
				<tfoot>
					<tr>
						<td style="border-top-width: 2px"></td>
						<td style="border-top-width: 2px"></td>
						<td style="border-top-width: 2px"></td>
						<td style="border-top-width: 2px"></td>
						<td style="text-align:right;border-top-width: 2px">Total Cost:</td>
						<td style="text-align:right;border-top-width: 2px"><strong><span id="priceTotal" class="large-bold-red"> <%=String.format("$%.2f",total) %></span></strong></td>
					</tr>
				</tfoot>
			</table>
		
			<div class="pull-right">
				<button class="btn btn-default" type="submit" value="Update" name="action">Update</button>
				<button class="btn btn-success" type="submit" value="Purchase" name="action"><span class="glyphicon glyphicon-shopping-cart"></span> Checkout</button>
			</div>
		</form>
		<% } else { %>
		<p>Your cart is empty!</p>
		<% } %>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>