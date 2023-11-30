<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file="/admin/layouts/BeanManager.jsp" %>
<%@ include file="/admin/admin_check/check.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="<%=request.getContextPath()%>/assets/js/admin/Menu/menu_main.js"></script>
<title>menu_uploadProcess</title>
</head>
<body>
<%@ page import="java.net.URLDecoder" %>

	<%
	    String menuType = "";
	    if (request.getCookies() != null) {
	        for (javax.servlet.http.Cookie cookie : request.getCookies()) {
	            if (cookie.getName().equals("menuType")) {
	                menuType = URLDecoder.decode(cookie.getValue(), "UTF-8");
	                break;
	            }
	        }
	    }
	%>
	<%
		//해당 주소는 서버 주소입니다. 로컬에서 실행시 오류 발생하므로 서버에 올려서 테스트
		String savePath= "/usr/local/tomcat/webapps/downloadfile2";
		String encType = "utf-8";
		int maxSize = 50 * 1024 * 1024;
		
		ServletContext context = this.getServletContext();
		MultipartRequest multi = null;
		multi = new MultipartRequest(request, savePath, maxSize, encType, new DefaultFileRenamePolicy());
		
		int menu_isUse = 0;
		int menu_isSale = 0;
		int menu_couponable = 0;
		int menu_recommend = 0;
		
		String menuIsSaleParameter = multi.getParameter("menu_isSale");
		if (menuIsSaleParameter != null && !menuIsSaleParameter.isEmpty()) {
		    menu_isSale = 1;
		}

		String menuIsUseParameter = multi.getParameter("menu_isUse");
		if (menuIsUseParameter != null && !menuIsUseParameter.isEmpty()) {
		    menu_isUse = 1;
		}
		String menuCouponableParameter = multi.getParameter("menu_couponable");
		if (menuCouponableParameter != null && !menuCouponableParameter.isEmpty()) {
			menu_couponable = 1;
		}
		
		String menuRecommendParameter = multi.getParameter("menu_recommend");
		if (menuRecommendParameter != null && !menuRecommendParameter.isEmpty()) {
			menu_recommend = 1;
		}
		
/***************************************************************************************************************************************************************************
																				입력값 불러오기
****************************************************************************************************************************************************************************/
		String menu_gubn = null;
		if (multi.getParameter("menu_gubn") != null && !multi.getParameter("menu_gubn").isEmpty())
		{
			menu_gubn = multi.getParameter("menu_gubn");
/***************************************************************************************************************************************************************************
																				재료 추가 하기
****************************************************************************************************************************************************************************/

			//menu_gubn이 menu_component 항목일 때 
			if (menu_gubn.equals("재료")){
				if (multi.getParameter("menu_name") != null && !multi.getParameter("menu_name").isEmpty() &&
					multi.getParameter("menu_price") != null && !multi.getParameter("menu_price").isEmpty())
					{
					String menu_name = multi.getParameter("menu_name");
					int menu_price = Integer.parseInt(multi.getParameter("menu_price"));
					String fileName = multi.getFilesystemName("menu_imgPath");
						menuComponentBean = new Menu_component_Bean();
						menuComponentBean.setComponent_name(menu_name);
						menuComponentBean.setComponent_amount(0);
						menuComponentBean.setComponent_isUse(menu_isUse);
						menuComponentBean.setComponent_imgPath("/downloadfile2/" + fileName);
						menuComponentBean.setComponent_price(menu_price);
						boolean result = menuMgr.insertTopingMenu(menuComponentBean);
						//table insert에 성공 했을 경우
						if (result == true)
						{
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("opener.updateMenu('"+menuType+"')");
							script.println("window.close();");
 							script.println("</script>");
							//table insert 실패 했을 경우
						} else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('정보 등록에 실패했습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
					}
				}
/***************************************************************************************************************************************************************************
																			일반 메뉴 추가 하기
****************************************************************************************************************************************************************************/
			//menu_gubn이 menu 항목 일 때
			else {
			if (multi.getParameter("menu_name") != null && !multi.getParameter("menu_name").isEmpty() &&
				    multi.getParameter("menu_price") != null && !multi.getParameter("menu_price").isEmpty() &&
				    multi.getParameter("menu_content") != null && !multi.getParameter("menu_content").isEmpty())
			{
				String fileName = multi.getFilesystemName("menu_imgPath");
				String menu_name = multi.getParameter("menu_name");
				int menu_price = Integer.parseInt(multi.getParameter("menu_price"));
				String menu_content = multi.getParameter("menu_content");
				
					menuBean = new Menu_menu_Bean();
					menuBean.setMenu_name(menu_name);
					menuBean.setMenu_gubn(menu_gubn);
					menuBean.setMenu_isSale(menu_isSale);
					menuBean.setMenu_imgPath("/downloadfile2/" +fileName);
					menuBean.setMenu_price(menu_price);
					menuBean.setMenu_content(menu_content); 
					menuBean.setMenu_isUse(menu_isUse);
					menuBean.setMenu_couponable(menu_couponable); 
					menuBean.setMenu_component("0");
					menuBean.setMenu_sell_amount(0);
					menuBean.setMenu_recommend(menu_recommend);
					boolean result = menuMgr.insertMenu(menuBean);
					//table insert에 성공 했을 경우
					if (result == true)
					{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("opener.updateMenu('"+menuType+"')");
						script.println("window.close();");
						script.println("</script>");
						//table insert 실패 했을 경우
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('정보 등록에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
				} 
				//getParameter 값 중 null이 있을 경우
				else { //null 값 처리 실패
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('모든 필드에 입력해주세요')");
					script.println("history.back()");
					script.println("</script>");
				} 
			}
		}
		//menu_gubn parameter 값 check 
		 else { 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('카테고리를 지정해주세요')");
			script.println("history.back()");
			script.println("</script>");
		}
		
	%>
</body>
</html>