package servlet.index;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import coupon.Coupon_Bean;
import coupon.Coupon_Mgr;

/**
 * Servlet implementation class coupon_api
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/api/coupon/get" })
public class coupon_api extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Coupon_Mgr mgr = new Coupon_Mgr();
	private Coupon_Bean bean = new Coupon_Bean();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public coupon_api() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendError(405);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String endPoint = request.getServletPath();
		
		if (endPoint.equals("api/coupon/get")) {
			
		}
	}

}
