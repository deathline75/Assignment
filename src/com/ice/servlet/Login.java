package com.ice.servlet;

import java.io.IOException;
import java.security.SecureRandom;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ice.api.User;
import com.ice.crud.CRUDUser;
import com.ice.util.HashingUtil;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(".");
		response.getWriter().append("You are not supposed to be here. Use POST to login.").close();;
	}

	private void lag() {
		// To make the lag noticeable for bruteforcers
		byte[] salt = new byte[16];
		SecureRandom random = new SecureRandom();
		random.nextBytes(salt);
		byte[] hashed = HashingUtil.hashPassword("abcdABCD1234!@#$".toCharArray(), salt, 10000, 512);
		hashed.toString();
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		// Redirect the user to the last page they were at
		String lastPage = (String) (session.getAttribute("lastpage") == null ? "." : session.getAttribute("lastpage"));
		
		// Checks if they are trying to cross site script
		if (request.getParameter("logintoken") == null || session.getAttribute("logintoken") == null 
				|| !((String) session.getAttribute("logintoken")).equals(request.getParameter("logintoken"))) {
			request.getSession().setAttribute("error", "Session has expired. Please try again.");
			lag();
			response.sendRedirect("login.jsp");
		} else {
			
			String inputEmail = request.getParameter("email");
			String inputPassword = request.getParameter("password");
			
			// Input validation
			if (inputEmail == null || inputEmail.isEmpty() || inputPassword == null ||  inputPassword.isEmpty()) {
				request.getSession().setAttribute("error", "Invalid username or password.");
				lag();
				response.sendRedirect("login.jsp");
			} else {
				CRUDUser db = new CRUDUser();
				User user = db.getUser(inputEmail, inputPassword);
				db.close();
				
				if (user == null) { // Checks if the user is in the database
					request.getSession().setAttribute("error", "Invalid username or password.");
					lag();
					response.sendRedirect("login.jsp");
				} else { // If it is, put it inside the session.
					session.invalidate();
					request.getSession().setAttribute("user", user);
					response.sendRedirect(lastPage);
				}
			}	
		}
	}

}
