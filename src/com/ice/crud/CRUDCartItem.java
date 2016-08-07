package com.ice.crud;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ice.MyConstants;
import com.ice.api.*;
import com.ice.util.DatabaseConnect;

/**
 * This class represents the modal where it connects the database with the controller together.
 * @author Qiurong
 *
 */
public class CRUDCartItem {
	private DatabaseConnect connection;
	
	public CRUDCartItem() {
		connection = new DatabaseConnect(MyConstants.url);
	}
	
	/**
	 * Checks if an item is in the user's cart
	 * @param user The user to check the cart on
	 * @param game The game to check
	 * @param platform The platform that the user selection
	 * @return A boolean determining if the item is in the user's cart
	 */
	public boolean isItem(User user, Game game, String platform) {
		ResultSet rs = connection.preparedQuery("select platform from shop_cart where userid=? and gameid=? and platform=?", user.getId(), game.getId() , platform);
		try {
			if (rs.next()){
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/**
	 * Gets a {@link com.ice.api.ShopCartItem ShopCartItem} based on a user, game and platform.<br/>
	 * This method will return a new {@link com.ice.api.ShopCartItem ShopCartItem} object, regardless if the same parameters were passed in.
	 * @param user The user to check this ShopCartItem from
	 * @param game The game to check
	 * @param platform The platform to check
	 * @return A new ShopCartItem object
	 */
	public ShopCartItem getItem(User user, Game game, String platform) {
		ResultSet rs = connection.preparedQuery("SELECT * FROM shop_cart WHERE userid=? AND gameid=? AND platform=?", user.getId(), game.getId(), platform);
		try {
			if (rs.next()) {
				return new ShopCartItem(rs.getInt(1), user, game, rs.getInt("quantity"), rs.getString("platform"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Deletes the database entry of the ShopCartItem based on the ID
	 * @param shopcartid The ShopCartItem id
	 * @return A boolean whether the deletion was successful
	 */
	public boolean deleteItem(int shopcartid) {
		int rows = connection.preparedUpdate("delete from shop_cart where shopcartid=?", shopcartid);
		if(rows != 0 ){
			return true;
		}
		return false;
	}
	
	/**
	 * Insert a new ShopCartItem into the database
	 * @param user The user that holds the ShopCartItem
	 * @param game The game that the user holds
	 * @param platform The platform the user holds
	 * @param quantity The amount the user holds
	 * @return The new ShopCartItem after inserting into the database.
	 */
	public ShopCartItem insertItem(User user, Game game, String platform, int quantity) {
		int result = connection.preparedUpdate("insert into shop_cart(gameid,userid,platform,quantity) VALUES(?,?,?,?)", game.getId(), user.getId(), platform, quantity);
		if (result != -1)
			return getItem(user, game, platform);
		return null;
	}
	
	/**
	 * Updates all the data of a ShopCartItem
	 * @param item The ShopCartItem to update
	 * @return A boolean of whether the update was successful
	 */
	public boolean updateItem(ShopCartItem item) {
		int result = connection.preparedUpdate("UPDATE shop_cart SET userid=?, gameid=?, quantity=?, platform=? WHERE shopCartID=?", item.getUser().getId(), item.getGame().getId(), item.getQuantity(), item.getPlatform(), item.getShopcartID());
		if (result != -1)
			return true;
		return false;
	}
		
	/**
	 * Gets all the items the user has in the cart
	 * @param user The user to get from
	 * @return An ArrayList of items that the user has in the cart
	 */
	public ArrayList<ShopCartItem> getItems(User user){
		ArrayList <ShopCartItem> shopcartitems = new ArrayList<ShopCartItem>(); 
		CRUDGame dbGame = new CRUDGame();
		
		ResultSet rs = connection.preparedQuery("Select * from shop_cart where userid=?", user.getId());
		try {
			while(rs.next()){
				Game game = dbGame.getGame(rs.getInt("gameid"));
				shopcartitems.add(new ShopCartItem(rs.getInt("shopcartID"), user, game, rs.getInt("quantity"),rs.getString("platform")));
			}

			dbGame.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return shopcartitems;
		
	}
	
	/**
	 * Closes the database connection.
	 */
	public void close() {
		connection.close();
	}
}
