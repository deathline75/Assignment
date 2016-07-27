package com.ice.api;

/**
 * This is a Java Object for public users.
 * @author Kelvin
 *
 */
public class User {
	
	private int id;
	private String name;
	private String email;
	private int contact;
	private String password;
	private String[] mailaddr;
	
	/**
	 * Gets the ID represented in the SQL table
	 * @return The ID represented in the SQL table
	 */
	public int getId() {
		return id;
	}
	
	/**
	 * Sets the ID represented in the SQL table.
	 * @param id The ID represented in the SQL table.
	 * @deprecated Used only when creating a new User instance. It will not update the ID in the SQL table.
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Gets the name of the user
	 * @return The name of the user
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * Sets the name of the user
	 * @param name The new name of the user
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * Gets the email of the user
	 * @return The email of the user
	 */
	public String getEmail() {
		return email;
	}
	
	/**
	 * Sets the email of the user
	 * @param email The new email of the user
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	
	/**
	 * Gets the contact number of the user
	 * @return The contact number of the user
	 */
	public int getContact() {
		return contact;
	}
	
	/**
	 * Sets the contact number of the user
	 * @param contact The new contact number of the user
	 */
	public void setContact(int contact) {
		this.contact = contact;
	}
	
	/**
	 * Gets the SALT + HASHED value of the user's password
	 * Format: Salt:Hashed
	 * @return The hashed and salted value of the user password
	 */
	public String getPassword() {
		return password;
	}
	
	/**
	 * Set the user's password
	 * The password MUST follow the following format: SALT:HASHED
	 * @see {@link com.ice.util.HashingUtil}
	 * @param password The hashed password to set the user.
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	
	/**
	 * Get the mail address of the user.
	 * The first index returns the first line of the mailing address.
	 * The second index returns the second line of the mailing address.
	 * @return The mail address of the user
	 */
	public String[] getMailaddr() {
		return mailaddr;
	}
	
	/**
	 * Sets the mail address of the user
	 * @param mailaddr The new mail address of the user
	 */
	public void setMailaddr(String[] mailaddr) {
		this.mailaddr = mailaddr;
	}
	
}
