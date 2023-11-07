<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 시스템</title>
<link rel='stylesheet' href='./purchase.css' />
</head>
<body>
  <div class="header" style='width: 244px; font-weight: 400; font-size: 1.2rem;'><span>STEP 1.</span><span style='margin-left: 2vw;'>포장 선택</span></div>
  	<div class="rowbox">
	    <div class="payment-option small-font" style='border-bottom-width: 2px; border-radius: 0 0 0 30px;'>
	      <img src="../svg/bag.svg" alt="bag" width='70' />
	      <span>포장</span><span>(1회용기 제공)</span>
	    </div>
	    <div class="payment-option small-font" style='border-right-width: 2px; border-bottom-width: 2px; border-radius: 0 0 30px 0;'>
	      <img src="../svg/shop.svg" alt="shop" width='70' />
	  	  <span>매장</span><span>(다회용기 제공)</span>
	    </div>
    </div>
  <div class="header" style='width: 244px; font-weight: 400; font-size: 1.2rem;'><span>STEP 2.</span><span style='margin-left: 2vw;'>할인/적립</span></div>
  	<div class="rowbox">
	    <div class="payment-option small-font" style='border-bottom-width: 2px; border-radius: 0 0 0 30px;'>
	      <img src="../svg/coupon.svg" alt="coupon" width='80' />
	      할인쿠폰 사용
	    </div>
	    <div class="payment-option small-font" style='border-right-width: 2px; border-bottom-width: 2px; border-radius: 0 0 30px 0;'>
	      <img src="../svg/smile.svg" alt="smile" width='80' />
	  	  마일리지 적립
	    </div>
    </div>
  <div class="header" style='width: 244px; font-weight: 400; font-size: 1.2rem;'><span>STEP 3.</span><span style='margin-left: 2vw;'>결제방법 선택</span></div>
  	<div class="rowbox">
	    <div class="payment-option small-font" style='border-bottom-width: 2px; border-radius: 0 0 0 30px;'>
	      <img src="../svg/credit-card.svg" alt="credit-card" width='80' />
	      신용/체크카드
	    </div>
	    <div class="payment-option small-font" style='border-right-width: 2px; border-bottom-width: 2px; border-radius: 0 0 30px 0;'>
	      <img src="../svg/phone.svg" alt="phone" width='80' />
	  	  모바일/바코드
	    </div>
    </div>
  <div class="rowbox">
    <div class="payment-cansle">결제</div>
    <div class="payment-cansle">취소</div>
  </div>
</body>
</html>