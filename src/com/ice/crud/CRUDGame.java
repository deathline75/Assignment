package com.ice.crud;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.ice.MyConstants;
import com.ice.api.Game;
import com.ice.util.DatabaseConnect;

public class CRUDGame {
	private DatabaseConnect connection;
	private static final HashMap<Integer, Game> masterGamesList = new HashMap<>();
	
	public CRUDGame() {
		connection = new DatabaseConnect(MyConstants.url);
	}
	
	public ArrayList<Game> getGames() {
		ResultSet rs = connection.preparedQuery("SELECT * FROM game");
		try {
			while (rs.next()) {
				if (!masterGamesList.containsKey(rs.getInt(1)))
					masterGamesList.put(rs.getInt(1), new Game(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14),rs.getInt(15)));
				else {
					Game game = masterGamesList.get(rs.getInt(1));
					game.updateGame(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14),rs.getInt(15));
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return new ArrayList<Game>(masterGamesList.values());
	}
	 
	public boolean updateGame(Game game) {
		if (game == null)
			throw new NullPointerException("Game cannot be null!");

		if (connection.preparedUpdate("update game set gameTitle=?,company=?,releaseDate=?,description=?,price=?,preOwned=?,supportWin=?,supportMac=?,supportXBOX=?,supportLinux=?,supportPS4=?,supportWIIU=?,qty=? where gameid=?",game.getTitle(),game.getCompany(),game.getReleaseDate(),game.getDescription(),game.getPrice(),game.isPreowned(),game.isSupportWin(),game.isSupportMac(),game.isSupportXbox(),game.isSupportLinux(),game.isSupportPs4(),game.isSupportWiiu(),game.getQuantity(),game.getId()) != -1)
			return true;
		return false;
	}
	
	public boolean updateQuantity(int gameid,int quantity) {
		
		if (connection.preparedUpdate("update game set qty=? where gameid=?",quantity,gameid) != -1)
			return true;
		return false;
	}
	
	public Game getGame(int gameid) {
		ResultSet rs = connection.preparedQuery("SELECT * FROM game WHERE gameid=?", gameid);
		try {
			if (rs.next()) {
				if (masterGamesList.containsKey(rs.getInt(1))) {
					Game game = masterGamesList.get(rs.getInt(1));
					game.updateGame(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14),rs.getInt(15));
					return game;
				}
				else {
					Game game = new Game(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14),rs.getInt(15));
					masterGamesList.put(rs.getInt(1), game);
					return game;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void close() {
		connection.close();
	}
	
}
