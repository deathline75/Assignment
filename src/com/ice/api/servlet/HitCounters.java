package com.ice.api.servlet;

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
import com.ice.api.HitCounter;
import com.ice.api.SearchResult;
import com.ice.util.DatabaseConnect;

/**
 * Servlet implementation class HitCounters
 */
@WebServlet("/api/hitcounters")
public class HitCounters extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HitCounters() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		// Sets the encoding to UTF-8 because Java...
		response.setCharacterEncoding("UTF-8");
		// Starts the connection to MySQL
		DatabaseConnect connection = new DatabaseConnect(MyConstants.url);
		String sql2 = "select day,SUM(COUNT) Count from game_hitcounter gh,game g where gh.gameid = g.gameid group by day";
		String sql = "select gametitle,SUM(COUNT) Count from game_hitcounter gh,game g where gh.gameid = g.gameid group by g.gameid order by Count DESC";
		// Executes the query and returns a ResultSet
		ResultSet rs = null;
		
		if (request.getParameterNames().hasMoreElements()) {
			rs = connection.preparedQuery(sql2);
		}
		else{
			rs = connection.preparedQuery(sql);
		}
		
		
		try {
			if (rs.isBeforeFirst()) {
				List<HitCounter> hitcounters = new ArrayList<HitCounter>();
				while (rs.next()) {
					hitcounters.add(new HitCounter(rs.getString(1),rs.getInt(2)));
				}
				// Writes out everything to screen along with the appropriate response code.
				response.getWriter().append(gson.toJson(hitcounters));
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
