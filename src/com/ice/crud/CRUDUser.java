package com.ice.crud;

import java.security.SecureRandom;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ice.MyConstants;
import com.ice.api.User;
import com.ice.util.DatabaseConnect;
import com.ice.util.HashingUtil;
/**
 * This class represents the modal where it connects the database with the controller together.
 * @author Qiurong
 *
 */
public class CRUDUser {
	
	private DatabaseConnect connection;
	
	public CRUDUser() {
		connection = new DatabaseConnect(MyConstants.url);
	}
	
	/**
	 * Gets a new User object based on User ID
	 * @param id The ID of the user in the SQL database
	 * @return The ID of the user
	 */
	public User getUser(int id) {
		ResultSet rs = connection.preparedQuery("SELECT * FROM userdata WHERE id=?", id);
		try {
			if (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setContact(rs.getInt("contact"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setMailaddr(new String[]{rs.getString("mailaddr1"), rs.getString("mailaddr2")});
				user.setPassword(rs.getString("password"));
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * Gets a new User object based on email and password (unhashed).
	 * @param email The email of the user
	 * @param password The password of the user
	 * @return The new User object.
	 */
	public User getUser(String email, String password) {
		
		ResultSet rs = connection.preparedQuery("SELECT * FROM userdata WHERE email=?", email);
		try {
			if (rs.next()) {
				String[] dbPassword = rs.getString("password").split(":");
				byte[] salt = HashingUtil.hexToByteArray(dbPassword[0]);
				String hashed = HashingUtil.byteArrayToHex(HashingUtil.hashPassword(password.toCharArray(), salt, 10000, 512));
				
				if (dbPassword[1].equals(hashed)) {
					User user = new User();
					user.setId(rs.getInt("id"));
					user.setContact(rs.getInt("contact"));
					user.setName(rs.getString("name"));
					user.setEmail(rs.getString("email"));
					user.setMailaddr(new String[]{rs.getString("mailaddr1"), rs.getString("mailaddr2")});
					user.setPassword(rs.getString("password"));
					return user;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
	/**
	 * Checks if the user email exists in the database.
	 * @param email The email to check
	 * @return A boolean to see if the user email exists.
	 */
	public boolean isUser(String email) {
		ResultSet rs = connection.preparedQuery("SELECT * FROM userdata WHERE email=?", email);
		try {
			if (rs.next()) 
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/**
	 * Updates the user details
	 * @param user The user details to reference
	 * @return A boolean to see if the user update was successful.
	 */
	public boolean updateUser(User user) {
		if (user == null)
			throw new NullPointerException("User cannot be null!");
		
		int result = connection.preparedUpdate("UPDATE userdata SET name=?, email=?, contact=?, password=?, mailaddr1=?, mailaddr2=? WHERE id=?", user.getName(), user.getEmail(), user.getContact(), user.getPassword(), user.getMailaddr()[0] ,user.getMailaddr()[1], user.getId());
		if (result != -1)
			return true;
		
		return false;
	}
	
	/**
	 * Inserts a new user into the database.
	 * This method will not check if the email already exists in the database. 
	 * If the email does exist, the method will probably throw an {@link java.sql.SQLException} 
	 * @param name The name to insert
	 * @param email The email to insert
	 * @param contact The contact number to insert
	 * @param password The unhashed password to insert
	 * @param mailAddr1 The first line of mail address
	 * @param mailAddr2 The second line of mail address
	 * @return A new User object based on the parameters provided.
	 */
	public User insertUser(String name, String email, int contact, String password, String mailAddr1, String mailAddr2) {
		byte[] salt = new byte[16];
		SecureRandom random = new SecureRandom();
		random.nextBytes(salt);
		String hashed = HashingUtil.byteArrayToHex(HashingUtil.hashPassword(password.toCharArray(), salt, 10000, 512));
		int result = connection.preparedUpdate("INSERT INTO userdata (name, email, contact, password, mailaddr1, mailaddr2) VALUES (?, ?, ?, ?, ?, ?)", name, email, contact, HashingUtil.byteArrayToHex(salt) + ":" + hashed, mailAddr1, mailAddr2);
		if (result != -1) {
			return getUser(email, password);
		}
		return null;
	}
	
	/**
	 * Closes the database connection
	 */
	public void close() {
		connection.close();
	}
	
}
