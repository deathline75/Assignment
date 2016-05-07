package com.ice.api;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URLConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
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
 * Servlet implementation class GameImage
 */
@WebServlet("/api/gameimages")
public class GameImages extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GameImages() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setCharacterEncoding("UTF-8");
		connectToMysql connection = new connectToMysql(MyConstants.url);
		if (request.getParameter("q-gameid") != null && request.getParameter("q-imageuse") != null) {
			String query = "SELECT * FROM game_image WHERE gameid=? AND imageuse=?";
			ResultSet rs = connection.preparedQuery(query, request.getParameter("q-gameid"), request.getParameter("q-imageuse"));
			
			try {
				if (rs.isBeforeFirst()) {
					List<GameImage> gameimage = new ArrayList<GameImage>();
					while (rs.next()) {
						String b64encoded = null;
		    			byte[] imageIS = rs.getBytes(3);
		    			String mimeType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(imageIS));
		    			if (mimeType.startsWith("image")) {
		    				b64encoded = new String(Base64.getEncoder().encode(imageIS), "UTF-8");
		    			}
		    			if (b64encoded != null)
		    				gameimage.add(new GameImage(rs.getInt(1), rs.getInt(2), mimeType, b64encoded));
					}
					if (!gameimage.isEmpty())
						response.getWriter().append(gson.toJson(new SearchResult(0, null, gameimage)));
					else 
						response.getWriter().append(gson.toJson(new SearchResult(-1, "No results found.", null)));
					
				} else {
					response.getWriter().append(gson.toJson(new SearchResult(-1, "No results found.", null)));
				}
			} catch (SQLException e) {
				response.getWriter().append(gson.toJson(new SearchResult(500, e.getMessage(), null)));
			}
			
			connection.close();
		} else {
			response.getWriter().append(gson.toJson(new SearchResult(100, "No game id or image use to search for!", null)));
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
