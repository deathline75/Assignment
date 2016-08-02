package com.ice;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class EditGame
 */
@WebServlet("/admin/EditGame")
@MultipartConfig
public class EditGame extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditGame() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getSession().getAttribute("username") == null)
			response.sendRedirect("login.jsp");
		else {
			String gameid = request.getParameter("gameid");
			String gameTitle = request.getParameter("gameTitle");
			String company = request.getParameter("company");
			String releaseDate = request.getParameter("releaseDate");
			String[] genres = request.getParameterValues("genre");
			String description = request.getParameter("description");
			String price = request.getParameter("price");
			//Part imgLocation = request.getPart("imgLocation");
			String preOwned = request.getParameter("preOwned") == null ? "0" : "1";
			String supportWin = request.getParameter("supportWin") == null ? "0" : "1";
			String supportMac = request.getParameter("supportMac") == null ? "0" : "1";
			String supportXBOX = request.getParameter("supportXBOX") == null ? "0" : "1";
			String supportLinux = request.getParameter("supportLinux") == null ? "0" : "1";
			String supportPS4 = request.getParameter("supportPS4") == null ? "0" : "1";
			String supportWIIU = request.getParameter("supportWIIU") == null ? "0" : "1";
			String quantity = request.getParameter("quantity");
			Part gameThumbnail = request.getPart("gamethumbnail");
			Part gameJumbo = request.getPart("gamejumbo");
			Part gamePromo = request.getPart("gamepromo");

			connectToMysql connection = new connectToMysql(MyConstants.url);

			connection.preparedUpdate(
					"update game set gameTitle=?,company=?,releaseDate=?,description=?,price=?,preOwned=?,supportWin=?,supportMac=?,supportXBOX=?,supportLinux=?,supportPS4=?,supportWIIU=?,qty=? where gameid=?",gameTitle,company,releaseDate,description,price,preOwned,supportWin,supportMac,supportXBOX,supportLinux,supportPS4,supportWIIU,quantity,gameid);
			
			connection.preparedUpdate("delete from game_genre where gameid=?",gameid);
			
			for (String s: genres) {
				int genreid = Integer.parseInt(s);
				connection.preparedUpdate("INSERT INTO game_genre VALUES (?,?)", gameid, genreid);
			}
			
			if (gameThumbnail.getSize() > 0) {
				connection.preparedUpdate("delete from game_image where gameid=? and imageuse=0",gameid);
				connection.preparedUpdate("INSERT INTO game_image VALUES (?,?,?)", gameid, 0, gameThumbnail.getInputStream());
			}
			if (gameJumbo.getSize() > 0) {
				connection.preparedUpdate("delete from game_image where gameid=? and imageuse=1",gameid);
				connection.preparedUpdate("INSERT INTO game_image VALUES (?,?,?)", gameid, 1, gameJumbo.getInputStream());
			}
			if (gamePromo.getSize() > 0) {
				connection.preparedUpdate("delete from game_image where gameid=? and imageuse=2",gameid);
				connection.preparedUpdate("INSERT INTO game_image VALUES (?,?,?)", gameid, 2, gamePromo.getInputStream());
			}
			
			response.sendRedirect("games.jsp");
		}
	}
}
