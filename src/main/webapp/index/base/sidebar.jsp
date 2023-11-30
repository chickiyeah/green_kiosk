<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" id="mySidebar">
	<div class="close_div">
		  <a class="close" href="javascript:void(0)" onclick="w3_close()"
		  class="w3-bar-item w3-button">X</a>
		</div>
		<%if (mem_id == null) {%> 
	  <form class="login" name="loginFrm" method="post" action="<%= cPath%>/login/login_proc.jsp">
	  	<div class="inside">
		  	<div class="idpw_warp">
			  	<input title="아이디" class="id" placeholder="아이디" onkeyup="if(window.event.keyCode==13){login()}" name="mem_id" maxlength="22">
			  	<input title="비밀번호" type="password" id="pw" class="pw"  onkeyup="if(window.event.keyCode==13){login()}" placeholder="비밀번호" maxlength="23" name="mem_pw">
			  	<div class="eyes">
			  		<i id="ps_hide" onclick="password_visable('true')" class="on"></i>
			  		<i id="ps_show" onclick="password_visable('false')" style="display:none" class="off"></i>
			  	</div>
			</div>
			
			<div class="checkbox">
				<input type="checkbox" id="save_id">
				<label id="string_save_id" for="save_id">아이디 저장</label>
			</div>
			
			<div class="bottom">
				<input class="login_btn" type="button" onclick="login()" value="로그인">
				
				<div class="login_tool">
					<span onclick="location.href='<%=cPath %>/user/find_idpw2.jsp'">ID/PW 찾기</span>
					<span onclick="open_register()">회원가입</span>
				</div>
			</div>
		</div>
	  </form>
	  
	     <button class="w3-bar-item w3-button side_main_btn" onclick="myAccFunc()">메뉴</button>
		  <div id="demoAcc" class="w3-bar-block w3-hide w3-white w3-card-4">
		  	<a href="<%=cPath %>/best" class="w3-bar-item w3-button w3-bar-child">인기메뉴</a>
		  	<a href="<%=cPath %>/recommand" class="w3-bar-item w3-button w3-bar-child">추천메뉴</a>
		  	<a href="<%=cPath %>/" class="w3-bar-item w3-button w3-bar-child">햄버거 단품</a>
		    <a href="<%=cPath %>/setMenu" class="w3-bar-item w3-button w3-bar-child">햄버거 세트</a>
		    <a href="<%=cPath %>/dessert" class="w3-bar-item w3-button w3-bar-child">디저트</a>
		    <a href="<%=cPath %>/drink" class="w3-bar-item w3-button w3-bar-child">음료수</a>
		  </div>
		
		  <button class="w3-bar-item w3-button side_main_btn" onclick="myAccFunc1()">이벤트</button>
		  <div id="demoAcc1" class="w3-bar-block w3-hide w3-white w3-card-4">
		    <a href="<%=cPath %>/Event" class="w3-bar-item w3-button w3-bar-child">이벤트 목록</a>
		    <a href="<%=cPath %>/" class="w3-bar-item w3-button w3-bar-child">쿠폰 목록</a>
		    <!--  <a href="/index/page/page4.jsp" class="w3-bar-item w3-button w3-bar-child">3</a> -->
		  </div>
		  
		  <button class="w3-bar-item w3-button side_main_btn" onclick="myAccFunc2()">고객지원</button>
		   <div id="demoAcc2" class="w3-bar-block w3-hide w3-white w3-card-4">
		    <a href="<%=cPath %>/index/page/page2.jsp" class="w3-bar-item w3-button w3-bar-child">ㅂ</a>
		    <a href="<%=cPath %>/index/page/page3.jsp" class="w3-bar-item w3-button w3-bar-child">ㅈ</a>
		    <a href="<%=cPath %>/index/page/page4.jsp" class="w3-bar-item w3-button w3-bar-child">ㄷ</a>
		  </div>
	  <%} else { if (mem_ac.equals("S")) {%>
		<div class="login">
			<div class="inside">
		  		<div class="info">
		  			<span class="name">관리자 <%=bean.getMem_name()%>님 환영합니다.</span>
		  			<div class="equip">
		  				<span class="mile">보유 마일리지 : <%=bean.getMem_mile() %> 점</span>
		  				<%	
		  					Integer count = 0;
			  				Vector<Coupon_Bean> side_user_coupons = side_c_mgr.getUserCoupon(String.valueOf(mem_id));
			  				long side_user_coupon_count = 0;
			  				System.out.println("sidecount : "+side_user_coupon_count);
			  				
			  				for (Coupon_Bean user_coupon : side_user_coupons) {
			  					String coupon = user_coupon.getCoupon_code();
			  					Map<String, String> c_vaild = side_c_mgr.checkCouponVaild(coupon);
			  					
			  					if (c_vaild.get("result").equals("success")) {
			  						side_user_coupon_count += 1;
			  					} else {
			  						System.out.println("code : "+coupon);
			  						System.out.println("reason : "+c_vaild.get("reason"));
			  					}
			  				}
		  					
			  				System.out.println("sidecount : "+side_user_coupon_count);
		  				%>
		  				<span class="coupon">보유중인 쿠폰 : <%=side_user_coupon_count %> 장</span>
		  			</div>
		  			<div class="setting">
		  				<span onclick="location.href='<%=cPath %>/admin/'">관리하기</span>
		  				<span onclick="location.href='<%=cPath %>/login/logout.jsp'">로그아웃</span>
		  			</div>
		  		</div>
		  	</div>
		</div>	
		
		   <button class="w3-bar-item w3-button" onclick="myAccFunc()">메뉴</button>
		  <div id="demoAcc" class="w3-bar-block w3-hide w3-white w3-card-4">
		  	<a href="<%=cPath %>/best" class="w3-bar-item w3-button w3-bar-child">인기메뉴</a>
		  	<a href="<%=cPath %>/recommand" class="w3-bar-item w3-button w3-bar-child">추천메뉴</a>
		  	<a href="<%=cPath %>/" class="w3-bar-item w3-button w3-bar-child">햄버거 단품</a>
		    <a href="<%=cPath %>/setMenu" class="w3-bar-item w3-button w3-bar-child">햄버거 세트</a>
		    <a href="<%=cPath %>/dessert" class="w3-bar-item w3-button w3-bar-child">디저트</a>
		    <a href="<%=cPath %>/drink" class="w3-bar-item w3-button w3-bar-child">음료수</a>
		  </div>
		
		  <button class="w3-bar-item w3-button" onclick="myAccFunc1()">이벤트</button>
		  <div id="demoAcc1" class="w3-bar-block w3-hide w3-white w3-card-4">
		    <a href="<%=cPath %>/Event" class="w3-bar-item w3-button w3-bar-child">이벤트 목록</a>
		    <a href="<%=cPath %>/Coupon" class="w3-bar-item w3-button w3-bar-child">쿠폰 목록</a>
		    <!--  <a href="/index/page/page4.jsp" class="w3-bar-item w3-button w3-bar-child">3</a> -->
		  </div>
		  
		  <button class="w3-bar-item w3-button" onclick="myAccFunc2()">고객지원</button>
		   <div id="demoAcc2" class="w3-bar-block w3-hide w3-white w3-card-4">
		    <a href="<%=cPath %>/index/page/page2.jsp" class="w3-bar-item w3-button w3-bar-child">ㅂ</a>
		    <a href="<%=cPath %>/index/page/page3.jsp" class="w3-bar-item w3-button w3-bar-child">ㅈ</a>
		    <a href="<%=cPath %>/index/page/page4.jsp" class="w3-bar-item w3-button w3-bar-child">ㄷ</a>
		  </div>  
	  <%} else {%>
		
		<div class="login">
			<div class="inside">
		  		<div class="info">
		  			<span class="name"><%=bean.getMem_name()%>님 환영합니다.</span>
		  			<div class="equip">
		  				<span class="mile">보유 마일리지 : <%=bean.getMem_mile() %> 점</span>
		  				<%	
		  					Integer count = 0;
			  				Vector<Coupon_Bean> side_user_coupons = side_c_mgr.getUserCoupon(String.valueOf(mem_id));
			  				long side_user_coupon_count = 0;
			  				System.out.println("sidecount : "+side_user_coupon_count);
			  				
			  				for (Coupon_Bean user_coupon : side_user_coupons) {
			  					String coupon = user_coupon.getCoupon_code();
			  					Map<String, String> c_vaild = side_c_mgr.checkCouponVaild(coupon);
			  					
			  					if (c_vaild.get("result").equals("success")) {
			  						side_user_coupon_count += 1;
			  					} else {
			  						System.out.println("code : "+coupon);
			  						System.out.println("reason : "+c_vaild.get("reason"));
			  					}
			  				}
		  					
			  				System.out.println("sidecount : "+side_user_coupon_count);
		  				%>
		  				<span class="coupon">보유중인 쿠폰 : <%=side_user_coupon_count %> 장</span>
		  			</div>
		  			<div class="setting">
		  				<span onclick="location.href='<%=cPath %>/mypage/personal.jsp'">마이페이지</span>
		  				<span onclick="location.href='<%=cPath %>/login/logout.jsp'">로그아웃</span>
		  			</div>
		  		</div>
		  	</div>
		</div>
		    <button class="w3-bar-item w3-button" onclick="myAccFunc()">메뉴</button>
  <div id="demoAcc" class="w3-bar-block w3-hide w3-white w3-card-4">
  	<a href="<%=cPath %>/best" class="w3-bar-item w3-button w3-bar-child">인기메뉴</a>
	<a href="<%=cPath %>/recommand" class="w3-bar-item w3-button w3-bar-child">추천메뉴</a>
  	<a href="<%=cPath %>/" class="w3-bar-item w3-button w3-bar-child">햄버거 단품</a>
    <a href="<%=cPath %>/setMenu" class="w3-bar-item w3-button w3-bar-child">햄버거 세트</a>
    <a href="<%=cPath %>/dessert" class="w3-bar-item w3-button w3-bar-child">디저트</a>
    <a href="<%=cPath %>/drink" class="w3-bar-item w3-button w3-bar-child">음료수</a>
  </div>

  <button class="w3-bar-item w3-button" onclick="myAccFunc1()">이벤트</button>
  <div id="demoAcc1" class="w3-bar-block w3-hide w3-white w3-card-4">
    <a href="<%=cPath %>/Event" class="w3-bar-item w3-button w3-bar-child">이벤트 목록</a>
    <a href="<%=cPath %>/Coupon" class="w3-bar-item w3-button w3-bar-child">쿠폰 목록</a>
    <!--  <a href="/index/page/page4.jsp" class="w3-bar-item w3-button w3-bar-child">3</a> -->
  </div>
  
  <button class="w3-bar-item w3-button" onclick="myAccFunc2()">고객지원</button>
   <div id="demoAcc2" class="w3-bar-block w3-hide w3-white w3-card-4">
    <a href="<%=cPath %>/index/page/page2.jsp" class="w3-bar-item w3-button w3-bar-child">ㅂ</a>
    <a href="<%=cPath %>/index/page/page3.jsp" class="w3-bar-item w3-button w3-bar-child">ㅈ</a>
    <a href="<%=cPath %>/index/page/page4.jsp" class="w3-bar-item w3-button w3-bar-child">ㄷ</a>
  </div>
	  <%}} %>

  
  
</nav>