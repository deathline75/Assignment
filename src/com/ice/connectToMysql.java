package com.ice;

import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.*;

public class ConnectToMySQL {
	private Connection conn;
	private String connectionURL;
	private ResultSet rs;
	private PreparedStatement pstmt;
	private Statement stat = null;
	
	/**
	 * Connect to a MySQL server
	 * @param connectionURL The connection string to connect to MySQL
	 */
	public ConnectToMySQL(String connectionURL) {
		this.connectionURL = connectionURL;
	}

	private void connect() throws SQLException, ClassNotFoundException{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectionURL);
			System.out.print("Success");
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
        try{  
        	connect();
            stat = conn.createStatement();  
            rs = stat.executeQuery(sql);  
        }catch(Exception ex){  
            ex.printStackTrace();  
        }
    	// Incredibly dangerous
        return rs;  
    }  
    
    /**
     * Query anything with extra security using prepared statements.
     * @param sql SQL statement to query
     * @param values Values to substitute into the prepared statement
     * @return The ResultSet for the query
     */
    public ResultSet preparedQuery(String sql, Object... values) {
    	try {
    		connect();
			pstmt = conn.prepareStatement(sql);
			
			for (int i = 0; i < values.length; i++) {
				if (values[i] instanceof Integer) 
					pstmt.setInt(i + 1, (int) values[i]);
				else if (values[i] instanceof Double)
					pstmt.setDouble(i + 1, (double) values[i]); 
				else if (values[i] instanceof String)
					pstmt.setString(i + 1, (String) values[i]);
				else if (values[i] instanceof Time)
					pstmt.setTime(i + 1, (Time) values[i]);
				else if (values[i] instanceof Timestamp)
					pstmt.setTimestamp(i + 1, (Timestamp) values[i]);
				else if (values[i] instanceof Boolean)
					pstmt.setBoolean(i + 1, (boolean) values[i]);
				else if (values[i] instanceof Float)
					pstmt.setFloat(i + 1, (float) values[i]);
				else if (values[i] instanceof Date)
					pstmt.setDate(i + 1, (Date) values[i]);
				else if (values[i] instanceof byte[])
					pstmt.setBytes(i + 1, (byte[]) values[i]);
				else if (values[i] instanceof Long) 
					pstmt.setLong(i + 1, (long) values[i]);
				else if (values[i] instanceof Short)
					pstmt.setShort(i + 1, (short) values[i]);
				else if (values[i] instanceof BigDecimal)
					pstmt.setBigDecimal(i + 1, (BigDecimal) values[i]);
				else if (values[i] instanceof InputStream)
					pstmt.setBinaryStream(i + 1, (InputStream) values[i]);
				else
					pstmt.setObject(i + 1, values[i]);
			}
			
			rs = pstmt.executeQuery();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
    	// Incredibly dangerous
		return rs;
    }

}
