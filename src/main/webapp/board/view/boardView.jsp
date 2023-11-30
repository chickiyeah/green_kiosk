<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0">
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>post_view page</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/board/layout.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/board/boardView.css">
<%@include file="/board/layouts/login_check.jsp" %>
<%@ include file="/board/bootstrap.jsp" %>
<%@include file="/board/layouts/Bean.jsp" %>
<%@include file="/board/layouts/header.jsp" %>
<script>
	var contextPath = '<%= request.getContextPath() %>';
</script>
</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/3.1.3/socket.io.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/board/boardView.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/board/timeCalculate.js"></script>
<%@include file="/board/layouts/sidebar.jsp" %>
<%
	Long post_no = Long.parseLong(request.getParameter("post_no"));
	
	BoardMgr bMgr = new BoardMgr();
	boardBean bean = bMgr.getBoard(post_no);
	
    String post_time = null;
    String post_title = null;
    String post_content = null;
    String post_filePath = null;
    Long post_writer = 0L;
    String post_writer_id = null;
    Long post_viewcount = 0L;
    Long post_likecount = 0L;
    Long count = 0L;

    	post_no = bean.getPost_no();
    	post_time = bean.getPost_time();
    	post_title =  bean.getPost_title();
    	post_content = bean.getPost_content();
    	post_filePath = bean.getPost_filePath();
    	post_writer = bean.getPost_writer();
    	post_writer_id = bMgr.findUser(post_writer);
    	post_viewcount = bean.getPost_viewcount();
    	post_likecount = bean.getPost_likecount(); 
    	
    	String session_mem_id = (String)session.getAttribute("mem_id");
    	Long comment_writer_id = bMgr.find_mem_no(session_mem_id);
    	
        HttpServletRequest requestPage = (HttpServletRequest) pageContext.getRequest();

        String CurrentUrl = requestPage.getRequestURL()+"?post_no=" + post_no;

%>

<script>
var session_mem_no = <%=comment_writer_id%>;
window.addEventListener('DOMContentLoaded', function(){
	increaseViewcount(<%=post_no%>);
	getCommentList(<%=post_no%>,<%=post_writer%>);
});
</script>
	
<br/><br/>
<div class="container">
    <div class="row">
        <div class="mainDivid" id="mainDivid-1">
        <div class="page_category" id="page_category">게시글 읽기</div>
        <hr class="page_category">
        </div>
        <div class="post-details">
            <table>
                <tr>
                    <td colspan="2">
                    <br/>
                        <h1 class="post_title" id="boardView_post_title"><%= post_title %></h1>
                        <br/>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;<span class="post_writer_id" id="boardView_post_writer_id"><%= post_writer_id %></span>
                         &nbsp; | &nbsp; <img src="<%=request.getContextPath()%>/assets/images/board/clock.svg">&nbsp;<%= post_time.substring(0, 19) %>
                    <br/>
                    </td >
                    
                    <td>
						<div class="icons_in_header" id="icons_in_header">
						    <img src="<%=request.getContextPath()%>/assets/images/board/eye.svg">
						    <div class="viewcount-loading" id="viewcount-loading">
						    	<span class="viewcount-label"><%=post_viewcount%></span>
						    </div>
						    &nbsp;
						    <img src="<%=request.getContextPath()%>/assets/images/board/hand-thumbs-up.svg">
						    <div class="recommend-loading2" id="recommend-loading2" >
						        <span class="recommend-label2"><%=post_likecount%></span>
						    </div>				 
						</div>	
                    </td>            
                </tr>
            </table>
              <div class="under_title">
              <hr>
              <div class="currentPageUrl" id="currentPageUrl" onclick="copyToClipboard('<%=CurrentUrl%>')">	
              	<img src="<%=request.getContextPath()%>/assets/images/board/clipboard.svg">&nbsp;<%=CurrentUrl%>
              </div>
			        <div class="post-content">
			            <div style="min-height: 400px; text-align: left; padding: 15px;">
			                <pre><%= post_content %></pre>
			            </div>
			        </div>
              </div>
              </div>
              <br/>
				<div class="recommend-button" id="recommend-button-<%=post_no %>" onclick="increaseRecommendation(<%=post_no%>)" style="max-width:120px">
				    <img class="recommend-icon" src="<%=request.getContextPath()%>/assets/images/board/hand-thumbs-up.svg" alt="Thumbs Up">
				  <div class="recommend-loading" id="recommend-loading-<%=post_no%>">
				    <span class="recommend-label">추천 <%=post_likecount%></span>
				    </div>
				</div>
	      <% if(mem_id.equals(post_writer_id)) { %>
				<div class="button_actions" id="button_actions">
				    <button type="button" class="board_delete" id="board_delete" onclick="board_delete_Action(<%=post_no%>)">삭제하기</button>
				    <button type="button" class="board_edit" id="board_edit" onclick="board_edit_Action(<%=post_no%>)">수정하기</button>
				</div>
              <% } %>
        </div>
    </div>
    <!--  여긴 댓글 구간  -->
	
    <div class="board_commentArea" id="board_commentArea">
    	<div class="comment_list_menu" id="comment_list_menu">댓글 목록<span id="list_amount"></span></div>
		<hr>
		<div class="board_commentUpdate" id="board_commentUpdate"></div>
			     <!-- 댓글 입력 -->
		<div class="comment_input" id="comment_input">
			<div class="comment_form" id="comment_form">
				<div class="scrollBottom" id="scrollBottom" style="display :none"></div>
				<textarea class="comment_content" name="comment_content" placeholder="댓글을 입력하세요..."></textarea>
					<input type="hidden" name="comment_writer" value="<%=mem_id%>">
					<input type="hidden" name="comment_post_no" value="<%=post_no%>">
				<button type="button" onclick="inputComment()">입력</button>
			</div>
		</div>
		<div class="comment_input_position" id="comment_input_position"></div>
	</div>


				
				
<!-- 댓글 구간 끝 -->
</body>
</html>