package com.ice;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ice.api.*;


/**
 * Servlet implementation class AddCartItem
 */
@WebServlet("/AddCartItem")
public class AddCartItem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCartItem() {
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

	private boolean checkInput(HttpServletRequest request) {
			return request.getParameter("gameid") != null && !request.getParameter("gameid").isEmpty();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String gameid = request.getParameter("gameid");
		User user = (User) session.getAttribute("user");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		String platform = request.getParameter("platforms");
		if (checkInput(request)) {
			
			ArrayList<ShopCartItem> shopCartItems = null;
			CRUDCartItem dbItem = new CRUDCartItem();
			
			// Check if the item on the same platform exist in shop cart already, if yes, update the quantity ONLY and return.
			if (session.getAttribute("cartitems") != null) {
				shopCartItems = (ArrayList<ShopCartItem>) session.getAttribute("cartitems");
				for (ShopCartItem it: shopCartItems) {
					if (it.getGame().getId() == Integer.parseInt(gameid) && it.getPlatform().equals(platform) && it.getUser().getId() == user.getId()) {
						it.setQuantity(it.getQuantity() + quantity);
						dbItem.updateItem(it);
						dbItem.close();
						response.sendRedirect("cart.jsp");
						return;
					}
				}
			}
			
			//Determine if the game has exist in the db, if yes, update quantity in the shopcart only!,if no, insert a new row in shop_cart
			CRUDGame dbGame = new CRUDGame();
			Game game = dbGame.getGame(Integer.parseInt(gameid));
			dbGame.close();
			
			ShopCartItem item = null;
			if (dbItem.isItem(user, game, platform)) {
				item = dbItem.getItem(user, game, platform);
				item.setQuantity(item.getQuantity() + quantity);
				dbItem.updateItem(item);
			} else {
				item = dbItem.insertItem(user, game, platform, quantity);
			}
			
			//If the shop cart is empty, create a shop cart arraylist and simply add the items in the arraylist if not empty just append to the existing arraylist!			
			if (session.getAttribute("cartitems") == null) {
				shopCartItems = new ArrayList<>();
				shopCartItems.add(item);
				session.setAttribute("cartitems", shopCartItems);
			} else {
				shopCartItems = (ArrayList<ShopCartItem>) session.getAttribute("cartitems");
				shopCartItems.add(item);
				session.setAttribute("cartitems", shopCartItems);
			}

			dbItem.close();
			response.sendRedirect("cart.jsp");
			
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("game.jsp?id=" + gameid);
			System.out.println("error sia kns cannot get rs.");
			rd.forward(request, response);
		}
	}

}
