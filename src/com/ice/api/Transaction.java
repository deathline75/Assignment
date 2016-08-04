package com.ice.api;

import java.sql.Date;
import java.util.ArrayList;

public class Transaction {

	private int transactionid;
	private User user;
	private ArrayList<TransactionDetail> items;
	private String creditCardHolder;
	private long creditCardNumber;
	private int creditCardCVV;
	private String[] mailaddr;
	private String date;

	public Transaction(int transactionid, User user, ArrayList<TransactionDetail> items, String creditCardHolder,
			long creditCardNumber, int creditCardCVV, String[] mailaddr,String date) {
		super();
		this.transactionid = transactionid;
		this.user = user;
		this.items = items;
		this.creditCardHolder = creditCardHolder;
		this.creditCardNumber = creditCardNumber;
		this.creditCardCVV = creditCardCVV;
		this.mailaddr = mailaddr;
		this.date = date;

	}

	
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	public int getTransactionid() {
		return transactionid;
	}

	public void setTransactionid(int transactionid) {
		this.transactionid = transactionid;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public ArrayList<TransactionDetail> getItems() {
		return items;
	}

	public void setItems(ArrayList<TransactionDetail> items) {
		this.items = items;
	}

	public String getCreditCardHolder() {
		return creditCardHolder;
	}

	public void setCreditCardHolder(String creditCardHolder) {
		this.creditCardHolder = creditCardHolder;
	}

	public long getCreditCardNumber() {
		return creditCardNumber;
	}

	public void setCreditCardNumber(long creditCardNumber) {
		this.creditCardNumber = creditCardNumber;
	}

	public int getCreditCardCVV() {
		return creditCardCVV;
	}

	public void setCreditCardCVV(int creditCardCVV) {
		this.creditCardCVV = creditCardCVV;
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
	
	public static class TransactionDetail {
		
		private Game game;
		private String platform;
		private int quantity;
		
		public TransactionDetail(Game game, String platform, int quantity) {
			super();
			this.game = game;
			this.platform = platform;
			this.quantity = quantity;
		}
		
		public Game getGame() {
			return game;
		}
		public void setGame(Game game) {
			this.game = game;
		}
		public String getPlatform() {
			return platform;
		}
		public void setPlatform(String platform) {
			this.platform = platform;
		}
		public int getQuantity() {
			return quantity;
		}
		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}
		
	}

	
}
