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

/**
 * Servlet implementation class AddGenre
 */
@WebServlet("/admin/AddGenre")
public class AddGenre extends HttpServlet {
       
    /**
	 * 
	 */
	private static final long serialVersionUID = -6862032968691196423L;

	/**
     * @see HttpServlet#HttpServlet()
     */
    public AddGenre() {
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
		if (request.getSession().getAttribute("username") == null)
			response.sendRedirect("login.jsp");
		else {
			int result = -10;
			String genreTitle = request.getParameter("genreTitle");
			
			if (genreTitle.isEmpty()) {
				result = -2;
			} else {
				connectToMysql connection = new connectToMysql(MyConstants.url);
				ResultSet rs = connection.preparedQuery("SELECT genreid FROM genre WHERE genrename=?", genreTitle);
				try {
					if (rs.next()) {
						result = -3;
					} else {
						rs.close();
					 	result = connection.preparedUpdate("insert into genre(genrename) values(?)", genreTitle);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					connection.close();	
				}
			}
			
			request.setAttribute("result", result);
			RequestDispatcher rd = request.getRequestDispatcher("genres.jsp");
			rd.forward(request, response);
		}
	}

}
