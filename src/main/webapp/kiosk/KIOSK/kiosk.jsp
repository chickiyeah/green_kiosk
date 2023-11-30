<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="menu.Menu_menu_Bean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="mMgr" class="menu.Manager_Menu"  />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Green KIOSK </title>

<link href="style3.css" rel="stylesheet" type="text/css">
<script src='https://unpkg.com/micromodal/dist/micromodal.min.js'></script>
</head>
<body>
	<div class="container" style="zoom: 0.5;">
	    <div class="head color1" align="center">	<h1>Green KIOSK</h1> <br></div>
		<div class="main color2" align="center">	
		    <div class="page"onclick="jumoon0()" ><h2>단 품</h2></div>
		 	<div class="page"onclick="jumoon1()" ><h2>세 트</h2></div>
		 	<div class="page"onclick="jumoon2()" ><h2>음 료 수</h2></div>
		 	<div class="page"onclick="jumoon3()" ><h2>사 이 드</h2></div>
		</div>
<div class="flex-wrapper" style="width: 100%;">
<!--  단품 메뉴 -->
<%
	Vector<Menu_menu_Bean> vector = mMgr.getMenuList(0);
	
	int menuLength = vector.size();

	if (vector.isEmpty()){
		out.println("등록된 메뉴가 없습니다.");
	} else {
		for (int i = 0; i < menuLength; i++) {
			Menu_menu_Bean bean = vector.get(i);
			if (bean.getMenu_gubn().equals("단품")) {
			
%>
<div class="flex-item" onclick="handleOnClick('<%=bean.getMenu_no()%>', '<%=bean.getMenu_name()%>', '<%=bean.getMenu_price()%>')">
	<div class="rowbox">
	    <img src="<%=bean.getMenu_imgPath() %>">
		<div class="colbox">
		    <span id="hamburger0" style="font-size:36px; margin :10px" ><%=bean.getMenu_name() %></span>
		    <span id="don" style="font-size:30px; margin :10px; color:blue;" ><%=bean.getMenu_price() %></span>
		</div>
	</div>
</div>
<%
			}
		}
	}
%>
</div>
<div class="modal micromodal-slide" id="modal-1" aria-hidden="true">
    <div class="modal__overlay" tabindex="-1">
        <div class="modal__container" role="dialog" aria-modal="true" aria-labelledby="modal-1-title">
  			<div class= "chucheon2 color3"><h1>추천 메뉴</h1></div>
  	        <div class="modal__content" id="modal-1-content">
<!--  음료 메뉴 -->
<%
	
	if (vector.isEmpty()){
		out.println("등록된 메뉴가 없습니다.");
	} else {
		for (int i = 0; i < menuLength; i++) {
			Menu_menu_Bean bean = vector.get(i);
			if (bean.getMenu_gubn().equals("음료")) {
%>
<div class="flex-item" onclick="handleOnClick('<%=bean.getMenu_no()%>', '<%=bean.getMenu_name()%>', '<%=bean.getMenu_price()%>')">
	<img src="<%=bean.getMenu_imgPath() %>">
	<span id="drink" style="font-size:36px; margin :10px" ><%=bean.getMenu_name() %></span>
	<span id="don" style="font-size:30px; margin :10px; color:blue;" ><%=bean.getMenu_price() %></span> 
</div>
<%
			}
		}
	}
%>
			</div>
		</div>
	</div>
</div>
<!--  사이드 메뉴 -->
<div class="modal micromodal-slide" id="modal-2" aria-hidden="true">
    <div class="modal__overlay" tabindex="-1">
        <div class="modal__container" role="dialog" aria-modal="true" aria-labelledby="modal-1-title">
  			<div class= "chucheon2 color3"><h1>추천 메뉴</h1></div>
  	        <div class="modal__content" id="modal-2-content">
<%
	
	if (vector.isEmpty()){
		out.println("등록된 메뉴가 없습니다.");
	} else {
		for (int i = 0; i < menuLength; i++) {
			Menu_menu_Bean bean = vector.get(i);
			if (bean.getMenu_gubn().equals("사이드")) {
%>
<div class="flex-item" onclick="handleOnClick('<%=bean.getMenu_no()%>', '<%=bean.getMenu_name()%>', '<%=bean.getMenu_price()%>')">
	<img src="<%=bean.getMenu_imgPath() %>">
	<span id="drink" style="font-size:36px; margin :10px" ><%=bean.getMenu_name() %></span>
	<span id="don" style="font-size:30px; margin :10px; color:blue;" ><%=bean.getMenu_price() %></span> 
</div>
<%
			}
		}
	}
