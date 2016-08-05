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
 * Servlet implementation class EditGenre
 */
@WebServlet("/admin/EditGenre")
public class EditGenre extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditGenre() {
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
			String genrename = request.getParameter("genrename");
			DatabaseConnect connection  = new DatabaseConnect(MyConstants.url);
			connection.preparedUpdate("update genre set genrename=? where genreid=?", genrename,genreid);
			connection.close();
			//response.sendRedirect("genres.jsp");
			
		}
	}

}
