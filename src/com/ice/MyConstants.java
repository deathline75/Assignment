package com.ice;

public class MyConstants {
	

	private static String db = "ead";
	private static String db_user = System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
	private static String db_pwd = System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
	private static String host = System.getenv("OPENSHIFT_MYSQL_DB_HOST");
	private static String port = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
	public static final String url = "jdbc:mysql://" + host + ":" + port + "/" + db + "?user=" + db_user + "&password=" + db_pwd; 
	public static final String SECRET_KEY = "6LctkR4TAAAAAFiTQ_ndqdd6Mi8Z66SVJSR3As3n";
}
