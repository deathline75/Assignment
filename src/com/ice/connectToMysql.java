package com.ice;

import java.sql.*;

public class connectToMysql {
	public static Connection conn;
	public static ResultSet rs;
	public static String sqlStr;
	public static PreparedStatement pstmt;
	public static Statement stat= null;

	public static Connection connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(MyConstants.url);
			System.out.print("Success");
		} catch (Exception e) {
			System.out.print(e);
		}
		
		return conn;
	}

    public static ResultSet query(String sql){  
        try{  
            conn = connect();  
            stat = conn.createStatement();  
            rs = stat.executeQuery(sql);  
        }catch(Exception ex){  
            ex.printStackTrace();  
        }  
        return rs;  
    }  

}
