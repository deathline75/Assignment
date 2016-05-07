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
 * Servlet implementation class GameGenre
 */
@WebServlet("/api/gamegenre")
public class GameGenre extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GameGenre() {
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
		if (request.getParameter("q-genre") != null) {
			String[] search = request.getParameter("q-genre").split(",");
			String query = "SELECT * FROM game WHERE gameid IN (SELECT gameid FROM game_genre WHERE ";
			for (int i = 0; i < search.length; i++) {
				if (i + 1 == search.length)
					query += "genreid=?";
				else
					query += "genreid=? OR ";
			}
			query += ")";
			ResultSet rs = connection.preparedQuery(query, (Object[]) search);
			
			try {
				if (rs.isBeforeFirst()) {
					List<Game> games = new ArrayList<Game>();
					while (rs.next()) {
						games.add(new Game(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14)));
					}				
					response.getWriter().append(gson.toJson(new SearchResult(0, null, games)));
				} else {
					response.getWriter().append(gson.toJson(new SearchResult(-1, "No results found.", null)));
				}
			} catch (SQLException e) {
				response.getWriter().append(gson.toJson(new SearchResult(500, e.getMessage(), null)));
			}
			
			connection.close();
		} else {
			response.getWriter().append(gson.toJson(new SearchResult(100, "No genre id or game id to search for!", null)));
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
