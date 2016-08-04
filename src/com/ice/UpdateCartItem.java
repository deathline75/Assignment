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
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
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

		
		for (ShopCartItem item: items) {
				int quantityInCart = Integer.parseInt(request.getParameter("qty-" + item.getShopcartID()));
				
				//replace with regex.
				if(quantityInCart <= 0){
					request.setAttribute("error",item.getGame().getTitle() + " update cart failed you ented an invalid number");
					RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");  
					rd.forward(request,response);
					return;
				}
				
				if(quantityInCart > (item.getGame().getQuantity())){
					request.setAttribute("error",item.getGame().getTitle() + " update cart failed, because there's only " + item.getGame().getQuantity() + "in the stock ");
					RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");  
					rd.forward(request,response);
					return;
				}
				item.setQuantity(quantityInCart);
				db.updateItem(item);

		}
		if(request.getParameter("action").equals("Update")){
			response.sendRedirect("cart.jsp");
		}
		else{
			response.sendRedirect("purchase.jsp");
		}

	}

}
