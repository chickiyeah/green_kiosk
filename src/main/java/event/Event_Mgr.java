package event;
import all.DBConnectionMgr;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

/*
 * Wrote by GwakTaeWoong
 */

public class Event_Mgr {

	private DBConnectionMgr pool;
	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;

	public Event_Mgr() {
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
	
	public Vector<Event_Bean> readAllEvent() {
		Vector<Event_Bean> vector = new Vector<Event_Bean>();
		try {
			this.Initializer("SELECT * FROM event");
			this.rs = this.pst.executeQuery();
			while (this.rs.next()) {
				Event_Bean bean = new Event_Bean();
	            bean.setEvent_no(this.rs.getInt("event_no"));
	            bean.setEvent_name(this.rs.getString("event_name"));
	            bean.setEvent_issueDate(this.rs.getTimestamp("event_issueDate"));
	            bean.setEvent_expireDate(this.rs.getTimestamp("event_expireDate"));
	            bean.setEvent_limitTime1(this.rs.getTimestamp("event_limitTime1"));
	            bean.setEvent_limitTime2(this.rs.getTimestamp("event_limitTime2"));
	            vector.add(bean);
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return vector;
	}
	
	public String readEventNameByNo(int no) {
		String result = "";
		try {
			this.Initializer("SELECT event_name FROM event WHERE event_no=?");
			this.pst.setInt(1, no);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            result = this.rs.getString("event_name");
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return result;
	}
	
	public Event_Bean readEventByNo(String no) {
		Event_Bean bean = new Event_Bean();
		try {
			this.Initializer("SELECT * FROM event WHERE event_no=?");
			this.pst.setString(1, no);
			this.rs = this.pst.executeQuery();
	        if (this.rs.next()) {
	            bean.setEvent_no(this.rs.getInt("event_no"));
	            bean.setEvent_name(this.rs.getString("event_name"));
	            bean.setEvent_issueDate(this.rs.getTimestamp("event_issueDate"));
	            bean.setEvent_expireDate(this.rs.getTimestamp("event_expireDate"));
	            bean.setEvent_limitTime1(this.rs.getTimestamp("event_limitTime1"));
	            bean.setEvent_limitTime2(this.rs.getTimestamp("event_limitTime2"));
	        }
		} catch (Exception error) {
			error.printStackTrace();
		} finally {
			this.Closer();
		}
		return bean;
	}
	
	public boolean createEvent(Event_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("INSERT event(event_name, event_issueDate, event_expireDate, event_limitTime1,"
					+ " event_limitTime2)"
					+ " VALUES (?,?,?,?,?)");
			this.pst.setString(1, bean.getEvent_name());
			this.pst.setTimestamp(2, bean.getEvent_issueDate());
			this.pst.setTimestamp(3, bean.getEvent_expireDate());
			this.pst.setTimestamp(4, bean.getEvent_limitTime1());
			this.pst.setTimestamp(5, bean.getEvent_limitTime2());
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
	
	public boolean updateEvent(Event_Bean bean) {
		boolean flag = false;
		try {
			this.Initializer("UPDATE event SET event_name=?, event_issueDate=?, event_expireDate=?,"
					+ " event_limitTime1=?, event_limitTime2=?"
					+ " WHERE event_no=?");
			this.pst.setString(1, bean.getEvent_name());
			this.pst.setTimestamp(2, bean.getEvent_issueDate());
			this.pst.setTimestamp(3, bean.getEvent_expireDate());
			this.pst.setTimestamp(4, bean.getEvent_limitTime1());
			this.pst.setTimestamp(5, bean.getEvent_limitTime2());
			this.pst.setInt(6, bean.getEvent_no());
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
	
	public boolean deleteEventByNo(int no) {
		boolean flag = false;
		try {
			this.Initializer("DELETE FROM event WHERE event_no=?");
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
