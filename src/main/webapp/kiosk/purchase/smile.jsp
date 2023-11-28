<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마일리지 사용/적립</title>
<link rel='stylesheet' href='../../assets/css/purchase.css' />
</head>
<body style="overflow: hidden;">
  <div class="header"><span>마일리지 사용/적립</span></div>
  <div class="payment-card within-top-border" style='height: 460px;'>
  
    <img src="../../assets/svg/smile.svg" alt="coupon" width='100' style="margin-bottom: 5px;" />
    <span><span style="color: green; font-size: 1.05rem; font-weight: 700;">적립</span> 을 원하시면 <span style="color: green; font-size: 1.05rem; font-weight: 700;">'휴대폰 번호'</span> 입력</span>
    <span><span style="color: red; font-size: 1.05rem; font-weight: 700;">사용과 적립</span> 둘다 원하시면 <span style="color: red; font-size: 1.05rem; font-weight: 700;">'회원 ID'</span> 입력</span>
    <span id="smileText">&nbsp;</span>
 	  <input type="text"
 	   id='smileCode'
 	   name='smileCode'
 	   size="20"
 	   style='
 	    margin-bottom: 24px;
 	    font-size: 1.2rem;
 	    font-weight: 500;
 	    outline: none;
 	    border: solid #ddd;
 	    border-width: 0 0 2px 0;
 	   '
 	   placeholder='카드번호/휴대폰번호'
 	   readOnly
 	  ></input>
 	  <input type="hidden"
 	   id="smileType"
 	   name="smileType"
 	  ></input>
 	  <div class="rowbox">
 	    <div class="numeric-keypad" onClick="handleKeypad2(1)">1</div>
       <div class="numeric-keypad" onClick="handleKeypad2(2)">2</div>
       <div class="numeric-keypad" onClick="handleKeypad2(3)">3</div>
 	  </div>
     <div class="rowbox">
       <div class="numeric-keypad" onClick="handleKeypad2(4)">4</div>
       <div class="numeric-keypad" onClick="handleKeypad2(5)">5</div>
       <div class="numeric-keypad" onClick="handleKeypad2(6)">6</div>
     </div>
     <div class="rowbox">
       <div class="numeric-keypad" onClick="handleKeypad2(7)">7</div>
       <div class="numeric-keypad" onClick="handleKeypad2(8)">8</div>
       <div class="numeric-keypad" onClick="handleKeypad2(9)">9</div>
     </div>
     <div class="rowbox">
       <div class="numeric-keypad" onClick="handleKeypad2(0)">0</div>
       <div class="numeric-keypad numeric-clear" onClick="clearKeypad2()">Clear</div>
     </div>
    <div class="payment-cancle" onClick="handleScanBarcode()">바코드 입력</div>
 	</div>
  <div class="rowbox">
    <div class="payment-ok" onClick="handleSmileForm()">확인</div>
    <div class="payment-cancle" onClick="back()">취소</div>
  </div>
  <script src="../../assets/js/kiosk/purchase/detailedFetch.js"></script>
  <script src="../../assets/js/kiosk/purchase/smile.js"></script>
  <script>
    const handleScanBarcode = () => {
      location.href = './scanner.jsp?by=smile';
    }
    </script>
</body>
</html>