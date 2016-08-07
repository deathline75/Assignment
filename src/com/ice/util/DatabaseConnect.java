package com.ice.util;

import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.*;

public class DatabaseConnect {
	private Connection conn;
	private String connectionURL;
	
	/**
	 * Connect to a MySQL server
	 * @param connectionURL The connection string to connect to MySQL
	 */
	public DatabaseConnect(String connectionURL) {
		this.connectionURL = connectionURL;
    	try {
			connect();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void connect() throws SQLException, ClassNotFoundException{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectionURL);
	}
	
	public void close() {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Query anything with no overhead. 
	 * @param sql SQL Statement to query
	 * @return The ResultSet for the query
	 */
    public ResultSet query(String sql){  
    	ResultSet rs = null;
        try{  
            Statement stat = conn.createStatement();  
            rs = stat.executeQuery(sql);  
        }catch(Exception ex){  
            ex.printStackTrace();  
        }
    	// Incredibly dangerous
        return rs;  
    }  
    
    
    private PreparedStatement prepareStatement(String sql, Object... values) {
		try {
			PreparedStatement ps = conn.prepareStatement(sql);		
			
			for (int i = 0; i < values.length; i++) {
				if (values[i] instanceof Integer) 
					ps.setInt(i + 1, (int) values[i]);
				else if (values[i] instanceof Double)
					ps.setDouble(i + 1, (double) values[i]); 
				else if (values[i] instanceof String)
					ps.setString(i + 1, (String) values[i]);
				else if (values[i] instanceof Time)
					ps.setTime(i + 1, (Time) values[i]);
				else if (values[i] instanceof Timestamp)
					ps.setTimestamp(i + 1, (Timestamp) values[i]);
				else if (values[i] instanceof Boolean)
					ps.setBoolean(i + 1, (boolean) values[i]);
				else if (values[i] instanceof Float)
					ps.setFloat(i + 1, (float) values[i]);
				else if (values[i] instanceof Date)
					ps.setDate(i + 1, (Date) values[i]);
				else if (values[i] instanceof byte[])
					ps.setBytes(i + 1, (byte[]) values[i]);
				else if (values[i] instanceof Long) 
					ps.setLong(i + 1, (long) values[i]);
				else if (values[i] instanceof Short)
					ps.setShort(i + 1, (short) values[i]);
				else if (values[i] instanceof BigDecimal)
					ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
				else if (values[i] instanceof InputStream)
					ps.setBinaryStream(i + 1, (InputStream) values[i]);
				else
					ps.setObject(i + 1, values[i]);
			}

			return ps;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }
    
    /**
     * Query anything with extra security using prepared statements.
     * @param sql SQL statement to query
     * @param values Values to substitute into the prepared statement
     * @return The ResultSet for the query
     */
    public ResultSet preparedQuery(String sql, Object... values) {
    	ResultSet rs = null;
    	try {
			PreparedStatement pstmt = prepareStatement(sql, values);
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	// Incredibly dangerous
		return rs;
    }
    
    /**
     * Update / Insert / Delete anything with extra security using prepared statements
     * @param sql SQL statement to execute
     * @param values Values to substitude into the prepared statement
     * @return (-1) for unable to connect or instantiate SQL, (0) for returning nothing, or the amount of rows updated.
     */
    public int preparedUpdate(String sql, Object... values) {
    	try {
    		PreparedStatement pstmt = prepareStatement(sql, values);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return -1;
    }
    
    /**
     * Update / Insert / Delete anything with extra security using prepared statements and returns auto-generated keys
     * @param sql SQL statement to execute
     * @param values Values to substitude into the prepared statement
     * @return The ResultSet with the auto-generated key
     */
    public ResultSet preparedUpdateAutoKey(String sql, Object... values) {
    	try {
			PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);		
			
			for (int i = 0; i < values.length; i++) {
				if (values[i] instanceof Integer) 
					ps.setInt(i + 1, (int) values[i]);
				else if (values[i] instanceof Double)
					ps.setDouble(i + 1, (double) values[i]); 
				else if (values[i] instanceof String)
					ps.setString(i + 1, (String) values[i]);
				else if (values[i] instanceof Time)
					ps.setTime(i + 1, (Time) values[i]);
				else if (values[i] instanceof Timestamp)
					ps.setTimestamp(i + 1, (Timestamp) values[i]);
				else if (values[i] instanceof Boolean)
					ps.setBoolean(i + 1, (boolean) values[i]);
				else if (values[i] instanceof Float)
					ps.setFloat(i + 1, (float) values[i]);
				else if (values[i] instanceof Date)
					ps.setDate(i + 1, (Date) values[i]);
				else if (values[i] instanceof byte[])
					ps.setBytes(i + 1, (byte[]) values[i]);
				else if (values[i] instanceof Long) 
					ps.setLong(i + 1, (long) values[i]);
				else if (values[i] instanceof Short)
					ps.setShort(i + 1, (short) values[i]);
				else if (values[i] instanceof BigDecimal)
					ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
				else if (values[i] instanceof InputStream)
					ps.setBinaryStream(i + 1, (InputStream) values[i]);
				else
					ps.setObject(i + 1, values[i]);
			}
			ps.executeUpdate();
			return ps.getGeneratedKeys();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return null;
    }

}
