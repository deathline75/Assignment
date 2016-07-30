package com.ice;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ice.api.User;


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
		connectToMysql connection = new connectToMysql(MyConstants.url);
		HttpSession session = request.getSession();
		String gameid = request.getParameter("gameid");
		User user = (User) session.getAttribute("user");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		
		if (checkInput(request)) {
			ResultSet rs = connection.preparedQuery("SELECT * from game where gameid=? and qty>0", gameid);
			try {
				if (rs.next()) {
					for (int i = 0; i < quantity; i++) {
						connection.preparedUpdate("insert into shop_cart(gameid,userid) VALUES(?,?)", gameid, user.getId());
					}
				}
				response.sendRedirect("game.jsp?id=" + gameid);
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			connection.close();
			RequestDispatcher rd = request.getRequestDispatcher("game.jsp?id=" + gameid);
			rd.forward(request, response);
		}
	}

}
