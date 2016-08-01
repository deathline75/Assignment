package com.ice;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ice.api.*;

public class CRUDCartItem {
	private connectToMysql connection;
	
	public CRUDCartItem() {
		connection = new connectToMysql(MyConstants.url);
	}
	
	public boolean isItem(User user, Game game, String platform) {
		ResultSet rs = connection.preparedQuery("select platform from shop_cart where userid=? and gameid=? and platform=?", user.getId(), game.getId() , platform);
		try {
			if (rs.next()){
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
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
	
	public ShopCartItem insertItem(User user, Game game, String platform, int quantity) {
		int result = connection.preparedUpdate("insert into shop_cart(gameid,userid,platform,quantity) VALUES(?,?,?,?)", game.getId(), user.getId(), platform, quantity);
		if (result != -1)
			return getItem(user, game, platform);
		return null;
	}
	
	public boolean updateItem(ShopCartItem item) {
		int result = connection.preparedUpdate("UPDATE shop_cart SET userid=?, gameid=?, quantity=?, platform=? WHERE shopCartID=?", item.getUser().getId(), item.getGame().getId(), item.getQuantity(), item.getPlatform(), item.getShopcartID());
		if (result != -1)
			return true;
		return false;
	}
	
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return shopcartitems;
		
	}
	
	public void close() {
		connection.close();
	}
}
