package com.ice.util;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;

import com.google.gson.Gson;
import com.ice.MyConstants;
 
public class VerifyUtils {
 
	public class CaptchaResponse {
	    public boolean success;

	    public boolean isSuccess() {
	        return success;
	    }

	    public void setSuccess(boolean success) {
	        this.success = success;
	    }
	}
	
   public static final String SITE_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";
 
   public static boolean verify( String gRecaptchaResponse) {
       if (gRecaptchaResponse == null || gRecaptchaResponse.length() == 0) {
           return false;
       }
 
       try {
           URL verifyUrl = new URL(SITE_VERIFY_URL);
 
           // Open Connection to URL
           HttpsURLConnection conn = (HttpsURLConnection) verifyUrl.openConnection();
 
 
           // Add Request Header
           conn.setRequestMethod("POST");
           conn.setRequestProperty("User-Agent", "Mozilla/5.0");
           conn.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
 
 
           // Data will be sent to the server.
           String postParams = "secret=" + MyConstants.SECRET_KEY + "&response=" + gRecaptchaResponse;
 
           // Send Request
           conn.setDoOutput(true);
          
           // Get the output stream of Connection
           // Write data in this stream, which means to send data to Server.
           OutputStream outStream = conn.getOutputStream();
           outStream.write(postParams.getBytes());
 
           outStream.flush();
           outStream.close();
 
           // Get the InputStream from Connection to read data sent from the server.
           InputStream is = conn.getInputStream();
 
           Gson gson = new Gson();
           CaptchaResponse response = gson.fromJson(new InputStreamReader(is, "UTF-8"), CaptchaResponse.class);
 
           // ==> {"success": true}
           return response.success;
       } catch (Exception e) {
           e.printStackTrace();
           return false;
       }
   }
}