package com.ice.crud;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ice.MyConstants;
import com.ice.api.ShopCartItem;
import com.ice.api.Transaction;
import com.ice.api.Transaction.TransactionDetail;
import com.ice.util.DatabaseConnect;
import com.ice.api.User;
/**
 * This class represents the modal where it connects the database with the controller together.
 * @author Qiurong
 *
 */
public class CRUDTransaction {

	private DatabaseConnect connection;

	public CRUDTransaction() {
		connection = new DatabaseConnect(MyConstants.url);
	}

	/**
	 * Gets all the transactions of a user.
	 * All the transactions created, regardless if method is called with the same User, will be a new Transaction object.
	 * @param user The user to get the transactions from
	 * @return All the transactions the user is tied to.
	 */
	public ArrayList<Transaction> getTransactions(User user) {
		ArrayList<Transaction> transactions = new ArrayList<>();
		CRUDGame dbGame = new CRUDGame();
		ResultSet rs = connection.preparedQuery("SELECT * FROM transaction WHERE userid=?", user.getId());
		try {
			while (rs.next()) {
				int id = rs.getInt(1);
				ArrayList<TransactionDetail> boughtItems = new ArrayList<TransactionDetail>();
				
				ResultSet rs1 = connection.preparedQuery("SELECT * FROM transactiondetails WHERE transactionID=?", id);
				while (rs1.next()) {
					boughtItems.add(new TransactionDetail(dbGame.getGame(rs1.getInt("gameid")), rs1.getString("platform"), rs1.getInt("quantity")));
				}
				rs1.close();				
				transactions.add(new Transaction(id, user, boughtItems, rs.getString("cardholdername"), rs.getLong("creditcardnumber"), rs.getInt("cvv"), new String[]{rs.getString("mailaddr1"), rs.getString("mailaddr2")}, rs.getString("date"), rs.getDouble("totalCost"), rs.getInt("contact")));
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		dbGame.close();
		return transactions;
	}
	
	/**
	 * Insert a new transaction into the database
	 * @param user The transaction's owner
	 * @param items The shopping cart items to insert into the database
	 * @param cardHolderName The credit card holder's name.
	 * @param creditCardNumber The credit card number
	 * @param cvv The credit card's Card Verification Value
	 * @param mailaddr1 Part 1 of the mail address
	 * @param mailaddr2 Part 2 of the mail address
	 * @param date The date of the transaction
	 * @param totalCost The total cost of the transaction
	 * @param contact The contact number of the credit card holder
	 * @return A new Transaction object based off the database inserted values.
	 */
	public Transaction insertTransaction(User user,ArrayList<ShopCartItem> items,String cardHolderName,long creditCardNumber,int cvv,String mailaddr1,String mailaddr2,String date, double totalCost, int contact) {
		
		ResultSet key = connection.preparedUpdateAutoKey("insert into transaction(userid,cardholdername,creditcardnumber,cvv,mailaddr1,mailaddr2,date,totalcost,contact) values(?,?,?,?,?,?,?,?,?)",user.getId(),cardHolderName,creditCardNumber,cvv,mailaddr1,mailaddr2,date,totalCost,contact);
		try {
			while(key.next()){
				
				int generatedKey = key.getInt(1);
				
				ArrayList<TransactionDetail> boughtItems = new ArrayList<TransactionDetail>();
				for(ShopCartItem item:items){
					if (connection.preparedUpdate("insert into transactiondetails(transactionID,gameid,platform,quantity) values(?,?,?,?) ", generatedKey,item.getGame().getId(),item.getPlatform(),item.getQuantity()) != -1) {
						boughtItems.add(new TransactionDetail(item.getGame(), item.getPlatform(), item.getQuantity()));
						item.getGame().setQuantity(item.getGame().getQuantity() - item.getQuantity());
						CRUDGame dbGame = new CRUDGame();
						dbGame.updateGame(item.getGame());
						dbGame.close();
					}
				}
				return new Transaction(generatedKey,user, boughtItems, cardHolderName, creditCardNumber, cvv, new String[]{mailaddr1, mailaddr2},date, totalCost, contact);	
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Closes the database connection.
	 */
	public void close(){
		connection.close();
	}

}
