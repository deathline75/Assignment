<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ice.*, com.ice.api.*,java.sql.*, java.util.*"%>
<%
	connectToMysql connection = new connectToMysql(MyConstants.url);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="head.html"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>| SP Games Store</title>
</head>
<body>
	<div class="container main-content">
		<%@ include file="navbar.jsp"%>
		<%			
			if (session.getAttribute("cartitems") != null) {
				System.out.println("----");
				for (ShopCartItem it : (ArrayList<ShopCartItem>) session.getAttribute("cartitems")) {
					System.out.println(it.getGame().getTitle() + ": " + it.getQuantity());
				}
			}
		%>
		<table id="cartTable" class="cart table table-condensed">
			<thead>
				<tr>
					<th><label><input class="check-all check"
							type="checkbox" />Select All</label></th>
					<th><label>Game</label></th>
					<th><label>Price</label></th>
					<th><label>Quantity</label></th>
					<th><label>Sub-Total</label></th>
					<th><label>Operation</label></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input class="check-one check" type="checkbox" /></td>
					<td class="goods"><label>Title</label></td>
					<td class="number small-bold-red"><span>$$$wo yao qiannn duo shao qiannn</span></td>
					<td class="input-group"><span class="input-group-addon minus">-</span>
						<input type="text" class="number form-control input-sm" value="10" />
						<span class="input-group-addon plus">+</span></td>
					<td class="subtotal number small-bold-red">101</td>
					<td class="operation"><span
						class="delete btn btn-xs btn-primary">Delete</span></td>
				</tr>
			</tbody>
		</table>
		<div class="row">
			<div class="col-md-12 col-lg-12 col-sm-12">
				<div style="border-top: 1px solid gray; padding: 4px 10px;">
					<div style="margin-left: 20px;" class="pull-right total">
						<label>Total:<span class="currency">$</span><span
							id="priceTotal" class="large-bold-red">0.00</span></label>
					</div>
					<div class="pull-right">
						<label>Selected<span id="itemCount" class="large-bold-red"
							style="margin: 0 4px;"></span>x Items .Total<span id="qtyCount"
							class="large-bold-red" style="margin: 0 4px;"></span> x Games
						</label>
					</div>
					<div class="pull-right selected" id="selected">
						<span id="selectedTotal"></span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>