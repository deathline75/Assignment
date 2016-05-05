package com.ice;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
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
			String genrename = request.getParameter("genrename");
			connectToMysql connection  = new connectToMysql(MyConstants.url);
			connection.preparedUpdate("update game_genre set genreid=?,genrename=? where genreid=?", genreid,genreid,genrename);
			connection.close();
			connection.preparedUpdate("update genre set genreid=?,genrename=? where genreid=?", genreid,genreid,genrename);
			connection.close();
			response.sendRedirect("genres.jsp");
			
		}
	}

}
