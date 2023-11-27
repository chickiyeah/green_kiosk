package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import DBconnector.DBConnectionMgr;

public class commentMgr {

	
	private DBConnectionMgr pool;
	private static final String ENCTYPE = "UTF-8";
 
	public commentMgr()	{
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//post_no에 맞는 댓글 리스트 가지고 오기
	public List<commentBean> getComment(Long comment_post_no) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    List<Long> comment_no_list = new ArrayList<>();
	    List<commentBean> list = new ArrayList<>();
	    String commentWriterId = null;
	    try {
	        con = pool.getConnection();
	        sql = "SELECT DISTINCT comment.comment_no FROM comment JOIN board ON board.post_no = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setLong(1, comment_post_no);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            comment_no_list.add(rs.getLong("comment_no"));
	        }

	        for (Long comment_no : comment_no_list) {
	            sql = "SELECT * FROM comment WHERE comment_no = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setLong(1, comment_no);
	            rs = pstmt.executeQuery();

	            while (rs.next()) {
	                commentBean bean = new commentBean();
	                commentWriterId = findUser(rs.getLong("comment_writer"));
	                bean.setComment_no(rs.getLong("comment_no"));
	                bean.setComment_content(rs.getString("comment_content"));
	                bean.setComment_time(rs.getString("comment_time"));
	                bean.setComment_writer_id(commentWriterId);
	                bean.setComment_writer(rs.getLong("comment_writer"));
	                bean.setComment_post_no(rs.getLong("comment_post_no"));
	                list.add(bean);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return list;
	}

	public String findUser(Long comment_writer)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String result = null;
		try {
			con = pool.getConnection();
			sql = "SELECT member.mem_id AS writer_id FROM comment "
					+ "JOIN member ON comment.comment_writer = member.mem_no "
					+ "WHERE comment.comment_writer = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, comment_writer);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				result = rs.getString("writer_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return result;
	}

	
	
}
