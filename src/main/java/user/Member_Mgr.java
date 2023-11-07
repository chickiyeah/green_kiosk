package user;

import java.lang.reflect.Member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;


import all.DBConnectionMgr;

/**
 * 
 * 
 * @author 재운
 * @param <Bean_Membe>
 * @param <BeanMember>
 *
 */
public class Member_Mgr<Bean_Membe> {
	
	
	private static final String Member_Bean = null;
	private static final String Bean_Member = null;
	private DBConnectionMgr pool;
	private Object bean;
	
	// 회원 정보 ===============================================================================
	// ID 중복 체크
	public boolean checkId(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select mem_id from  where mem_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			flag = pstmt.executeQuery().next();	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}


	// 회원 추가
	public boolean Member_bean(Member_Bean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert Member_bean( mem_no, mem_id, mem_pw,,mem_name,mem_phone,mem_ac,mem_mile,mem_coupon1)values(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,bean.getMem_no());
			pstmt.setString(2, bean.getMem_id());
			pstmt.setString(3, bean.getMem_pw());
			pstmt.setString(4, bean.getMem_name());
			pstmt.setString(5, bean.getMem_phone());
			pstmt.setString(6, bean.getMem_ac());
			pstmt.setInt(7, bean.getMem_mile());
			pstmt.setString(8, bean.getMem_coupon1());
			
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}


	
	// 패스워드 암호화(임시)
	public void getPass(int numb, String pass_w) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "update  Member_Bean set pass=SHA2('" + pass_w + "',256) where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 로그인
	public boolean loginMember(String usid, String uspw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select usid from Member_bean where usid=? and uspw=? and stat='승인' ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Bean_Member);
			pstmt.setString(2, Bean_Member);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 회원 조회 (usid)
	public Member_Bean getMember(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Member_Bean bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from Member_Bean where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Member_Bean();
				bean.setMem_no(rs.getInt("mem_no"));
				bean.setMem_id(rs.getString("mem_id"));
				bean.setMem_pw(rs.getString("mem_pw"));
				bean.setMem_name(rs.getString("mem_name"));
				bean.setMem_phone(rs.getString("mem_phone"));
				bean.setMem_ac(rs.getString("mem_ac"));
				bean.setMem_mile(rs.getInt("mem_miie"));
				bean.setMem_coupon1(rs.getString("mem_coupon1"));
				String hobbys[] = new String[5];
				String hobb = rs.getString("hobb");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobb.substring(i, i + 1);
				}
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}

	// 회원 조회 (numb)
	public Member_Bean getMember2(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Member_Bean bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from Member_bean where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Member_Bean();
				bean.getMem_no();
				bean.setMem_id(rs.getString("mem_id"));
				bean.setMem_pw(rs.getString("mem_pw"));
				bean.setMem_name(rs.getString("mem_name"));
				bean.setMem_phone(rs.getString("mem_phone"));
				bean.setMem_ac(rs.getString("mem_ac"));
				bean.setMem_mile(rs.getInt("mem_mile"));
				bean.setMem_coupon1(rs.getString("mem_coupon1"));
				String hobbys[] = new String[5];
				String hobb = rs.getString("hobb");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobb.substring(i, i + 1);
				}
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 회원 조회 (numb)
	public Member_Bean getMember3(String usid, int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Member_Bean bean = null;
		try {
			con = pool.getConnection();
			if (numb > 0) {
				String sql = "select * from bean_member where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
			} else {
				String sql = "select * from  bean_member where usid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, usid);
			}
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Member_Bean();
				bean.setMem_no(rs.getInt("mem_no"));
				bean.setMem_id(rs.getString("mem_id"));
				bean.setMem_pw(rs.getString("mem_pw"));
				bean.setMem_name(rs.getString("mem_name"));
				bean.setMem_phone(rs.getString("mem_phone"));
				bean.setMem_ac(rs.getString("mem_ac"));
				bean.setMem_mile(rs.getInt("mem_mile"));
				bean.setMem_coupon1(rs.getString("mem_coupon1"));
				String hobbys[] = new String[5];
				String hobb = rs.getString("hobb");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobb.substring(i, i + 1);
				}
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}

	// 회원 정보 수정
	public boolean updateMember(Member_Bean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "update Member_Bean set mem_id=?, mom_pw=?, mem_name=?, mem_phone=?, mem_ac=?, mem_mile=?, mem_coupon1=?, brth=?,";
			pstmt.setInt(1, bean.getMem_no());
			pstmt.setString(2, bean.getMem_id());
			pstmt.setString(3, bean.getMem_pw());
			pstmt.setString(4, bean.getMem_name());
			pstmt.setString(5, bean.getMem_phone());
			pstmt.setString(6, bean.getMem_ac());
			pstmt.setInt(7, bean.getMem_mile());
			pstmt.setString(8, bean.getMem_coupon1());
		
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
	

	// 회원 정보 삭제
	public void deleteMember(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from chul_admin where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	// 회원 승인 여부 
	public boolean updatePerm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("미승인")) {
				String sql = "update (Member_Bean  set stat='승인' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				String sql = "update (Member_Bean  set stat='미승인' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			}
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
	
}

