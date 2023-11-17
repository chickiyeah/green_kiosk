package payments;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class kakao_pay
 */
@WebServlet({"/kakao_pay", "/kakao_pay/success", "/kakao_pay/cancel", "/kakao_pay/fail" })
public class kakao_pay extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson();
	private Map<String, String> bfdatas = new HashMap<String, String>();
	private Map<String, String> afdatas = new HashMap<String, String>();
	private Map<String, Object> pay_return = new HashMap<String, Object>();
	private Map<String, Object> pay_return_af = new HashMap<String, Object>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public kakao_pay() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String endPoint = request.getServletPath();
		// TODO Auto-generated method stub
		
		if (endPoint.equals("/kakao_pay")) {
			String url = "https://open-api.kakaopay.com/online/v1/payment/ready";
			HttpSession session = request.getSession();
			String decodefoods = URLDecoder.decode(String.valueOf(request.getParameter("foods")), "UTF-8");
			System.out.println(decodefoods);
			List<Map<String, String>> foods = gson.fromJson(decodefoods, new TypeToken<List<Map<String, String>>>() {}.getType());
			List<Map<String, Object>> coupons = null;
			Map<String, Integer> mile = null;

			
			String name = "";
			Integer all_money = 0;
			
			for (Map<String, String> food : foods) {
				if (name.equals("")) {
					name = food.get("name") + " X " + food.get("amount") + " 외 " + (foods.size() - 1) + " 종";
				}
				all_money += (Integer.parseInt(String.valueOf(food.get("price"))) * Integer.parseInt(String.valueOf(food.get("amount"))));
			}
			
			if (request.getParameter("coupons") != null) {
				String decodecoupons = URLDecoder.decode(String.valueOf(request.getParameter("coupons")), "UTF-8");
				coupons = gson.fromJson(String.valueOf(decodecoupons), new TypeToken<List<Map<String, Object>>>() {}.getType());
				
				for (Map<String, Object> coupon : coupons) {
					all_money -= Integer.parseInt(String.valueOf(coupon.get("discount")).substring(0, String.valueOf(coupon.get("discount")).length() - 2));
				}
			}
			
			if (request.getParameter("mile_map") != null) {
				mile = gson.fromJson(String.valueOf(request.getParameter("mile_map")), new TypeToken<Map<String, Integer>>() {}.getType());
			}
			
			this.bfdatas.put("cid", "TC0ONETIME"); //String
			this.bfdatas.put("partner_order_id", "1"); //String
			this.bfdatas.put("partner_user_id", "test"); //String
			this.bfdatas.put("item_name", name); //String
			this.bfdatas.put("quantity", "1"); //Integer
			this.bfdatas.put("total_amount", String.valueOf(all_money)); //Integer
			this.bfdatas.put("tax_free_amount", "500"); //Integer
			this.bfdatas.put("approval_url", "https://nodove.duckdns.org"+request.getContextPath()+"/kakao_pay/success"); //String
			this.bfdatas.put("cancel_url", "https://nodove.duckdns.org"+request.getContextPath()+"/kakao_pay/fail"); //String
			this.bfdatas.put("fail_url", "https://nodove.duckdns.org"+request.getContextPath()+"/kakao_pay/cancel"); //String
			
			String data = "{";
			
			for(Map.Entry<String, String> entry : this.bfdatas.entrySet()) {
				String Key = entry.getKey();
				String Value = entry.getValue();
				data += "\""+Key+"\" : \""+Value+"\",";
			}
			data = data.substring(0, data.length() - 1) + "}";
			
			
			Map<String, Object> returnData = gson.fromJson(HttpPost.httpPostBodyConnection(url, data), new TypeToken<HashMap<String, Object>>(){}.getType());
			this.pay_return = returnData;
			
			session.setAttribute("bfdatas", gson.toJson(this.bfdatas));
			session.setAttribute("pay_return", gson.toJson(returnData));
			response.sendRedirect(String.valueOf(returnData.get("next_redirect_pc_url")));
		}
		
		if (endPoint.equals("/kakao_pay/success")) {
			String url = "https://open-api.kakaopay.com/online/v1/payment/approve";
			String pg_token = request.getParameter("pg_token");
			HttpSession session = request.getSession();
			if (pg_token == null || pg_token.trim().equals("")) {
				response.sendError(403);
			} else {
				System.out.println(String.valueOf(session.getAttribute("bfdatas")));
				Map<String, Object> bfdatas = gson.fromJson(String.valueOf(session.getAttribute("bfdatas")), new TypeToken<HashMap<String, Object>>(){}.getType());
				Map<String, Object> pay_return = gson.fromJson(String.valueOf(session.getAttribute("pay_return")),new TypeToken<HashMap<String, Object>>(){}.getType());
				
				this.afdatas.put("cid", "TC0ONETIME");
				this.afdatas.put("tid", String.valueOf(pay_return.get("tid")));
				this.afdatas.put("partner_order_id", String.valueOf(bfdatas.get("partner_order_id")));
				this.afdatas.put("partner_user_id", String.valueOf(bfdatas.get("partner_user_id")));
				this.afdatas.put("pg_token", pg_token);
				
				String data = "{";
				
				for(Map.Entry<String, String> entry : this.afdatas.entrySet()) {
					String Key = entry.getKey();
					String Value = entry.getValue();
					data += "\""+Key+"\" : \""+Value+"\",";
				}
				data = data.substring(0, data.length() - 1) + "}";
				
				Map<String, Object> returnData = gson.fromJson(HttpPost.httpPostBodyConnection(url, data), new TypeToken<HashMap<String, Object>>(){}.getType());
				this.pay_return_af = returnData;
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}