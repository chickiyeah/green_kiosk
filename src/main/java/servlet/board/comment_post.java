package servlet.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.commentBean;
import board.commentMgr;

@WebServlet({"/comment_post", "/board/view/getCommentList"})
public class comment_post extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Long post_no = 0L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			response.setCharacterEncoding("UTF-8");
	    	response.setContentType("application/json;charset=UTF-8");
	    	request.setCharacterEncoding("UTF-8");
	    	
	    	String endPoint = request.getServletPath();
	    	post_no = Long.parseLong(request.getParameter("post_no"));
	    	
	    	if ("/board/view/getCommentList".equals(endPoint))
	    	{
	    		commentMgr cMgr = new commentMgr();
	    		List<commentBean> comment_list = new ArrayList<>();

	    		comment_list = cMgr.getComment(post_no);
                String jsonResponse = convertCommentListToJSON(comment_list);
                response.getWriter().write(jsonResponse);

	    		} 
	    	}
	   	
    private String convertCommentListToJSON(List<commentBean> commentList) {

        List<String> jsonComments = new ArrayList<>();
        for (commentBean comment : commentList) {
            String jsonComment = convertCommentToJson(comment);
            if (jsonComment.equals("")) {}else {
            jsonComments.add(jsonComment);
            }
        }

        return "[" + String.join(",", jsonComments) + "]";
    }

    private String convertCommentToJson(commentBean comment) {
    	if(post_no.equals(comment.getComment_post_no())) {
    	return "{"
                + "\"comment_no\":\"" + comment.getComment_no() + "\","
                + "\"comment_content\":\"" + comment.getComment_content() + "\","
                + "\"comment_time\":\"" + comment.getComment_time() + "\","
                + "\"comment_writer\":\"" + comment.getComment_writer() + "\","
                + "\"comment_writer_id\":\"" + comment.getComment_writer_id() + "\","
                + "\"comment_post_no\":\"" + comment.getComment_post_no() + "\""
                + "}";
    	}  else {
    		return "";
    }
    }
}
