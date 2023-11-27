<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>결제 시스템</title>
    <link rel="stylesheet" href="../../assets/css/purchase.css" />
    <link rel="stylesheet" href="./micromodal.css" />
  </head>
  <body style="overflow: hidden">
    <div class="modal micromodal-slide" id="modal-1" aria-hidden="true" style="overflow: hidden">
      <div class="modal__overlay" tabindex="-1" data-micromodal-close>
        <div class="modal__container" role="dialog" aria-modal="true" aria-labelledby="modal-1-title">
          <main class="modal__content" id="modal-1-content">
            <div class="colbox">
              <span style="color: black; margin-bottom: 8px">영수증을 출력하시겠습니까?</span>
              <div class="rowbox">
                <div class="payment-ok" onClick="handleClickOkRecipie(orderObject_g, element_g, insertOrder_g)"
                  >&nbsp;네&nbsp;</div
                >
                <div class="payment-cancle" onClick="handleClickCancleRecipie()">아니오</div>
              </div>
            </div>
          </main>
        </div>
      </div>
    </div>
    <script src="../../assets/js/kiosk/purchase/detailedFetch.js"></script>
    <script src="../../assets/js/kiosk/purchase/bin/micromodal.min.js"></script>
    <script src="../../assets/js/kiosk/purchase/finally.js"></script>
    <script>
      MicroModal.init();
      MicroModal.show('modal-1');
    </script>
  </body>
</html>
