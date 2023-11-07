package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBconnector.DBConnectionMgr;

public class MemberMgr {

	private DBConnectionMgr pool;
	
	public MemberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

/*****************************************************************************************************************************************************************/
/*																				로그인                                                                                               */
/*****************************************************************************************************************************************************************/
	public int login(String mem_id, String mem_pw)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT mem_pw FROM member WHERE mem_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String pass = rs.getString("mem_pw");
				if(mem_pw.equals(pass)) {
					return 1;
				} 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1;
	}
	
	
	
}
