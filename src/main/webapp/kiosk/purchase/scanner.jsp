<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  request.setCharacterEncoding("UTF-8");
  String by = request.getParameter("by");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>바코드 스캐너</title>
  <link rel="stylesheet" href="./scanner.css">
  <script src="../../assets/js/kiosk/purchase/detailedFetch.js"></script>
  <script src="../../assets/js/kiosk/purchase/bin/barscanner.js"></script>
</head>
<body>
    <div class="bar_cam_wrap">
        <div class="inner">
            <div style="width: 100%" id="reader"></div>

            <a class="manual_type" href="./coupon.jsp">
                <div>
                    <span>돌아가기</span>
                </div>
            </a>
        </div>
    </div>

    <script>
        async function cacheCoupon(text) {
            const coupon = {
              'code': text,
            };
        	  const fetchCoupon = await detailedFetch(
        		      '/green_kiosk/api/kiosk/purchase/coupon',
        		      'POST',
        		      encodeURIComponent(JSON.stringify(coupon)),
        		);
            if (fetchCoupon.result) {
                const couponItem = sessionStorage.getItem('couponArray');
                let couponArray = [];
                const body = fetchCoupon.body;
                if (couponItem !== null && couponItem !== undefined) {
                  couponArray = JSON.parse(sessionStorage.getItem('couponArray'));
                  couponArray.push(body);
                } else {
                  couponArray = [body];
                }
                sessionStorage.setItem('couponArray', JSON.stringify(couponArray));
                }
            location.href = './coupon.jsp';
        }
        async function cacheMileage(text) {
            let smile = {
       	      'type': 'cardNumber',
       	      'value': text,
       	    };
       	    const mileage = await detailedFetch(
       	      '/green_kiosk/api/user/verify/smile',
       	      'POST',
       	      encodeURIComponent(JSON.stringify(smile)),
       	    );
       	    if (mileage.result) {
       	      sessionStorage.setItem('mileage', JSON.stringify(mileage.body));
       	    }
       	location.href = './smile.jsp';
        }
        function onScanSuccess(decodedText, decodedResult) {
            // Handle on success condition with the decoded text or result.
            console.log(`Scan result: ${decodedText}`, decodedResult);
            
        
            // ...
            html5QrcodeScanner.clear();
            document.write(`인식된 바코드 번호 ${decodedText}로 카드 번호를 조회중입니다.`);
            if ('<%=by%>' === 'coupon') {
            	cacheCoupon(decodedText);
            } else {
            	cacheMileage(decodedText);
            }
        }

        function onScanError(errorMessage) {
            // handle on error condition, with error message
            if (errorMessage == "D: 이미지에서 어떤 코드도 찾지 못했습니다. 다른이미지를 선택해주세요.") {
                location.href = './scanner.jsp'
            } else {
                console.log(errorMessage)
            }
            
        }

        var html5QrcodeScanner = new Html5QrcodeScanner("reader", { fps: 10, qrbox: 250 });
        html5QrcodeScanner.render(onScanSuccess, onScanError);
        html5QrcodeScanner
    </script>
</body>
</html>