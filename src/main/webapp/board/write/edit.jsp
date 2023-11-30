<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import= "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name ="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/board/write.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/board/layout.css">
<%@ include file="/board/bootstrap.jsp" %>
<%@ include file="/board/layouts/Bean.jsp" %>
<title>게시글 쓰기</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/board/tinymce/tinymce.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/board/write.js"></script>
<script>
window.addEventListener('DOMContentLoaded', function() {
    tinymce_editor();
});
</script>
<%@include file="/board/layouts/login_check.jsp" %>
</head>
<body>
<%@ include file="/board/layouts/sidebar.jsp" %>

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
	    
	%>
	<div class="container">
		<div class="row">
			<form method="post" name="board_post" action="./editBoardAction" enctype="mulipart/form-data" accept-charset = "utf-8">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #d5f5e3 ; text-align:center;">게시글 수정하기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="post_title" maxlength="50" value="<%=post_title%>"></td>
						</tr>
						<tr>
							<td><textarea id="editor" class="form-control" placeholder="글 내용" name="post_content" maxlength="60000" style="height: 350px"><%=post_content%></textarea></td>
					
						</tr>
						<tr>
							<td><input type="file" class="form-control" id="file_input" name="file" accept="image/*" multiple>
							    <button type="button" id="uploadFileBtn" onclick="javascript:uploadFile()">사진 업로드</button></td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="post_time" value="<%=post_time%>">
				<input type="hidden" name ="post_no" value="<%=post_no%>">
				<input type="hidden" name="post_writer" value="<%=mem_id%>">
				<input type="submit" class="btn btn-success pull-right" value="수정완료">
				<input type="reset" class="btn btn" value="다시쓰기">
		</form>
		</div>
	</div>

</body>
</html>