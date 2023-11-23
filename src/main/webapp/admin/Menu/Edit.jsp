<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit_page</title>
<%@ include file="/admin/layouts/BeanManager.jsp" %>
<%@ include file="/admin/layouts/bootstrap.jsp"%>
<%@ include file="/admin/admin_check/check.jsp" %>  
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/admin/Menu_upload.css">
</head>
<body>
<%
	int menu_no = 0;
	if(!request.getParameter("menu_no").equals(""))
	{
		menu_no = Integer.parseInt(request.getParameter("menu_no"));
	}
	menuBean = menuMgr.getMenu(menu_no); 
	String menu_name = menuBean.getMenu_name();
	String menu_gubn = menuBean.getMenu_gubn();
	String menu_imgPath = menuBean.getMenu_imgPath();
	int menu_price = menuBean.getMenu_price();
	String menu_content = menuBean.getMenu_content();
	String menu_component = menuBean.getMenu_component();
	int menu_sell_amount = menuBean.getMenu_sell_amount();
	int menu_isUse = menuBean.getMenu_isUse();
	int menu_isSale = menuBean.getMenu_isSale();
	int menu_recommend = menuBean.getMenu_recommend();
	int menu_couponable = menuBean.getMenu_couponable();
	
%>
		<script type="text/javascript">
		function down(filename, num){
			 document.downFrm.menu_imgPath.value=filename;
			 document.downFrm.submit();
		}
		</script>
		
	<div class="container" style="margin-top: 50px" >
		<div class="row">
			<form name="uploadFrm" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/admin/Menu/EditProc.jsp?menu_no=<%=menu_no%>" onSubmit="return validateForm()">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" rowspan="5" style="background-color: #eeeee; text-align:left;">상품 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="5">
								<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">상품명</div>
								        </div>
									<input type="text" class="form-control" name="menu_name" maxlength="150" value="<%=menu_name%>">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class= input-group>
							        <div class="input-group-prepend">
							          <div class="input-group-text">카테고리</div>
							        </div>
								    <select class="form-select" aria-label="Default select example" name="menu_gubn" id = "menu_gubn" onchange="handleCategoryChange()">
								        <option value="단품" <%= "단품".equals(menu_gubn) ? "selected" : "" %>>단품</option>
								        <option value="음료" <%= "음료".equals(menu_gubn) ? "selected" : "" %>>음료</option>
								        <option value="세트" <%= "세트".equals(menu_gubn) ? "selected" : "" %>>세트</option>
								        <option value="사이드" <%= "사이드".equals(menu_gubn) ? "selected" : "" %>>사이드</option>
								    </select>
								</div>
							</td>
								<td>
								<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">사용</div>
								        </div>
										<label>
	 											&nbsp;<input role="switch" type="checkbox" name="menu_isUse" id="menu_isUse" value="on" <% if (menu_isUse == 1) { %> checked <% } %>>
										</label>
								</div>
							</td>
							<td>
								<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">쿠폰</div>
								        </div>
										<label>
										  &nbsp;<input role="switch" type="checkbox" name="menu_couponable" id="menu_couponable" value="on"<% if (menu_couponable == 1) { %> checked <% } %>>
										</label>
								</div>
							</td>
						</tr>
						<tr>

							<td>
								<div class= input-group>
							        <div class="input-group-prepend">
							          <div class="input-group-text">가격</div>
						        </div>
							<input type="text" class="form-control" id="menu_price" name="menu_price" maxlength="30" value="<%=menu_price%>">
								</div>
							</td>
								<td>
								<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">행사</div>
								        </div>
										<label>
										  &nbsp;<input role="switch" type="checkbox" name="menu_isSale" id="menu_isSale" value="on"<% if (menu_isSale == 1) { %> checked <% } %>>
										</label>
								</div>
							</td>
							<td>
								<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">추천</div>
								        </div>
										<label>
										  &nbsp;<input role="switch" type="checkbox" name="menu_recommend" id="menu_recommend" value="on"<% if (menu_recommend == 1) { %> checked <% } %>>
										</label>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<textarea class="form-control" name="menu_content" id="menu_content" maxlength="2048" style="height: 150px; width:100%;"><%=menu_content%></textarea>
							</td>
						</tr>
					</tbody>
				</table>
					<div class="mb-3">
						<a href="javascript:void(0);" onclick="down('<%=menu_imgPath%>')"><%=menu_imgPath%></a>
					  <input class="form-control" type="file" id="formFile" name="menu_imgPath" value="<%=menu_imgPath%>">
					</div>
					  <input type="text" name="menu_imgPath" id="menu_imgPath" value="<%=menu_imgPath%>" style="display: none;">
					  <input type="hidden" name="menu_component" value="<%=menu_component %>">
					  <input type="hidden" name="menu_sell_amount" value="<%=menu_sell_amount %>">
				<input type="submit" class="btn btn-success pull-right" value="수정하기">
				<input type="button" class="btn btn-danger" value="삭제하기" onclick="deleteMenu('<%=menu_no%>')">
		</form>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function validateForm() {
	    var menuPrice = document.getElementById("menu_price").value;
	    if (menuPrice == null || menuPrice.trim() === "" || isNaN(menuPrice)) {
	        alert("가격은 숫자로 입력하세요.");
	        return false;
	    }
	}
</script>
<script>
	function deleteMenu(menu_no)
	{
		location.href = "Delete.jsp?menu_no=" + menu_no; 
	}
</script>
			<form name="downFrm" action="download.jsp" method="post">
				<input type="hidden" name="menu_imgPath">
			</form>
			
<script>
	function validateForm() {
	    var menuPrice = document.getElementById("menu_price").value;
	    if (menuPrice == null || menuPrice.trim() === "" || isNaN(menuPrice)) {
	        alert("가격은 숫자로 입력하세요.");
	        return false;
	    }
	}
	
	function handleCategoryChange() {
	    var category = document.getElementById("menu_gubn").value;
	    var contentTextarea = document.getElementById("menu_content");
	    
	    var menu_isSale = document.getElementById("menu_isSale");
		var menu_isUse = document.getElementById("menu_isUse");
		var menu_recommend = document.getElementById("menu_recommend");
		var menu_couponable = document.getElementById("menu_couponable");
		
	    document.querySelectorAll('#menu_gubn option').forEach(option => {
	        option.disabled = false;
	    });
	    
	    if (category === "재료") {
	        // 재료나 이벤트일 경우 행사여부 체크박스와 상품설명을 읽기 전용으로 설정
	        contentTextarea.disabled = true;
	        menu_isSale.disabled = true;
	        menu_recommend.disabled = true;
	        menu_couponable.diabled = true;
	        
	        document.getElementById("menu_couponable").disabled = true;
	        document.getElementById("menu_couponable").checked = false;
	        
	        menu_isSale.checked = false;
	        menu_recommend.checked = false;
	       	
	        contentTextarea.readOnly = true;
	        menu_isSale.readOnly = true;
	        menu_recommend.readOnly = true;
			menu_couponable.readOnly = true;
			
	        document.querySelector('#menu_gubn option[value="재료"]').disabled = false;

	    } else {
	        // 다른 카테고리일 경우 사용 가능하게 설정
	        contentTextarea.disabled = false;
	        menu_isUse.disabled = false;
	        menu_isSale.disabled = false;
	        menu_recommend.disabled = false;


	        document.getElementById("menu_couponable").disabled = false;
	    }
	}
	</script>
	</body>
</html>