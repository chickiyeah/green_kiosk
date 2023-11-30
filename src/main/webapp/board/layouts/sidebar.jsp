<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.io.PrintWriter" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/board/sidebar.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/board/boardMember.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="/board/layouts/Bean.jsp" %>
<script>
	var mem_id = '<%= (String)session.getAttribute("mem_id") %>';
</script>
<%
	BoardMgr boardMgr = new BoardMgr();
	String memID = (String)session.getAttribute("mem_id");
	Long mem_no = boardMgr.find_mem_no(memID);
	String mem_profile_img = boardMgr.getProfileImg(mem_no);
%>
<div class="sidebar">
<div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px;">
    <a href="<%=request.getContextPath()%>/board/index.jsp" class="d-flex align-items-center mb-3 mb-m
    d-0 me-md-auto link-dark text-decoration-none">
      <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
		<%-- <img src="<%=request.getContextPath()%>/assets/images/board/homepage_main_logo.png" width="50" height="50" alt="게시판home_logo"> --%>게시판
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
      	<!-- 키오스크 메인 페이지 -->
        <a href="<%=request.getContextPath()%>/index.jsp" class="nav-link active" aria-current="page">
          <svg class="bi me-2" width="16" height="16"><use xlink:href="#home"></use></svg>
          Home
        </a>
      </li>
      <li>
      <!-- 게시글 작성 페이지 -->
        <a href="<%=request.getContextPath()%>/board/write/write.jsp" class="nav-link link-dark">
          <svg class="bi me-2" width="16" height="16"><use xlink:href="#speedometer2"></use></svg>
          글쓰기
        </a>
      </li>
      
    </ul>
    <hr>
	<div class="dropdown">
      <a href="#" class="d-flex align-items-center link-dark text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false">
      <% if (mem_profile_img == null) { %>
      <img src="<%=request.getContextPath()%>/assets/images/board/human_icon.jpg" alt="" width="32" height="32" class="rounded-circle me-2" id="profileImage">
      <% } else { %>
      <img src="<%=mem_profile_img%>" alt="" width="32" height="32" class="rounded-circle me-2" id="profileImage">
      <% } %>
        <strong><%=(String)session.getAttribute("mem_id")%></strong>
      </a>
      <ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2">
        <li><a class="dropdown-item" href="<%=request.getContextPath()%>/board/index.jsp">게시판</a></li>
        <li><a class="dropdown-item" href="<%=request.getContextPath()%>/board/view/user.jsp">작성글 보기</a></li>
        <li><a class="dropdown-item" href="<%=request.getContextPath()%>/mypage/personal.jsp">회원 정보 수정</a></li>
        <li><a class="dropdown-item" href="javascript:void(0)" 
        onclick="openPopupMember(`<%=request.getContextPath()%>/board/write/memberEdit.jsp?mem_id=<%=(String)session.getAttribute("mem_id")%>`)">프로필 이미지 변경</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item" href="#">로그아웃</a></li>
      </ul>
    </div>
  </div>
 </div>