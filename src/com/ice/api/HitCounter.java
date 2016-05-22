package com.ice.api;

public class HitCounter {
	
	private String element;
	private int hitCounter;
	
	public HitCounter(String element,int hitCounter){
		this.element = element;
		this.hitCounter = hitCounter;
	}
	
	public String getelement(){
		return element;
	}
	
	public int getHitCount(){
		return hitCounter;
	}
	
	
}
