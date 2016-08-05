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

/**
 * Servlet implementation class DeleteCartItem
 */
@WebServlet("/DeleteCartItem")
public class DeleteCartItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCartItem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(".");
		response.getWriter().append("You are not supposed to be here. Use POST to send data to this page.").close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		HttpSession session = request.getSession();
		if (request.getParameter("shopCartId") == null || request.getParameter("shopCartId").isEmpty() || !request.getParameter("shopCartId").matches("^\\d+$")) {
			session.setAttribute("error", "Failed to delete Shop Cart Item. Try again later.");
			response.sendRedirect("cart.jsp");
			return;
		} 
		
		int cartid = Integer.parseInt(request.getParameter("shopCartId"));
		CRUDCartItem db = new CRUDCartItem();
		ArrayList<ShopCartItem> items = (ArrayList<ShopCartItem>) session.getAttribute("cartitems");
		
		if(!db.deleteItem(cartid)){
			request.setAttribute("error", "Delete failed. No rows deleted");
			response.sendRedirect("cart.jsp");
			return;
		}
		
		db.close();
		
		for(ShopCartItem item : items){
			if(item.getShopcartID() == cartid){
				session.setAttribute("success", "Deleted: " + item.getGame().getTitle());
				items.remove(item);
				break;
			}
		}
		
		response.sendRedirect("cart.jsp");
	}

}
