package servlet.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardMgr;

 
@WebServlet("/board/write/editBoardAction")
public class boardEditAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
    	response.setContentType("application/json;charset=UTF-8");
    	request.setCharacterEncoding("UTF-8");
    	
    	String endPoint = request.getServletPath();
    	
    	if ("/board/write/editBoardAction".equals(endPoint))
    	{
    		BoardMgr bMgr = new BoardMgr();
    		
    		Long post_no = Long.parseLong(request.getParameter("post_no"));
    		
    		boolean result = bMgr.editBoardAction(request);
    		
    		if (result == true)
    		{
    			System.out.println("수정 성공");
        		response.sendRedirect(request.getContextPath()+"/board/view/boardView.jsp?post_no=" + post_no);
    		} else {
    	        request.setAttribute("editFailure", "게시물 수정에 실패했습니다.");
    	        response.sendRedirect(request.getHeader("referer"));
    		}
    	}
	
	
	}

}
