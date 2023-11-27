const couponRegex = /^[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}$/;

const handleKeypad = (num) => {
  const input = document.querySelector('#couponCode') as HTMLInputElement;
  const length = input.value.length;
  let temp = '';

  if (length < 19) {
    if ((length + 1) % 5 === 0) {
      temp = '-';
    }
    input.value += temp + num;
  }
};
const generateCouponHTML = (arr: any[]) => {
  let couponHTML = '';

  if (arr && arr.length > 0) {
    document.getElementById('couponDOM2').style.display = 'inline-block';
    for (let i = 0; i < arr.length; i++) {
      couponHTML += `<div class='rowbox' style='border: solid #ddd; border-width: 0 0 2px 0; align-self: center; padding: 3px 0;'>`;
      couponHTML += `<span style='width: 200px;'>` + arr[i].name + `</span>`;
      couponHTML += `</div>`;
    }
  } else {
    document.getElementById('couponDOM2').style.display = 'none';
  }

  const couponElement = document.getElementById('couponDOM');

  couponElement.innerHTML = couponHTML;
};

(() => {
  let couponArray = [];
  const couponItem = sessionStorage.getItem('couponArray');
  if (couponItem !== null || couponItem !== undefined) {
    couponArray = JSON.parse(sessionStorage.getItem('couponArray'));
  }
  generateCouponHTML(couponArray);
})();

const handleClickCancle2 = () => {
  location.href = 'main.jsp';
};

const clearKeypad = () => {
  const input = document.querySelector('#couponCode') as HTMLInputElement;
  input.value = '';
};

const handleCouponForm = async () => {
  const couponCodeElement = document.querySelector('#couponCode') as HTMLInputElement;
  let couponCode = couponCodeElement.value;
  if (!couponRegex.test(couponCode)) {
    const couponTextElement = document.getElementById('couponText');
    couponTextElement.innerHTML = '<span style="color: red;">올바르지 않은 쿠폰 코드입니다.</span>';
    setTimeout(() => {
      couponTextElement.innerHTML = '할인 쿠폰 코드를 입력해 주세요.';
    }, 3000);
  } else {
    couponCode = couponCode.replace(/-/g, '');
    const coupon = {
      'code': couponCode,
    };
    const fetchCoupon: fetchCouponType = await detailedFetch(
      '/green_kiosk/api/kiosk/purchase/coupon',
      'POST',
      encodeURIComponent(JSON.stringify(coupon)),
    );
    if (fetchCoupon.result) {
      const couponItem = sessionStorage.getItem('couponArray');
      let couponArray: couponType[] = [];
      const body = fetchCoupon.body;
      if (couponItem !== null && couponItem !== undefined) {
        couponArray = JSON.parse(sessionStorage.getItem('couponArray'));
        couponArray.push(body as couponType);
      } else {
        couponArray = [body as couponType];
      }
      sessionStorage.setItem('couponArray', JSON.stringify(couponArray));
      generateCouponHTML(couponArray);
      couponCodeElement.value = '';
    } else {
      const couponTextElement = document.getElementById('couponText');
      if (fetchCoupon.body === 'invalid') {
        couponTextElement.innerHTML = '<span style="color: red;">유효하지 않은 쿠폰입니다.</span>';
      } else if (fetchCoupon.body === 'over-time') {
        couponTextElement.innerHTML = '<span style="color: red;">현재 사용 불가능한 쿠폰입니다.</span>';
      }
      setTimeout(() => {
        couponTextElement.innerHTML = '할인 쿠폰 코드를 입력해 주세요.';
      }, 3000);
    }
  }
};
