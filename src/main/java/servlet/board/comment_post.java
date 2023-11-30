package servlet.board;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.commentBean;
import board.commentMgr;

@WebServlet({"/comment_post", "/board/view/getCommentList", "/board/view/inputComment"})
public class comment_post extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Long post_no = 0L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			response.setCharacterEncoding("UTF-8");
	    	response.setContentType("application/json;charset=UTF-8");
	    	request.setCharacterEncoding("UTF-8");
	    	
	    	String endPoint = request.getServletPath();

	    	if ("/board/view/getCommentList".equals(endPoint))
	    	{
		    	post_no = Long.parseLong(request.getParameter("post_no"));
	    		commentMgr cMgr = new commentMgr();
	    		List<commentBean> comment_list = new ArrayList<>();

	    		comment_list = cMgr.getComment(post_no);
                String jsonResponse = convertCommentListToJSON(comment_list);
                response.getWriter().write(jsonResponse);

	    	} else if ("/board/view/inputComment".equals(endPoint)) {
	    		commentMgr cMgr = new commentMgr();

	    		boolean result = cMgr.insertComment(request);
	    		if (result == true) {
		    		response.setContentType("application/json;charset=UTF-8");
		    		response.getWriter().write("{ \"success\": true, \"message\": \"댓글 입력 성공\" }");
	    		}
	    	}
	    }
	   	
	private String convertCommentListToJSON(List<commentBean> commentList) {
	    try {
	        List<String> jsonComments = new ArrayList<>();
	        for (commentBean comment : commentList) {
	            String jsonComment = convertCommentToDecodeJson(comment);
	            if (!jsonComment.isEmpty()) {
	                jsonComments.add(jsonComment);
	            }
	        }

	        if (jsonComments.isEmpty()) {
	            return "[]";
	        } else {
	            return "[" + String.join(",", jsonComments) + "]";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "[]";
	    }
	}

	/*
	 * private String convertCommentToJson(commentBean comment) { try { return "{" +
	 * "\"comment_no\":\"" + comment.getComment_no() + "\"," +
	 * "\"comment_content\":\"" + comment.getComment_content() + "\"," +
	 * "\"comment_time\":\"" + comment.getComment_time() + "\"," +
	 * "\"comment_writer\":\"" + comment.getComment_writer() + "\"," +
	 * "\"comment_writer_id\":\"" + comment.getComment_writer_id() + "\"," +
	 * "\"comment_post_no\":\"" + comment.getComment_post_no() + "\"" + "}"; } catch
	 * (Exception e) { e.printStackTrace(); return ""; } }
	 */
	
	private String convertCommentToDecodeJson(commentBean comment) {
	    try {
	        return "{"
	                + "\"comment_no\":\"" + comment.getComment_no() + "\","
	                + "\"comment_content\":\"" + URLDecoder.decode(comment.getComment_content(), "UTF-8") + "\","
	                + "\"comment_time\":\"" + comment.getComment_time() + "\","
	                + "\"comment_writer\":\"" + comment.getComment_writer() + "\","
	                + "\"comment_writer_id\":\"" + comment.getComment_writer_id() + "\","
	                + "\"comment_post_no\":\"" + comment.getComment_post_no() + "\""
	                + "}";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "";
	    }
	}
}
