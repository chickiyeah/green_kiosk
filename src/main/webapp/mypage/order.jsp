<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="orders.Orders_Bean" %>
<%@ page import="orders.Orders_Mgr" %>
<%@ page import="user.Member_Mgr" %>
<%@ page import="user.Member_Bean" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ include file="/index/base/head_import.jsp"%>
<script> let res = "false"; </script>
<%
	Orders_Mgr mgr = new Orders_Mgr();
	String cPath = request.getContextPath();
	
	String S_2_foods = "";
	
	Gson gson = new Gson();

	Object mem_id = session.getAttribute("mem_id");
	Object failed_count = session.getAttribute("failed_count");
	Object pw_ok = session.getAttribute("pw_ok");
	
	Member_Mgr u_mgr = new Member_Mgr();
	Member_Bean bean = u_mgr.getMember(String.valueOf(mem_id));
	
	DecimalFormat format = new DecimalFormat("###,###");
	String mem_ac = "user";
	if (bean == null) {
		%> <script> alert("로그인 상태가 아닙니다.");location.href="<%=cPath %>/"</script> <%
	} else {
		mem_ac = bean.getMem_ac();
	}
	Map<String, String> a_foods = new HashMap<String, String>();
	Vector<Orders_Bean> orders = mgr.getOrdersByUser(String.valueOf(mem_id)); %>
<html>
<head>
<title>마이페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=cPath %>/assets/css/reset.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/index.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/mypage.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/register.css">
<script src="<%=cPath %>/assets/js/index.js"></script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
</style>
<script>
	const page_data = new Map();
	
	function save(id, html) {
		page_data.set(id, html)
	}
</script>
</head>
<script>
const foods = new Map();

//회원가입 창 여는 함수
function open_register() {
	let url = "<%=cPath %>/register/register.jsp"
	window.open(url, "회원가입", "width=460, height=600")
}

function edit() {
	let frm = document.querySelector(".joinform")
	let name = frm.mem_name.value
	let phone = frm.mem_phone.value
	let url = "<%=cPath %>/api/user/update?name="+name+"&phone="+phone
	
	fetch(url, {
		method: "post"
	}).then(response => {
		response.json().then((res) => {
			let result = res.result;
			
			if (result == "success") {
				alert("개인정보를 성공적으로 변경했습니다.");
				location.reload();
			} else {
				alert("개인정보 변경중 오류가 발생하였습니다.");
			}
		})
	})
}

function fnModalPrint() {
    const html = document.querySelector('html');
    const printContents = document.querySelector('.record_add_pop').innerHTML;
    const printDiv = document.createElement('DIV');
    printDiv.className = 'print-div';
    html.appendChild(printDiv);
    printDiv.innerHTML = printContents;
    document.body.style.display = 'none';
    window.print();
    document.body.style.display = 'block';
    printDiv.style.display = 'none';
}

function see_detail(food_no) {
	let food_data = foods_list[food_no-1];
	let element = document.getElementById("post_foods");
	element.innerHTML = "";
	food_data.forEach((food) => {
		let food_name = food.name
		let amount = food.amount;
		let price = food.price
		let allprice = amount * price
		let html = "<tr><td>"+food_name+"</td><td>"+amount+" 개</td><td>"+allprice.toLocaleString()+" 원</td></tr>"
		element.insertAdjacentHTML("beforeend", html)
		
		
	})
	
	document.querySelector(".record_add_pop").style.display = "flex"
}
</script>
<body>
<!-- Sidebar (hidden by default) -->
<%@ include file="/index/base/sidebar.jsp"%>
<!-- Top menu -->
<%@ include file="/index/base/head.jsp" %>
 
    <div class="record_add_pop">
        <div class="inner">
            <h2 class="title">주문 상세 내용</h2>
            <div class="record_add_wrap">
                <table class="record_add_box">
                    <thead>
                    <tr>
                        <th>제품명</th>
                        <th>갯수</th>
                        <th>금액</th>
                    </tr>
                    </thead>
                    <tbody id="post_foods">
                    <tr>
                        <td>데리버거</td>
                        <td>5</td>
                        <td>9000원</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="btn_box">
                <a class="black_line_btn" onclick="document.querySelector('.record_add_pop').style.display =''" href="javascript:">뒤로가기</a>
            </div>
        </div>
    </div>
