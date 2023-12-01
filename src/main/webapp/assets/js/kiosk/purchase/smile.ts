const phoneNumberStartRegex = /^01(0|1|6|7|8|9)/;

const handleKeypad2 = (num: number) => {
  const input = document.querySelector('#smileCode') as HTMLInputElement;
  const length = input.value.length;
  let temp = '';
  if (phoneNumberStartRegex.test(input.value) && length < 13) {
    if (length - 3 === 0) {
      const element = document.querySelector('#smileType') as HTMLInputElement;
      element.value = 'phoneNumber';
      temp += '-';
    } else if (length - 8 === 0) {
      temp += '-';
    }
    input.value += temp + num;
  } else if (length < 3) {
    input.value += num + '';
  } else if (!phoneNumberStartRegex.test(input.value) && length < 19) {
    if (length - 4 === 0) {
      const element = document.querySelector('#smileType') as HTMLInputElement;
      element.value = 'cardNumber';
      temp += '-';
    } else if ((length - 4) % 5 === 0) {
      temp += '-';
    }
    input.value += temp + num;
  }
};

const clearKeypad2 = () => {
  const input = document.querySelector('#smileCode') as HTMLInputElement;
  input.value = '';
};

const back = () => {
  const smileItem = sessionStorage.getItem('smile');

  if (smileItem !== null || smileItem !== undefined) {
    sessionStorage.setItem('smile', JSON.stringify(false));
  }

  location.href = 'main.jsp';
};

const smileRegex = /^01(0|1|6|7|8|9)-\d{3,4}-\d{4}$/;
const handleSmileForm = async () => {
  const smileCodeElement = document.querySelector('#smileCode') as HTMLInputElement;
  let smileCode = smileCodeElement.value;
  const smileTypeElement = document.querySelector('#smileType') as HTMLInputElement;
  const smileType = smileTypeElement.value;
  if (!smileRegex.test(String(smileCode)) && smileType === 'phoneNumber') {
    const smileTextElement = document.getElementById('smileText');
    smileTextElement.innerHTML = '<span style="color: red;">올바르지 않은 ';
    smileTextElement.innerHTML += '휴대폰';
    smileTextElement.innerHTML += ' 번호입니다.</span>';
    setTimeout(() => {
      smileTextElement.innerHTML = '&nbsp;';
    }, 3000);
    return;
  } else {
    smileCode = smileCode.replace(/-/g, '');
    let smile = {
      type: smileType,
      value: smileCode,
    };
    const mileage: fetchMileageType = await detailedFetch(
      '/green_kiosk/api/kiosk/purchase/mileage',
      'POST',
      encodeURIComponent(JSON.stringify(smile)),
    );

    if (mileage.result) {
      sessionStorage.setItem('mileage', JSON.stringify(mileage.body));

      location.href = 'main.jsp';
    } else {
      const smileTextElement = document.getElementById('smileText');
      smileTextElement.innerHTML = '<span style="color: red;">등록되어 있지 않은 ';
      smileTextElement.innerHTML += smileType === 'cardNumber' ? '카드' : '휴대폰';
      smileTextElement.innerHTML += ' 번호입니다.</span>';
      setTimeout(() => {
        smileTextElement.innerHTML = '&nbsp;';
      }, 3000);
    }
  }
};
