package com.ice;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ice.api.User;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(".");
		response.getWriter().append("You are not supposed to be here. Use POST to register.").close();;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (request.getParameter("name") == null || request.getParameter("name").isEmpty() ||
				request.getParameter("email") == null || request.getParameter("email").isEmpty() ||
				request.getParameter("cfmEmail") == null || request.getParameter("cfmEmail").isEmpty() ||
				request.getParameter("password") == null || request.getParameter("password").isEmpty() ||
				request.getParameter("cfmPassword") == null || request.getParameter("cfmPassword").isEmpty() ||
				request.getParameter("addr1") == null || request.getParameter("addr1").isEmpty() ||
				request.getParameter("addr2") == null || request.getParameter("addr2").isEmpty() ||
				request.getParameter("contact") == null || request.getParameter("contact").isEmpty() ||
				request.getParameter("g-recaptcha-response") == null || request.getParameter("g-recaptcha-response").isEmpty()) {
			request.getSession().setAttribute("error", "You did not fill in all the fields to register!");
			response.sendRedirect("login.jsp");
		} else {

			int contact = 0;
			String email = request.getParameter("email"), cfmEmail = request.getParameter("cfmEmail"), password = request.getParameter("password"),
					cfmPassword = request.getParameter("cfmPassword"), name = request.getParameter("name"), addr1 = request.getParameter("addr1"),
					addr2 = request.getParameter("addr2");
			
			try {
				if (request.getParameter("contact").length() != 8) {
					request.getSession().setAttribute("error", "Invalid contact number! Please input only 8 digits.");
					response.sendRedirect("login.jsp");
					return;
				}
				contact = Integer.parseInt(request.getParameter("contact"));
			} catch (NumberFormatException e) {
				request.getSession().setAttribute("error", "Invalid contact number! Please input only 8 digits.");
				response.sendRedirect("login.jsp");
				return;
			}
			
			if (!email.equals(cfmEmail)) {
				request.getSession().setAttribute("error", "Emails do not match!");
				response.sendRedirect("login.jsp");
				return;
			}
			
			if (password.length() < 8) {
				request.getSession().setAttribute("error", "Password length must be greater than 8 characters!");
				response.sendRedirect("login.jsp");
				return;
			}
			
			if (!password.equals(cfmPassword)) {
				request.getSession().setAttribute("error", "Passwords do not match!");
				response.sendRedirect("login.jsp");
				return;
			}
			
			if (!VerifyUtils.verify(request.getParameter("g-recaptcha-response"))) {
				request.getSession().setAttribute("error", "Please retry the captcha.");
				response.sendRedirect("login.jsp");	
				return;
			}
			
			CRUDUser dbUser = new CRUDUser();
			User user = null;
			if (dbUser.isUser(email)) {
				request.getSession().setAttribute("error", "Email already registered!");
				response.sendRedirect("login.jsp");
			} else if ((user = dbUser.insertUser(name, cfmEmail, contact, cfmPassword, addr1, addr2)) == null) {
				request.getSession().setAttribute("error", "Email already registered!");
				response.sendRedirect("login.jsp");
			} else {
				request.getSession().setAttribute("success", "You may now login with " + user.getEmail() + ".");
				response.sendRedirect("login.jsp");
			}
			dbUser.close();
		}
		
	}

}
