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
		
		if (		multi.getParameter("menu_no") != null && !multi.getParameter("menu_no").isEmpty() &&
				multi.getParameter("menu_name") != null && !multi.getParameter("menu_name").isEmpty() && 
			    multi.getParameter("menu_gubn") != null && !multi.getParameter("menu_gubn").isEmpty() &&
			    multi.getParameter("menu_price") != null && !multi.getParameter("menu_price").isEmpty() &&
			    multi.getParameter("menu_content") != null && !multi.getParameter("menu_content").isEmpty() &&
			    multi.getParameter("menu_component") != null && !multi.getParameter("menu_component").isEmpty() &&
				multi.getParameter("menu_sell_amount") != null && !multi.getParameter("menu_sell_amount").isEmpty()) 
		{
		int menu_no = Integer.parseInt(multi.getParameter("menu_no"));
		String fileName = multi.getFilesystemName("menu_imgPath");
		String menu_name = multi.getParameter("menu_name");
		String menu_gubn = multi.getParameter("menu_gubn");
		int menu_price = Integer.parseInt(multi.getParameter("menu_price"));
		String menu_content = multi.getParameter("menu_content");
		String menu_component = multi.getParameter("menu_component");
		int menu_sell_amount = Integer.parseInt(multi.getParameter("menu_sell_amount"));
		
		if (multi.getParameter("menu_gubn").equals("재료")){
			//쓸 일 없음 (component 부분)
		} else {
				menuBean = new Menu_menu_Bean();
				menuBean.setMenu_no(menu_no);
				menuBean.setMenu_name(menu_name);
				menuBean.setMenu_gubn(menu_gubn);
				menuBean.setMenu_isSale(menu_isSale);
				if (fileName == null){
					fileName = multi.getParameter("menu_imgPath");
					menuBean.setMenu_imgPath(fileName);
				} else {
					menuBean.setMenu_imgPath("/downloadfile2/"+fileName);
				}
				menuBean.setMenu_price(menu_price);
				menuBean.setMenu_content(menu_content); 
				menuBean.setMenu_isUse(menu_isUse);
				menuBean.setMenu_couponable(menu_couponable);
				menuBean.setMenu_recommend(menu_recommend);
				menuBean.setMenu_component(menu_component);
				menuBean.setMenu_sell_amount(menu_sell_amount);
				boolean result = menuMgr.updateMenu(menuBean);
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("opener.updateMenu('"+menuType+"')");
				script.println("window.close();");
				script.println("</script>");

			}
		} else { //null 값 처리 실패
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 필드에 입력해주세요')");
			script.println("history.back()");
			script.println("</script>");
		}
		
	%>
</body>
</html>