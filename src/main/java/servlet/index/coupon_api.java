package servlet.index;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import all.HttpBody;
import coupon.Coupon_Bean;
import coupon.Coupon_Mgr;
import coupon.Coupon_kind_Bean;
import coupon.Coupon_kind_Mgr;

import menu.Manager_Menu;
import menu.Menu_menu_Bean;

/**
 * Servlet implementation class coupon_api
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/api/coupon/get" })
public class coupon_api extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Coupon_kind_Mgr ck_mgr = new Coupon_kind_Mgr();
	private Coupon_kind_Bean ck_bean = new Coupon_kind_Bean();
	private Coupon_Mgr mgr = new Coupon_Mgr();
	private Coupon_Bean bean = new Coupon_Bean();
	private HttpSession session = null;
	private PrintWriter out = null;
	private Manager_Menu m_mgr = new Manager_Menu();
	private Menu_menu_Bean m_bean = new Menu_menu_Bean();
       
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
		this.session = request.getSession();
		this.out = response.getWriter();
		
		if (endPoint.equals("/api/coupon/get")) {
			Object mem_id = session.getAttribute("mem_id");
			if (mem_id != null) {
				Map<String, String> body = HttpBody.getBody(request.getInputStream());
				
				Vector<Coupon_kind_Bean> printable_coupons = ck_mgr.get_printable(String.valueOf(mem_id));
				
				String name = body.get("name");
				String menu = body.get("menu");
				String cate = body.get("menu_cate");
				
				List<String> printable_name = new ArrayList<String>();
				for(Coupon_kind_Bean printable_coupon : printable_coupons) {
					printable_name.add(printable_coupon.getName());
				}
				
				if (printable_name.contains(name)) {
					this.ck_bean = ck_mgr.get_type_with_name(name);
					List<Coupon_Bean> c_beans = mgr.readAllCoupon();
					List<String> cur_coupons = new ArrayList<String>();
					String code = "";
					for (Coupon_Bean coupon : c_beans) {
						cur_coupons.add(coupon.getCoupon_code());
					}
					boolean repeat = true;
					while (repeat) {
						Random rnd = new Random();
						StringBuffer buf = new StringBuffer();
						for(int i=0;i<16;i++){
							buf.append((rnd.nextInt(10)));
						}
						code = buf.toString();
						
						if (cur_coupons.contains(code) == false) {
							repeat = false;
						}
					}
					
					

					this.m_bean = this.m_mgr.getMenuwithName(menu);
					if (this.m_bean != null) {
						if (cate.equals(this.m_bean.getMenu_gubn())) {
							if (ck_bean.getCategory().contains(cate)) {
								this.bean.setCoupon_code(code);
								this.bean.set_owner(String.valueOf(mem_id));
								System.out.println(this.bean.get_owner());
								this.bean.setCoupon_discount(ck_bean.getDiscount_per());
								this.bean.setCoupon_name(ck_bean.getName());
								this.bean.setCoupon_menuNo(this.m_bean.getMenu_no());
								boolean res = mgr.createCoupon(this.bean);
								if (res) {
									this.out.write("{\"result\":\"success\"}");
								} else {
									response.sendError(500);
								}
							} else {
								response.sendError(400, "{\"reason\":\"invaild_couponc\"}");
							}
						} else {
							response.sendError(400, "{\"reason\":\"invaild_couponb\"}");
						}
					} else {
						response.sendError(400, "{\"reason\":\"menu_not_found\"}");
					}
				} else {
					response.sendError(400,  "{\"reason\":\"invaild_coupona\"}");
				}
			} else {
				response.sendError(401);
			}
		}
	}

}
