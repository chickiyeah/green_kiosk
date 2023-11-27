package servlet.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardMgr;


@WebServlet("/board/write/writeAction")
public class board_write extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	response.setCharacterEncoding("UTF-8");
    	response.setContentType("application/json;charset=UTF-8");
    	request.setCharacterEncoding("UTF-8");
    	
    	String endPoint = request.getServletPath();
    	
    	if ("/board/write/writeAction".equals(endPoint))
    	{
        	BoardMgr bMgr = new BoardMgr();
        	boolean result = bMgr.insertBoard(request);
        	if (result) {
        		response.sendRedirect(request.getContextPath()+"/board/index.jsp");
        	}
    	}
	}

}
