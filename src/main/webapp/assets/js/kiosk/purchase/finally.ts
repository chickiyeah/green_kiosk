const BARCODE_DICTIONARY: barcode_dic_type = {
  0: [false, false, true, true, false, true],
  1: [false, true, true, false, false, true],
  2: [false, true, false, false, true, true],
  3: [true, true, true, true, false, true],
  4: [true, false, false, false, true, true],
  5: [true, true, false, false, false, true],
  6: [true, false, true, true, true, true],
  7: [true, true, true, false, true, true],
  8: [true, true, false, true, true, true],
  9: [false, false, true, false, true, true],
};

class Barcode {
  code: string;
  lines: lines[];
  ctx: CanvasRenderingContext2D;
  size: {
    x: number;
    y: number;
  };

  constructor(code: number | string, ctx: CanvasRenderingContext2D, x: number, y: number) {
    this.ctx = ctx;
    this.ctx.canvas.width = x;
    this.ctx.canvas.height = y;
    this.code = typeof code === 'number' ? code.toString() : code;
    this.destructCode();
    this.size = { x, y };
    this.draw();
  }

  destructCode() {
    this.lines = [];
    for (let i = 0; i < this.code.length; i++) {
      const digit = parseInt(this.code[i]);
      if (BARCODE_DICTIONARY[digit]) {
        this.lines.push(BARCODE_DICTIONARY[digit]);
      }
    }
  }

  draw() {
    for (let i = 0; i < this.lines.length; i++) {
      for (let j = 0; j < 6; j++) {
        const lineCount = this.size.x / (this.code.length * 6);
        const x = lineCount * (i * 6 + j);
        const y = 0;
        const width = lineCount;
        const height = this.size.y - Math.round(this.size.y / 4);
        if (this.lines[i][j]) {
          this.ctx.fillRect(x, y, width, height);
        }
        if (j === 2) {
          const textX = x + width / 2;
          const textY = this.size.y - Math.round(this.size.y / 7);
          this.ctx.font = `${Math.round(this.size.y / 8.5)}px SUIT Variable`;
          this.ctx.fillText(this.code[i], textX, textY);
        }
      }
    }
  }
}

class Recipie {
  no: number;
  is_togo: boolean;
  timestamp: Date;
  foods: foodType[];
  price: number;
  discount: number;
  tax: number;
  mileage: boolean;
  mileage_id: string;
  mileage_type: string;
  mileage_value: number;
  payment_type: string;
  barcode: number;
  waitCount: number;

  constructor(orderObject: orderType, mileage: mileageType, pk: number) {
    this.no = 0;
    this.is_togo = orderObject.order_is_togo;
    this.timestamp = new Date();
    this.foods = orderObject.order_foods;
    this.price = orderObject.order_price;
    this.discount = orderObject.order_discount;
    this.tax = Math.round((this.price * 10) / 110);

    if (orderObject.order_who !== null) {
      this.mileage = true;
    } else {
      this.mileage = false;
    }

    if (this.mileage) {
      this.mileage_id = mileage.value;
      this.mileage_type = mileage.type;
      this.mileage_value = mileage.mileage;
    }

    this.payment_type = orderObject.order_type;

    this.barcode = Math.floor(Math.random() * 10 ** 16);
    this.waitCount = pk;
  }
}

const initSessionStorage = () => {
  let couponArray = sessionStorage.getItem('couponArray');
  if (couponArray !== null && couponArray !== undefined) {
    detailedFetch('/green_kiosk/api/kiosk/purchase/coupon/expire', 'POST', encodeURIComponent(couponArray));
  }
  sessionStorage.removeItem('basketArray');
  sessionStorage.removeItem('couponArray');
  sessionStorage.removeItem('mileage');
  sessionStorage.removeItem('order');
  sessionStorage.removeItem('coupon');
  sessionStorage.removeItem('mobile');
  sessionStorage.removeItem('bag');
  sessionStorage.removeItem('shop');
  sessionStorage.removeItem('smile');
  sessionStorage.removeItem('card');
};

const handleClickCancleRecipie = () => {
  initSessionStorage();
  location.href = '../KIOSK/kiosk.jsp';
};

