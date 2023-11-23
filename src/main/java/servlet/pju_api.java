package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.Member_Mgr;

/**
 * Servlet implementation class pju_api
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/api/user/find_id", "/api/user/find_pw" })
public class pju_api extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public pju_api() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd = request.getRequestDispatcher("/user/change_pw.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String endPoint = request.getServletPath();
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		if (endPoint.equals("/api/user/find_id")) {
			String mem_name = request.getParameter("name");
			String mem_phone = request.getParameter("phone");
			
			Member_Mgr mgr = new Member_Mgr();
			
			List<String> ids = mgr.findId(mem_name, mem_phone);
			
			System.out.println(ids);
			String s_res = "";
			for (String id : ids) {
				if (s_res.equals("") ) {
					s_res = id;
				} else {
					s_res = s_res+", "+id+"";
				}
				
			}
			out.write("{\"result\":\""+s_res+"\"}");
		}
		
		if (endPoint.equals("/api/user/find_pw")) {
			String mem_id = request.getParameter("id");
			String mem_name = request.getParameter("name");
			String mem_phone = request.getParameter("phone");
			
			Member_Mgr mgr = new Member_Mgr();
			
			boolean res = mgr.findpw( mem_id , mem_name, mem_phone);
			
			if (res) {
				session.setAttribute("find_pw_id", mem_id);
				
				response.setContentType("text/html; charset=UTF-8");
				request.setCharacterEncoding("UTF-8");
				
				
				response.sendRedirect(request.getContextPath()+"/api/user/find_pw");
			} else {
				out.write("{\"result\":\"아이디가 없습니다\"}");
			}
			
			
		}
			
		
		}
	
}

