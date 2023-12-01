package payments;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class HttpPost {
	public static String httpPostBodyConnection(String UrlData, String ParamData) {
		
		//http 요청 시 필요한 url 주소를 변수 선언
		String totalUrl = "";
		totalUrl = UrlData.trim().toString();
		
		//http 통신을 하기위한 객체 선언 실시
		URL url = null;
		HttpURLConnection conn = null;
	    
		//http 통신 요청 후 응답 받은 데이터를 담기 위한 변수
		String responseData = "";	    	   
		BufferedReader br = null;
		StringBuffer sb = null;
		StringBuffer eb = null;
	    
		//메소드 호출 결과값을 반환하기 위한 변수
		String returnData = "";
	 
		try {
			//파라미터로 들어온 url을 사용해 connection 실시
			url = new URL(totalUrl);	
			conn = (HttpURLConnection) url.openConnection();
	        
			//http 요청에 필요한 타입 정의 실시
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json; utf-8"); //post body json으로 던지기 위함
			conn.setRequestProperty("Accept", "application/json");
			conn.setRequestProperty("Authorization", "DEV_SECRET_KEY D27C194BF11935CB62EB33134DE4F53F1918CD05");
			conn.setDoOutput(true); //OutputStream을 사용해서 post body 데이터 전송
			try (OutputStream os = conn.getOutputStream()){
				byte request_data[] = ParamData.getBytes("utf-8");
				os.write(request_data);
				os.close();
			}
			catch(Exception e) {
				e.printStackTrace();
			}										        	            
	        
			//http 요청 실시
			conn.connect();
			System.out.println("http 요청 방식 : "+"POST BODY JSON");
			System.out.println("http 요청 타입 : "+"application/json");
			System.out.println("http 요청 주소 : "+UrlData);
			System.out.println("http 요청 데이터 : "+ParamData);
			String responseCode = String.valueOf(conn.getResponseCode());
			System.out.println("http 응답 코드 : "+responseCode);
			//http 요청 후 응답 받은 데이터를 버퍼에 쌓는다
			
			Gson gson = new Gson();
			
			if (responseCode.equals("200") == false) {
				BufferedReader er = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));	
				eb = new StringBuffer();	       
				while ((responseData = er.readLine()) != null) {
					eb.append(responseData); //StringBuffer에 응답받은 데이터 순차적으로 저장 실시
				}
				
				System.out.println("http 오류 데이터 : "+eb.toString());
				Map<String, Object> data = gson.fromJson(eb.toString(), new TypeToken<Map<String, Object>>(){});
				Map<String, Object> error = new HashMap<String, Object>();
				error.put("result", "error");
				error.put("reason", data.get("error_message"));
				return error.toString();
			} else {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));	
				sb = new StringBuffer(); 	       
				while ((responseData = br.readLine()) != null) {
					sb.append(responseData); //StringBuffer에 응답받은 데이터 순차적으로 저장 실시
				}
	
				//메소드 호출 완료 시 반환하는 변수에 버퍼 데이터 삽입 실시
				returnData = sb.toString(); 
				
				//http 요청 응답 코드 확인 실시
				System.out.println(returnData);
				 responseCode = String.valueOf(conn.getResponseCode());
				System.out.println("http 응답 코드 : "+responseCode);
				System.out.println("http 응답 데이터 : "+returnData);
			}
	 
		} catch (IOException e) {
			e.printStackTrace();
			return e.getMessage();
		} finally { 
			//http 요청 및 응답 완료 후 BufferedReader를 닫아줍니다
			try {
				if (br != null) {
					br.close();	
				}
				returnData = sb.toString(); 
				System.out.println("http 응답 데이터 : "+returnData);
				return returnData;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return returnData;	 		
	}
}
