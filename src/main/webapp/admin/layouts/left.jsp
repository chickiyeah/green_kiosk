<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5 w3-animate-left" id="mySidebar">
	  <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
	    <i class="fa fa-remove"></i>
	  </a>
	  <br/>
	  <h4 class="w3-bar-item"><b>Menu</b></h4>
	  <hr/>
	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="loadContent('<%=request.getContextPath()%>/login/login.jsp')">로그인</a>
	  <a class="w3-bar-item w3-button w3-hover-black" href="#">Link</a>
	  <a class="w3-bar-item w3-button w3-hover-black" href="#">Link</a>

	</nav>
	  <h4 class="w3-bar-item"><b>Menu</b></h4>
	  <a class="w3-bar-item w3-button w3-hover-black" href="">로그인</a>
	  <a class="w3-bar-item w3-button w3-hover-black" href="#"></a>
	  <a class="w3-bar-item w3-button w3-hover-black" href="#">Link</a>
	  <a class="w3-bar-item w3-button w3-hover-black" href="#">Link</a>
	</nav>
</body>
</html>
