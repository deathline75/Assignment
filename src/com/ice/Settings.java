package com.ice;

import java.io.IOException;
import java.security.SecureRandom;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;

import com.ice.api.User;
import com.ice.util.HashingUtil;

/**
 * Servlet implementation class Settings
 */
@WebServlet("/Settings")
public class Settings extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Settings() {
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		int action = -1;
		try {
			action = Integer.parseInt(request.getParameter("action"));
		} catch (NumberFormatException ex) {}
		if (user == null || action < 1 || action > 4) {
			response.sendRedirect(".");
		} else {
			switch (action) {
			case 1: changeName(user, request, response); break;
			case 2: changeEmail(user, request, response); break;
			case 3: changeMailAddress(user, request, response); break;
			case 4: changePassword(user, request, response); break;
			}
			response.sendRedirect("settings.jsp");
		}
	}
	
	private void changePassword(User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		CRUDUser db = new CRUDUser();
		if (request.getParameter("cpassword") == null || request.getParameter("cpassword").isEmpty() || 
				request.getParameter("password") == null || request.getParameter("password").isEmpty() ||
				request.getParameter("cfmPassword") == null || request.getParameter("cfmPassword").isEmpty())
			session.setAttribute("error", "Password fields cannot be empty!");
		else if (!request.getParameter("password").matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,16}$"))
			session.setAttribute("error", "Password must contain uppercase, lowercase, numbers and must be between 8 to 16 characters!");
		else if (!request.getParameter("password").equals(request.getParameter("cfmPassword")))
			session.setAttribute("error", "New passwords do not match!");
		else {
			String[] localPassword = user.getPassword().split(":");
			if (localPassword[1].equals(HashingUtil.byteArrayToHex(HashingUtil.hashPassword(request.getParameter("cpassword").toCharArray(), HashingUtil.hexToByteArray(localPassword[0]), 10000, 512)))) {
				byte[] salt = new byte[16];
				SecureRandom random = new SecureRandom();
				random.nextBytes(salt);
				String hashed = HashingUtil.byteArrayToHex(HashingUtil.hashPassword(request.getParameter("password").toCharArray(), salt, 10000, 512));
				user.setPassword(HashingUtil.byteArrayToHex(salt) + ":" + hashed);
				if (db.updateUser(user))
					session.setAttribute("success", "You may now login with your new password.");
				else
					session.setAttribute("error", "There is an error updating your details. Try again later.");
			} else {
				byte[] salt = new byte[16];
				SecureRandom random = new SecureRandom();
				random.nextBytes(salt);
				byte[] hashed = HashingUtil.hashPassword("abcdABCD1234!@#$".toCharArray(), salt, 10000, 512);
				hashed.toString();
				session.setAttribute("error", "Incorrect current password.");
			}
		}
		db.close();
	}

	private void changeMailAddress(User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		if (request.getParameter("addr1") == null || request.getParameter("addr1").isEmpty() ||
				request.getParameter("addr2") == null || request.getParameter("addr2").isEmpty())
			session.setAttribute("error", "Both the address fields cannot be empty!");
		else if (request.getParameter("addr1").length() > 255 || request.getParameter("addr2").length() > 255)
			session.setAttribute("error", "Address length is too long!");
		else {
			user.setMailaddr(new String[]{StringEscapeUtils.escapeHtml4(request.getParameter("addr1")), StringEscapeUtils.escapeHtml4(request.getParameter("addr2"))});
			CRUDUser db = new CRUDUser();
			if (db.updateUser(user))
				session.setAttribute("success", "Your mail address has been changed.");
			else
				session.setAttribute("error", "There is an error updating your details. Try again later.");
			db.close();
		}
	}

	private void changeEmail(User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		CRUDUser db = new CRUDUser();
		if (request.getParameter("email") == null || request.getParameter("email").isEmpty() || request.getParameter("cfmEmail") == null || request.getParameter("cfmEmail").isEmpty())
			session.setAttribute("error", "Both fields cannot be empty!");
		else if (!request.getParameter("email").matches("^(.+?@.+?(\\..+)+?){0,254}$"))
			session.setAttribute("error", "Email must contain an '@' and a '.'");
		else if (!request.getParameter("email").equals(request.getParameter("cfmEmail")))
			session.setAttribute("error", "Emails do not match!");
		else if (db.isUser(request.getParameter("email")))
			session.setAttribute("error", "There is an error updating your details. Try again later.");
		else {
			user.setEmail(request.getParameter("email"));
			if (db.updateUser(user))
				session.setAttribute("success", "You may now login with your new email.");
			else
				session.setAttribute("error", "There is an error updating your details. Try again later.");
		}
		db.close();
	}

	private void changeName(User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		if (request.getParameter("name") == null || request.getParameter("name").isEmpty())
			session.setAttribute("error", "The name field is empty!");
		else if (request.getParameter("contact") == null || request.getParameter("contact").isEmpty())
			session.setAttribute("error", "The contact field is empty!");
		else if (!request.getParameter("name").matches("^[\\w ]{0,45}$"))
			session.setAttribute("error", "Name must only contain alphanumeric and space characters. Maximum 45 characters.");
		else if (!request.getParameter("contact").matches("^\\d{8}$"))
			session.setAttribute("error", "Contact must only contain 8 digits.");
		else {
			user.setName(StringEscapeUtils.escapeHtml4(request.getParameter("name")));
			user.setContact(Integer.parseInt(StringEscapeUtils.escapeHtml4(request.getParameter("contact"))));
			CRUDUser db = new CRUDUser();
			if (db.updateUser(user))
				session.setAttribute("success", "Your name and/or contact has been changed.");
			else
				session.setAttribute("error", "There is an error updating your details. Try again later.");
			db.close();
		}
	}

}
