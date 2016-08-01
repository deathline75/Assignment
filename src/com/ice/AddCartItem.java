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
		String platform = request.getParameter("platforms");
		if (checkInput(request)) {
			ResultSet rs = connection.preparedQuery("SELECT * from game where gameid=? and qty>0", gameid);
		//	ResultSet rs = connection.preparedQuery("select platform from shop_cart where userid=? and gameid=? and platform='?'", user.getId(),gameid,platform);
			try {
				if (rs.next()) {
					rs = connection.preparedQuery("select platform from shop_cart where userid=? and gameid=?", user.getId(),gameid);
					if(rs.next()){
						connection.preparedUpdate("update shop_cart set quantity=quantity+? where userid=? and gameid=? and platform=?",quantity,user.getId(),gameid,platform);
					}
					else{
						connection.preparedUpdate("insert into shop_cart(gameid,userid,platform,quantity) VALUES(?,?,?,?)", gameid, user.getId(),platform,quantity);
					}
				}
/*				else{
					connection.preparedUpdate("insert into shop_cart(gameid,userid,platform,quantity) VALUES(?,?,?,?)", gameid, user.getId(),platform,quantity);
				}*/
				response.sendRedirect("game.jsp?id=" + gameid);
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			connection.close();
			RequestDispatcher rd = request.getRequestDispatcher("game.jsp?id=" + gameid);
			System.out.println("error sia kns cannot get rs.");
			rd.forward(request, response);
		}
	}

}
