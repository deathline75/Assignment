package com.ice.api;

public class GameComment {
	
	private int gameid;
	private int commentid;
	private String comment;
	private short rating;
	private String author;
	
	public GameComment(int gameid, int commentid, String comment, short rating,String author) {
		super();
		this.gameid = gameid;
		this.commentid = commentid;
		this.comment = comment;
		this.rating = rating;
		this.author = author;
	}
	
	/**
	 * @return the gameid
	 */
	public int getGameid() {
		return gameid;
	}
	/**
	 * @return the commentid
	 */
	public int getCommentid() {
		return commentid;
	}
	/**
	 * @return the comment
	 */
	public String getComment() {
		return comment;
	}
	/**
	 * @return the rating
	 */
	public short getRating() {
		return rating;
	}
	
	public String getAuthor(){
		return author;
	}
	
}
