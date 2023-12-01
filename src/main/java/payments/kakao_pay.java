package payments;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coupon.Coupon_Mgr;
import orders.Orders_Bean;
import orders.Orders_Mgr;

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
	public static final String ISO_8601_24H_FULL_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX";
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
			session.setAttribute("kakao_foods", null);
			session.setAttribute("kakao_all_money", null);
			session.setAttribute("bfdatas", null);
			session.setAttribute("pay_return", null);
			session.setAttribute("kakaopay_coupons", null);
			session.setAttribute("kakao_all_money", null);
			String decodefoods = URLDecoder.decode(String.valueOf(request.getParameter("foods")), "UTF-8");
			System.out.println(decodefoods);
			
			List<Map<String, String>> foods = gson.fromJson(decodefoods, new TypeToken<List<Map<String, String>>>() {}.getType());
			List<Map<String, Object>> coupons = null;
			Map<String, Integer> mile = null;

			
			String name = "";
			long all_money = 0;
			
			for (Map<String, String> food : foods) {
				if (name.equals("")) {
					name = food.get("name") + " X " + food.get("amount") + " 외 " + (foods.size() - 1) + " 종";
				}
				all_money += ((long) Integer.parseInt(String.valueOf(food.get("price"))) * Integer.parseInt(String.valueOf(food.get("amount"))));
			}
			
			if (request.getParameter("coupons") != null) {
				String decodecoupons = URLDecoder.decode(String.valueOf(request.getParameter("coupons")), "UTF-8");
				coupons = gson.fromJson(String.valueOf(decodecoupons), new TypeToken<List<Map<String, Object>>>() {}.getType());
				session.setAttribute("kakaopay_coupons", String.valueOf(decodecoupons));
				Coupon_Mgr c_mgr = new Coupon_Mgr();
				PrintWriter out = response.getWriter();
				for (Map<String, Object> coupon : coupons) {
					String code = String.valueOf(coupon.get("code"));
					Map<String, String> result = c_mgr.checkCouponVaild(code);
					if (result.get("result").equals("failed")) {
						out.write("{\"result\":\"coupon_failed\", \"reason\":\"code "+code+" | "+result.get("reason")+"\"}");
						return;
					} else {
						all_money -= Integer.parseInt(String.valueOf(coupon.get("discount")).substring(0, String.valueOf(coupon.get("discount")).length() - 2));
					}
					
				}
				
			} else {
				session.setAttribute("kakaopay_coupons", null);
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
			this.bfdatas.put("cancel_url", "https://nodove.duckdns.org"+request.getContextPath()+"/kakao_pay/cancel"); //String
			this.bfdatas.put("fail_url", "https://nodove.duckdns.org"+request.getContextPath()+"/kakao_pay/fail"); //String
			//"https://nodove.duckdns.org"+
			String data = "{";
			
			for(Map.Entry<String, String> entry : this.bfdatas.entrySet()) {
				String Key = entry.getKey();
				String Value = entry.getValue();
				data += "\""+Key+"\" : \""+Value+"\",";
			}
			data = data.substring(0, data.length() - 1) + "}";
			
			
			Map<String, Object> returnData = gson.fromJson(HttpPost.httpPostBodyConnection(url, data), new TypeToken<HashMap<String, Object>>(){}.getType());
			this.pay_return = returnData;
			
			session.setAttribute("kakao_foods", decodefoods);
			session.setAttribute("kakao_all_money", all_money);
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
				session = request.getSession();
				String s_foods = String.valueOf(session.getAttribute("kakao_foods"));
				List<Map<String, String>> foods = gson.fromJson(s_foods, new TypeToken<List<Map<String, String>>>() {}.getType());
				Map<String, Object> bfdatas = gson.fromJson(String.valueOf(session.getAttribute("bfdatas")), new TypeToken<HashMap<String, Object>>(){}.getType());
				Map<String, Object> pay_return = gson.fromJson(String.valueOf(session.getAttribute("pay_return")),new TypeToken<HashMap<String, Object>>(){}.getType());				
				List<Map<String, Object>> coupons = null;
				long coupon_money = 0;
				if (session.getAttribute("kakaopay_coupons") != null) {
					coupons = gson.fromJson(String.valueOf(session.getAttribute("kakaopay_coupons")), new TypeToken<List<Map<String, Object>>>() {}.getType());
					Coupon_Mgr c_mgr = new Coupon_Mgr();
					PrintWriter out = response.getWriter();
					for (Map<String, Object> coupon : coupons) {
						String code = String.valueOf(coupon.get("code"));
						Map<String, String> result = c_mgr.useCoupon(code);
						if (result.get("result").equals("failed")) {
							out.write("{\"result\":\"coupon_failed\", \"reason\":\"code "+code+" | "+result.get("reason")+"\"}");
							return;
						} else {
							coupon_money += Integer.parseInt(String.valueOf(coupon.get("discount")));
						}
					}
				} else {
					session.setAttribute("kakaopay_coupons", null);
				}
				
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
				
				String order_type = "";
				Date now = Calendar.getInstance().getTime();
				
				Timestamp ts = new Timestamp(now.getTime());
				Timestamp Approved_At = ts;
				if (returnData.get("payment_method_type").equals("CARD")) {
					//카카오페이 결제수단이 카드임
					System.out.println(String.valueOf(returnData.get("card_info")).replace("=,", "=\"\","));
					Map<String, String> card_info = gson.fromJson(String.valueOf(returnData.get("card_info")).replace("=,", "=\"\","), new TypeToken<HashMap<String, String>>(){}.getType());
					String Card_Corp = String.valueOf(card_info.get("kakaopay_purchase_corp")); // 카드 회사
					String Card_Type = String.valueOf(card_info.get("card_type")); // 신용 / 체크
					
					SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
					Date date = null;
					try {
						date = isoFormat.parse(String.valueOf(returnData.get("approved_at")));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						
					}
					Approved_At = new Timestamp(date.getTime());// 승인시간
					order_type = "kakao_card("+Card_Corp+")";
				} else {
					//카카오페이머니로 결제
					order_type = "kakao_money";
				}
				
				Map<String, Integer> amount = gson.fromJson(String.valueOf(returnData.get("amount")), new TypeToken<Map<String, Integer>>(){}.getType());				
				String s_coupon = null;
				if (coupons == null) {
					s_coupon = "[]";
				} else {
					s_coupon = String.valueOf(session.getAttribute("kakaopay_coupons")).replace("\'","\"");
				}
				
				long all_money = Integer.parseInt(String.valueOf(session.getAttribute("kakao_all_money")));
				
				long real_money = (long) Integer.parseInt(String.valueOf(amount.get("total")));
				
				long discount = (all_money - real_money) + coupon_money;
				
				Object mem_id = session.getAttribute("mem_id");
				Orders_Bean bean = new Orders_Bean();
				Orders_Mgr o_mgr = new Orders_Mgr();
				if (mem_id == null) {
					//비회원 결제
					bean.set_who(null);
					bean.setOrder_add_amount(0);
					bean.setOrder_add_mile(false);
					bean.setOrder_coupon(s_coupon);
					bean.setOrder_discount(discount);
					bean.setOrder_foods(s_foods.replace("\'","\""));
					bean.setOrder_is_maked(false);
					bean.setOrder_is_togo(true);
					bean.setOrder_price(real_money);
					bean.setOrder_time(Approved_At);
					bean.setOrder_type(order_type);
					bean.setOrder_use_amount(0);
					bean.setOrder_use_mile(false);
					o_mgr.no_user_order(bean);
				} else {
					//회원 결제
					bean.set_who(String.valueOf(mem_id));
					bean.setOrder_add_amount(0);
					bean.setOrder_add_mile(false);
					bean.setOrder_coupon(s_coupon);
					bean.setOrder_discount(discount);
					bean.setOrder_foods(s_foods.replace("\'","\""));
					bean.setOrder_is_maked(false);
					bean.setOrder_is_togo(true);
					bean.setOrder_price(real_money);
					bean.setOrder_time(Approved_At);
					bean.setOrder_type(order_type);
					bean.setOrder_use_amount(0);
					bean.setOrder_use_mile(false);
					o_mgr.addOrder(bean);
				}
				
				response.sendRedirect(request.getContextPath()+"/kiosk/purchase/finally.jsp");
			}
		}
		
		if (endPoint.equals("/kakao_pay/fail") || endPoint.equals("/kakao_pay/cancel")) {
			response.sendRedirect(request.getContextPath()+"/kiosk/KIOSK/kiosk.jsp");
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
