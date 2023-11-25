package menu;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import all.DBConnectionMgr;
import orders.Orders_Bean;



public class Manager_Menu {
	
	private DBConnectionMgr pool;
	
	private Gson gson = new Gson();

	public Manager_Menu() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
    // 1. 메뉴내역페이지 - 메뉴 목록 
	public Menu_menu_Bean getMenu(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Menu_menu_Bean bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from menu where menu_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Menu_menu_Bean();
				bean.setMenu_no(rs.getInt("menu_no"));
				bean.setMenu_name(rs.getString("menu_name"));
				bean.setMenu_gubn(rs.getString("menu_gubn"));
				bean.setMenu_isSale(rs.getInt("menu_isSale"));
				bean.setMenu_isUse(rs.getInt("menu_isUse"));
				bean.setMenu_imgPath(rs.getString("menu_imgPath"));
				bean.setMenu_component(rs.getString("menu_component"));
				bean.setMenu_content(rs.getString("menu_content")); 
				bean.setMenu_price(rs.getInt("menu_price"));
				bean.setMenu_sell_amount(rs.getInt("menu_sell_amount"));
				bean.setMenu_recommend(rs.getInt("menu_recommend"));
				bean.setMenu_couponable(rs.getInt("menu_couponable"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	
	//Menu 리스트 전체 불러오기
	public Vector<Menu_menu_Bean> getMenuList(int type){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Menu_menu_Bean> vlist = new Vector<Menu_menu_Bean>();
		try {
			con = pool.getConnection();
			//전체 메뉴
			if(type == 0)
			{
				sql = "SELECT * FROM menu ORDER BY menu_no DESC";
			//단품 메뉴
			} else if (type == 1)
			{
				sql = "SELECT * FROM menu WHERE menu_gubn = '단품' ORDER BY menu_no DESC";
			} else if (type == 2)
			{
				sql = "SELECT * FROM menu WHERE menu_gubn = '세트' ORDER BY menu_no DESC";
			} else if (type == 3)
			{
				sql = "SELECT * FROM menu WHERE menu_gubn = '음료' ORDER BY menu_no DESC";
			} else if (type == 4)
			{
				sql = "SELECT * FROM menu WHERE menu_gubn = '사이드' ORDER BY menu_no DESC";
			} else if (type==5) 
			{
				sql = "SELECT * FROM menu WHERE menu_isSale = 1 ORDER BY menu_no DESC";
			}
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Menu_menu_Bean bean = new Menu_menu_Bean();
				bean = new Menu_menu_Bean();
				bean.setMenu_no(rs.getInt("menu_no"));
				bean.setMenu_name(rs.getString("menu_name"));
				bean.setMenu_gubn(rs.getString("menu_gubn"));
				bean.setMenu_isSale(rs.getInt("menu_isSale"));
				bean.setMenu_isUse(rs.getInt("menu_isUse"));
				bean.setMenu_imgPath(rs.getString("menu_imgPath"));
				bean.setMenu_component(rs.getString("menu_component"));
				bean.setMenu_content(rs.getString("menu_content")); 
				bean.setMenu_price(rs.getInt("menu_price"));
				bean.setMenu_sell_amount(rs.getInt("menu_sell_amount"));
				bean.setMenu_recommend(rs.getInt("menu_recommend"));
				vlist.add(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

    // 1. 메뉴 관리 페이지 - 메뉴 추가
	public boolean insertMenu(Menu_menu_Bean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO menu(menu_name, menu_gubn, menu_isSale, menu_imgPath, menu_component,"
					+ "menu_price, menu_sell_amount, menu_recommend, menu_isUse, menu_content, menu_couponable) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMenu_name());
			pstmt.setString(2, bean.getMenu_gubn());
			pstmt.setInt(3, bean.getMenu_isSale());
			pstmt.setString(4, bean.getMenu_imgPath());
			pstmt.setString(5, bean.getMenu_component());
			pstmt.setInt(6, bean.getMenu_price());
			pstmt.setInt(7, bean.getMenu_sell_amount());
			pstmt.setInt(8, bean.getMenu_recommend());
			pstmt.setInt(9, bean.getMenu_isUse());
			pstmt.setString(10, bean.getMenu_content());
			pstmt.setInt(11, bean.getMenu_couponable());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 1. 메뉴 관리 페이지 - 메뉴 수정
	public boolean updateMenu(Menu_menu_Bean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE menu SET menu_name=?, menu_gubn=?, menu_isSale=?, menu_component=?,"
					+ "menu_price=?, menu_sell_amount=?, menu_recommend=?, menu_isUse = ?, menu_content=?, "
					+ "menu_imgPath=?, menu_couponable = ?  WHERE menu_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMenu_name());
			pstmt.setString(2, bean.getMenu_gubn());
			pstmt.setInt(3, bean.getMenu_isSale());
			pstmt.setString(4, bean.getMenu_component());
			pstmt.setInt(5, bean.getMenu_price());
			pstmt.setInt(6, bean.getMenu_sell_amount());
			pstmt.setInt(7, bean.getMenu_recommend());
			pstmt.setInt(8, bean.getMenu_isUse());
			pstmt.setString(9, bean.getMenu_content());
			pstmt.setString(10, bean.getMenu_imgPath());
			pstmt.setInt(11, bean.getMenu_couponable());
			pstmt.setInt(12, bean.getMenu_no());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	// 1. 메뉴 관리 페이지 - 메뉴 삭제
	public int deleteMenu(int menu_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM menu WHERE menu_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, menu_no);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		//실패시 -1 반환
		return -1;
	}
	
	
		// 1. 메뉴내역페이지 - 토핑 목록  
		public Menu_menu_Bean getTopingMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu_Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu_Bean();
					bean.setMenu_no(rs.getInt("menu_no"));
					bean.setMenu_name(rs.getString("menu_name"));
					bean.setMenu_gubn(rs.getString("menu_gubn"));
					bean.setMenu_isSale(rs.getInt("menu_isSale"));
					bean.setMenu_imgPath(rs.getString("menu_imgPath"));
					bean.setMenu_component(rs.getString("menu_component"));
					bean.setMenu_price(rs.getInt("menu_price"));
					bean.setMenu_sell_amount(rs.getInt("menu_sell_amount"));
					bean.setMenu_recommend(rs.getInt("menu_recommend"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	
	
	    // 1. 메뉴 관리 페이지 - 토핑 메뉴 추가
		public boolean insertTopingMenu(Menu_component_Bean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "INSERT INTO menu_component (component_name, component_price, component_amount, component_imgPath, component_isUse) values(?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getComponent_name());
				pstmt.setInt(2, bean.getComponent_price());
				pstmt.setInt(3, bean.getComponent_amount());
				pstmt.setString(4, bean.getComponent_imgPath());
				pstmt.setInt(5, bean.getComponent_isUse());
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 1. 메뉴 관리 페이지 - 토핑 메뉴 수정
		public boolean updateTopingMenu(Menu_menu_Bean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update menu_menu set menu_name=?, menu_gubn=?, menu_isSale=?, menu_component=?,"
						+ "menu_price=?, menu_sell_amount=?, menu_recommend=? ";
				pstmt.setString(1, bean.getMenu_name());
				pstmt.setString(2, bean.getMenu_gubn());
				pstmt.setInt(3, bean.getMenu_isSale());
				pstmt.setString(4, bean.getMenu_imgPath());
				pstmt.setString(5, bean.getMenu_component());
				pstmt.setInt(6, bean.getMenu_price());
				pstmt.setInt(7, bean.getMenu_sell_amount());
				pstmt.setInt(8, bean.getMenu_recommend());
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 1. 메뉴 관리 페이지 - 토핑 메뉴 삭제
		public void deleteTopingMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from menu_menu where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}	
		
		// 1. 메뉴내역페이지 - 세트 메뉴 목록 
		public Menu_menu_Bean getSetMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu_Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu_Bean();
					bean.setMenu_no(rs.getInt("menu_no"));
					bean.setMenu_name(rs.getString("menu_name"));
					bean.setMenu_gubn(rs.getString("menu_gubn"));
					bean.setMenu_isSale(rs.getInt("menu_isSale"));
					bean.setMenu_imgPath(rs.getString("menu_imgPath"));
					bean.setMenu_component(rs.getString("menu_component"));
					bean.setMenu_price(rs.getInt("menu_price"));
					bean.setMenu_sell_amount(rs.getInt("menu_sell_amount"));
					bean.setMenu_recommend(rs.getInt("menu_recommend"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	
	    // 1. 메뉴 관리 페이지 - 세트 메뉴 추가
		public boolean insertSetMenu(Menu_menu_Bean bean) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert menu_menu(menu_name, menu_gubn, menu_isSale, menu_imgPath, menu_component,"
						+ "menu_price, menu_sell_amount, menu_recommend) values(?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getMenu_name());
				pstmt.setString(2, bean.getMenu_gubn());
				pstmt.setInt(3, bean.getMenu_isSale());
				pstmt.setString(4, bean.getMenu_imgPath());
				pstmt.setString(5, bean.getMenu_component());
				pstmt.setInt(6, bean.getMenu_price());
				pstmt.setInt(7, bean.getMenu_sell_amount());
				pstmt.setInt(8, bean.getMenu_recommend());
						
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 1. 메뉴 관리 페이지 - 세트 메뉴 수정
		public boolean updateSetMenu(Menu_menu_Bean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update menu_menu set menu_name=?, menu_gubn=?, menu_isSale=?, menu_component=?,"
						+ "menu_price=?, menu_sell_amount=?, menu_recommend=? ";
				pstmt.setString(1, bean.getMenu_name());
				pstmt.setString(2, bean.getMenu_gubn());
				pstmt.setInt(3, bean.getMenu_isSale());
				pstmt.setString(4, bean.getMenu_imgPath());
				pstmt.setString(5, bean.getMenu_component());
				pstmt.setInt(6, bean.getMenu_price());
				pstmt.setInt(7, bean.getMenu_sell_amount());
				pstmt.setInt(8, bean.getMenu_recommend());
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 1. 메뉴 관리 페이지 - 세트 메뉴 삭제
		public void deleteSetMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from menu_menu where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		
		// 1. 메뉴내역페이지 - 추천 메뉴 목록 
		public Menu_menu_Bean getPickMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu_Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu_Bean();
					bean.setMenu_no(rs.getInt("menu_no"));
					bean.setMenu_name(rs.getString("menu_name"));
					bean.setMenu_gubn(rs.getString("menu_gubn"));
					bean.setMenu_isSale(rs.getInt("menu_isSale"));
					bean.setMenu_imgPath(rs.getString("menu_imgPath"));
					bean.setMenu_component(rs.getString("menu_component"));
					bean.setMenu_price(rs.getInt("menu_price"));
					bean.setMenu_sell_amount(rs.getInt("menu_sell_amount"));
					bean.setMenu_recommend(rs.getInt("menu_recommend"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	
	    // 1. 메뉴 관리 페이지 - 추천 메뉴 추가
		public boolean insertPickMenu(Menu_menu_Bean bean) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert menu_menu(menu_name, menu_gubn, menu_isSale, menu_imgPath, menu_component,"
						+ "menu_price, menu_sell_amount, menu_recommend) values(?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getMenu_name());
				pstmt.setString(2, bean.getMenu_gubn());
				pstmt.setInt(3, bean.getMenu_isSale());
				pstmt.setString(4, bean.getMenu_imgPath());
				pstmt.setString(5, bean.getMenu_component());
				pstmt.setInt(6, bean.getMenu_price());
				pstmt.setInt(7, bean.getMenu_sell_amount());
				pstmt.setInt(8, bean.getMenu_recommend());
						
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 1. 메뉴 관리 페이지 - 추천 메뉴 수정
		public boolean updatePickMenu(Menu_menu_Bean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update menu_menu set menu_name=?, menu_gubn=?, menu_isSale=?, menu_component=?,"
						+ "menu_price=?, menu_sell_amount=?, menu_recommend=? ";
				pstmt.setString(1, bean.getMenu_name());
				pstmt.setString(2, bean.getMenu_gubn());
				pstmt.setInt(3, bean.getMenu_isSale());
				pstmt.setString(4, bean.getMenu_imgPath());
				pstmt.setString(5, bean.getMenu_component());
				pstmt.setInt(6, bean.getMenu_price());
				pstmt.setInt(7, bean.getMenu_sell_amount());
				pstmt.setInt(8, bean.getMenu_recommend());
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 1. 메뉴 관리 페이지 - 추천 메뉴 삭제
		public void deletePickMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from menu_menu where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		
//--------------------------------------------------------------------------------------		
		
	    // 2. 행사 관리 페이지 - 쿠폰 목록
		public Menu_menu_Bean getCouponList(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu_Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu_Bean();
					bean.setMenu_no(rs.getInt("menu_no"));
					bean.setMenu_name(rs.getString("menu_name"));
					bean.setMenu_gubn(rs.getString("menu_gubn"));
					bean.setMenu_isSale(rs.getInt("menu_isSale"));
					bean.setMenu_imgPath(rs.getString("menu_imgPath"));
					bean.setMenu_component(rs.getString("menu_component"));
					bean.setMenu_price(rs.getInt("menu_price"));
					bean.setMenu_sell_amount(rs.getInt("menu_sell_amount"));
					bean.setMenu_recommend(rs.getInt("menu_recommend"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	
	    // 2. 행사 관리 페이지 - 쿠폰 발행
		public boolean insertCoupon(Menu_menu_Bean bean) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert menu_menu(menu_name, menu_gubn, menu_isSale, menu_imgPath, menu_component,"
						+ "menu_price, menu_sell_amount, menu_recommend) values(?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getMenu_name());
				pstmt.setString(2, bean.getMenu_gubn());
				pstmt.setInt(3, bean.getMenu_isSale());
				pstmt.setString(4, bean.getMenu_imgPath());
				pstmt.setString(5, bean.getMenu_component());
				pstmt.setInt(6, bean.getMenu_price());
				pstmt.setInt(7, bean.getMenu_sell_amount());
				pstmt.setInt(8, bean.getMenu_recommend());
						
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 2. 메뉴 관리 페이지 - 쿠폰 수정
		public boolean updateCoupon(Menu_menu_Bean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update menu_menu set menu_name=?, menu_gubn=?, menu_isSale=?, menu_component=?,"
						+ "menu_price=?, menu_sell_amount=?, menu_recommend=? ";
				pstmt.setString(1, bean.getMenu_name());
				pstmt.setString(2, bean.getMenu_gubn());
				pstmt.setInt(3, bean.getMenu_isSale());
				pstmt.setString(4, bean.getMenu_imgPath());
				pstmt.setString(5, bean.getMenu_component());
				pstmt.setInt(6, bean.getMenu_price());
				pstmt.setInt(7, bean.getMenu_sell_amount());
				pstmt.setInt(8, bean.getMenu_recommend());
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 2. 행사 관리 페이지 - 쿠폰 삭제
		public void deleteCoupon(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from menu_menu where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		
		// 2. 행사 관리 페이지 - 이벤트 관리 
		public Menu_menu_Bean getEventList(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu_Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu_Bean();
					bean.setMenu_no(rs.getInt("menu_no"));
					bean.setMenu_name(rs.getString("menu_name"));
					bean.setMenu_gubn(rs.getString("menu_gubn"));
					bean.setMenu_isSale(rs.getInt("menu_isSale"));
					bean.setMenu_imgPath(rs.getString("menu_imgPath"));
					bean.setMenu_component(rs.getString("menu_component"));
					bean.setMenu_price(rs.getInt("menu_price"));
					bean.setMenu_sell_amount(rs.getInt("menu_sell_amount"));
					bean.setMenu_recommend(rs.getInt("menu_recommend"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
			
		// 2. 행사 관리 페이지 - 이벤트 발행
		public boolean insertEvent(Menu_menu_Bean bean) {
					
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert menu_menu(menu_name, menu_gubn, menu_isSale, menu_imgPath, menu_component,"
						+ "menu_price, menu_sell_amount, menu_recommend) values(?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getMenu_name());
				pstmt.setString(2, bean.getMenu_gubn());
				pstmt.setInt(3, bean.getMenu_isSale());
				pstmt.setString(4, bean.getMenu_imgPath());
				pstmt.setString(5, bean.getMenu_component());
				pstmt.setInt(6, bean.getMenu_price());
				pstmt.setInt(7, bean.getMenu_sell_amount());
				pstmt.setInt(8, bean.getMenu_recommend());
								
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
				
		// 2. 메뉴 관리 페이지 - 이벤트 수정
		public boolean updateEvent(Menu_menu_Bean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update menu_menu set menu_name=?, menu_gubn=?, menu_isSale=?, menu_component=?,"
						+ "menu_price=?, menu_sell_amount=?, menu_recommend=? ";
				pstmt.setString(1, bean.getMenu_name());
				pstmt.setString(2, bean.getMenu_gubn());
				pstmt.setInt(3, bean.getMenu_isSale());
				pstmt.setString(4, bean.getMenu_imgPath());
				pstmt.setString(5, bean.getMenu_component());
				pstmt.setInt(6, bean.getMenu_price());
				pstmt.setInt(7, bean.getMenu_sell_amount());
				pstmt.setInt(8, bean.getMenu_recommend());
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
				
		// 2. 행사 관리 페이지 - 이벤트 삭제
		public void deleteEvent(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from menu_menu where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		
//----------------------------------------------------------------------------------		
	
		// 3. 회계 관리 페이지 - 주문 현황
		public Menu_order_Bean getmgrOrder(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_order_Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_order where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Menu_order_Bean();
				bean.setMgrodr_no(rs.getInt("mgrodr_no"));
				bean.setMgrodr_day(rs.getString("mgrodr_day"));
				bean.setMgrodr_kind(rs.getString("mgrodr_kind"));
				bean.setMgrodr_sele(rs.getString("mgrodr_sele"));
				bean.setMgrodr_mtd(rs.getString("mgrodr_mtd"));
				bean.setMgrodr_hsel(rs.getString("mgrodr_hsel"));
				bean.setMgrodr_csel(rs.getString("mgrodr_csel"));
				bean.setMgrodr_sday(rs.getString("mgrodr_sday"));
				bean.setMgrodr_smon(rs.getString("mgrodr_smon"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
		
		// 3. 회계 관리 페이지 - 거래 내역
		public Vector<Orders_Bean> getMgrorderList(int pageNum, int pageSize) {
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String sql = null;
		    Vector<Orders_Bean> vlist = new Vector<Orders_Bean>();

		    try {
		        con = pool.getConnection();
		        // Calculate the starting index for the pagination
		        int offset = ((pageNum-1) * pageSize);
		        if (pageNum == 0) {
		        	sql = "select * from orders order by order_no desc";
			        pstmt = con.prepareStatement(sql);
		        } else {
			        sql = "SELECT * FROM orders LIMIT ? OFFSET ?";
			        pstmt = con.prepareStatement(sql);
			        pstmt.setInt(1, pageSize);
			        pstmt.setInt(2, offset);
		        }
		        // Use the LIMIT and OFFSET clauses for pagination

		        rs = pstmt.executeQuery();

		        while (rs.next()) {
		            Orders_Bean bean = new Orders_Bean();
		            bean.setOrder_no(rs.getInt("order_no"));
		            bean.setOrder_time(rs.getTimestamp("order_time"));
		            bean.setOrder_foods(rs.getString("order_foods"));
		            bean.setOrder_price(rs.getLong("order_price"));
		            bean.setOrder_discount(rs.getInt("order_discount"));
		            bean.setOrder_coupon(rs.getString("order_coupon"));
		            bean.setOrder_type(rs.getString("order_type"));
		            bean.setOrder_use_amount(rs.getInt("order_use_mile_amount"));
		            vlist.add(bean);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        pool.freeConnection(con, pstmt, rs);
		    }

		    return vlist;
		}
				
		 // 3. 회계 관리 페이지 - 거래내역추가
		public boolean insertmgrorder(Menu_order_Bean bean) {
						
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert menu_order(mgrodr_no,mgrodr_day,mgrodr_kind,mgrodr_sele,mgrodr_mtd,"
						+ "mgrodr_hsel,mgrodr_csel,mgrodr_sday,mgrodr_smon)values(?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getMgrodr_day());
				pstmt.setString(2, bean.getMgrodr_kind());
				pstmt.setString(3, bean.getMgrodr_sele());
				pstmt.setString(4, bean.getMgrodr_mtd());
				pstmt.setString(5, bean.getMgrodr_hsel());
				pstmt.setString(6, bean.getMgrodr_csel());
				pstmt.setString(7, bean.getMgrodr_sday());
				pstmt.setString(8, bean.getMgrodr_smon());
									
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}		
		
		// 3. 회계 관리 페이지 - 거래 내역 페이지 분활
		public List<Orders_Bean> getSalesList(int pageNum, int amount) {
		        	List <Orders_Bean> list = new ArrayList<>();
		        	
		        	Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
			
			try {
				con = pool.getConnection();
				sql = "select *"
						+"from orders rn,"
						+        " a.* "
						+"from (select *"
						+         "from board order by bno desc) a ) "
						+     "where rn > 0 and rn <= 10";
			    pstmt = con.prepareStatement(sql);
			    pstmt.setInt(1,  (pageNum - 1) * amount);
			    pstmt.setInt(2,  pageNum * amount);
			    rs = pstmt.executeQuery();
				while (rs.next()) {
					Orders_Bean vo = new Orders_Bean();
					vo.setOrder_no(rs.getInt("order_no"));
					vo.setOrder_time(rs.getTimestamp("order_time"));
					vo.setOrder_foods(rs.getString("order_foods"));
					vo.setOrder_price(rs.getInt("order_price"));
					vo.setOrder_discount(rs.getInt("order_discount"));
					vo.setOrder_coupon(rs.getString("order_coupon"));
					vo.setOrder_type(rs.getString("order_type"));
					vo.setOrder_add_mile(rs.getBoolean("order_add_mile"));
					vo.setOrder_is_maked(rs.getBoolean("order_is_maked"));
					  list.add(vo);
				}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con);
				}
				return list;
			}
	
		
		// 3. 회계 관리 페이지 - 거래 내역 페이지 분활
		public Map<String, Object> getSalesList2(int pageNum1) {
		    List<Orders_Bean> list = new ArrayList<>();
		    Map<String, Object> res = new HashMap<>();

		    Connection con = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String sql = null;

		    try {
		        con = pool.getConnection();

		        // Retrieve paginated sales data
		        int pageSize = 10;
		        int offset = (pageNum1 - 1) * pageSize;

		        sql = "SELECT * FROM orders LIMIT ? OFFSET ?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setInt(1, pageSize);
		        pstmt.setInt(2, offset);
		        rs = pstmt.executeQuery();

		        while (rs.next()) {
		            Orders_Bean vo = new Orders_Bean();
		            vo.setOrder_no(rs.getInt("order_no"));
		            vo.setOrder_time(rs.getTimestamp("order_time"));
		            vo.setOrder_foods(rs.getString("order_foods"));
		            vo.setOrder_price(rs.getInt("order_price"));
		            vo.setOrder_discount(rs.getInt("order_discount"));
		            vo.setOrder_coupon(rs.getString("order_coupon"));
		            vo.setOrder_type(rs.getString("order_type"));
		            vo.setOrder_add_mile(rs.getBoolean("order_add_mile"));
		            vo.setOrder_is_maked(rs.getBoolean("order_is_maked"));
		            list.add(vo);
		        }

		        // Retrieve total count of records
		        sql = "SELECT COUNT(order_no) as count FROM orders";
		        pstmt = con.prepareStatement(sql);
		        rs = pstmt.executeQuery();

		        int totalCount = 0;
		        if (rs.next()) {
		            totalCount = rs.getInt("count");
		        }

		        // Populate the result map
		        res.put("data", list);
		        res.put("currentPage", pageNum1);
		        res.put("pageSize", pageSize);
		        res.put("totalCount", totalCount);

		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (pstmt != null) pstmt.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        pool.freeConnection(con);
		    }

		    return res;
		}
	
		// 3. 회계 관리 페이지 - 재료 입고
		public boolean insertComponent(Menu_component_Bean bean) {
		
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert menu_component(component_name,component_price,component_amount,component_imgpath)values(?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getComponent_name());
				pstmt.setInt(2, bean.getComponent_price());
				pstmt.setInt(3, bean.getComponent_amount());
				pstmt.setString(4, bean.getComponent_imgPath());
					
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
	
	
		// 3. 회계 관리 페이지 - 재료 수정
		public boolean updateComponent(Menu_component_Bean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update menu_component set component_name=?, component_price=?, component_amount=?, component_imgpath=?, component_isUse=?, component_isTopping=? where component_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getComponent_name());
				pstmt.setInt(2, bean.getComponent_price());
				pstmt.setInt(3, bean.getComponent_amount());
				pstmt.setString(4, bean.getComponent_imgPath());
				pstmt.setInt(5, bean.getComponent_isUse());
				pstmt.setInt(6, bean.getComponent_isTopping());
				pstmt.setInt(7, bean.getComponent_no());
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
	
	
		// 3. 회계 관리 페이지 - 재료 삭제
		public int deleteComponent(int component_no) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from menu_component where component_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, component_no);
				pstmt.executeUpdate();
				return 1;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return -1;
		}
	
	
		// 3. 회계 관리 페이지 - 재료 현황
		public Vector<Menu_component_Bean> getComponenctlist() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_component_Bean bean = null;
			Vector<Menu_component_Bean> vlist = new Vector<Menu_component_Bean>();
			try {
				con = pool.getConnection();
				String sql = "select * from menu_component";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					bean = new Menu_component_Bean();
					bean.setComponent_no(rs.getInt("component_no"));
					bean.setComponent_name(rs.getString("component_name"));
					bean.setComponent_price(rs.getInt("component_price"));
					bean.setComponent_amount(rs.getInt("component_amount"));
					bean.setComponent_imgPath(rs.getString("component_imgPath"));
				  vlist.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return vlist;
		}
		
		// 3. 회계 관리 페이지 - 등록 재료 조회
				public Menu_component_Bean getComponent1(int numb) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					Menu_component_Bean bean = null;
					try {
						con = pool.getConnection();
						String sql = "select * from menu_component where component_no = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, numb);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							bean = new Menu_component_Bean();
							bean.setComponent_no(rs.getInt("component_no"));
							bean.setComponent_name(rs.getString("component_name"));
							bean.setComponent_price(rs.getInt("component_price"));
							bean.setComponent_amount(rs.getInt("component_amount"));
							bean.setComponent_imgPath(rs.getString("component_imgPath"));
							bean.setComponent_isUse(rs.getInt("component_isUse"));
							bean.setComponent_isTopping(rs.getInt("component_isTopping"));
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con);
					}
					return bean;
				}
				
				public Vector<Menu_component_Bean> getComponentList(int type){
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					Menu_component_Bean bean = null;
					Vector<Menu_component_Bean> list = new Vector<Menu_component_Bean>();
					try {
						con = pool.getConnection();
						//전체 메뉴
						if(type == 0)
						{
							sql = "select * from menu_component ORDER BY component_no DESC";
						} 
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) {
							bean = new Menu_component_Bean();
							bean.setComponent_no(rs.getInt("component_no"));
							bean.setComponent_name(rs.getString("component_name"));
							bean.setComponent_price(rs.getInt("component_price"));
							bean.setComponent_amount(rs.getInt("component_amount"));
							bean.setComponent_imgPath(rs.getString("component_imgPath"));
							list.add(bean);
						}
					} catch(Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return list;
				}
	// 3. 회계 관리 페이지 - 갯수 적용  버튼
				public Boolean setAmount(int amount, int no) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					Menu_component_Bean bean = null;
					try {
						con = pool.getConnection();
						String sql = "update menu_component SET `component_amount` = ? where component_no = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, amount);
						pstmt.setInt(2, no);
						pstmt.executeUpdate();
						
					} catch (Exception e) {
						e.printStackTrace();
						return false;
					} finally {
						pool.freeConnection(con);
					}
					return true;
				}
				
				public Menu_menu_Bean getMenuwithName(String name) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					Menu_menu_Bean bean = null;		
					
					try {
						con = pool.getConnection();
						String sql = "select * from menu where menu_name = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, name);
						rs = pstmt.executeQuery();
						if (rs.next()) {
							bean = new Menu_menu_Bean();
							bean.setMenu_no(rs.getInt("menu_no"));
							bean.setMenu_name(rs.getString("menu_name"));
							bean.setMenu_gubn(rs.getString("menu_gubn"));
							bean.setMenu_isSale(rs.getInt("menu_isSale"));
							bean.setMenu_isUse(rs.getInt("menu_isUse"));
							bean.setMenu_imgPath(rs.getString("menu_imgPath"));
							bean.setMenu_component(rs.getString("menu_component"));
							bean.setMenu_content(rs.getString("menu_content")); 
							bean.setMenu_price(rs.getInt("menu_price"));
							bean.setMenu_sell_amount(rs.getInt("menu_sell_amount"));
							bean.setMenu_recommend(rs.getInt("menu_recommend"));
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
				
						pool.freeConnection(con);
					}
					
					return bean;
				}
			
				

//--------------------------------------------------------------------------------
	//menu_file download

	public void downLoad(HttpServletRequest req, HttpServletResponse res,
			JspWriter out, PageContext pageContext) {
		try {
			String filename = req.getParameter("menu_filePath");
			File file = new File(UtilMgr.con(filename));
			byte b[] = new byte[(int) file.length()];
			res.setHeader("Accept-Ranges", "bytes");
			String strClient = req.getHeader("User-Agent");
			if (strClient.indexOf("MSIE6.0") != -1) {
				res.setContentType("application/smnet;charset=euc-kr");
				res.setHeader("Content-Disposition", "filename=" + filename + ";");
			} else {
				res.setContentType("application/smnet;charset=euc-kr");
				res.setHeader("Content-Disposition", "attachment;filename="+ filename + ";");
			}
			out.clear();
			out = pageContext.pushBody();
			if (file.isFile()) {
				BufferedInputStream fin = new BufferedInputStream(
						new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(
						res.getOutputStream());
				int read = 0;
				while ((read = fin.read(b)) != -1) {
					outs.write(b, 0, read);
				}
				outs.close();
				fin.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}  
	}
	
	
//--------------------------------------------------------------------------------
}
