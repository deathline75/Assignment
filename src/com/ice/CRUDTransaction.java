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

	public Transaction insertTransaction(User user,ArrayList<ShopCartItem> items,String cardHolderName,long creditCardNumber,int cvv,String mailaddr1,String mailaddr2) {
		
		ResultSet key = connection.preparedUpdateAutoKey("insert into transaction(userid,cardholdername,creditcardnumber,cvv,mailaddr1,mailaddr2) values(?,?,?,?,?,?)",user.getId(),cardHolderName,creditCardNumber,cvv,mailaddr1,mailaddr2);
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
				return new Transaction(generatedKey,user, boughtItems, cardHolderName, creditCardNumber, cvv, new String[]{mailaddr1, mailaddr2});	
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
