package com.ice;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jsoup.*;
import org.jsoup.safety.Whitelist;

/**
 * Servlet implementation class AddComment
 */
@WebServlet("/AddComment")
public class AddComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddComment() {
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
			//String commentId = request.getParameter("commentId");
			String gameid = request.getParameter("gameid");
			String comment = request.getParameter("comment");
			comment = Jsoup.clean(comment, Whitelist.basic());
			String rating = request.getParameter("rating");
			String author = request.getParameter("author");
			author = Jsoup.clean(author, Whitelist.basic());
			connectToMysql connection  = new connectToMysql(MyConstants.url);
			connection.preparedUpdate("insert into game_comment(gameid,comment,rating,author) VALUES(?,?,?,?)",gameid, comment,rating,author);
			connection.close();
			response.sendRedirect("comment.jsp");
			

	}
	}

