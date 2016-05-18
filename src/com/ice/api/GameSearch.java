package com.ice.api;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
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
 * Servlet implementation class GameSearch
 */
@WebServlet("/GameSearch")
public class GameSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GameSearch() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Configure GSON, which is JSON parser from Google
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		// Sets the encoding to UTF-8 because Java...
		response.setCharacterEncoding("UTF-8");
		// Starts the connection to MySQL
		connectToMysql connection = new connectToMysql(MyConstants.url);		
		String sql = "SELECT * FROM game";
		
		String operator = "OR";
		
		if (request.getParameter("inclusive") != null) {
			if (Boolean.parseBoolean(request.getParameter("inclusive"))) {
				operator = "AND";
			}
		}
		
		// Executes the query and returns a ResultSet
		ResultSet rs = null;
		
		if (request.getParameterNames().hasMoreElements()) {
			
			sql += " WHERE";
			Enumeration<String> queries = request.getParameterNames();
			List<String> values = new ArrayList<String>();
			
			while (queries.hasMoreElements()) {
				String query = queries.nextElement();
				String value = request.getParameter(query);
				boolean addable = false;
				switch (query.toLowerCase()) {
				case "q-gameid":
					sql += " gameid=? " + operator;
					addable = true;
					break;
				case "q-gametitle":
					sql += " gametitle LIKE ? " + operator;
					value = "%" + value + "%";
					addable = true;
					break;
				case "q-company":
					sql += " company LIKE ? " + operator;
					value = "%" + value + "%";
					addable = true;
					break;
				case "q-genreid":
					String[] search = value.split(",");
					for (int i = 0; i < search.length; i++) {
						if (i + 1 == search.length)
							value = search[i];
						else 
							values.add(search[i]);
						query += " gameid IN (SELECT gameid FROM game_genre WHERE genreid=?) " + operator;
					}
					break;
				case "q-preowned":
					sql += " preOwned=? " + operator;
					addable = true;
					break;
				}
				if (addable)
					values.add(value);
			}
			
			sql = sql.substring(0, sql.length() - 2);
			rs = connection.preparedQuery(sql, values.toArray());
			
		} else {
			rs = connection.preparedQuery(sql);
		}

		
		try {
			if (rs.isBeforeFirst()) {
				
				List<Game> games = new ArrayList<Game>();
				
				while (rs.next()) {
					games.add(new Game(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14)));
				}
				// Writes out everything to screen along with the appropriate response code.
				response.getWriter().append(gson.toJson(new SearchResult(0, null, games)));
			} else {
				response.getWriter().append(gson.toJson(new SearchResult(-1, "No results found.", null)));
			}

		} catch (SQLException e) {
			response.getWriter().append(gson.toJson(new SearchResult(500, e.getMessage(), null)));
		}
		
		// Close the connection
		connection.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
