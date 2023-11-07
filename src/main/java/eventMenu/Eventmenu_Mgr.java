package eventMenu;

import DBconnector.DBConnectionMgr
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

/*
 * Wrote by GwakTaeWoong
 */

public class Eventmenu_Mgr {

	private DBConnectionMgr pool;
	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;

	public Eventmenu_Mgr() {
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
	
	public Vector<Eventmenu_Bean> readAllEventmenuByEventNo(int eventNo) {
		Vector<Eventmenu_Bean> vector = new Vector<Eventmenu_Bean>();
		try {
			this.Initializer("SELECT * FROM eventMenu WHERE eventMenu_eventNo=?");
			this.pst.setInt(1, eventNo);
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Eventmenu_Bean bean = new Eventmenu_Bean();
	            bean.setEventMenu_no(this.rs.getInt("eventMenu.no"));
	            bean.setEventMenu_eventNo(this.rs.getInt("eventMenu.eventNo"));
	            bean.setEventMenu_menuNo(this.rs.getInt("eventMenu.menuNo"));
	            bean.setEventMenu_discount(this.rs.getInt("eventMenu.discount"));
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public Vector<Eventmenu_Bean> readAllEventmenuByMenuNo(int menuNo) {
		Vector<Eventmenu_Bean> vector = new Vector<Eventmenu_Bean>();
		try {
			this.Initializer("SELECT * FROM eventMenu WHERE eventMenu_menuNo=?");
			this.pst.setInt(1, menuNo);
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Eventmenu_Bean bean = new Eventmenu_Bean();
	            bean.setEventMenu_no(this.rs.getInt("eventMenu.no"));
	            bean.setEventMenu_eventNo(this.rs.getInt("eventMenu.eventNo"));
	            bean.setEventMenu_menuNo(this.rs.getInt("eventMenu.menuNo"));
	            bean.setEventMenu_discount(this.rs.getInt("eventMenu.discount"));
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public Eventmenu_Bean readEventmenuByNo(String no) {
		Eventmenu_Bean bean = new Eventmenu_Bean();
		try {
			this.Initializer("SELECT * FROM eventMenu WHERE eventMenu_no=?");
			this.pst.setString(1, no);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            bean.setEventMenu_no(this.rs.getInt("eventMenu.no"));
	            bean.setEventMenu_eventNo(this.rs.getInt("eventMenu.eventNo"));
	            bean.setEventMenu_menuNo(this.rs.getInt("eventMenu.menuNo"));
	            bean.setEventMenu_discount(this.rs.getInt("eventMenu.discount"));
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return bean;
	}
	
	public boolean createEventmenu(Eventmenu_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("INSERT eventMenu(eventMenu_eventNo, eventMenu_menuNo, eventMenu_discount"
					+ " VALUES (?,?,?)");
			this.pst.setInt(1, bean.getEventMenu_eventNo());
			this.pst.setInt(2, bean.getEventMenu_menuNo());
			this.pst.setInt(3, bean.getEventMenu_discount());
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
	
	public boolean updateEvent(Eventmenu_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("UPDATE eventMenu SET eventMenu_eventNo=?, eventMenu_menuNo=?, eventMenu_discount=?"
					+ " WHERE eventMenu_no=?");
			this.pst.setInt(1, bean.getEventMenu_eventNo());
			this.pst.setInt(2, bean.getEventMenu_menuNo());
			this.pst.setInt(3, bean.getEventMenu_discount());
			this.pst.setInt(4, bean.getEventMenu_no());
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
