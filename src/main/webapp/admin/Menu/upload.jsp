<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/admin/layouts/bootstrap.jsp"%>
<%@ include file="/admin/admin_check/check.jsp" %>  
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/admin/Menu_upload.css">
</head>
<body>

	<div class="container" style="margin-top: 50px" >
		<div class="row">
			<form name="uploadFrm" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/admin/Menu/uploadProc.jsp" onSubmit="return validateForm()">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" rowspan="5" style="background-color: #eeeee; text-align:left;">상품 등록</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="5">
								<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">상품명</div>
								        </div>
									<input type="text" class="form-control" name="menu_name" maxlength="150">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class= input-group>
							        <div class="input-group-prepend">
							          <div class="input-group-text">카테고리</div>
							        </div>
								<select class="form-select" aria-label="Default select example" name="menu_gubn" id="menu_gubn" onchange="handleCategoryChange()">
								  <option selected>단품</option>
								  <option value="음료">음료</option>
								  <option value="세트">세트</option>
								  <option value="재료">재료</option>
								  <option value="사이드">사이드</option>
								</select>
								</div>
							</td>
								<td>
								<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">판매</div>
								        </div>
										<label>
										  &nbsp;<input role="switch" type="checkbox" name="menu_isUse" id="menu_isUse"/>
										</label>
								</div>
							</td>
							<td>
								<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">쿠폰</div>
								        </div>
										<label>
										  &nbsp;<input role="switch" type="checkbox" name="menu_couponable" id="menu_couponable"/>
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
							<input type="text" class="form-control" id="menu_price" name="menu_price" maxlength="30">
								</div>
							</td>
								<td>
								<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">행사</div>
								        </div>
										<label>
										  &nbsp;<input role="switch" type="checkbox" name="menu_isSale" id="menu_isSale"/>
										</label>
								</div>
								</td>
								<td>
									<div class= input-group>
								        <div class="input-group-prepend">
								          <div class="input-group-text">추천</div>
								        </div>
										<label>
										  &nbsp;<input role="switch" type="checkbox" name="menu_recommend" id="menu_recommend"/>
										</label>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<textarea class="form-control" name="menu_content" id="menu_content" maxlength="2048" style="height: 150px; width:100%" placeholder="상품설명"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
					<div class="mb-3">
					  <input class="form-control" type="file" id="formFile" name="menu_imgPath">
					</div>
				<input type="submit" class="btn btn-success pull-right" value="등록하기">
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
	
	function handleCategoryChange() {
	    var category = document.getElementById("menu_gubn").value;
	    var contentTextarea = document.getElementById("menu_content");
	    
	    var menu_isSale = document.getElementById("menu_isSale");
		var menu_isUse = document.getElementById("menu_isUse");
		var menu_recommend = document.getElementById("menu_recommend");
		var menu_couponable = document.getElementById("menu_couponable");
		
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