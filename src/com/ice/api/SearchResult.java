package com.ice.api;

import java.util.List;

/**
 * SearchResult is a POJO which is mainly used in GSON.
 * SearchResult is implemented mostly as a way for people to handle different responses that the API can throw.
 * @author Kelvin Neo
 *
 */
public class SearchResult {
	
	private int responseCode;
	private String errorMessage;
	private List<?> results;
	
	/**
	 * This response code is thrown when no results is returned when searching
	 */
	public static final int NO_RESULTS = -1;
	
	/**
	 * This response code is thrown when no errors are thrown and the query is executed successfully.
	 */
	public static final int SUCCESS = 0;
	
	/**
	 * This response code is thrown when the API expected more input data but received none or too few.
	 */
	public static final int LACK_OF_INPUT = 100;
	
	/**
	 * This response code is thrown when an {@link java.sql.SQLException} has occurred.
	 */
	public static final int SQL_EXCEPTION = 500;
	
	public SearchResult(int responseCode, String errorMessage, List<?> results) {
		super();
		this.responseCode = responseCode;
		this.errorMessage = errorMessage;
		this.results = results;
	}
	
	/**
	 * Gets the response code returned by the search result
	 * @return The response code returned by the search result
	 */
	public int getResponseCode() {
		return responseCode;
	}
	
	/**
	 * Gets the error message returned if there are any.
	 * @return The error message returned if there are any.
	 */
	public String getErrorMessage() {
		return errorMessage;
	}
	
	/**
	 * Gets the data returned from the search result.
	 * @return The data returned from the search result.
	 */
	public List<?> getData() {
		return results;
	}
	
}
