package com.ice.api;

public class HitCounter {
	
	private String gameTitle;
	private int hitCounter;
	
	public HitCounter(String gameTitle,int hitCounter){
		this.gameTitle = gameTitle;
		this.hitCounter = hitCounter;
	}
	
	public String getTitle(){
		return gameTitle;
	}
	
	public int getHitCount(){
		return hitCounter;
	}
	
	
}
