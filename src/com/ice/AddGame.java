package com.ice;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;

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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = -10;
		if (request.getParameter("continue") != null || request.getParameter("redirect") != null) {
			String gameTitle = request.getParameter("gameTitle");
			String company = request.getParameter("company");
			String releaseDate = request.getParameter("releaseDate");
			String description = request.getParameter("description");
			String price = request.getParameter("price");
			Part imgLocation = request.getPart("imgLocation");
			
			String preOwned = request.getParameter("preOwned");
			if (preOwned != null) {
				//out.println("Clicked");
				preOwned = "1";
			} else {
				preOwned = "0";
				//out.println("Not clicked");
			}
			String supportWin = request.getParameter("supportWin");
			if (supportWin != null) {
				//out.println("Clicked");
				supportWin = "1";
			} else {
				supportWin = "0";
				//out.println("Not clicked");
			}
			String supportMac = request.getParameter("supportMac");
			if (supportMac != null) {
				//out.println("Clicked");
				supportMac = "1";
			} else {
				supportMac = "0";
				//out.println("Not clicked");
			}
			String supportXBOX = request.getParameter("supportXBOX");
			if (supportXBOX != null) {
				//out.println("Clicked");
				supportXBOX = "1";
			} else {
				supportXBOX = "0";
				//out.println("Not clicked");
			}
			String supportLinux = request.getParameter("supportLinux");
			if (supportLinux != null) {
				//out.println("Clicked");
				supportLinux = "1";
			} else {
				supportLinux = "0";
				//out.println("Not clicked");
			}
			String supportPS4 = request.getParameter("supportPS4");
			if (supportPS4 != null) {
				//out.println("Clicked");
				supportPS4 = "1";
			} else {
				supportPS4 = "0";
				//out.println("Not clicked");
			}
			String supportWIIU = request.getParameter("supportWIIU");
			if (supportWIIU != null) {
				//out.println("Clicked");
				supportWIIU = "1";
			} else {
				supportWIIU = "0";
				//out.println("Not clicked");
			}
			connectToMysql connection = new connectToMysql(MyConstants.url);
			//connection.preparedUpdate("insert into game(gametitle) values(?),",gameTitle);
			result = connection.preparedUpdate(
					"insert into game(gametitle,company,releaseDate,description,price,preowned,supportWin,supportMac,supportXBOX,supportLinux,supportPS4,supportWIIU) values(?,?,?,?,?,?,?,?,?,?,?,?)",
					gameTitle, company, releaseDate, description, price, preOwned, supportWin, supportMac,
					supportXBOX, supportLinux, supportPS4, supportWIIU);

			connection.close();
			
			if (result > 0) {
				if (imgLocation.getSize() > 0) {
					ResultSet rs = connection.preparedQuery("SELECT gameid FROM game WHERE gametitle=?", gameTitle);
					try {
						rs.last();					
						int gameid = rs.getInt(1);
						connection.close();
						result = connection.preparedUpdate("INSERT INTO game_image VALUES (?,?,?)", gameid, 0, imgLocation.getInputStream());
						connection.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if (result > 0 && request.getParameter("redirect") != null)
					response.sendRedirect("games.jsp");
					
			}
		}
		
		request.setAttribute("result", result);
		RequestDispatcher rd = request.getRequestDispatcher("addGame.jsp");
		rd.forward(request, response);
		
	}

}
