<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>post_view page</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/board/layout.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/board/boardView.css">
<%@ include file="/board/bootstrap.jsp" %>
<%@include file="/board/layouts/Bean.jsp" %>
<%@include file="/board/layouts/header.jsp" %>

</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/3.1.3/socket.io.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/board/boardView.js"></script>
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
    	
        HttpServletRequest requestPage = (HttpServletRequest) pageContext.getRequest();

        String CurrentUrl = requestPage.getRequestURL()+"?post_no=" + post_no;

    	
%>

<script>
window.addEventListener('DOMContentLoaded', function(){
	console.log("increaseViewcount 새로고침으로 실행");
	increaseViewcount(<%=post_no%>);
});
</script>
	
<br/><br/>
<div class="container">
    <div class="row">
        <div class="mainDivid" id="mainDivid-1">
        <div class="page_category" id="page_category">게시글 읽기</div>
        <hr>
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
				<div class="recommend-button" id="recommend-button" onclick="increaseRecommendation(<%=post_no%>)" style="max-width:120px">
				    <img class="recommend-icon" src="<%=request.getContextPath()%>/assets/images/board/hand-thumbs-up.svg" alt="Thumbs Up">
				  <div class="recommend-loading" id="recommend-loading">
				    <span class="recommend-label">추천 <%=post_likecount%></span>
			    </div>
				</div>
        </div>
    </div>
    <!--  여긴 댓글 구간  -->
    <div class="board_commentArea" id="board_commentArea">
		<hr>	
		<div class="board_commentUpdate" id="board_commentUpdate"></div>
	</div>






				
				
<!-- 댓글 구간 끝 -->
</body>
</html>