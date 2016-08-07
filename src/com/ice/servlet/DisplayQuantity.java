package com.ice.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ice.api.Game;
import com.ice.crud.CRUDGame;

/**
 * Servlet implementation class DisplayQuantity
 */
@WebServlet("/admin/DisplayQuantity")
public class DisplayQuantity extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DisplayQuantity() {
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

	private boolean checkInput(HttpServletRequest request) {
		return request.getParameter("quantity") != null && !request.getParameter("quantity").isEmpty()
				&& request.getParameter("quantity").matches("^\\d+$")
				&& Integer.parseInt(request.getParameter("quantity")) > 0;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		CRUDGame dbGame = new CRUDGame();
		if(checkInput(request)){
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			ArrayList<Game> games = dbGame.getGamesWithinQuantity(quantity);
			session.setAttribute("stocks", games);
			dbGame.close();
			response.sendRedirect("stocks.jsp");
		}
		else{
			session.setAttribute("error","Please Input a valid value!");
			response.sendRedirect("stocks.jsp");
		}
	}

}
