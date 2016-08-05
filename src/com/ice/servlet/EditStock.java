package com.ice.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ice.crud.*;

/**
 * Servlet implementation class EditStock
 */
@WebServlet("/admin/EditStock")
public class EditStock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditStock() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(".");
		response.getWriter().append("You are not supposed to be here. Use POST to update data.").close();;
	}
	
	private boolean checkInput(HttpServletRequest request) {
		return request.getParameter("gameid") != null && !request.getParameter("gameid").isEmpty()
				&& request.getParameter("quantity") != null && !request.getParameter("quantity").isEmpty() && request.getParameter("quantity").matches("^\\d+$");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(checkInput(request)){
			int gameid = Integer.parseInt(request.getParameter("gameid"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			CRUDGame dbGame = new CRUDGame();

			if(dbGame.updateQuantity(gameid, quantity)){
				response.getWriter().println("Success! Updated quantity.");
			} else {
				response.getWriter().println("Error! Unable to update quantity. Try again later.");
			}
			dbGame.close();
		}
		else{
			response.getWriter().println("Error! You have entered an invalid value.");
		}
	}

}
