<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="menu.Menu_menu_Bean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="mMgr" class="menu.Manager_Menu"  />
<link href="style3.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet">
<script src='https://unpkg.com/micromodal/dist/micromodal.min.js'></script>

<html>

<head>
<script>
  MicroModal.init();

  

  const hrefTo3 = (type) => {
    MicroModal.show('modal-2-1');
    MicroModal.init(); // 모달 초기화
  };

  const back3 = (type) => {
    MicroModal.close('modal-2-1');
  };

  
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

  // 주문 내역을 저장할 배열
  let basketArray = [];
  
//장바구니에 메뉴 추가
  const addToBasket = (menuName, price, SubName, Subprice, DrinkName, Drinkprice) => {
      const menuItem = {
          name: menuName,
          price: price,
          amount: 1, // 초기 수량은 1로 설정
      };
      const SubItem = {           
          name: SubName,
          price: Subprice,
          amount: 1,    
          }
      const DrinkItem = {           
              name: DrinkName,
              price: Drinkprice,
              amount: 1,    
              }

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
			    html += '<div class="alldelete" >';
			    html += '취소하기';
			    html += '</div>';
			    html += '<div class="basket">';
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
            deleteBasket(deletedIndex);
        }
    }
});


const deleteBasket = (deletedIndex) => {
    // basketArray에서 deletedIndex에 해당하는 위치의 요소를 제외하고 새로운 배열을 생성합니다.

    basketArray = basketArray.filter(function(_, index) { 
        return index !== deletedIndex - 1;
    });

    // 장바구니 디스플레이를 업데이트합니다.
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


  // 예제에서는 각 메뉴의 클릭 이벤트에 addToBasket 함수를 추가하였습니다.
	document.addEventListener('DOMContentLoaded', function () {


//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  

		document.querySelector('.item1').addEventListener('click', () => {addToBasket('코카콜라', 1500);
		 });
		 document.querySelector('.item2').addEventListener('click', () => {addToBasket('제로콜라', 1500);
		 });	
		 document.querySelector('.item3').addEventListener('click', () => {addToBasket('스프라이트', 1500);
		 });;	
		 document.querySelector('.item4').addEventListener('click', () => {addToBasket('스프라이트 제로',1500);
		 });	
		 document.querySelector('.item5').addEventListener('click', () => {addToBasket('밀키스', 1500);
		 });
		 document.querySelector('.item6').addEventListener('click', () => {addToBasket('마운틴듀', 1500);
		 });	
		 document.querySelector('.item7').addEventListener('click', () => {addToBasket('환타', 1500);
		  MicroModal.open('modal-2-1');
		 });	
		 
		 document.querySelector('.item8').addEventListener('click', () => {addToBasket('오렌지쥬스', 2500);
		 });
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  
		 document.querySelectorAll('.fanta1').forEach((item) => {
				    item.addEventListener('click', () => {
				      addToBasket('환타(포도)', 1500);
				      MicroModal.close('modal-2-1');
				       MicroModal.close('modal-2');

				 		  });
				      });

			   document.querySelectorAll('.fanta2').forEach((item) => {
				     item.addEventListener('click', () => {
				       addToBasket('환타(파인애플)', 1500);
				       MicroModal.close('modal-2-1');
				       MicroModal.close('modal-2');

				    	 });
				      });

			   document.querySelectorAll('.fanta3').forEach((item) => {
				      item.addEventListener('click', () => {
				       addToBasket('환타(오렌지)', 1500);
				       MicroModal.close('modal-2-1');
				       MicroModal.close('modal-2');

				        });
				      });
			   
		});




		  
		  
	  
	  
	  

	  

  
  
</script>

	 
	 
	 
</head>
<body>
<div class="container">

	 <div class="head color1" align="center">	<h1>KIOSK</h1> <br>
	 </div>
	 <div class="main color2" align="center">	
	 	<div class="page w3-button"onclick="jumoon0()" ><h2>단 품</h2></div>
	 	<div class="page w3-button"onclick="jumoon1()" ><h2>세 트</h2></div>
	 	<div class="page w3-button"onclick="jumoon2()" ><h2>음 료 수</h2></div>
	 	<div class="page w3-button"onclick="jumoon3()" ><h2>사 이 드</h2></div>
	 </div>

	<div class="item1" >
		<div class="rowbox">
 			<img src="../images/cola.jpg">
 				<div class="colbox">
 				  <span id="hamburger0" style="font-size:36px; margin :10px" >코카콜라</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >1500~</span>
 				 </div>
		</div>
	</div>
	
	<div class="item2" >
		<div class="rowbox">
 			<img src="../images/cola1.jpg" >
 				<div class="colbox">
 				  <span id="hamburger1" style="font-size:36px; margin :10px" >제로콜라</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >1500~</span>
 				</div>
		</div>
	</div>
	
	<div class="item3 " >
		<div class="rowbox">
 			<img src="../images/saida.jpg" >
 				<div class="colbox">
 			 	  <span id="hamburger2" style="font-size:36px; margin :10px" >스프라이트</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >1500~</span>
				</div>
		</div>
	</div>
	
	<div class="item4" >
		<div class="rowbox">
 			<img src="../images/saida1.jpg" >
 				<div class="colbox">
 				  <span id="hamburger3" style="font-size:36px; margin :10px" >스프라이트<br>제로</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >1500~</span>
 				</div>
		</div>
	</div>
	
	<div class="item5">
		<div class="rowbox">
 			<img src="../images/milkiseu.jpg" >
 				<div class="colbox">
 				  <span id="hamburger4" style="font-size:36px; margin :10px" >밀키스</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >1500~</span>

 				</div>
		</div>	
	</div>
	
	<div class="item6">
		<div class="rowbox">
 			<img src="../images/mauntindyu.jpg" >
 				<div class="colbox">
 				  <span id="hamburger5" style="font-size:36px; margin :10px" >마운틴듀</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >1500~</span>

 				</div>
		</div>
	</div>
	
	<div class="item7">
		<div class="rowbox">
 		<img src="../images/fanta.jpg" >
 			<div class="colbox">
 				<div class="colbox">
 				  <span id="hamburger6" style="font-size:36px; margin :10px" >환타</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >1500~</span>

				</div>
 			</div>
		</div>	
	</div>
	
	<div class="item8">
		<div class="rowbox">
 			<img src="../images/orange juice.jpg" >
 				<div class="colbox">
 				  <span id="hamburger7" style="font-size:36px; margin :10px" >오렌지 쥬스</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >2500~</span>

 				</div>
		</div>	
	</div>

  <div class="modal micromodal-slide" id="modal-2-1" aria-hidden="true">
    <div class="modal__overlay" tabindex="-1">
      <div class="modal__container1" role="dialog" aria-modal="true" aria-labelledby="modal-1-title">
        <main class="modal__content2" id="modal-2-content">
				<div class="potato"><h1 style="background-color:#b4fffb">맛을 선택하세요.</h1></div>
				<div class="fanta1"><h1>포도</h1></div>
				<div class="fanta2"><h1>파인애플</h1></div>
				<div class="fanta3"><h1>오렌지</h1></div>
				<div class="page5" id="close_btn" onclick="back3()"><H1 style="color:black;">닫 기</H1></div>		

		</main>
	  </div>
	</div>
  </div>





	
	
		<div class="order" id="totalOrder" >
			  	<div class="price" id ="totalPrice" >
				
				</div>

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
function jumoon0() {
	location.href = "test1-1-4.jsp";
}		
function jumoon1() {
	location.href = "test2.jsp";
}		
function jumoon2() {
	location.href = "test3.jsp";
}		
function jumoon3() {
	location.href = "test4.jsp";
}		
	
	
</script>

</body>
</html>
