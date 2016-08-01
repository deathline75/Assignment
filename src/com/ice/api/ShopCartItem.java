package com.ice.api;

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
	
	public int getShopcartID() {
		return shopcartID;
	}
	public void setShopcartID(int shopcartID) {
		this.shopcartID = shopcartID;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Game getGame() {
		return game;
	}
	public void setGame(Game game) {
		this.game = game;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getPlatform() {
		return platform;
	}
	public void setPlatform(String platform) {
		this.platform = platform;
	}
	
}