const handleClickOkRecipie = (orderObject: orderType, element: HTMLElement, pk: number) => {
  const mileage = JSON.parse(sessionStorage.getItem('mileage'));

  const recipie = new Recipie(orderObject, mileage, pk);
  // element에 영수증 출력해서 보여주기
  let html = '';
  html += `<div class='colbox' style='width:400px;'>`;

  html += `<span style='font-size: 0.8rem'>[ 무&nbsp;&nbsp;&nbsp;&nbsp;인 ]</span>`;
  html += `<span style='font-size: 1.2rem'>대기번호</span>`;
  html += `<span style='font-size: 1.2rem'>${recipie.waitCount}</span>`;
  html += `<span style='font-size: 1.2rem'>[&nbsp;${recipie.is_togo ? '매장 식사' : '포장 주문'}&nbsp;]</span>`;

  html += `<span>---------------------------------------------------------------------------</span>`;
  html += `<div class='rowbox' style='justify-content:space-between'>`;
  html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
  html += `<span>제품명</span>`;
  html += `<span>단가</span>`;
  html += `</div>`;
  html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
  html += `<span>수량</span>`;
  html += `<span>금액</span>`;
  html += `</div>`;
  html += `</div>`;
  html += `<span>---------------------------------------------------------------------------</span>`;

  for (let i = 0; i < recipie.foods.length; i++) {
    const food = recipie.foods[i] as any;
    html += `<div class='rowbox' style='justify-content:space-between'>`;
    html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
    html += `<span>${food.name}</span>`;
    html += `<span>${food.price}</span>`;
    html += `</div>`;
    html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
    html += `<span>${food.amount}</span>`;
    html += `<span>${food.price * food.amount}</span>`;
    html += `</div>`;
    html += `</div>`;
  }

  html += `<span>---------------------------------------------------------------------------</span>`;
  html += `<div class='rowbox' style='justify-content:space-between'>`;
  html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
  html += `<span>총 합 계</span>`;
  html += `<span>${recipie.price}</span>`;
  html += `</div>`;
  html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
  html += `<span>할   인</span>`;
  html += `<span>${recipie.discount}</span>`;
  html += `</div>`;
  html += `</div>`;
  html += `<div class='rowbox' style='justify-content:space-between'>`;
  html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
  html += `<span>과세금액</span>`;
  html += `<span>${recipie.price - recipie.tax}</span>`;
  html += `</div>`;
  html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
  html += `<span>부가세</span>`;
  html += `<span>${recipie.tax}</span>`;
  html += `</div>`;
  html += `</div>`;
  html += `<div class='rowbox' style='justify-content:space-between'>`;
  html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
  html += `<span>청구금액</span>`;
  html += `<span>${recipie.price - recipie.tax}</span>`;
  html += `</div>`;
  html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
  html += `<span>받 은 돈</span>`;
  html += `<span>${recipie.price}</span>`;
  html += `</div>`;
  html += `</div>`;
  html += `<span>---------------------------------------------------------------------------</span>`;
  if (recipie.mileage) {
    html += `<div class='rowbox' style='justify-content:space-between'>`;
    html += `<div class='rowbox' style='justify-content:space-between;width:220px'>`;
    html += `<span>마일리지</span>`;
    html += `<span>${recipie.mileage_id}</span>`;
    html += `</div>`;
    html += `<div class='rowbox' style='justify-content:space-between;width:170px'>`;
    html += `<span>적립POINT</span>`;
    html += `<span>${Math.floor((recipie.price - recipie.discount) / 100)}</span>`;
    html += `</div>`;
    html += `</div>`;
    html += `<span>---------------------------------------------------------------------------</span>`;
  }
  html += `<span>${recipie.payment_type}</span>`;
  html += `<span>---------------------------------------------------------------------------</span>`;
  html += `<canvas class="canvas"></canvas>`;
  html += `<div class="payment-cancle" onClick="handleClickCancleRecipie()">닫기</div>`;

  html += `</div>`;

  element.innerHTML = html;

  const canvas = document.querySelector('.canvas') as HTMLCanvasElement;

  const canvasCtx = canvas.getContext('2d');

  const barcode = new Barcode(recipie.barcode, canvasCtx, 400, 140);

  initSessionStorage();
};

let insertOrder_g = null;

const getPk = async () => {
  // fetch 함수를 불러오는 타이밍을 알 수 없어서 따로 선언
  try {
    const response = await fetch('/green_kiosk/api/kiosk/purchase/order/primary-key', {
      method: 'GET',
      mode: 'cors',
      cache: 'no-cache',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
      },
      redirect: 'follow',
      referrerPolicy: 'no-referrer',
    });

    if (!response.ok) {
      throw new Error(`Network response was not ok: ${response.statusText}`);
    }
    const json: fetchOrderType = await response.json();

    insertOrder_g = json.body.primaryKey + 1;
  } catch (error) {
    // 네트워크 오류 및 JSON 파싱 오류에 대한 예외 처리
    console.error('Fetch error:', error);
  }
};

const element_g = document.querySelector('.modal__content') as HTMLElement;
const orderObject_g = JSON.parse(sessionStorage.getItem('order'));

(() => {
  setTimeout(() => {
    getPk();
  }, 100);
})();
