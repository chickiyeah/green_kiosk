<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String cPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/admin/Accounting/account.css" />
    <title>Insert title here</title>
    <script src="<%=request.getContextPath()%>/assets/js/admin/menu_main_1.js"></script>
    <%@ include file="/admin/layouts/indexBase.jsp" %>
    <%@ include file="/admin/layouts/bootstrap.jsp"%> 
    <%@ include file="/admin/admin_check/check.jsp" %>
    <%@ include file="/admin/layouts/header.jsp" %>
</head>
<body>
    <%@ include file="/admin/layouts/left.jsp" %>
    <div class="mainContent" id="mainContent">
        <main>
          <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">매장 관리 페이지</h1>
        <p class="lead text-body-secondary"></p>
        <p>
          <a href="javascript:void(0)" class="btn btn-primary my-2" onClick="loadContent('sales/ac00.jsp')">거래 내역 페이지</a>
          <a href="javascript:void(0)" class="btn btn-primary my-2" onClick="loadContent('inventory/iv00.jsp')">재고 관리 페이지</a>
          <!-- <a href="#" class="btn btn-secondary my-2"></a> -->
        </p>
      </div>
    </div>
  </section></main>
    </div>

<script>
window.addEventListener('DOMContentLoaded', function() {
	
});
function loadContent(url) {
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      // Ajax 요청이 완료되고 페이지를 가져온 경우 메인 페이지를 업데이트
      document.getElementById('mainContent').innerHTML = xhr.responseText;
      if (url.includes("sales/ac00up.jsp?numb=")) {
    	  getFoodList(orderFoodsValue);
      }
      sessionStorage.setItem("context", "<%=request.getContextPath()%>")
      // 맨 상단으로 가도록
      window.scrollTo(0, 0);
    }
  };
  xhr.open('GET', url, true);
  xhr.send();
}
</script>


</body>
</html>
