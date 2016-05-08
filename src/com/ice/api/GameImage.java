package com.ice.api;

/**
 * GameImage is a POJO which is mostly implemented with GSON.
 * @author Kelvin Neo
 *
 */
public class GameImage {
	
	private int gameid;
	private int imageuse;
	private String mimeType;
	private String b64imagedata;
	
	/**
	 * Used for image thumbnails.
	 * Eg. Listing of games
	 */
	public static final int IMAGE_THUMBNAIL = 0;
	/**
	 * Used for carousels or in the actual game page
	 */
	public static final int IMAGE_JUMBOTRON = 1;
	/**
	 * Used for promotions at the side of the website
	 */
	public static final int IMAGE_PROMOTION = 2;
	
	public GameImage(int gameid, int imageuse, String mimeType, String b64imagedata) {
		super();
		this.gameid = gameid;
		this.imageuse = imageuse;
		this.mimeType = mimeType;
		this.b64imagedata = b64imagedata;
	}
	
	/**
	 * Gets the Game ID associated with this image
	 * @return The Game ID associated with this image
	 */
	public int getGameid() {
		return gameid;
	}
	
	/**
	 * Gets the use of this image.
	 * @see {@code IMAGE_THUMBNAIL} 
	 * {@code IMAGE_JUMBOTRON} 
	 * {@code IMAGE_PROMOTION} 
	 * @return The use of this image.
	 */
	public int getImageuse() {
		return imageuse;
	}
	
	/**
	 * Gets the MIME type for this image
	 * @return The MIME type for this image
	 */
	public String getMimeType() {
		return mimeType;
	}
	
	/**
	 * Gets the image encoded in Base64
	 * @return The image encoded in Base64
	 */
	public String getB64imagedata() {
		return b64imagedata;
	}
	
}
