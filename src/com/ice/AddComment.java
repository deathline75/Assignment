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

import org.apache.commons.lang3.StringEscapeUtils;
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
		return request.getParameter("gameid") != null && !request.getParameter("gameid").isEmpty()
				&& request.getParameter("rating") != null && !request.getParameter("rating").isEmpty()
				&& request.getParameter("comment") != null && !request.getParameter("comment").isEmpty()
				&& request.getParameter("author") != null && !request.getParameter("author").isEmpty();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// String commentId = request.getParameter("commentId");
		connectToMysql connection = new connectToMysql(MyConstants.url);
		String gameid = request.getParameter("gameid");
		String failed = null;
		if (request.getParameter("g-recaptcha-response") == "") {
			failed = "Retry your captcha.";
			System.out.println(failed);
		}

		if (VerifyUtils.verify(request.getParameter("g-recaptcha-response"))) {
			if (checkInput(request)) {
				ResultSet rs = connection.preparedQuery("SELECT gameid FROM game WHERE preowned=0 AND gameid=?",
						gameid);
				try {
					if (rs.next()) {
						String comment = StringEscapeUtils.escapeHtml4(request.getParameter("comment"));
						comment = Jsoup.clean(comment, Whitelist.none());
						String rating = request.getParameter("rating");
						String author = request.getParameter("author");
						author = Jsoup.clean(author, Whitelist.none());
						connection.preparedUpdate(
								"insert into game_comment(gameid,comment,rating,author,date) VALUES(?,?,?,?,now())",
								gameid, comment, rating, author);
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
		} else {
			failed = "Retry your captcha.";
			response.sendRedirect("game.jsp?id=" + gameid);
		}

	}

}