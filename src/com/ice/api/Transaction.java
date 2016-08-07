package com.ice.api;

import java.util.ArrayList;

/**
 * This is a Transaction POJO.
 * This class is aimed to describe the transactions the user has had.
 * This class is not GSON safe, meaning the transaction may go on a recursion trip.
 * @author Qiurong
 *
 */
public class Transaction {

	private int transactionid;
	private User user;
	private ArrayList<TransactionDetail> items;
	private String creditCardHolder;
	private long creditCardNumber;
	private int creditCardCVV;
	private String[] mailaddr;
	private String date;
	private double totalCost;
	private int contact;

	public Transaction(int transactionid, User user, ArrayList<TransactionDetail> items, String creditCardHolder,
			long creditCardNumber, int creditCardCVV, String[] mailaddr,String date, double totalCost, int contact) {
		super();
		this.transactionid = transactionid;
		this.user = user;
		this.items = items;
		this.creditCardHolder = creditCardHolder;
		this.creditCardNumber = creditCardNumber;
		this.creditCardCVV = creditCardCVV;
		this.mailaddr = mailaddr;
		this.date = date;
		this.totalCost = totalCost;
		this.contact = contact;
	}

	/**
	 * Gets the date of the transaction
	 * @return The date of the transaction
	 */
	public String getDate() {
		return date;
	}

	/**
	 * Sets the date of the transaction
	 * @param date The date of the transaction
	 */
	public void setDate(String date) {
		this.date = date;
	}
	
	/**
	 * Gets the unique internal transaction ID
	 * @return The unique internal transaction ID
	 */
	public int getTransactionid() {
		return transactionid;
	}

	/**
	 * Sets the unique internal transaction ID
	 * @param transactionid The unique transactionID
	 * @deprecated Dangerous. Does not change internal value, instead overrides values of database if it exists.
	 */
	@Deprecated
	public void setTransactionid(int transactionid) {
		this.transactionid = transactionid;
	}

	/**
	 * Gets the user of this transaction
	 * @return The user of this transaction
	 */
	public User getUser() {
		return user;
	}

	/**
	 * Sets the user of this transaction
	 * @param user The user of this transaction
	 */
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * Gets the list of items bought in this transaction
	 * @return The list of items bought in this transaction
	 * @see {@link com.ice.api.Transaction.TransactionDetail}
	 */
	public ArrayList<TransactionDetail> getItems() {
		return items;
	}

	/**
	 * Sets the list of items bought in this transaction
	 * @param items The list of items bought in this transaction
	 * @see {@link com.ice.api.Transaction.TransactionDetail}
	 */
	public void setItems(ArrayList<TransactionDetail> items) {
		this.items = items;
	}

	/**
	 * Get the name of the credit card holder
	 * @return The name of the credit card holder
	 */
	public String getCreditCardHolder() {
		return creditCardHolder;
	}

	/**
	 * Sets the name of the credit card holder
	 * @param creditCardHolder The name of the credit card holder
	 */
	public void setCreditCardHolder(String creditCardHolder) {
		this.creditCardHolder = creditCardHolder;
	}

	/**
	 * Gets the credit card number
	 * @return The credit card number
	 */
	public long getCreditCardNumber() {
		return creditCardNumber;
	}

	/**
	 * Sets the credit card number
	 * @param creditCardNumber The credit card number
	 */
	public void setCreditCardNumber(long creditCardNumber) {
		this.creditCardNumber = creditCardNumber;
	}

	/**
	 * Gets the credit card's Card Verification Value
	 * @return The credit card's Card Verification Value
	 */
	public int getCreditCardCVV() {
		return creditCardCVV;
	}

	/**
	 * Sets the credit card's Card Verification Value
	 * @param creditCardCVV The credit card's Card Verification Value
	 */
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
	
	/**
	 * Gets the total cost of the transaction
	 * @return The total cost of the transaction
	 */
	public double getTotalCost() {
		return totalCost;
	}
	
	/**
	 * Sets the total cost of the transaction
	 * @param totalCost The total cost of the transaction
	 */
	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}
	
	/**
	 * Gets the contact number of the credit card holder
	 * @return The contact number of the credit card holder
	 */
	public int getContact() {
		return contact;
	}
	
	/**
	 * Sets the contact number of the credit card holder
	 * @param contact The contact number of the credit card holder
	 */
	public void setContact(int contact) {
		this.contact = contact;
	}
	
	/**
	 * This is a TransactionDetail POJO.
 	 * This class is aimed to describe the transaction items of a transaction
  	 * This class is not GSON safe, meaning the transaction item may go on a recursion trip.
	 * @author Qiurong
	 *
	 */
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
		
		/**
		 * Gets the game bought
		 * @return The game bought
		 */
		public Game getGame() {
			return game;
		}
		
		/**
		 * Sets the game bought
		 * @param game The game bought
		 */
		public void setGame(Game game) {
			this.game = game;
		}
		
		/**
		 * Gets the platform the game was bought on
		 * @return The platform the game was bought on
		 */
		public String getPlatform() {
			return platform;
		}
		
		/**
		 * Sets the platform the game was bought on
		 * @param platform The platform the game was bought on
		 */
		public void setPlatform(String platform) {
			this.platform = platform;
		}
		
		/**
		 * Gets the quantity bought for the game
		 * @return The quantity bought for the game
		 */
		public int getQuantity() {
			return quantity;
		}
		
		/**
		 * Sets the quantity bought for the game
		 * @param quantity The quantity bought for the game
		 */
		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}
		
	}

	
}
