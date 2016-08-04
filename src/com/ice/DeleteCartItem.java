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
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		int cartid = Integer.parseInt(request.getParameter("shopCartId"));
		CRUDCartItem db = new CRUDCartItem();
		HttpSession session = request.getSession();
		ArrayList<ShopCartItem> items = (ArrayList<ShopCartItem>) session.getAttribute("cartitems");
		
		if(db.deleteItem(cartid) != true){
			request.setAttribute("error", "Delete failed. No rows deleted");
			response.sendRedirect("cart.jsp");
			return;
		}
		
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
