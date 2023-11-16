package coupon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import all.DBConnectionMgr;

public class Coupon_kind_Mgr {
	
	private DBConnectionMgr pool;
	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;
	private Gson gson = new Gson();

	public Coupon_kind_Mgr() {
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
    
	public Vector<Coupon_kind_Bean> readAllKind() {
		Vector<Coupon_kind_Bean> vector = new Vector<Coupon_kind_Bean>();
		try {
			this.Initializer("SELECT * FROM coupon_type");
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Coupon_kind_Bean bean = new Coupon_kind_Bean();
	            bean.setNumb(this.rs.getInt("numb"));
	            bean.setName(this.rs.getString("name"));
	            bean.setDesc(this.rs.getString("desc"));
	            bean.setDiscount_per(this.rs.getInt("discount_per"));
	            bean.setVaild_date(this.rs.getInt("vaild_date"));
	            bean.setEnable(this.rs.getBoolean("enable"));
	            bean.setCategory(this.gson.fromJson(this.rs.getString("category"), new TypeToken<List<String>>() {}.getType()));
	            bean.setDefault_coupon(this.rs.getBoolean("default_coupon"));
	            vector.add(bean);
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public Vector<Coupon_kind_Bean> searchKind(String keyword) {
		Vector<Coupon_kind_Bean> vector = new Vector<Coupon_kind_Bean>();
		try {
			this.Initializer("SELECT * FROM coupon_type WHERE `name` LIKE ?");
			this.pst.setString(1, "%"+keyword+"%");
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Coupon_kind_Bean bean = new Coupon_kind_Bean();
	            bean.setNumb(this.rs.getInt("numb"));
	            bean.setName(this.rs.getString("name"));
	            bean.setDesc(this.rs.getString("desc"));
	            bean.setDiscount_per(this.rs.getInt("discount_per"));
	            bean.setVaild_date(this.rs.getInt("vaild_date"));
	            bean.setEnable(this.rs.getBoolean("enable"));
	            bean.setCategory(this.gson.fromJson(this.rs.getString("category"), new TypeToken<List<String>>() {}.getType()));
	            bean.setDefault_coupon(this.rs.getBoolean("default_coupon"));
	            vector.add(bean);
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public boolean addKind(Coupon_kind_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("INSERT INTO coupon_type (`name`, `desc`, `discount_per`, `vaild_date`, `enable`, `category`, `default_coupon`) VALUES (?, ?, ?, ?, ?, ?, ?)");
			this.pst.setString(1, bean.getName());
			this.pst.setString(2, bean.getDesc());
			this.pst.setInt(3, bean.getDiscount_per());
			this.pst.setInt(4, bean.getVaild_date());
			this.pst.setBoolean(5, bean.isEnable());
			this.pst.setString(6, bean.getCategory().toString());
			this.pst.setBoolean(7, bean.isDefault_coupon());
			if (this.pst.executeUpdate() == 1) {
				flag = true;
			}
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return flag;
	}
	
	public boolean updateKind(Coupon_kind_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("UPDATE coupon_type SET name = ?, desc = ?, discount_per = ?, vaild_date = ?, enable = ?, category = ?, default_coupon = ?) WHERE numb = ?");
			this.pst.setString(1, bean.getName());
			this.pst.setString(2, bean.getDesc());
			this.pst.setInt(3, bean.getDiscount_per());
			this.pst.setInt(4, bean.getVaild_date());
			this.pst.setBoolean(5, bean.isEnable());
			this.pst.setString(6, bean.getCategory().toString());
			this.pst.setBoolean(7, bean.isDefault_coupon());
			this.pst.setInt(8, bean.getNumb());
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
	
	public boolean deleteKind(Integer numb) {
		boolean flag = false;
		try {
			this.Initializer("DELETE FROM coupon_type WHERE numb = ?");
			this.pst.setInt(1, numb);
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