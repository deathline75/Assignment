package com.ice.api;

public class ShopCartItem {

	private int shopcartID;
	private int userid;
	private int gameid;
	private int quantity;
	
	public ShopCartItem(int shopcartID, int userid, int gameid, int quantity) {
		super();
		this.shopcartID = shopcartID;
		this.userid = userid;
		this.gameid = gameid;
		this.quantity = quantity;
	}
	
	public int getShopcartID() {
		return shopcartID;
	}
	public void setShopcartID(int shopcartID) {
		this.shopcartID = shopcartID;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getGameid() {
		return gameid;
	}
	public void setGameid(int gameid) {
		this.gameid = gameid;
	}
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
}
