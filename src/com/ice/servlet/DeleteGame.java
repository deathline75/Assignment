package com.ice.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ice.MyConstants;
import com.ice.util.DatabaseConnect;

/**
 * Servlet implementation class DeleteGame
 */
@WebServlet("/admin/DeleteGame")
public class DeleteGame extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteGame() {
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
		if (request.getSession().getAttribute("username") == null)
			response.sendRedirect("login.jsp");
		else {
			String gameid = request.getParameter("gameid");
			
			DatabaseConnect connection = new DatabaseConnect(MyConstants.url);
			connection.preparedUpdate("delete from game_image where gameid=?",gameid);
			connection.preparedUpdate("delete from game_genre where gameid=?",gameid);
			connection.preparedUpdate("delete from game where gameid=?",gameid);
			
			connection.close();
			
			response.sendRedirect("games.jsp");
			
		}
	}

}
