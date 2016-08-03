package com.ice.api;

public class Transaction {

	private int transactionid;
	private int userid;
	private int gameid;
	private int quantity;
	private String platform;
	
	public Transaction(int transactionid, int userid, int gameid, int quantity, String platform) {
		super();
		this.transactionid = transactionid;
		this.userid = userid;
		this.gameid = gameid;
		this.quantity = quantity;
		this.platform = platform;
	}
	
	public int getTransactionid() {
		return transactionid;
	}
	public void setTransactionid(int transactionid) {
		this.transactionid = transactionid;
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
	public String getPlatform() {
		return platform;
	}
	public void setPlatform(String platform) {
		this.platform = platform;
	}


	
	
}
