package com.ice.api;

/**
 * Genre is a POJO which is mostly used in GSON.
 * @author Kelvin Neo
 *
 */
public class Genre {
	
	private int id;
	private String name;
	
	public Genre(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}
	
	/**
	 * Gets the Genre ID that uniquely identifies this genre.
	 * @return The Genre ID that uniquely identifies this genre.
	 */
	public int getId() {
		return id;
	}
	
	/**
	 * Gets the name of this genre
	 * @return The name of this genre
	 */
	public String getName() {
		return name;
	}
	
	
}