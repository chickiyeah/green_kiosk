package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import DBconnector.DBConnectionMgr;
import menu.Menu_menu_Bean;

public class BoardMgr {

	private DBConnectionMgr pool;
	private static final String ENCTYPE = "UTF-8";
 
	public BoardMgr()	{
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//post_no에 맞는 게시글 가지고 오기
	public boardBean getBoard(Long numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boardBean bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from board where post_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new boardBean();
				bean.setPost_no(rs.getLong("post_no"));
				bean.setPost_time(rs.getString("post_time"));
				bean.setPost_title(rs.getString("post_title"));
				bean.setPost_content(rs.getString("post_content"));
				bean.setPost_writer(rs.getLong("post_writer"));
				bean.setPost_viewcount(rs.getLong("post_viewcount"));
				bean.setPost_likecount(rs.getLong("post_likecount"));
				bean.setPost_filePath(rs.getString("post_filePath"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	//board 리스트 전체 불러오기
	public List <boardBean> getBoardList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List <boardBean> list = new ArrayList <boardBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM board ORDER BY post_no DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				boardBean bean = new boardBean();
				bean = new boardBean();
				bean.setPost_no(rs.getLong("post_no"));
				bean.setPost_time(rs.getString("post_time"));
				bean.setPost_title(rs.getString("post_title"));
				bean.setPost_content(rs.getString("post_content"));
				bean.setPost_writer(rs.getLong("post_writer"));
				bean.setPost_viewcount(rs.getLong("post_viewcount"));
				bean.setPost_likecount(rs.getLong("post_likecount"));
				bean.setPost_filePath(rs.getString("post_filePath"));
				list.add(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}
	/**
	 *  게시판 페이징
	 * @return
	 */
	public Vector<boardBean> getBoardList1(int pageNum, int pageSize){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector <boardBean> vlist = new Vector <boardBean>();
		try {
			 con = pool.getConnection();
		        // Calculate the starting index for the pagination
		        int offset = ((pageNum-1) * pageSize);
		        if (pageNum == 0) {
		        	sql = "select * from board ORDER BY post_no DESC";
			        pstmt = con.prepareStatement(sql);
		        } else {
			        sql = "SELECT * FROM board ORDER BY post_no DESC LIMIT ? OFFSET ? ";
			        pstmt = con.prepareStatement(sql);
			        pstmt.setInt(1, pageSize);
			        pstmt.setInt(2, offset);
		        }
		        // Use the LIMIT and OFFSET clauses for pagination

		        rs = pstmt.executeQuery();
			while(rs.next()) {
				boardBean bean = new boardBean();
				bean = new boardBean();
				bean.setPost_no(rs.getLong("post_no"));
				bean.setPost_time(rs.getString("post_time"));
				bean.setPost_title(rs.getString("post_title"));
				bean.setPost_content(rs.getString("post_content"));
				bean.setPost_writer(rs.getLong("post_writer"));
				bean.setPost_viewcount(rs.getLong("post_viewcount"));
				bean.setPost_likecount(rs.getLong("post_likecount"));
				bean.setPost_filePath(rs.getString("post_filePath"));
				vlist.add(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//mem_no로 mem_id 찾기
	public String findUser(Long post_writer)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String result = null;
		try {
			con = pool.getConnection();
			sql = "SELECT member.mem_id AS writer_id FROM board "
					+ "JOIN member ON board.post_writer = member.mem_no "
					+ "WHERE board.post_writer = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, post_writer);
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
	//mem_id로 mem_no 찾기
	public Long find_mem_no (String mem_id)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Long result = 0L;
		try {
			con = pool.getConnection();
			sql = "SELECT member.mem_no AS mem_no from member where member.mem_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				result = rs.getLong("mem_no");
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return result;
	}

    // 게시글 작성하기
	public boolean insertBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		int result = 0;
		Long post_writer = 0L;
		try {
			con = pool.getConnection();
			sql = "SELECT distinct member.mem_no FROM member JOIN board ON member.mem_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("post_writer"));
			rs = pstmt.executeQuery();
			if (rs.next()) {
				post_writer = rs.getLong("mem_no");
				result = 1;
			}
			if (result == 1)
			{
			pool.freeConnection(con, pstmt, rs);
			con = pool.getConnection();
			sql = "INSERT INTO board(post_time, post_title, post_content, post_writer, post_viewcount, post_likecount, post_filePath)"
					+ "VALUES (now() , ?, ?, ?, 0, 0, ' ')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("post_title"));
			pstmt.setString(2, req.getParameter("post_content"));
			pstmt.setLong(3, post_writer);
			if (pstmt.executeUpdate() == 1)
				flag = true;
			} else {
				flag = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 1. 메뉴 관리 페이지 - 메뉴 수정
	public boolean updateMenu(Menu_menu_Bean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE menu SET menu_name=?, menu_gubn=?, menu_isSale=?, menu_component=?,"
					+ "menu_price=?, menu_sell_amount=?, menu_recommend=?, menu_isUse = ?, menu_content=?, "
					+ "menu_imgPath=?, menu_couponable = ?  WHERE menu_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMenu_name());
			pstmt.setString(2, bean.getMenu_gubn());
			pstmt.setInt(3, bean.getMenu_isSale());
			pstmt.setString(4, bean.getMenu_component());
			pstmt.setInt(5, bean.getMenu_price());
			pstmt.setInt(6, bean.getMenu_sell_amount());
			pstmt.setInt(7, bean.getMenu_recommend());
			pstmt.setInt(8, bean.getMenu_isUse());
			pstmt.setString(9, bean.getMenu_content());
			pstmt.setString(10, bean.getMenu_imgPath());
			pstmt.setInt(11, bean.getMenu_couponable());
			pstmt.setInt(12, bean.getMenu_no());
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
	
	//추천 수 업데이트
	public Long updateLikecount(Long board_no)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int result = 0;
		Long post_likecount = 0L;
		try {
			con = pool.getConnection();
			sql = "UPDATE board SET post_likecount =post_likecount + 1 WHERE post_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, board_no);
			result = pstmt.executeUpdate();
			if (result == 1) {
				pool.freeConnection(con, pstmt);
				con = pool.getConnection();
				sql = "SELECT post_likecount FROM board WHERE post_no =? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setLong(1, board_no);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					post_likecount = rs.getLong("post_likecount");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return post_likecount;
	}
	
	//조회수 업데이트 
	public Long updateViewcount(Long board_no)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int result = 0;
		Long post_viewcount = 0L;
		try {
			con = pool.getConnection();
			sql = "UPDATE board SET post_viewcount =post_viewcount + 1 WHERE post_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, board_no);
			result = pstmt.executeUpdate();
			if (result == 1) {
				pool.freeConnection(con, pstmt);
				con = pool.getConnection();
				sql = "SELECT post_viewcount FROM board WHERE post_no =? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setLong(1, board_no);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					post_viewcount = rs.getLong("post_viewcount");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return post_viewcount;
	}
	
	// 1. 게시판 - 게시판 삭제
	public int deleteBoardAction(Long post_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int flag = -1;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM board WHERE post_no=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, post_no);
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		//실패시 -1 반환
		return flag;
	}
	
		//게시판 사용자 이미지 변경하기
	public boolean updateProfileImg(String filePath, Long mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE member SET mem_profile_img = ? where mem_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, filePath);
			pstmt.setLong(2, mem_no);
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

	public String getProfileImg(Long mem_no)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String result = null;
		try {
			con = pool.getConnection();
			sql = "SELECT mem_profile_img FROM member WHERE mem_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, mem_no);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				result = rs.getString("mem_profile_img");
			}
		} catch(Exception e)
		{
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return result;
	}
	
	public boolean editBoardAction(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		int result = 0;
		Long post_writer = 0L;
		try {
			con = pool.getConnection();
			sql = "SELECT distinct member.mem_no FROM member JOIN board ON member.mem_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("post_writer"));
			rs = pstmt.executeQuery();
			if (rs.next()) {
				post_writer = rs.getLong("mem_no");
				result = 1;
			}
			if (result == 1)
			{
			pool.freeConnection(con, pstmt, rs);
			con = pool.getConnection();
			sql = "UPDATE board SET edit_post_time = now(), post_title = ?, "
					+ "post_content = ?, post_writer = ? WHERE post_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("post_title"));
			pstmt.setString(2, req.getParameter("post_content"));
			pstmt.setLong(3, post_writer);
			pstmt.setLong(4, Long.parseLong(req.getParameter("post_no")));
			if (pstmt.executeUpdate() == 1)
				flag = true;
			} else {
				flag = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

 
	
	
}
