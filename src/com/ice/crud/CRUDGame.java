package com.ice.crud;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.ice.MyConstants;
import com.ice.api.Game;
import com.ice.util.DatabaseConnect;
/**
 * This class represents the modal where it connects the database with the controller together.
 * @author Qiurong
 *
 */
public class CRUDGame {
	private DatabaseConnect connection;
	private static final HashMap<Integer, Game> masterGamesList = new HashMap<>();
	
	public CRUDGame() {
		connection = new DatabaseConnect(MyConstants.url);
	}
	
	/**
	 * Gets the whole games list.<br/>
	 * Does not return a new object if the game is already called. Instead, it uses the internal application data.
	 * @return The whole games list
	 */
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
	 
	/**
	 * Update the game data into the database
	 * @param game The game to update
	 * @return A boolean of whether the update was successful.
	 */
	public boolean updateGame(Game game) {
		if (game == null)
			throw new NullPointerException("Game cannot be null!");

		if (connection.preparedUpdate("update game set gameTitle=?,company=?,releaseDate=?,description=?,price=?,preOwned=?,supportWin=?,supportMac=?,supportXBOX=?,supportLinux=?,supportPS4=?,supportWIIU=?,qty=? where gameid=?",game.getTitle(),game.getCompany(),game.getReleaseDate(),game.getDescription(),game.getPrice(),game.isPreowned(),game.isSupportWin(),game.isSupportMac(),game.isSupportXbox(),game.isSupportLinux(),game.isSupportPs4(),game.isSupportWiiu(),game.getQuantity(),game.getId()) != -1)
			return true;
		return false;
	}
	
	/**
	 * Updates the quantity of a game based on its id.
	 * @param gameid The game id to update from
	 * @param quantity The quantity to update to
	 * @return A boolean of whether the update was successful
	 */
	public boolean updateQuantity(int gameid,int quantity) {
		if (connection.preparedUpdate("update game set qty=? where gameid=?",quantity,gameid) != -1)
			return true;
		return false;
	}
	
	/**
	 * Gets a Game object based on the game id.
	 * If the same gameid is used more than once, it will not create a new Game object. It instead uses the internal saved Game object.
	 * @param gameid The game id to get the game from.
	 * @return The Game object based on the id.
	 */
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

	/**
	 * Closes the database connection.
	 */
	public void close() {
		connection.close();
	}
	
}
