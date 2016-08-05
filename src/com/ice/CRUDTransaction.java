package com.ice;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ice.api.ShopCartItem;
import com.ice.api.Transaction;
import com.ice.api.Transaction.TransactionDetail;
import com.ice.api.User;

public class CRUDTransaction {

	private connectToMysql connection;

	public CRUDTransaction() {
		connection = new connectToMysql(MyConstants.url);
	}

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
	
	public void close(){
		connection.close();
	}

}
