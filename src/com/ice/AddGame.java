package com.ice;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class AddGame
 */
@WebServlet("/admin/AddGame")
@MultipartConfig
public class AddGame extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddGame() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	private boolean checkInput(HttpServletRequest request) {
		return request.getParameter("gameTitle") != null && !request.getParameter("gameTitle").isEmpty() && request.getParameter("company") != null 
				&& !request.getParameter("company").isEmpty() && request.getParameter("releaseDate") != null && !request.getParameter("releaseDate").isEmpty() 
				&& request.getParameter("price") != null && !request.getParameter("price").isEmpty() && request.getParameter("genre") != null && request.getParameterValues("genre") != null;
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getSession().getAttribute("username") == null)
			response.sendRedirect("login.jsp");
		else {
			int result = -2;
			if ((request.getParameter("continue") != null || request.getParameter("redirect") != null) && checkInput(request)) {
				
				String gameTitle = request.getParameter("gameTitle");
				String company = request.getParameter("company");
				String releaseDate = request.getParameter("releaseDate");
				String[] genres = request.getParameterValues("genre");
				String description = request.getParameter("description");
				String price = request.getParameter("price");
				String preOwned = request.getParameter("preOwned") == null ? "0" : "1";
				String supportWin = request.getParameter("supportWin") == null ? "0" : "1";
				String supportMac = request.getParameter("supportMac") == null ? "0" : "1";
				String supportXBOX = request.getParameter("supportXBOX") == null ? "0" : "1";
				String supportLinux = request.getParameter("supportLinux") == null ? "0" : "1";
				String supportPS4 = request.getParameter("supportPS4") == null ? "0" : "1";
				String supportWIIU = request.getParameter("supportWIIU") == null ? "0" : "1";
				Part gameThumbnail = request.getPart("gamethumbnail");
				Part gameJumbo = request.getPart("gamejumbo");
				Part gamePromo = request.getPart("gamepromo");
				
				connectToMysql connection = new connectToMysql(MyConstants.url);
				//connection.preparedUpdate("insert into game(gametitle) values(?),",gameTitle);
				result = connection.preparedUpdate(
						"insert into game(gametitle,company,releaseDate,description,price,preowned,supportWin,supportMac,supportXBOX,supportLinux,supportPS4,supportWIIU) values(?,?,?,?,?,?,?,?,?,?,?,?)",
						gameTitle, company, releaseDate, description, price, preOwned, supportWin, supportMac,
						supportXBOX, supportLinux, supportPS4, supportWIIU);

				connection.close();
				
				ResultSet rs = connection.preparedQuery("SELECT gameid FROM game WHERE gametitle=?", gameTitle);
				try {
					rs.last();					
					int gameid = rs.getInt(1);
					connection.close();
					
					for (String s: genres) {
						try {
							int genreid = Integer.parseInt(s);
							result = connection.preparedUpdate("INSERT INTO game_genre VALUES (?,?)", gameid, genreid);
							connection.close();
						} catch (NumberFormatException ex) {
							result = -1;
						}
						
						if (result <= 0)
							break;
					}
					
					if (result > 0) {
						if (gameThumbnail.getSize() > 0) {
							result = connection.preparedUpdate("INSERT INTO game_image VALUES (?,?,?)", gameid, 0, gameThumbnail.getInputStream());
							connection.close();
						}
						if (gameJumbo.getSize() > 0) {
							result = connection.preparedUpdate("INSERT INTO game_image VALUES (?,?,?)", gameid, 1, gameJumbo.getInputStream());
							connection.close();
						}
						if (gamePromo.getSize() > 0) {
							result = connection.preparedUpdate("INSERT INTO game_image VALUES (?,?,?)", gameid, 2, gamePromo.getInputStream());
							connection.close();
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			request.setAttribute("result", result);
			if (result > 0 && request.getParameter("redirect") != null) {
				response.sendRedirect("games.jsp");
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("addGame.jsp");
				rd.forward(request, response);
			}
		}
	}
}
