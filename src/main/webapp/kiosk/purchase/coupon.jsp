<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인쿠폰 사용</title>
<link rel='stylesheet' href='../../assets/css/purchase.css' />
</head>
<body style="overflow: hidden;">
  <header class="header"><span>할인쿠폰 사용</span></header>
  <main class="payment-card within-top-border" style='height: 500px;'>
    <img src="../../assets/svg/coupon.svg" alt="coupon" width='100' style='margin-bottom: 5px;' />
    <section class="rowbox">
	    <article id="couponDOM2" class="colbox" style="border: 2px solid #eee; padding: 10px; margin-right: 16px;">
	      <!-- 여기서 쿠폰 리스트 JS로 표시, 정해진 줄 길이, 넘어가면 페이지로,  -->
	      <span style="width: 120px; background-color: #eee; border: 2px solid #ddd; align-self: center; padding: 3px 0;">적용된 쿠폰</span>
	      <div id="couponDOM"></div>
	    </article>
	    <article class="colbox" style="border: 2px solid #eee; padding: 10px;">
		    <div id="couponText" style="margin-bottom: 16px;">할인 쿠폰 코드를 입력해 주세요.</div>
	      <input type="text"
	       id='couponCode'
	       name='couponCode'
	       size="16"
	       style='
	        margin-bottom: 24px;
	        font-size: 1.2rem;
	        font-weight: 500;
	        outline: none;
	        border: solid #ddd;
	        border-width: 0 0 2px 0;
	       '
	       placeholder='쿠폰 번호'
				 readonly
	      ></input>
		    <div class="rowbox">
		      <div class="numeric-keypad" onClick="handleKeypad(1)">1</div>
		       <div class="numeric-keypad" onClick="handleKeypad(2)">2</div>
		       <div class="numeric-keypad" onClick="handleKeypad(3)">3</div>
		    </div>
		    <div class="rowbox">
		      <div class="numeric-keypad" onClick="handleKeypad(4)">4</div>
		      <div class="numeric-keypad" onClick="handleKeypad(5)">5</div>
		      <div class="numeric-keypad" onClick="handleKeypad(6)">6</div>
		    </div>
		    <div class="rowbox">
		      <div class="numeric-keypad" onClick="handleKeypad(7)">7</div>
		      <div class="numeric-keypad" onClick="handleKeypad(8)">8</div>
		      <div class="numeric-keypad" onClick="handleKeypad(9)">9</div>
		    </div>
		    <div class="rowbox">
		      <div class="numeric-keypad" onClick="handleKeypad(0)">0</div>
		      <div class="numeric-keypad numeric-clear" onClick="clearKeypad()">Clear</div>
		    </div>
	    </article>
    </section>
    <div class="payment-cancle" onClick="handleScanBarcode()">바코드 입력</div>
  </main>
  <footer class="rowbox">
    <div class="payment-ok" onClick="handleCouponForm()">쿠폰 사용</div>
    <div class="payment-cancle" onClick="handleClickCancle2()">뒤로가기</div>
  </footer>
  <script src="../../assets/js/kiosk/purchase/detailedFetch.js"></script>
  <script src="../../assets/js/kiosk/purchase/coupon.js"></script>
	<script>
		const handleScanBarcode = () => {
			location.href = './scanner.jsp?by=coupon';
		}
	</script>
</body>
</html>