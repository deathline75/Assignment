package com.ice.api;

import java.util.List;

public class SearchResult {
	
	private int responseCode;
	private String errorMessage;
	private List<?> results;
	
	public SearchResult(int responseCode, String errorMessage, List<?> results) {
		super();
		this.responseCode = responseCode;
		this.errorMessage = errorMessage;
		this.results = results;
	}
	
	public int getResponseCode() {
		return responseCode;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public List<?> getData() {
		return results;
	}
	
}
