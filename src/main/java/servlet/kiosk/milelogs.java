package servlet.kiosk;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import mile.Mile_log_Bean;
import mile.Mile_log_Mgr;

/**
 * Servlet implementation class milelogs
 */
@WebServlet("/api/kiosk/milelogs")
public class milelogs extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Mile_log_Bean bean = new Mile_log_Bean();
	private Mile_log_Mgr mgr = new Mile_log_Mgr();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public milelogs() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uid = request.getParameter("uid");
		PrintWriter out = response.getWriter();
		if (uid == null) {
			out.write("{\"result\":\"failed\",\"reason\":\"no parameter\"}");
		} else {
			Vector<Mile_log_Bean> v_bean = this.mgr.getMileLogsByUid(uid);
			out.print(v_bean);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		
		BufferedReader reader = req.getReader();
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}
		String mile_log = sb.toString();
		
		if (mile_log == null || mile_log.isEmpty()) {
			res.sendError(400, "Parameter is null");
			return;
		}
		
		try {
			mile_log = URLDecoder.decode(mile_log, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			res.sendError(400, "Parameter is not encode by RFC-3986");
			e.printStackTrace();
          return;
		}
		
		Mile_log_Bean bean = new Gson().fromJson(mile_log, Mile_log_Bean.class);
		
		System.out.println(bean.getMem_uid());
		
		boolean flag = this.mgr.addMileLog(bean);
		
		if (flag) {
			out.write("{"
					+ "\"result\": true"
					+ "}");
		} else {
			out.write("{"
					+ "\"result\": false"
					+ "}");
		}
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String param = request.getParameter("bean");
		PrintWriter out = response.getWriter();
		if (param == null) {
			out.write("{\"result\":\"failed\",\"reason\":\"no parameter\"}");
		} else {
			Mile_log_Bean bean = new Gson().fromJson(param, Mile_log_Bean.class); ;
			boolean res = this.mgr.updateMileLog(bean);
			if (res) {
				out.write("{\"result\":\"success\"}");
			} else {
				out.write("{\"result\":\"failed\"}");
			}
		}
	}

	/**
	 * @see HttpServlet#doDelete(HttpServletRequest, HttpServletResponse)
	 */
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String param = request.getParameter("no");
		PrintWriter out = response.getWriter();
		if (param == null) {
			out.write("{\"result\":\"failed\",\"reason\":\"no parameter\"}");
		} else {
			Integer no = Integer.parseInt(param);
			boolean res = this.mgr.deleteMileLogByNo(no);
			if (res) {
				out.write("{\"result\":\"success\"}");
			} else {
				out.write("{\"result\":\"failed\"}");
			}
		}
	}

}
