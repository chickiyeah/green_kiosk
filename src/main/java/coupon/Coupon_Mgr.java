package coupon;

import DBconnector.DBConnectionMgr;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

/*
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
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
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
		} catch (Exception error) {
			error.printStackTrace();
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
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return bean;
	}
	
	public boolean createCoupon(Coupon_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("INSERT coupon(coupon_name, coupon_code, coupon_menuNo, coupon_discount,"
					+ " coupon_issueDate, coupon_expireDate, coupon_limitTime1, coupon_limitTime2)"
					+ " VALUES (?,?,?,?,?,?,?,?)");
			this.pst.setString(1, bean.getCoupon_name());
			this.pst.setString(2, bean.getCoupon_code());
			this.pst.setInt(3, bean.getCoupon_menuNo());
			this.pst.setInt(4, bean.getCoupon_discount());
			this.pst.setTimestamp(5, bean.getCoupon_issueDate());
			this.pst.setTimestamp(6, bean.getCoupon_expireDate());
			this.pst.setTimestamp(7, bean.getCoupon_limitTime1());
			this.pst.setTimestamp(8, bean.getCoupon_limitTime2());
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
		} catch (Exception error) {
			error.printStackTrace();
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
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return flag;
	}
}
