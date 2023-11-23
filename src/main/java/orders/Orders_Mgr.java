package orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import DBconnector.DBConnectionMgr;
import menu.Menu_component_Bean;
import orders.Orders_Bean;


public class Orders_Mgr {
	private DBConnectionMgr pool;
	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;
	
	private Gson gson = new Gson();

	public Orders_Mgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//초기화
	private void Initializer(String query) {
		try {
			this.conn = pool.getConnection();
			this.pst = conn.prepareStatement(query);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//커넥션 풀 해제
	private void Closer() {
		int flag = 0;
		if (this.conn != null) {
			flag += 1;
		}
		if (this.pst != null) {
			flag += 1;
		}
		if (flag == 1) {
			pool.freeConnection(this.conn);
		} else if (flag == 2) {
			pool.freeConnection(this.conn, this.pst);
		} else {
			pool.freeConnection(this.conn, this.pst, this.rs);
		}
	}
	
	public Vector<Orders_Bean> getAllOrders() {
		Vector<Orders_Bean> vector = new Vector<Orders_Bean>();
		try {
			this.Initializer("SELECT * FROM orders");
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Orders_Bean bean = new Orders_Bean();
	            bean.setOrder_no(this.rs.getInt("order_no"));
	            bean.setOrder_time(this.rs.getTimestamp("order_time"));
	            bean.setOrder_foods(this.rs.getString("order_foods"));
	            bean.setOrder_price(this.rs.getLong("order_price"));
	            bean.setOrder_discount(this.rs.getLong("order_discount"));
	            bean.setOrder_coupon(this.rs.getString("order_coupon"));
	            bean.setOrder_type(this.rs.getString("order_type"));
	            bean.setOrder_use_mile(this.rs.getBoolean("order_use_mile"));
	            bean.setOrder_use_amount(this.rs.getInt("order_use_mile_amount"));
	            bean.setOrder_add_mile(this.rs.getBoolean("order_add_mile"));
	            bean.setOrder_add_amount(this.rs.getInt("order_add_mile_amount"));
	            bean.setOrder_is_maked(this.rs.getBoolean("order_is_maked"));
	            bean.set_who(this.rs.getString("order_who"));
	            bean.setOrder_is_togo(this.rs.getBoolean("order_is_togo"));
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public Vector<Orders_Bean> getAllOrdersByType(int type) {
		Vector<Orders_Bean> vector = new Vector<Orders_Bean>();
		try {
			if(type == 0) {
			this.Initializer("SELECT * FROM orders");
			} else if (type == 1) {
				this.Initializer("SELECT * FROM orders WHERE DATE(order_time) = CURDATE()");
			} else if (type == 2) {
				this.Initializer("SELECT * FROM orders WHERE YEAR(order_time) = YEAR(CURDATE()) AND MONTH(order_time) = MONTH(CURDATE()) ");
			} else if(type == 3) {
				this.Initializer("SELECT * FROM orders WHERE YEAR(order_time) = YEAR(CURDATE()) AND WEEK(order_time) = WEEK(CURDATE())");
			}
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Orders_Bean bean = new Orders_Bean();
	            bean.setOrder_no(this.rs.getInt("order_no"));
	            bean.setOrder_time(this.rs.getTimestamp("order_time"));
	            bean.setOrder_foods(this.rs.getString("order_foods"));
	            bean.setOrder_price(this.rs.getLong("order_price"));
	            bean.setOrder_discount(this.rs.getLong("order_discount"));
	            bean.setOrder_coupon(this.rs.getString("order_coupon"));
	            bean.setOrder_type(this.rs.getString("order_type"));
	            bean.setOrder_use_mile(this.rs.getBoolean("order_use_mile"));
	            bean.setOrder_use_amount(this.rs.getInt("order_use_mile_amount"));
	            bean.setOrder_add_mile(this.rs.getBoolean("order_add_mile"));
	            bean.setOrder_add_amount(this.rs.getInt("order_add_mile_amount"));
	            bean.setOrder_is_maked(this.rs.getBoolean("order_is_maked"));
	            bean.set_who(this.rs.getString("order_who"));
	            bean.setOrder_is_togo(this.rs.getBoolean("order_is_togo"));
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public Vector<Orders_Bean> getAllOrdersByTime(String startDate, String endDate) {
		Vector<Orders_Bean> vector = new Vector<Orders_Bean>();
		try {
			this.Initializer("SELECT * FROM orders WHERE DATE_FORMAT(order_time,  '%Y-%m-%d') BETWEEN ? AND ?");
			this.pst.setString(1 , startDate);
			this.pst.setString(2, endDate);
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Orders_Bean bean = new Orders_Bean();
	            bean.setOrder_no(this.rs.getInt("order_no"));
	            bean.setOrder_time(this.rs.getTimestamp("order_time"));
	            bean.setOrder_foods(this.rs.getString("order_foods"));
	            bean.setOrder_price(this.rs.getLong("order_price"));
	            bean.setOrder_discount(this.rs.getLong("order_discount"));
	            bean.setOrder_coupon(this.rs.getString("order_coupon"));
	            bean.setOrder_type(this.rs.getString("order_type"));
	            bean.setOrder_use_mile(this.rs.getBoolean("order_use_mile"));
	            bean.setOrder_use_amount(this.rs.getInt("order_use_mile_amount"));
	            bean.setOrder_add_mile(this.rs.getBoolean("order_add_mile"));
	            bean.setOrder_add_amount(this.rs.getInt("order_add_mile_amount"));
	            bean.setOrder_is_maked(this.rs.getBoolean("order_is_maked"));
	            bean.set_who(this.rs.getString("order_who"));
	            bean.setOrder_is_togo(this.rs.getBoolean("order_is_togo"));
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	
	public Vector<Orders_Bean> getAllOrdersByDate(Date startDate, Date endDate) {
		Vector<Orders_Bean> vector = new Vector<Orders_Bean>();
		try {
			this.Initializer("SELECT * FROM orders WHERE order_time BETWEEN date(?) AND date(?)");
			this.pst.setDate(1, new java.sql.Date(startDate.getTime()));
			this.pst.setDate(2, new java.sql.Date(endDate.getTime()));
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Orders_Bean bean = new Orders_Bean();
	            bean.setOrder_no(this.rs.getInt("order_no"));
	            bean.setOrder_time(this.rs.getTimestamp("order_time"));
	            bean.setOrder_foods(this.rs.getString("order_foods"));
	            bean.setOrder_price(this.rs.getLong("order_price"));
	            bean.setOrder_discount(this.rs.getLong("order_discount"));
	            bean.setOrder_coupon(this.rs.getString("order_coupon"));
	            bean.setOrder_type(this.rs.getString("order_type"));
	            bean.setOrder_use_mile(this.rs.getBoolean("order_use_mile"));
	            bean.setOrder_use_amount(this.rs.getInt("order_use_mile_amount"));
	            bean.setOrder_add_mile(this.rs.getBoolean("order_add_mile"));
	            bean.setOrder_add_amount(this.rs.getInt("order_add_mile_amount"));
	            bean.setOrder_is_maked(this.rs.getBoolean("order_is_maked"));
	            bean.set_who(this.rs.getString("order_who"));
	            bean.setOrder_is_togo(this.rs.getBoolean("order_is_togo"));
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}

	
	public Vector<Orders_Bean> getOrderByNo(int no) {
		Vector<Orders_Bean> vector = new Vector<Orders_Bean>();
		try {
			this.Initializer("SELECT * FROM orders WHERE order_no = ?");
			this.pst.setInt(1, no);
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Orders_Bean bean = new Orders_Bean();
	            bean.setOrder_no(this.rs.getInt("order_no"));
	            bean.setOrder_time(this.rs.getTimestamp("order_time"));
	            bean.setOrder_foods(this.rs.getString("order_foods"));
	            bean.setOrder_price(this.rs.getLong("order_price"));
	            bean.setOrder_discount(this.rs.getLong("order_discount"));
	            bean.setOrder_coupon(this.rs.getString("order_coupon"));
	            bean.setOrder_type(this.rs.getString("order_type"));
	            bean.setOrder_use_mile(this.rs.getBoolean("order_use_mile"));
	            bean.setOrder_use_amount(this.rs.getInt("order_use_mile_amount"));
	            bean.setOrder_add_mile(this.rs.getBoolean("order_add_mile"));
	            bean.setOrder_add_amount(this.rs.getInt("order_add_mile_amount"));
	            bean.setOrder_is_maked(this.rs.getBoolean("order_is_maked"));
	            bean.set_who(this.rs.getString("order_who"));
	            bean.setOrder_is_togo(this.rs.getBoolean("order_is_togo"));
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public int getLastOrder() {
		int pk = 0;
		try {
			this.Initializer("SELECT order_no FROM orders ORDER BY `order_no` DESC LIMIT 1");
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				pk = rs.getInt("order_no");
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return pk;
	}
	
	public Vector<Orders_Bean> getOrdersByUser(String mem_id) {
		Vector<Orders_Bean> vector = new Vector<Orders_Bean>();
		try {
			this.Initializer("SELECT * FROM orders WHERE `order_who` = ?");
			this.pst.setString(1, mem_id);
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Orders_Bean bean = new Orders_Bean();
	            bean.setOrder_no(this.rs.getInt("order_no"));
	            bean.setOrder_time(this.rs.getTimestamp("order_time"));
	            bean.setOrder_foods(this.rs.getString("order_foods"));
	            bean.setOrder_price(this.rs.getLong("order_price"));
	            bean.setOrder_discount(this.rs.getLong("order_discount"));
	            bean.setOrder_coupon(this.rs.getString("order_coupon"));
	            bean.setOrder_type(this.rs.getString("order_type"));
	            bean.setOrder_use_mile(this.rs.getBoolean("order_use_mile"));
	            bean.setOrder_use_amount(this.rs.getInt("order_use_mile_amount"));
	            bean.setOrder_add_mile(this.rs.getBoolean("order_add_mile"));
	            bean.setOrder_add_amount(this.rs.getInt("order_add_mile_amount"));
	            bean.setOrder_is_maked(this.rs.getBoolean("order_is_maked"));
	            bean.set_who(this.rs.getString("order_who"));
	            bean.setOrder_is_togo(this.rs.getBoolean("order_is_togo"));
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public boolean addOrder(Orders_Bean order) {
		boolean flag = false;
		try {
			this.Initializer("INSERT INTO `orders` (`order_time`, `order_foods`, `order_price`, `order_discount`, `order_coupon`, `order_type`, `order_use_mile`, `order_use_mile_amount`, `order_add_mile`, `order_add_mile_amount`, `order_is_maked`, `order_who`, `order_is_togo`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			this.pst.setTimestamp(1, order.getOrder_time());
			this.pst.setString(2, order.getOrder_foods());
			this.pst.setLong(3, order.getOrder_price());
			this.pst.setLong(4, order.getOrder_discount());
			this.pst.setString(5, order.getOrder_coupon());
			this.pst.setString(6, order.getOrder_type());
			this.pst.setBoolean(7, order.isOrder_use_mile());
			this.pst.setInt(8, order.getOrder_use_amount());
			this.pst.setBoolean(9, order.isOrder_add_mile());
			this.pst.setInt(10, order.getOrder_add_amount());
			this.pst.setBoolean(11, order.isOrder_is_maked());
			this.pst.setString(12, order.get_who());
			this.pst.setBoolean(13, order.isOrder_is_togo());
			if (this.pst.executeUpdate() == 1) {
				flag = true;
			};
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return flag;
	}
	
	public boolean no_user_order(Orders_Bean order) {
		boolean flag = false;
		try {
			this.Initializer("INSERT INTO `orders` (`order_time`, `order_foods`, `order_price`, `order_discount`, `order_coupon`, `order_type`, `order_use_mile`, `order_use_mile_amount`, `order_add_mile`, `order_add_mile_amount`, `order_is_maked`, `order_is_togo`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			this.pst.setTimestamp(1, order.getOrder_time());
			this.pst.setString(2, order.getOrder_foods());
			this.pst.setLong(3, order.getOrder_price());
			this.pst.setLong(4, order.getOrder_discount());
			this.pst.setString(5, order.getOrder_coupon());
			this.pst.setString(6, order.getOrder_type());
			this.pst.setBoolean(7, order.isOrder_use_mile());
			this.pst.setInt(8, order.getOrder_use_amount());
			this.pst.setBoolean(9, order.isOrder_add_mile());
			this.pst.setInt(10, order.getOrder_add_amount());
			this.pst.setBoolean(11, order.isOrder_is_maked());
			this.pst.setBoolean(12, order.isOrder_is_togo());
			if (this.pst.executeUpdate() == 1) {
				flag = true;
			};
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return flag;
	}
	
	public boolean updateOrder(Orders_Bean order) {
		boolean flag = false;
		try {
			this.Initializer("UPDATE `orders` SET `order_time` = ?, `order_foods` = ?, `order_price` = ?, `order_discount` = ?, `order_coupon` = ?, `order_type` = ?, `order_use_mile` = ?, `order_use_mile_amount` = ?, `order_add_mile` = ?, `order_add_mile_amount` = ?, `order_is_maked` = ?, `order_who` = ?, `order_is_togo` = ? WHERE `order_no` = ?");
			this.pst.setTimestamp(1, order.getOrder_time());
			this.pst.setString(2, order.getOrder_foods());
			this.pst.setLong(3, order.getOrder_price());
			this.pst.setLong(4, order.getOrder_discount());
			this.pst.setString(5, order.getOrder_coupon());
			this.pst.setString(6, order.getOrder_type());
			this.pst.setBoolean(7, order.isOrder_use_mile());
			this.pst.setInt(8, order.getOrder_use_amount());
			this.pst.setBoolean(9, order.isOrder_add_mile());
			this.pst.setInt(10, order.getOrder_add_amount());
			this.pst.setBoolean(11, order.isOrder_is_maked());
			this.pst.setString(12, order.get_who());
			this.pst.setBoolean(13, order.isOrder_is_togo());
			this.pst.setInt(14, order.getOrder_no());
			if (this.pst.executeUpdate() == 1) {
				flag = true;
			};
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return flag;
	}
	
	public boolean deleteOrderByNo(int no) {
		boolean flag = false;
		try {
			this.Initializer("DELETE FROM `orders` WHERE `order_no` = ?");
			this.pst.setInt(1, no);
			if (this.pst.executeUpdate() == 1) {
				flag = true;
			};
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return flag;
	}

	// 3 관리자 페이지 거래 내역 수정.
			public boolean updateOrder1(Orders_Bean bean) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				boolean flag = false;
				try {
					con = pool.getConnection();
					sql = "update orders set order_time=?, order_price=?, order_discount=?, order_coupon=?, order_type=?, order_is_maked = ? where order_no = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setTimestamp(1, bean.getOrder_time());
					pstmt.setLong(2, bean.getOrder_price());
					pstmt.setLong(3, bean.getOrder_discount());
					pstmt.setString(4, bean.getOrder_coupon());
					pstmt.setString(5, bean.getOrder_type());
					pstmt.setBoolean(6, bean.isOrder_is_maked());
					System.out.println("sdsd" + bean.getOrder_no());
					pstmt.setInt(7, bean.getOrder_no());
					if (pstmt.executeUpdate() == 1) {
						flag = true;
					};
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return flag;
			}
			
			
	// 3 관리자 페이지 수정을 위한 목록업데이트
	public Orders_Bean getord1(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Orders_Bean bean = new Orders_Bean();
		try {
			con = pool.getConnection();
			String sql = "select * from orders where order_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
				  	bean.setOrder_no(rs.getInt("order_no"));
		            bean.setOrder_time(rs.getTimestamp("order_time"));
		            bean.setOrder_foods(rs.getString("order_foods"));
		            bean.setOrder_price(rs.getLong("order_price"));
		            bean.setOrder_discount(rs.getLong("order_discount"));
		            bean.setOrder_coupon(rs.getString("order_coupon"));
		            bean.setOrder_type(rs.getString("order_type"));
		            bean.setOrder_use_mile(rs.getBoolean("order_use_mile"));
		            bean.setOrder_use_amount(rs.getInt("order_use_mile_amount"));
		            bean.setOrder_add_mile(rs.getBoolean("order_add_mile"));
		            bean.setOrder_add_amount(rs.getInt("order_add_mile_amount"));
		            bean.setOrder_is_maked(rs.getBoolean("order_is_maked"));
		            bean.set_who(rs.getString("order_who"));
		            bean.setOrder_is_togo(rs.getBoolean("order_is_togo"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
}