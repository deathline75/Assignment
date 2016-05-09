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
 * Servlet implementation class Genres
 */
@WebServlet("/api/genres")
public class Genres extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Genres() {
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
		String sql = "SELECT * FROM genre";
		// Executes the query and returns the result set
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
				case "q-genreid": 
					sql += " genreid=? OR";
					addable = true;
					break;
				case "q-name":
					sql += " genrename LIKE ? OR";
					value = "%" + value + "%";
					addable = true;
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
				List<Genre> genres = new ArrayList<Genre>();
				while (rs.next()) {
					// Adds all the results into the list
					genres.add(new Genre(rs.getInt(1), rs.getString(2)));
				}
				// Writes out all the data along with the appropriate response code
				response.getWriter().append(gson.toJson(new SearchResult(0, null, genres)));
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
