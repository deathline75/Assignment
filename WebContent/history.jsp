<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.ice.*, com.ice.api.*, com.ice.api.Transaction.*, java.sql.*, java.util.*, java.net.*, java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.html"%>
<title>History | SP Games Store</title>
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
			<h1>Purchase History</h1>
		</div>

		<%
		
		CRUDTransaction dbTransaction = new CRUDTransaction();
		ArrayList<Transaction> transactions = dbTransaction.getTransactions(user);
		Collections.reverse(transactions);
		dbTransaction.close();
		
		if (!transactions.isEmpty()) {
			for (Transaction transaction: transactions) {
		%>
		
		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  			<div class="panel panel-default">
    			<div class="panel-heading" role="tab" id="heading-<%= transaction.getTransactionid()%>">
      				<h4 class="panel-title">
        				<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse-<%= transaction.getTransactionid()%>" aria-expanded="false" aria-controls="collapse-<%= transaction.getTransactionid()%>">
          					Purchase Date: <%= transaction.getDate() %>
        				</a>
      				</h4>
    			</div>
    			<div id="collapse-<%= transaction.getTransactionid()%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
      				<div class="panel-body">
      					<div class="col-md-6">
      						<dl class="dl-horizontal">
								<dt>Transaction ID:</dt>
								<dd><%= String.format("%012d", transaction.getTransactionid()) %></dd>
								<dt>Name: </dt>
								<dd><%= transaction.getCreditCardHolder() %></dd>
								<dt>Address 1: </dt>
								<dd><%= transaction.getMailaddr()[0] %></dd>
							</dl>
      					</div>
      					<div class="col-md-6">
      						<dl class="dl-horizontal">
								<dt>Transaction Date:</dt>
								<dd><%= transaction.getDate() %></dd>
								<dt>Contact: </dt>
								<dd><%= transaction.getContact() %></dd>
								<dt>Address 2: </dt>
								<dd><%= transaction.getMailaddr()[1] %></dd>
      						</dl>
      					</div>
      				</div>
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
		</div>
		
		<% 	} %>
		<% } else { %>
		
		<p>You have not bought anything yet! :(</p>
		
		<% } %>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>