%>
			</div>
		</div>
	</div>
</div>







		<div class="order" id="totalOrder" style="width: 100%;" >
		  	<div class="price" id ="totalPrice" ></div>
		  	<div class="Ordermenu" >
		  		<span class="Ordermenu" id="menu" style="font-size:36px; font-weight: 600; color:black;margin :10px"></span>
		    </div>
		
		  	<div class="count" >
		  		<span class="count" id="count" style="font-size:36px; font-weight: 600; color:black;margin :10px"></span>  
		    </div>
		  	
		  	<div class="price" >
		  		<span id="price" style="font-size:36px; font-weight: 600; color:black;margin :10px"></span>
			</div>
	
		</div>
	</div>
	<script>
	
		MicroModal.init();
		
	    const handleOnClick = (itemNumber, menuName, menuPrice) => {	   
             MicroModal.show('modal-1');
		     addToBasket(itemNumber, menuName, menuPrice);

		};
	
		document.getElementById('modal-1-content').addEventListener('click', function (event) {
		    MicroModal.close('modal-1');
		    MicroModal.show('modal-2');
		});
		document.getElementById('modal-2-content').addEventListener('click', function (event) {
		    MicroModal.close('modal-1');
		    MicroModal.close('modal-2');
		});
		

		
		
		
		
		
		
		
		
		
		
	    let basketArray = [];

	    const addToBasket = (itemNumber, menuName, price) => {
	        const menuItem = {
	        	index: itemNumber,
	            name: menuName,
	            price: price,
	            amount: 1,
	    	};


	      	// 이미 장바구니에 있는지 확인
		    const existingItem = basketArray.find(item => item.name === menuName);
	
		    if (existingItem) {
		          // 이미 존재하는 경우 수량 증가
		        existingItem.amount++;
		    } else {
		          // 새로운 메뉴인 경우 배열에 추가
		        basketArray.push(menuItem);
	
		    }

	        // 장바구니 업데이트
	        updateBasket();
		      
		};
		document.addEventListener('click', function (event) {
		    if (event.target.classList.contains('arrow-up')) {
		        const parent = event.target.parentNode.parentNode;

		        if (parent) {
		            // 부모 요소의 data-index 속성을 이용하여 인덱스를 가져옵니다.
		            const updatedIndex = parent.getAttribute('data-index');

		            if (updatedIndex !== null && basketArray[updatedIndex]) {
		                basketArray[updatedIndex].amount++;

		                updateBasket();
		            }
		        }
		    }
		});

	    document.addEventListener('click', function (event) {
		    if (event.target.classList.contains('arrow-down')) {
		        const parent = event.target.parentNode.parentNode;

		        if (parent) {
		            // 부모 요소의 data-index 속성을 이용하여 인덱스를 가져옵니다.
		            const updatedIndex = parent.getAttribute('data-index');
	
		            if (updatedIndex !== null && basketArray[updatedIndex]) {
		                if (basketArray[updatedIndex].amount > 1) {
		                    // 최소값이 1이 되도록 처리
		                    basketArray[updatedIndex].amount--;
		                    updateBasket();
		                }
		            }
		        }
		    }
		});
	    
    function cancelOrder() {
	    sessionStorage.removeItem('basketArray');
	    basketArray = []; // Clear the local array as well
	    updateBasket(); // Update the basket display
	}
	    
	    
	    //장바구니 표시 업데이트
	    const updateBasket = () => {
	      console.log(basketArray);

	      // 총 가격과 항목 수를 계산합니다
	      let totalPrice = 0;
	      let itemCount = 0;
	  	  let menuNames = [];
	  	
	      basketArray.forEach(item => {
	          menuNames.push(item.name); // 메뉴 이름을 배열에 추가
	          totalPrice += item.price * item.amount;
	          itemCount += item.amount;
	  	    sessionStorage.setItem('basketArray', JSON.stringify(basketArray));
	      });
	      
	      element = document.getElementById('totalOrder');
	      
	  //-------------------------------------------------------------------------------------------------------------------------------------------------------    
	      let html = '<div class="price,count" style="display:flex; width:95vw;justify-content: flex-end;">';
	      html += '<div class="totalcount" >';
	      html += itemCount + '개</span>';
	      html += '</div>';
	      html += '<div class="totalprice">';
	      html += '<span>총 금액: ' + totalPrice + '원</span>';
	      html += '</div>';
	      html += '</div>';
	      
	      
	      for (let i = 0; i < basketArray.length; i++) {
	          html += '<div class="box" data-index="' + i + '">'
	           			
	          html += '<span class="Ordermenu" style="font-size:36px; font-weight: 600; color:black;margin :10px">' + basketArray[i].name + '</span>'
	  	
	          html += '<span class="count" style="font-size:36px; font-weight: 600; color:black;margin :10px">' + basketArray[i].amount + '</span>'  

	          html += ' <div class="arrow-container">'
	          html += ' <div class="arrow-up"(\'' + basketArray[i].name + '\')">&#9650;</div>';
	          html += ' <div class="arrow-down" (\'' + basketArray[i].name +'\')">&#9660;</div>';
	  		html += '</div>'
	                  	
	          html += '<span class="price" style="font-size:36px; font-weight: 600; color:black;margin :10px">' + basketArray[i].price + '</span>'

	          html += '<h2 class="delete">삭제</h2>'
	  		html += '</div>'
	  	}
	  			
	  	html += '<div class="alldelete,basket" style="display:flex; width:100vw; justify-content: flex-end; ">';
	  	html += '<div class="alldelete" onclick="cancelOrder()" >';
	  	html += '취소하기';
	  	html += '</div>';
	  	html += '<div class="basket" onclick="basket()">';
	  	html += '결제하기';
	  	html += '</div>';
	  	html += '</div>';
	  			    

	      element.innerHTML = html;

	  //-------------------------------------------------------------------------------------------------------------------------------------------------------    

	  	const orderDetailsDiv = document.getElementById('orderDetails');

	      if (orderDetailsDiv) {
	          orderDetailsDiv.innerHTML = ''; // 이전 내용 초기화
	    	
	      }
	   
	      const deleteButton = document.querySelector('.delete');

	      // basketArray에 항목이 있는지 확인
	      if (basketArray.length > 0) {
	          // 항목이 있는 경우 그리드 레이아웃으로 전환
	          deleteButton.style.display = 'grid';
	      } else {
	          // 항목이 없는 경우 원래의 레이아웃으로 전환 (예: 블록)
	          deleteButton.style.display = 'none'; // 원래의 display 값으로 설정
	      }    
	      
	      
//-------------------------------------------------------------------------------------------------------------------------------------------------------    
	  	document.addEventListener('click', function (event) {
	  	    if (event.target.classList.contains('delete')) {
	  	        // 클릭한 요소의 부모 요소를 확인하고, 부모가 존재할 때만 처리합니다.
	  	        const parent = event.target.parentNode.parentNode;
	  	        if (parent) {
	  	            // 클릭한 요소의 부모 요소에서 인덱스를 가져옵니다.
	  	            const deletedIndex = Array.from(parent.children).indexOf(event.target.parentNode);
	  	            // deleteBasket 함수를 호출하고 삭제할 인덱스를 전달합니다.
	  	            deleteBasket(deletedIndex-1);
	  	        }
	  	    }
	  	});

	  	const deleteBasket = (deletedIndex) => {
	  	    basketArray = basketArray.filter(function(_, index) { 
	  	        return index !== deletedIndex;
	  	    });
	  	
	  	    sessionStorage.setItem('basketArray', JSON.stringify(basketArray));
	  	    updateBasket();
	  	
	  	};

	      const clearBasket = () => {
	          basketArray = [];
	          updateBasket();
	      };
	      document.querySelector('.alldelete').addEventListener('click', () => {
	          clearBasket();
	      });  

	    };

	    window.onload = () => {
	    	  const storedBasket = sessionStorage.getItem('basketArray');
	    	  if (storedBasket) {
	    	    basketArray = JSON.parse(storedBasket);
	    	    updateBasket();
	    	  }
	    	};
	  
	  
	  
	  
function jumoon0() {
	location.href = "kiosk.jsp";
}		
function jumoon1() {
	location.href = "kiosk2.jsp";
}		
function jumoon2() {
	location.href = "kiosk3.jsp";
}		
function jumoon3() {
	location.href = "kiosk4.jsp";
}	
function basket() {
	location.href = "../purchase/main.jsp";
}	
	  
	  
	  
	</script>
</body>
</html>