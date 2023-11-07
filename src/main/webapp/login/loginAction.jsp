<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="user.MemberMgr" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id = "user" class = "user.Member_Bean" scope = "page" />
<jsp:setProperty property="mem_id" name="user"/>
<jsp:setProperty property="mem_pw" name="user"/>
<!DOCTYPE html>
<meta charset = "UTF-8">
<%
	String userName = null;
	if(session.getAttribute("userName")!= null){
		userName=(String)session.getAttribute("userName");
	}
	if (userName != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("location.href = '../index.jsp'");
		script.println("</script>");
	}
	MemberMgr mMgr = new MemberMgr();
	int result = mMgr.login(user.getMem_id(), user.getMem_pw());
	if(result == 1){
		session.setAttribute("mem_id", user.getMem_id());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 성공!')");
		script.println("location.href = '../index.jsp'");
		script.println("</script>");
	}
	else if(result==0){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result==-1){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result==-2){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
%>