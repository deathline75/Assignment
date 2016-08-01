package com.ice.api;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ice.MyConstants;
import com.ice.connectToMysql;

/**
 * Servlet implementation class ShopCartItems
 */
@WebServlet("/ShopCartItems")
public class ShopCartItems extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShopCartItems() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = new User();
		ArrayList<ShopCartItem> shopCartBean= new ArrayList<ShopCartItem>();
		connectToMysql connection = new connectToMysql(MyConstants.url);
		ResultSet rs = connection.preparedQuery("select * from ",user.getId());
		
		try {
			while(rs.next()){
				shopCartBean.add(new ShopCartItem(rs.getInt(1),rs.getInt(2),rs.getInt(3),rs.getInt(4)));
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
