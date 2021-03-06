package com.ice.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ice.MyConstants;
import com.ice.util.DatabaseConnect;

/**
 * Servlet implementation class DeleteGenre
 */
@WebServlet("/admin/DeleteGenre")
public class DeleteGenre extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteGenre() {
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
			String genreid = request.getParameter("genreid");
			DatabaseConnect connection  = new DatabaseConnect(MyConstants.url);
			ResultSet rs = connection.preparedQuery("SELECT * from game_genre where genreid=?", genreid);
			try {
				if (!rs.next()) {
					rs.close();
					connection.preparedUpdate("delete from genre where genreid=?", genreid);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			connection.close();
			response.sendRedirect("genres.jsp");
			
		}
	}

}
