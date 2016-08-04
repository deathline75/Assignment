package com.ice.api;

import java.sql.Timestamp;

/**
 * Game is a POJO where it is mostly implemented with GSON.
 * @author Kelvin Neo
 *
 */
public class Game {
	
	private int id;
	private String title;
	private String company;
	private Timestamp releaseDate;
	private String description;
	private double price;
	private String imgLocation;
	private boolean preowned;
	private boolean supportWin;
	private boolean supportMac;
	private boolean supportXbox;
	private boolean supportLinux;
	private boolean supportPs4;
	private boolean supportWiiu;
	private int quantity;
	
	public Game(int id, String title, String company, Timestamp releaseDate, String description, double price, String imgLocation,
			boolean preowned, boolean supportWin, boolean supportMac, boolean supportXbox, boolean supportLinux,
			boolean supportPs4, boolean supportWiiu,int quantity) {
		super();
		updateGame(id, title, company, releaseDate,description,price,imgLocation,preowned,supportWin,supportMac,supportXbox,supportLinux,supportPs4,supportWiiu,quantity);
	}
	
	public void updateGame(int id, String title, String company, Timestamp releaseDate, String description, double price, String imgLocation,
			boolean preowned, boolean supportWin, boolean supportMac, boolean supportXbox, boolean supportLinux,
			boolean supportPs4, boolean supportWiiu,int quantity) {
		this.id = id;
		this.title = title;
		this.company = company;
		this.releaseDate = releaseDate;
		this.description = description;
		this.price = price;
		this.imgLocation = imgLocation;
		this.preowned = preowned;
		this.supportWin = supportWin;
		this.supportMac = supportMac;
		this.supportXbox = supportXbox;
		this.supportLinux = supportLinux;
		this.supportPs4 = supportPs4;
		this.supportWiiu = supportWiiu;
		this.quantity = quantity;
	}
	
	/**
	 * Gets the Game ID for the Game
	 * @return The Game ID of the Game
	 */
	public int getId() {
		return id;
	}
	/**
	 * Gets the title of the game
	 * @return The title of the game
	 */
	public String getTitle() {
		return title;
	}
	
	/**
	 * Gets the name of the company that developed this game.
	 * @return The name of the company that developed this game.
	 */
	public String getCompany() {
		return company;
	}
	
	/**
	 * Gets the earliest release date of the game.
	 * @return The earliest release date of the game
	 */
	public Timestamp getReleaseDate() {
		return releaseDate;
	}
	
	/**
	 * Gets the description of the game.
	 * @return The description of the game.
	 */
	public String getDescription() {
		return description;
	}
	
	/**
	 * Gets the price of the game.
	 * @return The price of the game
	 */
	public double getPrice() {
		return price;
	}
	
	/**
	 * Gets the image location in the local directory
	 * @return The image location in the local directory
	 * @deprecated Unused. Moved to {@link com.ice.api.GameImage}
	 */
	@Deprecated
	public String getImgLocation() {
		return imgLocation;
	}
	
	/**
	 * Checks if the game is preowned.
	 * @return Returns true if the game is preowned.
	 */
	public boolean isPreowned() {
		return preowned;
	}
	
	/**
	 * Checks if the game is supported on Windows platform
	 * @return Returns true if the game is supported on Windows platform
	 */
	public boolean isSupportWin() {
		return supportWin;
	}
	
	/**
	 * Checks if the game is supported on OS X platform
	 * @return Returns true if the game is supported on OS X platform
	 */
	public boolean isSupportMac() {
		return supportMac;
	}
	
	/**
	 * Checks if the game is supported on Xbox One
	 * @return Returns true if the game is supported on Xbox One
	 */
	public boolean isSupportXbox() {
		return supportXbox;
	}
	
	/**
	 * Checks if the game is supported on Linux platform
	 * @return Returns true if the game is supported on Linux platform
	 */
	public boolean isSupportLinux() {
		return supportLinux;
	}
	
	/**
	 * Checks if the game is supported on PS4
	 * @return Returns true if the game is supported on PS4
	 */
	public boolean isSupportPs4() {
		return supportPs4;
	}
	
	/**
	 * Checks if the game is supported on Wii-U
	 * @return Returns true if the game is supported on Wii-U
	 */
	public boolean isSupportWiiu() {
		return supportWiiu;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "Game [id=" + id + ", title=" + title + ", company=" + company + ", releaseDate=" + releaseDate
				+ ", description=" + description + ", price=" + price + ", imgLocation=" + imgLocation + ", preowned="
				+ preowned + ", supportWin=" + supportWin + ", supportMac=" + supportMac + ", supportXbox="
				+ supportXbox + ", supportLinux=" + supportLinux + ", supportPs4=" + supportPs4 + ", supportWiiu="
				+ supportWiiu + ", quantity=" + quantity + "]";
	}
	
	
}