package com.ice.api;

public class Genre {
	
	private int id;
	private String name;
	
	public Genre(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}
	
	public int getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	
	
}