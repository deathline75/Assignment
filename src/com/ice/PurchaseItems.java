package com.ice;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ice.api.ShopCartItem;
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
		// Update
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		if (user == null) {
			response.sendRedirect("login.jsp");
		}

		ArrayList<ShopCartItem> items = (ArrayList<ShopCartItem>) session.getAttribute("cartitems");
		CRUDCartItem dbitem = new CRUDCartItem();

		for (ShopCartItem item : items) {
			// Validate . see if the updated cart quantity(sum of quantity
			// regardless on what platform) can be lower than the game quantity.
			if (dbitem.getTotalQuantityAcrossPlatforms(user, item.getGame()) > item.getGame().getQuantity()) {
				request.setAttribute("error", item.getGame().getTitle() + " Purchase failed. Quantity not enough. ");
				RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");
				rd.forward(request, response);
				return;
			}
			request.setAttribute("error", item.getGame().getTitle() + " Purchase failed. Quantity not enough. ");
			RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");
			rd.forward(request, response);
			return;
		
			
			//Insert shits here
			

		}

	}

}
