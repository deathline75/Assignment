package com.ice;

import java.sql.*;

public class connectToMysql {
	public static String url = "jdbc:mysql://188.166.238.151/ead?user=root&password=iloveeadxoxo";
	public static Connection conn;
	public static ResultSet rs;
	public static String sqlStr;
	public static PreparedStatement pstmt;
	public static Statement stat= null;

	public static Connection connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url);
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
