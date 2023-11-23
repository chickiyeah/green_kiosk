package servlet.index;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.net.URLDecoder;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import user.Member_Bean;
import user.Member_Mgr;

/**
 * Servlet implementation class User_Api
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/api/user/update", "/api/user/check_pw", "/api/user/verify/smile" })
public class User_Api extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public User_Api() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String endPoint = request.getServletPath();
		if (endPoint.equals("/api/user/check_pw")) {
			RequestDispatcher rd = request.getRequestDispatcher("/user/pw_check.jsp");
			rd.forward(request, response);
		} else {
			response.sendError(405);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String endPoint = request.getServletPath();// TODO Auto-generated method stub
		Member_Mgr mgr = new Member_Mgr();
		PrintWriter out = response.getWriter();
		if (endPoint.equals("/api/user/update")) {
			HttpSession session = request.getSession();
			String mem_id = String.valueOf(session.getAttribute("mem_id"));
			String Name = request.getParameter("name");
			String phone = request.getParameter("phone");
			
			boolean res = mgr.updateMember(mem_id, Name, phone);
			if(res){
				  out.write("{\"result\":\"success\"}");
			  } else {
				  out.write("{\"result\":\"failed\"}");
			  }
		}
		
		
		
		if (endPoint.equals("/api/user/verify/smile")) {
			
			BufferedReader reader = request.getReader();
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
			String smile = sb.toString();
			
			if (smile == null || smile.isEmpty()) {
				response.sendError(400, "Parameter is null");
				return;
			}
			
			try {
				smile = URLDecoder.decode(smile, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				response.sendError(400, "Parameter is not encode by RFC-3986");
				e.printStackTrace();
	          return;
			}

			Type type = new TypeToken<Map<String, String>>() {}.getType();
			Map<String, String> smile_map = new Gson().fromJson(smile, type);
			
			if (smile_map.get("type").equals("phoneNumber") && mgr.checkPhone(smile_map.get("value"))) {
				Member_Bean member_bean = mgr.get_user_with_phone(smile_map.get("value"));
				out.write("{"
						+ "\"index\": \"" + member_bean.getMem_no() + "\","
					    + "\"name\": \"" + member_bean.getMem_name() + "\","
						+ "\"mileage\": \"" + member_bean.getMem_mile() + "\","
						+ "\"value\": \"" + smile_map.get("value") + "\","
					    + "\"type\": \"" + smile_map.get("type") + "\""
						+ "}");
			} else if (smile_map.get("type").equals("cardNumber") && mgr.checkCard(smile_map.get("value"))) {
				Member_Bean member_bean = mgr.get_user_with_card(smile_map.get("value"));
				out.write("{"
						+ "\"index\": \"" + member_bean.getMem_no() + "\","
					    + "\"name\": \"" + member_bean.getMem_name() + "\","
						+ "\"mileage\": \"" + member_bean.getMem_mile() + "\","
						+ "\"value\": \"" + smile_map.get("value") + "\","
					    + "\"type\": \"" + smile_map.get("type") + "\""
						+ "}");
			} else {
				out.write("{"
						+ "\"index\": 0,"
					    + "\"name\": \"x\","
						+ "\"mileage\": 0,"
						+ "\"value\": \"x\","
					    + "\"type\": \"x\""
						+ "}");
			}
			
		}
	}

}
