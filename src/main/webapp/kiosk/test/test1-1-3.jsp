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

  
  const hrefTo = (type) => {
    MicroModal.show('modal-1');
  };

  const hrefTo1 = (type) => {
    MicroModal.show('modal-1-1');
    MicroModal.init(); // 모달 초기화

  };

  const hrefTo2 = (type) => {
    MicroModal.init(); // 모달 초기화
    MicroModal.show('modal-2');
    MicroModal.close('modal-1');

  };

  const hrefTo3 = (type) => {
    MicroModal.show('modal-2-1');
    MicroModal.init(); // 모달 초기화
  };

  const back = (type) => {
    MicroModal.close('modal-1');
  };

  const back1 = (type) => {
    MicroModal.close('modal-1-1');
  };

  const back2 = (type) => {
    MicroModal.close('modal-2');
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

	  document.querySelector('.item1').addEventListener('click', () => addToBasket('데리버거', 3500));
	  document.querySelector('.item2').addEventListener('click', () => addToBasket('더블 데리버거', 3500));
	  document.querySelector('.item3').addEventListener('click', () => addToBasket('불고기버거', 3500));
	  document.querySelector('.item4').addEventListener('click', () => addToBasket('더블 불고기버거', 3500));
	  document.querySelector('.item5').addEventListener('click', () => addToBasket('치킨버거', 3500));
	  document.querySelector('.item6').addEventListener('click', () => addToBasket('더블 치킨버거', 3500));
	  document.querySelector('.item7').addEventListener('click', () => addToBasket('치즈버거', 3500));
	  document.querySelector('.item8').addEventListener('click', () => addToBasket('더블 클래식 치즈버거', 3500));
	  
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  
		 document.querySelector('.item1-1').addEventListener('click', () => addToBasket('포테이토', 1500));
		 document.querySelector('.item3-1').addEventListener('click', () => addToBasket('포테이토(L)', 2300));	
		 document.querySelector('.item4-1').addEventListener('click', () => addToBasket('치즈 스틱', 1800));	
		 document.querySelector('.item5-1').addEventListener('click', () => addToBasket('치즈 볼', 1800));	
		 document.querySelector('.item6-1').addEventListener('click', () => addToBasket('치킨 너겟', 1800));	
		 document.querySelector('.item7-1').addEventListener('click', () => addToBasket('오징어 링', 1800));	
		 document.querySelector('.item8-1').addEventListener('click', () => addToBasket('웨지 포테이토', 2000));	

		 
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  
 		document.querySelectorAll('.potato1').forEach((item) => {
		    item.addEventListener('click', () => {
		      addToBasket('양념감자(어니언)', 1500);
		      MicroModal.show('modal-2');
		      MicroModal.close('modal-1-1');
		       MicroModal.close('modal-1');
		        });
		      });

	   document.querySelectorAll('.potato2').forEach((item) => {
		     item.addEventListener('click', () => {
		       addToBasket('양념감자(치즈)', 1500);
		       MicroModal.show('modal-2');
		       MicroModal.close('modal-1-1');
		       MicroModal.close('modal-1');

		        });
		      });

	   document.querySelectorAll('.potato3').forEach((item) => {
		      item.addEventListener('click', () => {
		       addToBasket('양념감자(칠리)', 1500);
		       MicroModal.show('modal-2');
		       MicroModal.close('modal-1-1');
		       MicroModal.close('modal-1');

		        });
		      });
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  

		document.querySelector('.item1-2').addEventListener('click', () => {addToBasket('코카콜라', 1500);
		  MicroModal.close('modal-2');
		 });
		 document.querySelector('.item2-2').addEventListener('click', () => {addToBasket('제로콜라', 1500);
		  MicroModal.close('modal-2');
		 });	
		 document.querySelector('.item3-2').addEventListener('click', () => {addToBasket('스프라이트', 1500);
		  MicroModal.close('modal-2');
		 });;	
		 document.querySelector('.item4-2').addEventListener('click', () => {addToBasket('스프라이트 제로',1500);
		  MicroModal.close('modal-2');
		 });	
		 document.querySelector('.item5-2').addEventListener('click', () => {addToBasket('밀키스', 1500);
		  MicroModal.close('modal-2');
		 });
		 document.querySelector('.item6-2').addEventListener('click', () => {addToBasket('마운틴듀', 1500);
		  MicroModal.close('modal-2');
		 });	
		 document.querySelector('.item8-2').addEventListener('click', () => {addToBasket('오렌지쥬스', 2500);
		  MicroModal.close('modal-2');
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
	 	<div class="page "onclick="jumoon0()" ><h2>단 품</h2></div>
	 	<div class="page "onclick="jumoon1()" ><h2>세 트</h2></div>
	 	<div class="page "onclick="jumoon2()" ><h2>음 료 수</h2></div>
	 	<div class="page "onclick="jumoon3()" ><h2>사 이 드</h2></div>
	 </div>

	<div class="item1" onclick="hrefTo('item1')">
		<div class="rowbox">
 			<img src="../images/hamburger0.jpg">
 				<div class="colbox">
 				  <span id="hamburger0" style="font-size:36px; margin :10px" >데리버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>
 				 </div>
		</div>
	</div>
	
	<div class="item2" onclick="hrefTo('item2')">
		<div class="rowbox">
 			<img src="../images/hamburger1.jpg" >
 				<div class="colbox">
 				  <span id="hamburger1" style="font-size:36px; margin :10px" >더블 데리버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>
 				</div>
		</div>
	</div>
	
	<div class="item3 " onclick="hrefTo('item3')">
		<div class="rowbox">
 			<img src="../images/hamburger2.jpg" >
 				<div class="colbox">
 			 	  <span id="hamburger2" style="font-size:36px; margin :10px" >불고기버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>
				</div>
		</div>
	</div>
	
	<div class="item4" onclick="hrefTo('item4')">
		<div class="rowbox">
 			<img src="../images/hamburger3.jpg" >
 				<div class="colbox">
 				  <span id="hamburger3" style="font-size:36px; margin :10px" >더블 불고기버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>
 				</div>
		</div>
	</div>
	
	<div class="item5" onclick="hrefTo('item5')">
		<div class="rowbox">
 			<img src="../images/hamburger4.jpg" >
 				<div class="colbox">
 				  <span id="hamburger4" style="font-size:36px; margin :10px" >치킨버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>

 				</div>
		</div>	
	</div>
	
	<div class="item6" onclick="hrefTo('item6')">
		<div class="rowbox">
 			<img src="../images/hamburger5.jpg" >
 				<div class="colbox">
 				  <span id="hamburger5" style="font-size:36px; margin :10px" >더블 치킨버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>

 				</div>
		</div>
	</div>
	
	<div class="item7" onclick="hrefTo('item7')">
		<div class="rowbox">
 			<img src="../images/hamburger6.jpg" >
 				<div class="colbox">
 				  <span id="hamburger6" style="font-size:36px; margin :10px" >치즈버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>

 				</div>
		</div>	
	</div>
	
	<div class="item8" onclick="hrefTo('item8')">
		<div class="rowbox">
 			<img src="../images/hamburger7.jpg" >
 				<div class="colbox">
 				  <span id="hamburger7" style="font-size:36px; margin :10px" >더블 클래식치즈버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>

 				</div>
		</div>	
	</div>


<div class= "menu">
  <div class="modal micromodal-slide" id="modal-1" aria-hidden="true">
    <div class="modal__overlay" tabindex="-1">
      <div class="modal__container" role="dialog" aria-modal="true" aria-labelledby="modal-1-title">
        <main class="modal__content" id="modal-1-content">
				<div class= "chucheon2 color3"><h1>추천 메뉴</h1></div>
					<div class="page1" onclick="hrefTo2()"><H1 style="color:black;">다 음</H1></div>		
					<div class="page3" onclick="back()"><H1 style="color:black;">닫 기</H1></div>		
				

 <!-- 포테이토 메뉴 아이템 -->
	<div class="item1-1 modal-1-item" onclick="hrefTo2()">
      <div class="rowbox">
        <img src="../images/potato.jpg" >
        <div class="colbox">
          <h1>포테이토</h1>
          <h2 style="color:blue;" >1500</h2>
        </div>
      </div>
    </div>

	<div class="item2-1 modal-1-item" onclick="hrefTo1()">
      <div class="rowbox">
        <img src="../images/potato1.jpg" >
        <div class="colbox">
          <h1>양념 감자</h1>
          <h2 style="color:blue;" >1700</h2>
        </div>
      </div>
    </div>
	
	<div class="item3-1" onclick="hrefTo2()">
		<div class="rowbox">
 			<img src="../images/potato2.jpg" >
 				<div class="colbox">
 				     <H1>포테이토(L)</H1>
 					  <h2 style="color:blue;" >2300</h2>
 				</div>
		</div>
	</div>
	
	<div class="item4-1" onclick="hrefTo2()">
		<div class="rowbox">
 			<img src="../images/cheese.jpg" >
 				<div class="colbox">
 				     <H1>치즈 스틱</H1>
 				 	 <h2 style="color:blue;" >1800</h2>
 				</div>
		</div>
	</div>
	
	<div class="item5-1" onclick="hrefTo2()">
		<div class="rowbox">
 			<img src="../images/cheese2.jpg" >
 				<div class="colbox">
 				     <H1>치즈 볼</H1>
 				  	<h2 style="color:blue;" >1800</h2>
 				</div>
		</div>	
	</div>
	
	<div class="item6-1" onclick="hrefTo2()">
		<div class="rowbox">
 			<img src="../images/chicken.jpg" >
 				<div class="colbox">
 				     <H1>치킨 너겟</H1>
 					  <h2 style="color:blue;" >1800</h2>
 				</div>
		</div>
	</div>
	
	<div class="item7-1" onclick="hrefTo2()">
		<div class="rowbox">
 			<img src="../images/ojingeo.jpg" >
 				<div class="colbox">
 				     <H1>오징어 링</H1>
 					  <h2 style="color:blue;" >1800</h2>
 				</div>
		</div>	
	</div>
	
	<div class="item8-1" onclick="hrefTo2()">
		<div class="rowbox">
 			<img src="../images/potato3.jpg" >
 				<div class="colbox">
 				     <H1>웨지 <br>포테이토</H1>
 					  <h2 style="color:blue;" >2000</h2>
 				</div>
		</div>	
	</div>

        </main>
      </div>
    </div>
  </div>
</div>



  <div class="modal micromodal-slide" id="modal-1-1" aria-hidden="true">
    <div class="modal__overlay" tabindex="-1">
      <div class="modal__container1" role="dialog" aria-modal="true" aria-labelledby="modal-1-title">
        <main class="modal__content2" id="modal-2-content">
				<div class="potato"><h1 style="background-color:#b4fffb">맛을 선택하세요.</h1></div>
		        <div class="potato1" ><h1>어니언</h1></div>
		        <div class="potato2" ><h1>치즈</h1></div>
		        <div class="potato3" ><h1>칠리</h1></div>
				<div class="page5" id="close_btn" onclick="back1()"><H1 style="color:black;">닫 기</H1></div>		
				
		</main>
	  </div>
	</div>
  </div>

<!-- 음료수 modal -->

<div class= "menu">
  <div class="modal micromodal-slide" id="modal-2" aria-hidden="true">
    <div class="modal__overlay" tabindex="-1">
      <div class="modal__container" role="dialog" aria-modal="true" aria-labelledby="modal-1-title">
        <main class="modal__content1" id="modal-1-content">
	        	<div class= "chucheon2 color3"><h1>추천 메뉴</h1></div>
					<div class="page2" onclick="back2()"><H1 style="color:black;">이 전</H1></div>		
					<div class="page2-1" onclick="back2()"><H1 style="color:black;">닫 기</H1></div>		
	

	<div class="item1-2 ">
		<div class="rowbox">
			<img src="../images/cola.jpg" >
				<div class="colbox">
				  <H1>코카콜라</H1>
				  <h2 style="color:blue;" >1500</h2>
				</div>
		</div>
	</div>
	
	<div class="item2-2">
		<div class="rowbox">
 			<img src="../images/cola1.jpg" >
 				<div class="colbox">
 				     <H1>제로콜라</H1>
 					  <h2 style="color:blue;" >1500</h2>
 				</div>
		</div>
	</div>
	
	<div class="item3-2">
		<div class="rowbox">
 			<img src="../images/saida.jpg" >
 				<div class="colbox">
 				     <H1>스프라이트</H1>
 					  <h2 style="color:blue;" >1500</h2>
 				</div>
		</div>
	</div>
	
	<div class="item4-2">
		<div class="rowbox">
 			<img src="../images/saida1.jpg" >
 				<div class="colbox">
 				     <H1>스프라이트<br> 제로</H1>
 				 	 <h2 style="color:blue;" >1500</h2>
 				</div>
		</div>
	</div>
	
	<div class="item5-2">
		<div class="rowbox">
 			<img src="../images/milkiseu.jpg" >
 				<div class="colbox">
 				     <H1>밀키스</H1>
 				  	<h2 style="color:blue;" >1500</h2>
 				</div>
		</div>	
	</div>
	
	<div class="item6-2">
		<div class="rowbox">
 			<img src="../images/mauntindyu.jpg" >
 				<div class="colbox">
 				     <H1>마운틴듀</H1>
 					  <h2 style="color:blue;" >1500</h2>
 				</div>
		</div>
	</div>
	
	<div class="item7-2">
		<div class="rowbox">
 			<img src="../images/fanta.jpg" >
 				<div class="colbox" onclick="hrefTo3()">
 				     <H1>환타</H1>
 					  <h2 style="color:blue;" >1500</h2>
 				</div>
		</div>	
	</div>
	
	<div class="item8-2">
		<div class="rowbox">
 			<img src="../images/orange juice.jpg" >
 				<div class="colbox">
 				     <H1>오렌지쥬스</H1>
 					  <h2 style="color:blue;" >2500</h2>
 				</div>
		</div>	
	</div>

        </main>
      </div>
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
	
	
	
	
<%
	Vector<Menu_menu_Bean> vector = mMgr.getMenuList(1);
	
	int menuLength = vector.size();

	if (vector.isEmpty()){
		out.println("등록된 메뉴가 없습니다.");
	} else {
		for (int i = 0; i < menuLength; i++) {
			Menu_menu_Bean bean = vector.get(i);
			
%>

<%
		}
	}

%>


<script>


    
</script>
</body>
</html>