<!-- !PAGE CONTENT! -->
<div class="w3-main w3-content w3-padding" style="max-width:1300px;margin-top:100px;height:920px;width:1300px">
		
	<div class="w3-row-padding w3-padding-16 w3-center w3-tooltip" id="food">
		<table border="1" class="mypage" cellspacing="0" cellpadding="2" width="1250">
			<tr>
				<td colspan="2" height="5%">
					<div class="top">
						<span class="title"><b>마이페이지</b></span>
					</div>
				</td>
			</tr>
			<tr>
				<td align="center">
					<div class="setting">
						<div class="order" onclick="location.href='<%=cPath %>/mypage/personal.jsp'">
							<span class="title">개인정보 확인/수정</span>
						</div>
						
						<div class="order" style="background-color: orangered; border-color: darkorchid; border-width: 3px;" onclick="location.href='<%=cPath %>/mypage/order.jsp'">
							<span class="title">주문내역</span>
						</div>	
						
						<div class="mile" onclick="location.href='<%=cPath %>/mypage/mile.jsp'">
							<span class="title">마일리지 적립/사용내역</span>
						</div>
						
						<div class="unregi" onclick="location.href='<%=cPath %>/mypage/unregi.jsp'">
							<span class="title">회원탈퇴</span>
						</div>
					</div>
				</td>
				<!-- 해당 위치 고정 -->
				<td rowspan="4" width="80%">
					<table border="1" style="max-height: 597.27px; overflow-y: scroll; border-top-width: 0px; border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; table-layout: fixed" cellspacing="0" cellpadding="2" width="100%" height="100%" id="inner_order">
						<tr align="center" height="5%">
							<td width="5%">번호</td>
							<td width="25%">주문 일시</td>
							<td width="45%">주문 음식</td>
							<td width="15%">총 금액</td>
							<td width="10%">영수증 발급</td>
						</tr>		
						<%
							boolean runned = false;
							Integer count = 0;
							Integer paging = 1;
							Integer rem = 20;
							Map<String, String> page_data = new HashMap<String, String>();
							String p_html = "<tr align=\"center\" height=\"5%\"><td width=\"5%\">번호</td><td width=\"25%\">주문 일시</td><td width=\"45%\">주문 음식</td><td width=\"15%\">총 금액</td><td width=\"10%\">영수증 발급</td></tr>";
							for(Orders_Bean order : orders) {
								long all_money = 0;
								if (runned == false) {
									runned = true;
								}
								S_2_foods += ","+order.getOrder_foods();
								
								List<Map<String, Object>> foods = gson.fromJson(order.getOrder_foods(), new TypeToken<List<Map<String,Object>>>(){}.getType());
								String S_foods = "";
								
								for (Map<String, Object> food : foods) {
									all_money += ((long) Integer.parseInt(String.valueOf(food.get("price"))) * Integer.parseInt(String.valueOf(food.get("amount"))));
									if (S_foods.equals("")) {
										S_foods = food.get("name")+" X "+Integer.parseInt(String.valueOf(food.get("amount")).replace(".0", ""));
									} else {
										S_foods = S_foods + ", " + food.get("name")+" X "+Integer.parseInt(String.valueOf(food.get("amount")).replace(".0", ""));
									}
								}
								count += 1;
								rem -= 1;
								System.out.println("line 162 count : "+count);
								a_foods.put("food_"+count, order.getOrder_foods());
								
								if (count % 20 == 0) {
									page_data.put(String.valueOf(paging), p_html);
									page_data.put(String.valueOf(paging)+"_rem", "0");
									p_html = "<tr align=\"center\" height=\"5%\"><td width=\"5%\">번호</td><td width=\"25%\">주문 일시</td><td width=\"45%\">주문 음식</td><td width=\"15%\">총 금액</td><td width=\"10%\">영수증 발급</td></tr>";
									rem = 20;
									paging += 1;
								} else {
									p_html += "<tr align=\"center\"><td>"+order.getOrder_no()+"</td><td>"+String.valueOf(order.getOrder_time()).substring(0,19)+"</td><td onclick=\"see_detail("+count+")\" style=\"text-overflow:ellipsis; overflow:hidden; white-space:nowrap; padding: 0 90px; cursor: pointer\">"+S_foods+"</td><td>"+format.format(order.getOrder_price())+" 원</td><td><button no=\""+order.getOrder_no()+"\" type=\"button\">영수증 발급</button></td></tr>";
								}
								if (count < 21) {
									
									
								
						%>
							<tr align="center" height="4.5%">
								<td width="5%"><%=order.getOrder_no() %></td>
								<td width="25%"><%=String.valueOf(order.getOrder_time()).substring(0,19) %></td>
								<td width="45%" onclick="see_detail(<%=count %>)" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; padding: 0 90px; cursor: pointer"><%=S_foods %></td>
								<td width="15%"><%=format.format(all_money) %> 원</td>
								<td width="10%"><button no="<%=order.getOrder_no() %>" type="button">영수증 발급</button></td>
							</tr>
						<%	
								} //if
							}//for
							
							if (runned == false) {
								%>
								<tr align="center">
									<td colspan="5"><h2>주문 내역이 존재 하지 않습니다.</h2></td>
								</tr>
								<%
							} else {
								if (rem > 0) {
									if(paging == 1) {
										for (int i=0;i<rem;i++) {
											%>
											<tr align="center" height="4.5%">
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											</tr>
											<%
										}
									} else {
										for (int i=0;i<rem;i++) {
											p_html += "<tr align=\"center\" height=\"4.5%\"><td></td><td></td><td></td><td></td><td></td></tr>";
										}
									}
								} 
								page_data.put(String.valueOf(paging), p_html);
								%>
								<tr align="center">
									<td colspan="5">
								<%
								String paginghtml = "<tr align=\"center\"><td colspan=\"5\">";
								
								for (int i = 1; i<=paging; i++) {
									System.out.println("page : "+i+" data : "+page_data.get(String.valueOf(i)));
									if (i == 1) {
										%>
											<button style="border: 1px black solid; padding: 0 5px; border-radius: 20px; font-weight:900; background-color: black; color:white " onclick="view(<%=i %>)"><%=i %></button>
										<%									
									} else {
										%>
											<button style="border: 1px black solid; padding: 0 5px; border-radius: 20px; font-weight:900" onclick="view(<%=i %>)"><%=i %></button>
										<%
									}
									for (int j = 1; j<=paging; j++) {
										if (i == j) {
											paginghtml += "<button style=\"border: 1px black solid; padding: 0 5px; border-radius: 20px; font-weight:900; background-color: black; color:white; margin-left:5px;\" onclick=\"view("+j+")\">"+j+"</button>";
										} else {
											paginghtml += "<button style=\"border: 1px black solid; padding: 0 5px; border-radius: 20px; font-weight:900; margin-left:5px;\" onclick=\"view("+j+")\">"+j+"</button>";
										}
									}
									paginghtml += "</td></tr>";
									page_data.put("paging"+i, paginghtml);
									paginghtml = "<tr align=\"center\"><td colspan=\"5\">";
								}
								
								
								page_data.put(String.valueOf(paging)+"_rem", String.valueOf(rem));
								%>
									</td>
								</tr>
								<%
							}
						%>
					</table>
				</td>
				<!-- 해당 위치 고정 -->
			</tr>
		</table>
	</div>

  
  <hr id="about">
  
  <!-- Footer -->

