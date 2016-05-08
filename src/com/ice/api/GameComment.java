package com.ice.api;

/**
 * GameComment is a POJO where it is mostly implemented in GSON
 * @author Kelvin Neo
 *
 */
public class GameComment {
	
	private int gameid;
	private int commentid;
	private String author;
	private String comment;
	private short rating;
	
	public GameComment(int gameid, int commentid, String comment, short rating, String author) {
		super();
		this.gameid = gameid;
		this.commentid = commentid;
		this.author = author;
		this.comment = comment;
		this.rating = rating;
	}
	
	/**
	 * Get the Game ID associated with this comment
	 * @return The Game ID associated with this comment
	 */
	public int getGameid() {
		return gameid;
	}
	
	/**
	 * Get the Comment ID that uniquely identifies this comment for this game
	 * @return The Comment ID that uniquely identifies this comment for this game
	 */
	public int getCommentid() {
		return commentid;
	}
	
	/**
	 * Gets the author name of this comment
	 * @return The author name of this comment
	 */
	public String getAuthor(){
		return author;
	}
	
	/**
	 * Gets the comment data
	 * @return The comment data
	 */
	public String getComment() {
		return comment;
	}
	
	/**
	 * Gets the rating of the game given by the author 
	 * @return The rating of the game given by the author
	 */
	public short getRating() {
		return rating;
	}

	
}
