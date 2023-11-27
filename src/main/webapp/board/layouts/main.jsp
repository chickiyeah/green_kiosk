<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%@include file="/board/layouts/Bean.jsp" %>
<div class="mainPage">

<div class="w3-container">
  <h2>게시글 목록</h2>
  <br/>
<%
	BoardMgr bMgr = new BoardMgr();
	List <boardBean> list = bMgr.getBoardList();	
	
    Long post_no = 0L;
    String post_time = null;
    String post_title = null;
    String post_content = null;
    String post_filePath = null;
    Long post_writer = 0L;
    String post_writer_id = null;
    Long post_viewcount = 0L;
    Long post_likecount = 0L;
    Long count = 0L;

    for (int i = 0; i < list.size(); i++)
    {
    	post_no = list.get(i).getPost_no();
    	post_time = list.get(i).getPost_time();
    	post_title = list.get(i).getPost_title();
    	post_content = list.get(i).getPost_content();
    	post_filePath = list.get(i).getPost_filePath();
    	post_writer = list.get(i).getPost_writer();
    	post_writer_id = bMgr.findUser(post_writer);
    	post_viewcount = list.get(i).getPost_viewcount();
    	post_likecount = list.get(i).getPost_likecount(); 
    	count++;
%>
 <script>
 	getThumbNail(`<%=post_content%>`, <%=post_no%>); 
 </script>

<ul class="w3-ul">
    <li class="w3-bar w3-border">
        <a href="<%=request.getContextPath()%>/board/view/boardView.jsp?post_no=<%=post_no%>">
        <span class="w3-bar-item w3-button w3-white w3-xlarge w3-right"></span>
        <img id= "thumbnail<%=post_no%>" src="<%=request.getContextPath()%>/assets/images/cat.jpg" class="w3-bar-item w3-circle w3-hide-small" style="width:85px">
        <div class="w3-bar-item">
            <span class="w3-large"><%=post_writer_id%></span>
            <span class="post_time"><%=post_time%></span>
            <br>
            <span><%=post_title%></span>
        </div>
        </a>
    </li>
 </ul>
<%
   }
%>
	</div>
</div>