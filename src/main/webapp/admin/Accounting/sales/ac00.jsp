<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="orders.Orders_Bean"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>

<jsp:useBean id="menuMgr" class="menu.Manager_Menu"/>
<%
    int AllPrice = 0;
    int pageNum = 1;

    if (request.getParameter("pageNum") != null && !request.getParameter("pageNum").isEmpty()) {
        pageNum = Integer.parseInt(request.getParameter("pageNum"));
    }

    int pageSize = 20; // Set your desired page size here
    Vector<Orders_Bean> vlist = menuMgr.getMgrorderList(pageNum, pageSize);
    int listSize = vlist.size();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>코드관리</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/admin/Accounting/ac00.css"/>
    <link rel="stylesheet" href="/post_inc/datatables/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/admin/account/ac00.js"></script>
    <script>
        Orders_Bean bean = new Orders_Bean();
        String orders_foods = request.getParameter("orders_foods");
        Bean.setOrder_foods(request.getParameter("order_foods"))
    </script>
    
</head>

<body leftmargin="0" topmargin="0">
    <div align="center">
        <br/>
        <h2>매장 관리 페이지</h2>
        <br>
        <%     
        
            listSize = vlist.size();
            if (vlist.isEmpty()) {
                out.println("등록된 목록이 없습니다.");
            } else {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th colspan="11"> <%=pageNum%> 페이지 등록 자료수 : <%=listSize%></th>
                </tr>
            </thead>
            <tbody class="getMenuList" id="getMenuList">
                <tr align="center" bgcolor="#D0D0D0" height="120%">
                    <td>번호</td>
                    <td>판매 일시</td>
                    <td>판매 내역</td>
                    <td>판매 금액</td>
                    <td>할인</td>
                    <td>쿠폰</td>
                    <td>결제 방식</td>
                    <td>사용된 마일리지</td>
                    <td>수정</td>
                    <td>삭제</td>
                </tr>
            </tbody>
            <%
                for (int i = 0; i < listSize; i++) {
                    if (i == listSize) break;
                    Orders_Bean bean = vlist.get(i);
                    int order_no = bean.getOrder_no();
                    Timestamp order_time = bean.getOrder_time();
                    String order_foods = bean.getOrder_foods();
                    long order_price = bean.getOrder_price();
                    long order_discount = bean.getOrder_discount();
                    String order_coupon = bean.getOrder_coupon();
                    String order_type = bean.getOrder_type();
                    int order_use_amount = bean.getOrder_use_amount();
                    int count = 0;
                    System.out.println("ALL =>  " + order_no + ", (order_coupon:) " + order_coupon );
                %>
                <tr>
                    <td align="center"><%=order_no%></td>
                    <td align="center"><%=String.valueOf(order_time).substring(0, String.valueOf(order_time).length()-2)%></td>
                    <%
                        Gson gson = new Gson();
                        List<Map<String, Object>> parsedData = gson.fromJson(order_foods, new TypeToken<List<Map<String, Object>>>() {}.getType());
                        Map<String, Integer> menuMap = new HashMap<>();
                        String productInfo = "";

                        for (Map<String, Object> order : parsedData) {
                            for (Map.Entry<String, Object> entry : order.entrySet()) {
                                String menuName = entry.getKey();
                                Object value = entry.getValue();
                                if ("name".equals(menuName)) {
                                    productInfo += value + " X ";
                                } else if ("amount".equals(menuName)) {
                                    productInfo += value + "개, ";
                                }
                            }
                        }
                        productInfo = productInfo.replaceAll(", $", "");
                       
                        String CouponInfo ="";
		
                      if(order_coupon != null && !order_coupon.equals("") &&
                    	 !order_coupon.equals("' '") && !order_coupon.equals("null") &&
                    	 !order_coupon.equals("[]")) {
                      List<Map<String, Object>> couponData = gson.fromJson(order_coupon, new TypeToken<List<Map<String, Object>>>() {}.getType());
                        // Process coupon data similarly to order_foods
                        Map<String,Integer> CouponMap = new HashMap<>();

                        for (Map<String, Object> coupon : couponData) {
                        	for (Map.Entry<String, Object> entry : coupon.entrySet()) {
                        		System.out.println(entry.getKey());
                        		System.out.println(entry.getValue());
                             	String keys = entry.getKey();
                             	Object Values = entry.getValue();
                            // Customize this part based on your coupon structure
                            CouponInfo += keys + " : " + Values + ", ";
							System.out.println("CouponInfo:" + CouponInfo);
                        		
                        	}
                        }

                        // Remove the trailing comma and space again
                        CouponInfo = CouponInfo.replaceAll(", $", "");
                       } else {
                    	CouponInfo = order_coupon;
                       }
                    %>
       				<td align="center"><%= (productInfo.length() > 20) ? productInfo.substring(0, 20) + "..." : productInfo %></td>
                    <td align="center"><%=order_price%></td>
                    <td align="center"><%=order_discount%></td>
					<td align="center" onclick="openPopup('<%=request.getContextPath()%>/admin/Accounting/sales/ac00_popup.jsp?CouponInfo=<%=CouponInfo%>')">
					    <%= (CouponInfo != null && CouponInfo.length() > 20) ? CouponInfo.substring(0, 20) + "..." : CouponInfo %>
					</td>                    
					<td align="center"><%=order_type%></td>
                    <td align="center"><%=order_use_amount%></td>
                    <td align="center"><input type="button" value="수정" onClick="loadContent('sales/ac00up.jsp?numb=<%=order_no%>');"></td>
                    <td align="center"><input type="button" value="삭제" onClick="loadContent('sales/ac00Delete.jsp?numb=<%=order_no%>')"></td>
                </tr>
                <tr>
                </tr>
                <%
                    }//for
                %>
            </table>
            <!-- Pagination links -->
            <div>
                <%
                    Vector<Orders_Bean> vlistAll = menuMgr.getMgrorderList(0, pageSize);
                    int listSizeAll = vlistAll.size();
                    int numb = 0;
                    int totalPages = (int) Math.ceil((double) listSizeAll / pageSize);
                    for (int i = 1; i <= totalPages; i++) {
                %>
                <div onClick="loadContent('sales/ac00.jsp?pageNum=<%= i %>')" class="pagination">
                    <a href="javascript:void(0)"><%= i %></a>
                </div>
                <%
                    }
              	}
            
                %>
            </div>
            <script>
                function deleteOrder(order_no) {
                    location.href = "ac00Delete.jsp?order_no=" + order_no;
                }
                function updateOrder1(updateOrder1Bean) {
                    location.href = "ac00up.jsp?order_no=" + order_no;
                }
            </script>
        </div>
    </body>
</html>
