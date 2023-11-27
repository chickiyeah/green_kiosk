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
<title>게시글 쓰기</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/board/tinymce/tinymce.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/board/write.js"></script>
<script>
window.addEventListener('DOMContentLoaded', function() {
    tinymce_editor();
});
</script>
</head>
<body>
<%@ include file="/board/layouts/sidebar.jsp" %>

	<%
		String mem_id=null;
		if(session.getAttribute("mem_id")!=null){
			mem_id=(String)session.getAttribute("mem_id");
		} else {
			PrintWriter script = response.getWriter();
			
		}
	%>
	<div class="container">
		<div class="row">
			<form method="post" name="board_post" action="./writeAction" enctype="mulipart/form-data" accept-charset = "utf-8">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #d5f5e3 ; text-align:center;">게시판 글쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="post_title" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea id="editor" class="form-control" placeholder="글 내용" name="post_content" maxlength="60000" style="height: 350px"></textarea></td>
					
						</tr>
						<tr>
							<td><input type="file" class="form-control" id="file_input" name="file" accept="image/*" multiple>
							    <button type="button" id="uploadFileBtn" onclick="javascript:uploadFile()">사진 업로드</button></td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="post_writer" value="<%=mem_id%>">
				<input type="submit" class="btn btn-success pull-right" value="글쓰기">
				<input type="reset" class="btn btn" value="다시쓰기">
		</form>
		</div>
	</div>

</body>
</html>