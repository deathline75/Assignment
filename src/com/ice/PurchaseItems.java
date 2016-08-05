package com.ice;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;

import com.ice.api.ShopCartItem;
import com.ice.api.Transaction;
import com.ice.api.User;

/**
 * Servlet implementation class PurchaseItems
 */
@WebServlet("/PurchaseItems")
public class PurchaseItems extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PurchaseItems() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		if (session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		User user = (User) session.getAttribute("user");
		
		
		if (request.getParameter("name") == null || request.getParameter("name").isEmpty()
				|| request.getParameter("ccnumb") == null || request.getParameter("ccnumb").isEmpty()
				|| request.getParameter("CVV") == null || request.getParameter("CVV").isEmpty() 
				|| request.getParameter("addr1") == null || request.getParameter("addr1").isEmpty()
				|| request.getParameter("addr2") == null || request.getParameter("addr2").isEmpty() 
				|| request.getParameter("contact") == null || request.getParameter("contact").isEmpty()) {
			session.setAttribute("error", "Please fill in all the fields.");
			response.sendRedirect("purcahse.jsp");
			return;
		}


		ArrayList<ShopCartItem> items = (ArrayList<ShopCartItem>) session.getAttribute("cartitems");
		CRUDTransaction dbPurchase = new CRUDTransaction();
		CRUDCartItem dbCart = new CRUDCartItem();  
		double totalCost = 0;
		for (ShopCartItem item : items) {
			
		
			//replace with regex.
			if(item.getQuantity() <= 0){
				session.setAttribute("error",item.getGame().getTitle() + " update cart failed you ented an invalid number");
				response.sendRedirect("cart.jsp");
				return;
			}
			
			// Validate . see if the updated cart quantity(sum of quantity
			// regardless on what platform) can be lower than the game quantity.
			if (item.getQuantity() > item.getGame().getQuantity()) {
				session.setAttribute("error", item.getGame().getTitle() + " Purchase failed. Quantity not enough. ");
				response.sendRedirect("cart.jsp");
				return;
			}
			
			totalCost += item.getQuantity() * item.getGame().getPrice();
			
		}
		
		java.util.Date date = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = sdf.format(date);
		
		
		//Get parameters here to dump into the database!
		
		String creditCardHolderName = StringEscapeUtils.escapeHtml4(request.getParameter("name"));
		long creditCardNumber = Long.parseLong(request.getParameter("ccnumb"));
		int creditCardCvv = Integer.parseInt(request.getParameter("CVV"));
		String mailaddr1 = StringEscapeUtils.escapeHtml4(request.getParameter("addr1"));
		String mailaddr2 = StringEscapeUtils.escapeHtml4(request.getParameter("addr2"));
		int contactNo = Integer.parseInt(request.getParameter("contact"));
		
		Transaction transaction = dbPurchase.insertTransaction(user, items, creditCardHolderName, creditCardNumber, creditCardCvv, mailaddr1, mailaddr2,currentTime,totalCost,contactNo);
		
		if(transaction == null){
			session.setAttribute("error", "Purchase Failed. Please try again later.");
			response.sendRedirect("purcahse.jsp");
			return;
		}
		
		//Delete CartItems here
		Iterator<ShopCartItem> i = items.iterator();
		while (i.hasNext()) {
		   ShopCartItem item = i.next();
		   i.remove();
		   dbCart.deleteItem(item.getShopcartID());
		}
		
		session.setAttribute("transaction", transaction);
		response.sendRedirect("completed.jsp");

	}

}
