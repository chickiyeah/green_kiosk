package coupon;

import all.DBConnectionMgr;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Vector;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

/**
 * Wrote by GwakTaeWoong
 */

public class Coupon_Mgr {

	private DBConnectionMgr pool;
	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;

	public Coupon_Mgr() {
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
        try {
            if (this.rs != null) {
                this.rs.close();
            }
            if (this.pst != null) {
                this.pst.close();
            }
            if (this.conn != null) {
                pool.freeConnection(this.conn);
            }
        } catch (Exception e) {
			e.printStackTrace();
        }
    }

	public Vector<Coupon_Bean> readAllCoupon() {
		Vector<Coupon_Bean> vector = new Vector<Coupon_Bean>();
		try {
			this.Initializer("SELECT * FROM coupon");
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Coupon_Bean bean = new Coupon_Bean();
	            bean.setCoupon_no(this.rs.getInt("coupon_no"));
	            bean.setCoupon_name(this.rs.getString("coupon_name"));
	            bean.setCoupon_code(this.rs.getString("coupon_code"));
	            bean.setCoupon_menuNo(this.rs.getInt("coupon_menuNo"));
	            bean.setCoupon_discount(this.rs.getInt("coupon_discount"));
	            bean.setCoupon_issueDate(this.rs.getTimestamp("coupon_issueDate"));
	            bean.setCoupon_expireDate(this.rs.getTimestamp("coupon_expireDate"));
	            bean.setCoupon_limitTime1(this.rs.getTimestamp("coupon_limitTime1"));
	            bean.setCoupon_limitTime2(this.rs.getTimestamp("coupon_limitTime2"));
	            bean.set_owner(this.rs.getString("coupon_owner"));
	            vector.add(bean);
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public Vector<Coupon_Bean> getUserCoupon(String user_id) {
		Vector<Coupon_Bean> vector = new Vector<Coupon_Bean>();
		try {
			this.Initializer("SELECT * FROM coupon WHERE coupon_owner = ? AND coupon_used = false");
			this.pst.setString(1, user_id);
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Coupon_Bean bean = new Coupon_Bean();
	            bean.setCoupon_no(this.rs.getInt("coupon_no"));
	            bean.setCoupon_name(this.rs.getString("coupon_name"));
	            bean.setCoupon_code(this.rs.getString("coupon_code"));
	            bean.setCoupon_menuNo(this.rs.getInt("coupon_menuNo"));
	            bean.setCoupon_discount(this.rs.getInt("coupon_discount"));
	            bean.setCoupon_issueDate(this.rs.getTimestamp("coupon_issueDate"));
	            bean.setCoupon_expireDate(this.rs.getTimestamp("coupon_expireDate"));
	            bean.setCoupon_limitTime1(this.rs.getTimestamp("coupon_limitTime1"));
	            bean.setCoupon_limitTime2(this.rs.getTimestamp("coupon_limitTime2"));
	            bean.set_owner(this.rs.getString("coupon_owner"));
	            vector.add(bean);
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public String readCouponNameByNo(int no) {
		String result = "";
		try {
			this.Initializer("SELECT coupon_name FROM coupon WHERE coupon_no=?");
			this.pst.setInt(1, no);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            result = this.rs.getString("coupon_name");
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return result;
	}
	
	public Coupon_Bean readCouponByCode(String code) {
		Coupon_Bean bean = new Coupon_Bean();
		try {
			this.Initializer("SELECT * FROM coupon WHERE coupon_code=?");
			this.pst.setString(1, code);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            bean.setCoupon_no(this.rs.getInt("coupon_no"));
	            bean.setCoupon_name(this.rs.getString("coupon_name"));
	            bean.setCoupon_code(this.rs.getString("coupon_code"));
	            bean.setCoupon_menuNo(this.rs.getInt("coupon_menuNo"));
	            bean.setCoupon_discount(this.rs.getInt("coupon_discount"));
	            bean.setCoupon_issueDate(this.rs.getTimestamp("coupon_issueDate"));
	            bean.setCoupon_expireDate(this.rs.getTimestamp("coupon_expireDate"));
	            bean.setCoupon_limitTime1(this.rs.getTimestamp("coupon_limitTime1"));
	            bean.setCoupon_limitTime2(this.rs.getTimestamp("coupon_limitTime2"));
	            bean.set_owner(this.rs.getString("coupon_owner"));
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return bean;
	}
	
	public int checkCouponCode(String code) {
		int result = -1;
		try {
			this.Initializer("SELECT coupon_no FROM coupon WHERE coupon_code=?");
			this.pst.setString(1, code);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            result = this.rs.getInt("coupon_no");
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return result;
	}
	
	public Map<String, String> useCoupon(String code) {
		java.util.Date date = null;
		Integer vaild_date = 0;
		boolean used = false;
		String coupon_name = "";
		Map<String, String> result = new HashMap<String, String>();
		result.put("result", "failed");
		result.put("reason", "unknown");
		try {
			this.Initializer("SELECT * FROM coupon WHERE coupon_code=?");
			this.pst.setString(1, code);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            date = this.rs.getDate("coupon_issueDate");
	            used = this.rs.getBoolean("coupon_used");
	            coupon_name = this.rs.getString("coupon_name");
	            if (used) {
	            	result.put("reason", "already_used");
		        	return result;
	            }
	        } else {
	        	result.put("reason", "not_found");
	        	return result;
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		boolean enable = false;
		try {
			this.Initializer("SELECT * FROM coupon_type WHERE name=?");
			this.pst.setString(1, coupon_name);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            vaild_date = this.rs.getInt("vaild_date");
	            enable = this.rs.getBoolean("enable");
	            if (enable) {
	            	Calendar date_c = Calendar.getInstance();
	            	java.util.Date now = Calendar.getInstance().getTime();
	            	
	            	
	            	date_c.add(Calendar.DATE, vaild_date);
	            	date = date_c.getTime();
	            	
	            	if (date.before(now)) {

	            	} else {
	            		result.put("reason", "coupon_expired");
	            		
	            		return result;
	            	}
	            } else {
	            	result.put("reason", "disabled_coupon");
		        	return result;
	            }
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		
		try {
			this.Initializer("UPDATE coupon SET coupon_used = ? WHERE coupon_code=?");
			this.pst.setBoolean(1, true);
			this.pst.setString(2, code);
			if (this.pst.executeUpdate() == 1) {
        		result.put("result", "success");
        		result.put("reason", "none");
        		
        		return result;
			};
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return result;
	}
	
	public Map<String, String> checkCouponVaild(String code) {
		java.util.Date date = null;
		Integer vaild_date = 0;
		boolean used = false;
		String coupon_name = "";
		Timestamp issue_date = null;
		Map<String, String> result = new HashMap<String, String>();
		result.put("result", "failed");
		result.put("reason", "unknown");
		try {
			this.Initializer("SELECT * FROM coupon WHERE coupon_code=?");
			this.pst.setString(1, code);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            date = this.rs.getDate("coupon_issueDate");
	            used = this.rs.getBoolean("coupon_used");
	            coupon_name = this.rs.getString("coupon_name");
	            issue_date = this.rs.getTimestamp("coupon_issueDate");
	            if (used) {
	            	result.put("reason", "already_used");
		        	return result;
	            }
	        } else {
	        	result.put("reason", "not_found");
	        	return result;
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		boolean enable = false;
		try {
			this.Initializer("SELECT * FROM coupon_type WHERE name=?");
			this.pst.setString(1, coupon_name);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            vaild_date = this.rs.getInt("vaild_date");
	            enable = this.rs.getBoolean("enable");
	            if (enable) {
	            	Calendar date_c = Calendar.getInstance();
	            	java.util.Date now = Calendar.getInstance().getTime();
	            	
	            	if (vaild_date < 0) {
	            		result.put("result", "success");
	            		result.put("reason", "none");
	            		
	            		return result;
	            	}
	            	LocalDateTime issueday = issue_date.toLocalDateTime();
					LocalDateTime endday = issueday.plusDays(vaild_date);
					LocalDateTime now1 = LocalDateTime.now();
	            	
	            	date_c.add(Calendar.DATE, vaild_date);
	            	date = date_c.getTime();
	            	
	            	if (now1.isBefore(endday)) {
	            		result.put("result", "success");
	            		result.put("reason", "none");
	            		
	            		return result;
	            	} else {
	            		result.put("reason", "coupon_expired");
	            		
	            		return result;
	            	}
	            } else {
	            	result.put("reason", "disabled_coupon");
		        	return result;
	            }
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return result;
	}
	
	public boolean createCoupon(Coupon_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("INSERT coupon(coupon_name, coupon_code, coupon_menuNo, coupon_discount,"
					+ " coupon_owner )"
					+ " VALUES (?,?,?,?,?)");
			this.pst.setString(1, bean.getCoupon_name());
			this.pst.setString(2, bean.getCoupon_code());
			this.pst.setInt(3, bean.getCoupon_menuNo());
			this.pst.setInt(4, bean.getCoupon_discount());
			this.pst.setString(5, bean.get_owner());
			if (this.pst.executeUpdate() == 1) {
				flag = true;
			};
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return flag;
	}
	
	public boolean updateCoupon(Coupon_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("UPDATE coupon SET coupon_name=?, coupon_code=?, coupon_menuNo=?, coupon_discount=?,"
					+ " coupon_issueDate=?, coupon_expireDate=?, coupon_limitTime1=?, coupon_limitTime2=?"
					+ " WHERE coupon_no=?");
			this.pst.setString(1, bean.getCoupon_name());
			this.pst.setString(2, bean.getCoupon_code());
			this.pst.setInt(3, bean.getCoupon_menuNo());
			this.pst.setInt(4, bean.getCoupon_discount());
			this.pst.setTimestamp(5, bean.getCoupon_issueDate());
			this.pst.setTimestamp(6, bean.getCoupon_expireDate());
			this.pst.setTimestamp(7, bean.getCoupon_limitTime1());
			this.pst.setTimestamp(8, bean.getCoupon_limitTime2());
			this.pst.setInt(9, bean.getCoupon_no());
			if (this.pst.executeUpdate() == 1) {
				flag = true;
			};
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return flag;
	}
	
	public boolean deleteCouponByNo(int no) {
		boolean flag = false;
		try {
			this.Initializer("DELETE FROM coupon WHERE coupon_no=?");
			this.pst.setInt(1, no);
			if (this.pst.executeUpdate() == 1) {
				flag = true;
			};
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return flag;
	}
}
