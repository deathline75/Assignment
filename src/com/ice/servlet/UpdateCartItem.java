package com.ice.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ice.api.ShopCartItem;
import com.ice.api.User;
import com.ice.crud.CRUDCartItem;

/**
 * Servlet implementation class UpdateCartItem
 */
@WebServlet("/UpdateCartItem")
public class UpdateCartItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartItem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(".");
		response.getWriter().append("You are not supposed to be here. Use POST to update data.").close();;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		User user = (User) session.getAttribute("user");
		if(user == null){
			response.sendRedirect("login.jsp");
		}

		ArrayList<ShopCartItem> items = (ArrayList<ShopCartItem>) session.getAttribute("cartitems");
		CRUDCartItem db = new CRUDCartItem();

		// Get every cart item in session
		for (ShopCartItem item: items) {
			
			// Input validation
			if (request.getParameter("qty-" + item.getShopcartID()) == null || request.getParameter("qty-" + item.getShopcartID()).isEmpty() || !request.getParameter("qty-" + item.getShopcartID()).matches("^\\d{0,8}$")) {
				
				session.setAttribute("error",item.getGame().getTitle() + ": Update cart failed because you entered an invalid number");
				response.sendRedirect("cart.jsp");
				return;
				
			} else {
				
				int quantityInCart = Integer.parseInt(request.getParameter("qty-" + item.getShopcartID()));
				
				// Check if the user inputed a value less than 1
				if (quantityInCart <= 0) {
					session.setAttribute("error",item.getGame().getTitle() + ": Update cart failed because you entered an invalid number");
					response.sendRedirect("cart.jsp");
					return;
				}
				
				// Check if the quantity for the game is more than what the user wants
				if (quantityInCart > (item.getGame().getQuantity())) {
					session.setAttribute("error", item.getGame().getTitle() + ": Update cart failed, because there's only " + item.getGame().getQuantity() + " in the stock ");
					response.sendRedirect("cart.jsp");
					return;
				}
				
				// Update the cart quantity accordingly
				item.setQuantity(quantityInCart);
				db.updateItem(item);
			}
		}
		
		// If the user presses update, don't redirect to purchase page.
		if (request.getParameter("action").equals("Update")) {
			session.setAttribute("success","Updated all the relevant quantities");
			response.sendRedirect("cart.jsp");
		}
		else {
			response.sendRedirect("purchase.jsp");
		}

	}

}
