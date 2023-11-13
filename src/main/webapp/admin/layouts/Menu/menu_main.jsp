<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/admin/layouts/BeanManager.jsp" %>

<script type="text/javascript">
	function getListfunction() {
		$.ajax({
			type: "POST",
			url: "./api/admin/edit_menu",
			dataType="json",
	        contentType: "application/json; charset=UTF-8", 
			success: function(response) {
	            if (response && response.length > 0) {
				var ListHtml = '';
				for (var i=0; i<response.length; i++){
					var menu_no = response[i].menu_no;
					var menu_imgPath = response[i].menu_imgPath;
					var menu_name = response[i].menu_name;
					var menu_gubn = response[i].menu_gubn;
					var menu_price = reponse[i].menu_price;
					var menu_content = response[i].menu_content;
					var menu_isUse = response[i].menu_isUse;
					var menu_isSale = response[i].menu_isSale;
					
				}
                $('#getChatlist').html(chatListHtml);
				}
			}
		});
		$('#content').val(' ');
	}
</script> 


<main class="mainContent">
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">메뉴 관리 페이지</h1>
        <p class="lead text-body-secondary"></p>
        <p>
          <a href="javascript:void(0)" class="btn btn-primary my-2" onclick="openPopup('<%=request.getContextPath()%>/admin/Menu/upload.jsp')">제품 등록하기</a>
          <!-- <a href="#" class="btn btn-secondary my-2"></a> -->
        </p>
      </div>
    </div>
  </section>

  <div class="album py-5 bg-body-tertiary">
    
    <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      <%
      	int menu_no = 0;
		String menu_imgPath = null;
		String menu_name = null;
		String menu_gubn = null;
		int menu_price = 0;
		String menu_content = null;
		int menu_isUse = 0;
		int menu_isSale = 0;
		int count = 0;
	
		
		Vector<Menu_menu_Bean> vlist = menuMgr.getMenuList(0);
		int vlistsize = vlist.size();
		
		for (Menu_menu_Bean bean : vlist) {
			menu_no = bean.getMenu_no();
			menu_name = bean.getMenu_name();
			menu_gubn = bean.getMenu_gubn();
			menu_price = bean.getMenu_price();
			menu_content = bean.getMenu_content();
			menu_imgPath = bean.getMenu_imgPath();
			menu_isUse = bean.getMenu_isUse();
			menu_isSale = bean.getMenu_isSale();
			count++;
		
      %>
        <div class="col">
          <div class="card shadow-sm">
            <img id="menu_imgPath" src="/downloadfile2/<%=menu_imgPath%>"class="bd-placeholder-img card-img-top" width="100%" height="225" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">
            <title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"></rect><text x="50%" y="50%" fill="#eceeef" dy=".3em"><span class="menu_name" id="menu_name"><%=menu_name%></span></text></image>
            <div class="card-body">
              <p class="card-text" align="center" id="menu_content"><%=menu_content%></p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <a href="javascript:void(0)" class="btn btn-sm btn-outline-secondary" onclick="openPopup('<%=request.getContextPath()%>/admin/Menu/View.jsp?menu_no=<%=menu_no%>')">상세보기</a>
                  <a href="javascript:void(0)" class="btn btn-sm btn-outline-secondary" onclick="openPopup('<%=request.getContextPath()%>/admin/Menu/Edit.jsp?menu_no=<%=menu_no%>')">수정하기</a>
                </div>
                <%
                	String menu_price1 = formatNumber(menu_price);
                %>
                <small class="text-body-secondary"><%=menu_price1%>원</small>
              </div>
            </div>
          </div>
        </div>
        
        <% } %>
<!-- not repeat div -->
      </div>
    </div>
  </div>

</main>

<!-- <footer class="text-body-secondary py-5">
  <div class="container">
    <p class="float-end mb-1">
      <a href="#">Back to top</a>
    </p>
    <p class="mb-1">Album example is © Bootstrap, but please download and customize it for yourself!</p>
    <p class="mb-0">New to Bootstrap? <a href="/">Visit the homepage</a> or read our <a href="/docs/5.3/getting-started/introduction/">getting started guide</a>.</p>
  </div>
</footer> -->

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="/docs/5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
	<%!
    public String formatNumber(double number) {
        // 숫자를 3자리마다 쉼표로 구분
        java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");
        return df.format(number);
    }
	
	public String formatTime(Long number) {
		java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");
		return df.format(number);
	}
%>
<script>
function loadContent(url) {
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      // Ajax 요청이 완료되고 페이지를 가져온 경우 메인 페이지를 업데이트
      document.getElementById('mainContent').innerHTML = xhr.responseText;
      // 맨 상단으로 가도록
      window.scrollTo(0, 0);
    }
  };
  xhr.open('GET', url, true);
  xhr.send();
}
</script>

<%-- <script type="text/javascript">
var auto_refresh = setInterval(
function ()
{
$('#mainContent').load('menu_main.jsp').fadeIn("slow");
}, 500); 
</script>

<script type="text/javascript">
	var auto_refresh = setInterval(function () {
	  $('#mainContent').load('<%=request.getContextPath()%>/admin/layouts/menu_main.jsp').fadeIn("slow");
	}, 500);
	
	function loadContent(url) {
	  var xhr = new XMLHttpRequest();
	  xhr.onreadystatechange = function() {
	    if (xhr.readyState === 4 && xhr.status === 200) {
	      document.getElementById('mainContent').innerHTML = xhr.responseText;
	      window.scrollTo(0, 0);
	    }
	  };
	  xhr.open('GET', url, true);
	  xhr.send();
	}
	
	function openPopup(url) {
	  var popupWidth = 500;
	  var popupHeight = 300;
	  var popupX = (window.screen.width/2) - (popupWidth/2);
	  var popupY = (window.screen.height/2) - (popupHeight/2);
	  var popup = window.open(url, 'PopupWindow', 'width=popupWidth, height=popupHeight, scrollbars=yes, left=popupX, top=popupY');
	}
	
	function closePopup(popup) {
	  if (popup && !popup.closed) {
	    popup.close();
	  }
	}
	</script>
	 --%>


