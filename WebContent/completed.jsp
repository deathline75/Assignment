<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,com.ice.api.Transaction.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>Purchase Complete | SP Games Store</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<%
		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		if (session.getAttribute("transaction") == null) {
			response.sendRedirect("cart.jsp");
			return;
		}
		Transaction transaction = (Transaction) session.getAttribute("transaction");
		session.removeAttribute("transaction");
	%>
	
<div class="container main-content">
	<div class="page-header ice-header">
		<h1>
			Purchase completed! <small>Here are your transaction details</small>
		</h1>
	</div>
	
	<div class="row">
		<div class="col-md-4" style="padding-left:0">
			<dl class="dl-horizontal">
				<dt>Transaction ID:</dt>
				<dd><%= String.format("%012d", transaction.getTransactionid()) %></dd>
				<dt>Transaction Date:</dt>
				<dd><%= transaction.getDate() %></dd>
				<dt>Name: </dt>
				<dd><%= transaction.getCreditCardHolder() %></dd>
				<dt>Address 1: </dt>
				<dd><%= transaction.getMailaddr()[0] %></dd>
				<dt>Address 2: </dt>
				<dd><%= transaction.getMailaddr()[1] %></dd>
				<dt>Contact: </dt>
				<dd><%= transaction.getContact() %></dd>
			</dl>
		</div>
		<div class="col-md-8">		
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
						for (TransactionDetail item : transaction.getItems()) {
							double cost = item.getQuantity() * item.getGame().getPrice();
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
						<td style="text-align:right;border-top-width: 2px"><strong><span id="priceTotal" class="large-bold-red"> <%=String.format("$%.2f",transaction.getTotalCost()) %></span></strong></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	
	<hr/>
	
	<a class="btn btn-default" href="history.jsp" role="button">Purchase History</a>
	<a class="btn btn-primary" href="." role="button">Back to Index</a>
			
</div>
	<%@ include file="footer.html"%>
</body>
</html>