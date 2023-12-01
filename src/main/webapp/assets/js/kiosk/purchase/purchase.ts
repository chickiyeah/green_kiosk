const purchase = async (type: string) => {
  const element = document.querySelector('modal__message') as HTMLElement;
  const orderObject = JSON.parse(sessionStorage.getItem('order'));
  orderObject.order_type = type;
  if (type === 'kakao') {
    const href = 'https://nodove.duckdns.org/green_kiosk/kakao_pay?';
    let params = 'foods=';
    const foods = orderObject.order_foods.map((v) => {
      return {
        name: v.name,
        price: v.price,
        amount: v.amount,
      };
    });
    params += encodeURIComponent(JSON.stringify(foods));
    location.href = href + params;
  } else {
    const insertOrder: fetchOrderType = await detailedFetch(
      '/green_kiosk/api/kiosk/purchase/order',
      'POST',
      encodeURIComponent(JSON.stringify(orderObject)),
    );
    if (insertOrder.result) {
      const mile_type =
        orderObject.order_add_mile && orderObject.order_use_mile
          ? 'both'
          : orderObject.order_add_mile && !orderObject.order_use_mile
          ? 'add'
          : orderObject.order_use_mile && !orderObject.order_add_mile
          ? 'use'
          : 'none';
      if (orderObject.order_who !== null) {
        const mile_log = {
          mem_uid: String(orderObject.order_who),
          mile_type,
          mile_reason: 'order',
          mile_deff: orderObject.order_add_amount,
          mile_order_no: insertOrder.body.primaryKey,
          mile_timestamp: new Date(),
        };
        console.table(mile_log);
        const insertMileage = await detailedFetch(
          '/green_kiosk/api/kiosk/milelogs',
          'POST',
          encodeURIComponent(JSON.stringify(mile_log)),
        );
        if (insertMileage.result) {
          location.href = 'finally.jsp';
        } else {
          element.innerHTML = `<span style='color: red;'>마일리지 정산에 실패했습니다.</span>`;
          setTimeout(() => {
            location.href = 'main.jsp';
          }, 2500);
        }
      } else {
        location.href = 'finally.jsp';
      }
    } else {
      element.innerHTML = `<span style='color: red;'>주문에 실패했습니다.</span>`;
      setTimeout(() => {
        location.href = 'main.jsp';
      }, 2500);
    }
  }
};
