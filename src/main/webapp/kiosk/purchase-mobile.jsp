<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 시스템</title>
<link rel='stylesheet' href='./purchase.css' />
</head>
<body>
  <div class="header"><span style='margin-left: 2vw;'>원하시는 결제 방법을 선택해 주세요.</span></div>
  <div class="payment-options">
    <div class="payment-option select">
      <img src="../svg/phone.svg" alt="phone" width='80' />모바일 카드</div>
    <div class="payment-option selelct">
      <img src="../svg/삼성.svg" alt="Samsung Pay" width='80' />
    </div>
    <div class="payment-option">
      <img src="../svg/애플.png" alt="Apple Pay" width='100' />
    </div>
    <div class="payment-option" style='border-right-width: 2px;'>
    </div>
  </div>
  <div class="payment-options">
    <div class="payment-option select" style='border-bottom-width: 2px; border-radius: 0 0 0 30px;'>
      <img src="../svg/barcode.svg" alt="barcode" width='80' />바코드 스캔</div>
    <div class="payment-option" style='border-bottom-width: 2px;'>
      <img src="../svg/카카오.svg" alt="Kakao Pay" width='100' />
    </div>
    <div class="payment-option" style='border-bottom-width: 2px;'>
      <img src="../svg/네이버.svg" alt="Naver Pay" width='100' />
    </div>
    <div class="payment-option" style='border-right-width: 2px; border-bottom-width: 2px; border-radius: 0 0 30px 0;'>
      <img src="../svg/엘.svg" alt="L Pay" width='100' />
    </div>
  </div>
  <div class="payment-cansle">취소</div>
</body>
</html>