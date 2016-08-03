package com.ice;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ice.api.Game;

public class CRUDGame {
	private connectToMysql connection;
	
	public CRUDGame() {
		connection = new connectToMysql(MyConstants.url);
	}
	
	public ArrayList<Game> getGames() {
		ResultSet rs = connection.preparedQuery("SELECT * FROM game");
		ArrayList<Game> games = new ArrayList<>();
		try {
			while (rs.next()) {
				games.add(new Game(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14),rs.getInt(15)));			
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return games;
	}
	 
	public Game getGame(int gameid) {
		ResultSet rs = connection.preparedQuery("SELECT * FROM game WHERE gameid=?", gameid);
		try {
			if (rs.next()) {
				return new Game(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getDouble(6), rs.getString(7), rs.getBoolean(8), rs.getBoolean(9), rs.getBoolean(10), rs.getBoolean(11), rs.getBoolean(12), rs.getBoolean(13), rs.getBoolean(14),rs.getInt(15));
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
