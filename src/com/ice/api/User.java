package com.ice.api;

public class User {
	
	private int id;
	private String name;
	private String email;
	private int contact;
	private String password;
	private String[] mailaddr;
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public int getContact() {
		return contact;
	}
	
	public void setContact(int contact) {
		this.contact = contact;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String[] getMailaddr() {
		return mailaddr;
	}
	
	public void setMailaddr(String[] mailaddr) {
		this.mailaddr = mailaddr;
	}
	
}
