<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="coupon.Coupon_kind_Bean" %>
<%@ page import="coupon.Coupon_kind_Mgr" %>
<%@ page import="coupon.Coupon_Bean" %>
<%@ page import="coupon.Coupon_Mgr" %>
<%@ page import="menu.Manager_Menu" %>
<%@ page import="menu.Menu_menu_Bean" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<% 
	Coupon_Mgr c_mgr = new Coupon_Mgr(); 
	Coupon_kind_Mgr c_k_mgr = new Coupon_kind_Mgr();
	Vector<Coupon_Bean> coupons = c_mgr.readAllCoupon();
%>
<!DOCTYPE html>
<html>
<head>
	<style>
		td, th {
			border-width:2px;
			padding: 3px 20px;
		}
	</style>
</head>
<body>
<div style="display: grid; justify-content: center; width: 100%;">
	<table width="100%" border=1 cellpadding=2 cellspacing=10 style="display: grid;border-collapse: collapse; margin-top: 4%;">
		<tbody id="coupons">
			<tr align="center">
				<th>쿠폰 번호</th>
				<th>쿠폰 이름</th>
				<th>쿠폰 코드</th>
				<th>메뉴 번호</th>
				<th>할인율</th>
				<th>소유자 아이디</th>
				<th>발급일</th>
				<th>만료일</th>
				<th>사용여부</th>
				<th>사용가능여부</th>
				<th>삭제</th>
			</tr>
			<%
				for (Coupon_Bean coupon : coupons) {
					String base_code = coupon.getCoupon_code();
					String code = base_code.substring(0,4) + " - " + base_code.substring(4, 8) + " - " + base_code.substring(8, 12) + " - " + base_code.substring(12);
					
					int vaild_date = c_k_mgr.get_type_with_name(coupon.getCoupon_name()).getVaild_date();
					
					LocalDateTime issueday = coupon.getCoupon_issueDate().toLocalDateTime();
					LocalDateTime endday = issueday.plusDays(vaild_date);
					LocalDateTime now = LocalDateTime.now();
					
					String useable = "O";
					String used = "미사용";
					if (now.isBefore(endday) == false) {
						useable = "X";
					}
					
					if (coupon.getCoupon_used()) {
						used = "사용완료";
					}
					
					
					%>
						<tr align="center">
							<td><%=coupon.getCoupon_no() %> </td>
							<td><%=coupon.getCoupon_name() %></td>
							<td><%=code %></td>
							<td><%=coupon.getCoupon_menuNo() %></td>
							<td><%=coupon.getCoupon_discount() %>%</td>
							<td><%=coupon.get_owner() %></td>
							<td><%=issueday.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %></td>
							<td><%=endday.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %></td>
							<td><%=used %></td>
							<td><%=useable %></td>
							<td style="cursor:pointer;" onclick="cou_delete(<%=coupon.getCoupon_no() %>)">삭제</td>
						</tr>
					<%
				}
			%>

		</tbody>
	</table>
</div>
</body>
</html>