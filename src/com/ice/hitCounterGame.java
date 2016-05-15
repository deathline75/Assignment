package com.ice;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class hitCounter
 */
@WebServlet("/hitCounterGame")
public class hitCounterGame extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public hitCounterGame() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/*request.getHeader("VIA");               
		request.getHeader("X-FORWARDED-FOR");
		System.out.println(request.getHeader("X-FORWARDED-FOR"));
		Get Ip,But oh well,whatever.
		*/
		String gameid = request.getParameter("gameid");
		connectToMysql connection = new connectToMysql(MyConstants.url);
		//Prevent mutex lock...
		connection.preparedUpdate("insert into game_hitcounter(day,gameids,slot,count)value(CURRENT_DATE,?,RAND()*100,1) on duplicate key update count=count+1",gameid);
		//Format Time 
		java.util.Date date = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String currentTime = sdf.format(date);
		ResultSet rs = connection.preparedQuery("select sum(count) from game_hitcounter where day=? and gameids=?",currentTime,gameid); //Get today
		
		//select gameids,sum(count) from game_hitcounter group by gameids order by count DESC LIMIT 5// Select the most pop to the most not-pop
		
		
		//ResultSet rs = connection.preparedQuery("select sum(count) from daily_hitcounter"); //Get Total count
		try {
			while(rs.next()){
				int hitCounter = rs.getInt(1);
				System.out.println(hitCounter);
				response.getWriter().println(hitCounter);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		connection.close();
	}

}
