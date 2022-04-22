package fr.legrain;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;


public class lancementEdition {

	/**
	 * @param args
	 * @throws MalformedURLException 
	 */
	public static void main(String[] args)     {
//        URL url;        
//		try {
////			url = new URL("http://localhost:8080/birt/frameset?__report=report/report/report_lancement.rptdesign&data=report/report_lancement.xml&__format=pdf&date="+new Date());
//			url = new URL("http://localhost:8080/birt/frameset?__report=report/report/report_lancement.rptdesign&data=report/report_lancement.xml&__format=pdf");
//        HttpURLConnection connection = (HttpURLConnection)url.openConnection();
//        connection.setRequestMethod("GET");
//        connection.connect();
//
//        int code = connection.getResponseCode();
//        System.out.println("Response code of the object is "+code);
//        if (code==200)
//        {
//            System.out.println("OK");
//        }
//		} catch (MalformedURLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		   
		lancementEdition c = new lancementEdition();
			     System.out.println(c.getHTML("http://localhost:8080/birt/frameset?__report=report/report_lancement.rptdesign&data=report/report_lancement.xml&__format=pdf"));
			   }
		   
			   public String getHTML(String urlToRead) {
			      URL url;
			      HttpURLConnection conn;
			      BufferedReader rd;
			      String result = "";
			      try {
			         url = new URL(urlToRead);
			         conn = (HttpURLConnection) url.openConnection();
			         conn.setRequestMethod("GET");
			         rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//			         while ((line = rd.readLine()) != null) {
//			            result += line;
//			         }
			         rd.close();
			      } catch (Exception e) {
			         e.printStackTrace();
			      }
			      return result;
			   }



}

