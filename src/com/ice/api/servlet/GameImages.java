package com.ice.api.servlet;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URLConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ice.MyConstants;
import com.ice.api.GameImage;
import com.ice.api.SearchResult;
import com.ice.util.DatabaseConnect;

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
		// Configure GSON, which is JSON parser from Google
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		// Sets the encoding to UTF-8 because Java...
		response.setCharacterEncoding("UTF-8");
		// Starts the connection to MySQL
		DatabaseConnect connection = new DatabaseConnect(MyConstants.url);
		
		// Checks if parameters exist
		if (request.getParameter("q-gameid") != null && request.getParameter("q-imageuse") != null) {
			
			String query = "SELECT * FROM game_image WHERE gameid=? AND imageuse=?";
			// Returns the result set for the query
			ResultSet rs = connection.preparedQuery(query, request.getParameter("q-gameid"), request.getParameter("q-imageuse"));
			
			try {
				// Checks if the ResultSet is empty
				if (rs.isBeforeFirst()) {
					List<GameImage> gameimage = new ArrayList<GameImage>();
					
					// There may be more than 1 image
					while (rs.next()) {
						// Start of encoding image into Base64
						String b64encoded = null;
		    			byte[] imageIS = rs.getBytes(3);
		    			String mimeType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(imageIS));
		    			// Checks if the data is an image first
		    			if (mimeType.startsWith("image")) {
		    				b64encoded = DatatypeConverter.printBase64Binary(imageIS);
		    			}
		    			// If it is an image, add it to the list
		    			if (b64encoded != null)
		    				gameimage.add(new GameImage(rs.getInt(1), rs.getInt(2), mimeType, b64encoded));
					}
					
					// If the list is not empty, write out everything along with the appropriate response code
					if (!gameimage.isEmpty())
						response.getWriter().append(gson.toJson(new SearchResult(0, null, gameimage)));
					// Otherwise give the appropriate response code where no result is found
					else 
						response.getWriter().append(gson.toJson(new SearchResult(-1, "No results found.", null)));
					
				} else {
					// Give the appropriate response code where no result is found
					response.getWriter().append(gson.toJson(new SearchResult(-1, "No results found.", null)));
				}
			} catch (SQLException e) {
				// Give the appropriate response code when SQLException occurs
				response.getWriter().append(gson.toJson(new SearchResult(500, e.getMessage(), null)));
			}
			
			// Close the connection
			connection.close();
		} else {
			// Give the appropriate response code when the minimum input requirement is not met
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
