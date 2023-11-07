package menu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import all.DBConnectionMgr;


public class Maneger_Menu {
	
	private DBConnectionMgr pool;

	public void Manager_Menu() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	    // 1. 메뉴내역페이지 - 메뉴 목록 
		public Menu_menu__Bean getMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu__Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu__Bean();
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
	
	    // 1. 메뉴 관리 페이지 - 메뉴 추가
		public boolean insertMenu(Menu_menu__Bean bean) {
			
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
		
		// 1. 메뉴 관리 페이지 - 메뉴 수정
		public boolean updateMenu(Menu_menu__Bean bean) {
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
		
		// 1. 메뉴 관리 페이지 - 메뉴 삭제
		public void deleteMenu(int numb) {
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
		
		
	
		// 1. 메뉴내역페이지 - 토핑 목록  
		public Menu_menu__Bean getTopingMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu__Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu__Bean();
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
		public boolean insertTopingMenu(Menu_menu__Bean bean) {
			
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
		
		// 1. 메뉴 관리 페이지 - 토핑 메뉴 수정
		public boolean updateTopingMenu(Menu_menu__Bean bean) {
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
		public Menu_menu__Bean getSetMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu__Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu__Bean();
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
		public boolean insertSetMenu(Menu_menu__Bean bean) {
			
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
		public boolean updateSetMenu(Menu_menu__Bean bean) {
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
		public Menu_menu__Bean getPickMenu(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu__Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu__Bean();
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
		public boolean insertPickMenu(Menu_menu__Bean bean) {
			
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
		public boolean updatePickMenu(Menu_menu__Bean bean) {
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
		public Menu_menu__Bean getCouponList(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu__Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu__Bean();
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
		public boolean insertCoupon(Menu_menu__Bean bean) {
			
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
		public boolean updateCoupon(Menu_menu__Bean bean) {
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
		public Menu_menu__Bean getEventList(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_menu__Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_menu where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_menu__Bean();
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
		public boolean insertEvent(Menu_menu__Bean bean) {
					
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
		public boolean updateEvent(Menu_menu__Bean bean) {
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
	
		// 3. 회계 관리 페이지 - 주문 현황 (수정 요망)
		public Menu_component_Bean getOrder(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_component_Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_component where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Menu_component_Bean();
				bean.setComponent_no(rs.getInt("component_no"));
				bean.setComponent_name(rs.getString("component_name"));
				bean.setComponent_price(rs.getInt("component_price"));
				bean.setComponent_amount(rs.getInt("component_amount"));
				bean.setComponent_imgPath(rs.getString("component_imgPath"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
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
				sql = "update menu_component set component_name=?, component_price=?, component_amount=?, component_imgpath=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getComponent_name());
				pstmt.setInt(2, bean.getComponent_price());
				pstmt.setInt(3, bean.getComponent_amount());
				pstmt.setString(4, bean.getComponent_imgPath());
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
		public void deleteComponent(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from menu_component where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
	
	
		// 3. 회계 관리 페이지 - 재료 현황
		public Menu_component_Bean getComponenct(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Menu_component_Bean bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from menu_component where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Menu_component_Bean();
					bean.setComponent_no(rs.getInt("component_no"));
					bean.setComponent_name(rs.getString("component_name"));
					bean.setComponent_price(rs.getInt("component_price"));
					bean.setComponent_amount(rs.getInt("component_amount"));
					bean.setComponent_imgPath(rs.getString("component_imgPath"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
		
	}

//--------------------------------------------------------------------------------
