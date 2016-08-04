<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ice.*, com.ice.api.*,java.sql.*, java.util.*"%>
<%
	connectToMysql connection = new connectToMysql(MyConstants.url);
%>
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
<title>| SP Games Store</title>
</head>
<body>
	<div class="container main-content">
		<%@ include file="navbar.jsp"%>
		<%if(request.getAttribute("error")!=null){
			System.out.println("hello!!");
			%>
		<div class="panel panel-default">
    		<div class="panel-heading">Error</div>
    		<div class="panel-body"><%=request.getAttribute("error") %></div>
		</div>
		<% }%>
		
		<%
			if(user == null){
			response.sendRedirect("login.jsp");
		} %>
			
			
		<form action="UpdateCartItem" method="post">
		<table id="cartTable" class="cart table table-condensed">
			<thead>
				<tr>
					<th><label><input class="check-all check" type="checkbox" />Select All</label></th>
					<th><label>Game</label></th>
					<th><label>Price</label></th>
					<th><label>Quantity</label></th>
					<th><label>Platform</label></th>
					<th><label>Operation</label></th>
				</tr>
			</thead>
			<tbody>
				<%

				double total = 0;
			if (session.getAttribute("cartitems") != null) {
				for (ShopCartItem it : (ArrayList<ShopCartItem>) session.getAttribute("cartitems")) {
					total += it.getQuantity() * it.getGame().getPrice();
					/* System.out.println(it.getGame().getTitle() + ": " + it.getQuantity()); */
				%>
				<tr>
					<td><input class="check-one check" type="checkbox" name="shopCartId" value="<%=it.getShopcartID() %>" /></td>
					<td class="goods"><label><%= it.getGame().getTitle()%></label></td>
					<td class="number small-bold-red"><span><%= String.format("$%.2f",it.getGame().getPrice())%></span></td>
					<td class="input-group"><span class="input-group-addon minus">-</span>
						<input type="number" class="number form-control input-sm qty" id="qty-<%=it.getShopcartID()%>" name="qty-<%=it.getShopcartID()%>" value="<%=it.getQuantity() %>" >
						<div class="input-group-btn">
        					<button class="btn btn-default" type="button" onclick="changeQty(1,'#qty-<%=it.getShopcartID()%>')"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;</button>
      					</div>
						
					</td>
						<td class="platforms"><label><%= it.getPlatform()%></label></td>
					<td class="subtotal number small-bold-red">101</td>
						<td class="operation">
							<form action="DeleteCartItem" method="post">
							<input type="hidden" name="shopCartId" value="<%=it.getShopcartID()%>">
							<input type="submit" class="delete btn btn-xs btn-primary" value="Delete">
							</form>
						</td>
				</tr>
				<%
				}
			}
		%>
		<input type="submit" value="Update" name="action">
		<input type="submit" value="Purchase" name="action">
			</tbody>
		</table>
			</form>
		<div class="row">
			<div class="col-md-12 col-lg-12 col-sm-12">
				<div style="border-top: 1px solid gray; padding: 4px 10px;">
					<div style="margin-left: 20px;" class="pull-right total">
						<label>Total:<span class="currency">$</span><span
							id="priceTotal" class="large-bold-red"> <%=String.format("%.2f",total) %></span></label>
					</div>
					<div class="pull-right selected" id="selected">
						<span id="selectedTotal"></span>
					</div>
					<a href="purchase.jsp" class="btn btn-success">Checkout</a>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>