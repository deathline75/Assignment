package com.ice;

import java.sql.Timestamp;

public class Game {
	
	private int id;
	private String title;
	private String company;
	private Timestamp releaseDate;
	private String description;
	private double price;
	private boolean preowned;
	private boolean supportWin;
	private boolean supportMac;
	private boolean supportXbox;
	private boolean supportLinux;
	private boolean supportPs4;
	private boolean supportWiiu;
	
	public Game(int id, String title, String company, Timestamp releaseDate, String description, double price,
			boolean preowned, boolean supportWin, boolean supportMac, boolean supportXbox, boolean supportLinux,
			boolean supportPs4, boolean supportWiiu) {
		super();
		this.id = id;
		this.title = title;
		this.company = company;
		this.releaseDate = releaseDate;
		this.description = description;
		this.price = price;
		this.preowned = preowned;
		this.supportWin = supportWin;
		this.supportMac = supportMac;
		this.supportXbox = supportXbox;
		this.supportLinux = supportLinux;
		this.supportPs4 = supportPs4;
		this.supportWiiu = supportWiiu;
	}
	
	public int getId() {
		return id;
	}
	public String getTitle() {
		return title;
	}
	public String getCompany() {
		return company;
	}
	public Timestamp getReleaseDate() {
		return releaseDate;
	}
	public String getDescription() {
		return description;
	}
	public double getPrice() {
		return price;
	}
	public boolean isPreowned() {
		return preowned;
	}
	public boolean isSupportWin() {
		return supportWin;
	}
	public boolean isSupportMac() {
		return supportMac;
	}
	public boolean isSupportXbox() {
		return supportXbox;
	}
	public boolean isSupportLinux() {
		return supportLinux;
	}
	public boolean isSupportPs4() {
		return supportPs4;
	}
	public boolean isSupportWiiu() {
		return supportWiiu;
	}
	
	
}