<%@ include file="/index/base/footer.jsp" %>

<!-- End page content -->
</div>



<script>

<%
for (int i = 1; i<=paging; i++) {
	System.out.println("page : "+i+" data : "+page_data.get(String.valueOf(i)));
	%>
		page_data.set(<%=i%>, '<%=page_data.get(String.valueOf(i))+""+page_data.get("paging"+i)%>')
	<%
}
List<String> list = new ArrayList<String>(a_foods.keySet());

List<String> keys = new ArrayList<String>();

for (String key: list) {
	keys.add("\""+key+"\"");
}
%>
page_data.set("data_value", '<%=a_foods.values()%>')
page_data.set("data_key", '<%=keys.toString() %>')
//const keys = JSON.parse(foods.get("data_key"))
//const values = JSON.parse(foods.get("data_value"))
let foods_list = new Array();
let foods_map = new Map();
let i = 0
/*keys.forEach((entry) => {
	
	if (entry === "index" && i != 0) {
		foods_list.unshift(foods_map);
		foods_map = new Map();
	}
	foods_map.set(entry, values[i])
	i = i + 1
})*/

foods_list = JSON.parse('[<%=S_2_foods.substring(1)%>]');
<%
%>

function view(num) {
	console.log(num)
	document.getElementById("inner_order").innerHTML = page_data.get(num);
}


// Script to open and close sidebar
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
}

function myAccFunc() {
	  var x = document.getElementById("demoAcc");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	    x.previousElementSibling.className += " w3-green";
	  } else { 
	    x.className = x.className.replace(" w3-show", "");
	    x.previousElementSibling.className = 
	    x.previousElementSibling.className.replace(" w3-green", "");
	  }
	}

function myAccFunc1() {
	  var x = document.getElementById("demoAcc1");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	    x.previousElementSibling.className += " w3-green";
	  } else { 
	    x.className = x.className.replace(" w3-show", "");
	    x.previousElementSibling.className = 
	    x.previousElementSibling.className.replace(" w3-green", "");
	  }
	}

function myAccFunc2() {
	  var x = document.getElementById("demoAcc2");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	    x.previousElementSibling.className += " w3-green";
	  } else { 
	    x.className = x.className.replace(" w3-show", "");
	    x.previousElementSibling.className = 
	    x.previousElementSibling.className.replace(" w3-green", "");
	  }
	}

</script>

</body>
</html>
