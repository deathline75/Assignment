package com.ice.api;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ice.MyConstants;
import com.ice.connectToMysql;

/**
 * Servlet implementation class GameComments
 */
@WebServlet("/api/gamecomments")
public class GameComments extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GameComments() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setCharacterEncoding("UTF-8");
		connectToMysql connection = new connectToMysql(MyConstants.url);
		if (request.getParameter("q-gameid") != null) {
			String query = "SELECT * FROM game_comment WHERE gameid=?";
			ResultSet rs = connection.preparedQuery(query, request.getParameter("q-gameid"));
			
			try {
				if (rs.isBeforeFirst()) {
					List<GameComment> gamecomments = new ArrayList<GameComment>();
					while (rs.next()) {
						gamecomments.add(new GameComment(rs.getInt(2), rs.getInt(1), rs.getString(3), rs.getShort(4),rs.getString(5)));
					}				
					response.getWriter().append(gson.toJson(new SearchResult(0, null, gamecomments)));
				} else {
					response.getWriter().append(gson.toJson(new SearchResult(-1, "No results found.", null)));
				}
			} catch (SQLException e) {
				response.getWriter().append(gson.toJson(new SearchResult(500, e.getMessage(), null)));
			}
			
			connection.close();
		} else {
			response.getWriter().append(gson.toJson(new SearchResult(100, "No game id to search for!", null)));
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
