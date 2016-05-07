package com.ice.api;

public class GameImage {
	
	private int gameid;
	private int imageuse;
	private String b64imagedata;
	
	public GameImage(int gameid, int imageuse, String b64imagedata) {
		super();
		this.gameid = gameid;
		this.imageuse = imageuse;
		this.b64imagedata = b64imagedata;
	}
	
	public int getGameid() {
		return gameid;
	}
	public int getImageuse() {
		return imageuse;
	}
	public String getB64imagedata() {
		return b64imagedata;
	}
	
}
