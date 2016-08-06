package com.ice.api;

/**
 * This is a ShopCartItem POJO.
 * This class is aimed to describe the item that is being held in the user's shopping cart currently.
 * This class is not GSON safe, meaning the cart may go on a recursion trip.
 * @author Qiurong
 *
 */
public class ShopCartItem {

	private int shopcartID;
	private User user;
	private Game game;
	private int quantity;
	private String platform;
	
	public ShopCartItem(int shopcartID, User user, Game game, int quantity, String platform) {
		super();
		this.shopcartID = shopcartID;
		this.user = user;
		this.game = game;
		this.quantity = quantity;
		this.platform = platform;
	}
	
	/**
	 * Get the internal ID of the shop cart item.
	 * This ID is unique for every user and item in the shopping cart.
	 * @return The internal ID of the shop cart item.
	 */
	public int getShopcartID() {
		return shopcartID;
	}
	
	/**
	 * Sets the internal ID of the shop cart item.
	 * This ID is unique for every user and item in the shopping cart.
	 * @param shopcartID The internal ID of the shop cart item.
	 * @deprecated Dangerous. Does not change internal value, instead overrides values of database if it exists.
	 */
	@Deprecated
	public void setShopcartID(int shopcartID) {
		this.shopcartID = shopcartID;
	}
	
	/**
	 * Gets the user of this cart item.
	 * @return The user of this cart item
	 */
	public User getUser() {
		return user;
	}
	
	/**
	 * Sets the user of this cart item
	 * @param user The user of this cart item.
	 */
	public void setUser(User user) {
		this.user = user;
	}
	
	/**
	 * Gets the game the cart item is referencing.
	 * @return The game the cart item is referencing.
	 */
	public Game getGame() {
		return game;
	}
	
	/**
	 * Set the game the cart item is referencing.
	 * @param game The game the cart item is referencing.
	 */
	public void setGame(Game game) {
		this.game = game;
	}
	
	/**
	 * Gets the quantity the user wants to buy.
	 * @return The quantity the user wants to buy.
	 */
	public int getQuantity() {
		return quantity;
	}
	
	/**
	 * Sets the quantity the user wants to buy
	 * @param quantity The quantity the user wants to buy
	 */
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	/**
	 * Gets the platform of the game the user wants to buy on.
	 * @return The platform of the game the user wants to buy on.
	 */
	public String getPlatform() {
		return platform;
	}
	
	/**
	 * Sets the platform of the game the user wants to buy on.
	 * @param platform The platform of the game the user wants to buy on.
	 */
	public void setPlatform(String platform) {
		this.platform = platform;
	}
}
