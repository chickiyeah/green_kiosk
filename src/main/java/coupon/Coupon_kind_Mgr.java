package coupon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
    
    public Coupon_kind_Bean get_type_with_name(String name) {
    	Coupon_kind_Bean type = new Coupon_kind_Bean();
    	try {
    		this.Initializer("SELECT * FROM `coupon_type` WHERE `name` = ?");
    		this.pst.setString(1, name);
    		System.out.println(name);
    		this.rs = this.pst.executeQuery();
    		if (this.rs.next()) {
    			type.setNumb(this.rs.getInt("numb"));
	            type.setName(this.rs.getString("name"));
	            type.setDesc(this.rs.getString("desc"));
	            type.setDiscount_per(this.rs.getInt("discount_per"));
	            type.setVaild_date(this.rs.getInt("vaild_date"));
	            type.setEnable(this.rs.getBoolean("enable"));
	            type.setCategory(this.gson.fromJson(this.rs.getString("category"), new TypeToken<List<String>>() {}.getType()));
	            type.setDefault_coupon(this.rs.getBoolean("default_coupon"));
    		}
    	} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
    	
    	return type;
    }
    
    public Vector<Coupon_kind_Bean> get_printable(String user_id) {
		Vector<Coupon_kind_Bean> base_vector = new Vector<Coupon_kind_Bean>();
		Vector<String> printed_coupon = new Vector<String>(); //이미 발급한 쿠폰
		Vector<Coupon_kind_Bean> res_vector = new Vector<Coupon_kind_Bean>();
		
		try {
			this.Initializer("SELECT * FROM coupon_type WHERE enable = true");
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
	            base_vector.add(bean);
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		
		try {
			this.Initializer("SELECT coupon_name FROM coupon WHERE `coupon_owner` = ?");
			this.pst.setString(1, user_id);
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				printed_coupon.add(this.rs.getString("coupon_name"));
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		
		for (Coupon_kind_Bean bean : base_vector) {
			if (printed_coupon.contains(bean.getName()) == false) {
				res_vector.add(bean);
			}
		}
		
		return res_vector;
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
	
	public Coupon_kind_Bean getKindWithNumb(Integer numb) {
		Coupon_kind_Bean bean = new Coupon_kind_Bean();
		try {
			this.Initializer("SELECT * FROM coupon_type WHERE numb = ?");
			this.pst.setInt(1, numb);
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				
	            bean.setNumb(this.rs.getInt("numb"));
	            bean.setName(this.rs.getString("name"));
	            bean.setDesc(this.rs.getString("desc"));
	            bean.setDiscount_per(this.rs.getInt("discount_per"));
	            bean.setVaild_date(this.rs.getInt("vaild_date"));
	            bean.setEnable(this.rs.getBoolean("enable"));
	            bean.setCategory(this.gson.fromJson(this.rs.getString("category"), new TypeToken<List<String>>() {}.getType()));
	            bean.setDefault_coupon(this.rs.getBoolean("default_coupon"));
	        }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.Closer();
		}
		return bean;
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
	
	public Map<String, String> addKind(Coupon_kind_Bean bean) {
		Map<String, String> res = new HashMap<String, String>();
		res.put("result","failed");
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
				res.put("result","success");
			}
        } catch (Exception e) {
			e.printStackTrace();
			res.put("reason",e.getMessage());
		} finally {
			this.Closer();
		}
		return res;
	}
	
	public boolean updateKind(Coupon_kind_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("UPDATE coupon_type SET `name` = ?, `desc` = ?, `discount_per` = ?, `vaild_date` = ?, `enable` = ?, `category` = ? WHERE `numb` = ?");
			this.pst.setString(1, bean.getName());
			this.pst.setString(2, bean.getDesc());
			this.pst.setInt(3, bean.getDiscount_per());
			this.pst.setInt(4, bean.getVaild_date());
			this.pst.setBoolean(5, bean.isEnable());
			this.pst.setString(6, bean.getCategory().toString());
			this.pst.setInt(7, bean.getNumb());
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
