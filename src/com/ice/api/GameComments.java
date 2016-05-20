package com.ice.api;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
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
		// Configure GSON, which is JSON parser from Google
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		// Sets the encoding to UTF-8 because Java...
		response.setCharacterEncoding("UTF-8");
		// Starts the connection to MySQL
		connectToMysql connection = new connectToMysql(MyConstants.url);
		
		// Checks if parameters exist
		if (request.getParameter("q-gameid") != null) {
			String positionRows = request.getParameter("positionRows");
			String s = "limit " + positionRows + "," + 5;
			String query = "SELECT * FROM game_comment WHERE gameid=? order by date desc " + s;
			// Gets the data back from the query
			ResultSet rs = connection.preparedQuery(query, request.getParameter("q-gameid"));
			
			try {
				// Checks if the ResultSet is empty
				if (rs.isBeforeFirst()) {
					
					// Initialize the ArrayList for the GameComments coming in.
					List<GameComment> gamecomments = new ArrayList<GameComment>();
					while (rs.next()) {
						// Add the GameComments into the List
						gamecomments.add(new GameComment(rs.getInt(2), rs.getInt(1), rs.getString(3), rs.getShort(4),rs.getString(5),rs.getDate(6)));
					}	
					// Print out the data along with the response code.
					response.getWriter().append(gson.toJson(new SearchResult(0, null, gamecomments)));
				} else {
					// Prints appropriate response when empty
					response.getWriter().append(gson.toJson(new SearchResult(-1, "No results found.", null)));
				}
			} catch (SQLException e) {
				// Prints appropriate response when SQLException occurs
				response.getWriter().append(gson.toJson(new SearchResult(500, e.getMessage(), null)));
			}
			
			connection.close();
		} else {
			// Prints appropriate response when there is a lack of data to search for.
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
