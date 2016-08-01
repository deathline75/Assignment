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
 * Servlet implementation class Games
 */
@WebServlet("/api/games")
public class Games extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Games() {
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
		
		// Executes the query and returns a ResultSet
		ResultSet rs = null;
		
		if (request.getParameterNames().hasMoreElements()) {
			
			sql += " WHERE";
			Enumeration<String> queries = request.getParameterNames();
			List<Object> values = new ArrayList<Object>();
			
			while (queries.hasMoreElements()) {
				String query = queries.nextElement();
				String value = request.getParameter(query);
				boolean addable = false;
				switch (query.toLowerCase()) {
				case "q-gameid":
					sql += " gameid=? OR";
					addable = true;
					break;
				case "q-gametitle":
					sql += " gametitle LIKE ? OR";
					value = "%" + value + "%";
					addable = true;
					break;
				case "q-company":
					sql += " company LIKE ? OR";
					value = "%" + value + "%";
					addable = true;
					break;
				case "q-releasedate":
					sql += " releaseDate=? OR";
					addable = true;
					break;
				case "q-price":
					sql += " price=? OR";
					addable = true;
					break;
				case "q-price-lt":
					sql += " price<? OR";
					addable = true;
					break;
				case "q-price-le":
					sql += " price<=? OR";
					addable = true;
					break;
				case "q-price-mt":
					sql += " price>? OR";
					addable = true;
					break;
				case "q-price-me":
					sql += " price>=? OR";
					addable = true;
					break;
				case "q-preowned":
					sql += " preOwned=? OR";
					addable = true;
					break;
				case "q-support-win":
					sql += " supportWin=? OR";
					addable = true;
					break;
				case "q-support-mac":
					sql += " supportMac=? OR";
					addable = true;
					break;
				case "q-support-xbox":
					sql += " supportXbox=? OR";
					addable = true;
					break;
				case "q-support-linux":
					sql += " supportLinux=? OR";
					addable = true;
					break;
				case "q-support-ps4":
					sql += " supportPs4=? OR";
					addable = true;
					break;
				case "q-support-wiiu":
					sql += " supportWiiu=? OR";
					addable = true;
					break;
				case "q-quantity":
					sql += " quantity=? OR";
					addable = true;
					break;
				}
				if (addable)
					values.add(value);
			}
			
			if (sql.endsWith("WHERE"))
				sql = sql.substring(0, sql.length() - 5);
			else
				sql = sql.substring(0, sql.length() - 3);
			
			if (request.getParameter("limit") != null) {
				try {
					int limit = Integer.parseInt(request.getParameter("limit"));
					if (limit > 0) {
						sql += " LIMIT ?";
						values.add(limit);
						if (request.getParameter("limit-offset") != null) {
							int limitOffset = Integer.parseInt(request.getParameter("limit"));
							if (limitOffset > 0) {
								sql += ",?";
								values.add(limitOffset);
							}
						}
					}
				} catch (NumberFormatException ex) {}
			}
			
			rs = connection.preparedQuery(sql, values.toArray());
			
		} else {
			rs = connection.preparedQuery(sql);
		}

		
		try {
			if (rs.isBeforeFirst()) {
				
				List<Game> games = new ArrayList<Game>();
				
				while (rs.next()) {
					games.add(new Game(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14),rs.getInt(15)));
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

