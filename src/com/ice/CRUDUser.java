package com.ice;

import java.security.SecureRandom;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ice.api.User;
import com.ice.util.HashingUtil;

public class CRUDUser {
	
	private connectToMysql connection;
	
	public CRUDUser() {
		connection = new connectToMysql(MyConstants.url);
	}
	
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
	
	public User insertUser(String name, String email, int contact, String password, String mailAddr1, String mailAddr2) {
		ResultSet rs = connection.preparedUpdateAutoKey("INSERT INTO userdata VALUES (?, ?, ?, ?, ?, ?)", name, email, contact, password, mailAddr1, mailAddr2);
		int id = -1;
		try {
			if (rs.next()) {
				id = rs.getInt(1);
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
		
		if (id != -1) {
			return getUser(id);
		}
		
		return null;
	}
	
	public void close() {
		connection.close();
	}
	
}
