var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var _this = this;
var phoneNumberStartRegex = /^01(0|1|6|7|8|9)/;
var handleKeypad2 = function (num) {
    var input = document.querySelector('#smileCode');
    var length = input.value.length;
    var temp = '';
    if (phoneNumberStartRegex.test(input.value) && length < 13) {
        if (length - 3 === 0) {
            var element = document.querySelector('#smileType');
            element.value = 'phoneNumber';
            temp += '-';
        }
        else if (length - 8 === 0) {
            temp += '-';
        }
        input.value += temp + num;
    }
    else if (length < 3) {
        input.value += num + '';
    }
    else if (!phoneNumberStartRegex.test(input.value) && length < 19) {
        if (length - 4 === 0) {
            var element = document.querySelector('#smileType');
            element.value = 'cardNumber';
            temp += '-';
        }
        else if ((length - 4) % 5 === 0) {
            temp += '-';
        }
        input.value += temp + num;
    }
};
var clearKeypad2 = function () {
    var input = document.querySelector('#smileCode');
    input.value = '';
};
var back = function () {
    var smileItem = sessionStorage.getItem('smile');
    if (smileItem !== null || smileItem !== undefined) {
        sessionStorage.setItem('smile', JSON.stringify(false));
    }
    location.href = 'main.jsp';
};
var smileRegex = /^01(0|1|6|7|8|9)-\d{3,4}-\d{4}$/;
var handleSmileForm = function () { return __awaiter(_this, void 0, void 0, function () {
    var smileCodeElement, smileCode, smileTypeElement, smileType, smileTextElement_1, smile, mileage, smileTextElement_2;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                smileCodeElement = document.querySelector('#smileCode');
                smileCode = smileCodeElement.value;
                smileTypeElement = document.querySelector('#smileType');
                smileType = smileTypeElement.value;
                if (!(!smileRegex.test(String(smileCode)) && smileType === 'phoneNumber')) return [3 /*break*/, 1];
                smileTextElement_1 = document.getElementById('smileText');
                smileTextElement_1.innerHTML = '<span style="color: red;">올바르지 않은 ';
                smileTextElement_1.innerHTML += '휴대폰';
                smileTextElement_1.innerHTML += ' 번호입니다.</span>';
                setTimeout(function () {
                    smileTextElement_1.innerHTML = '&nbsp;';
                }, 3000);
                return [2 /*return*/];
            case 1:
                smileCode = smileCode.replace(/-/g, '');
                smile = {
                    type: smileType,
                    value: smileCode,
                };
                return [4 /*yield*/, detailedFetch('/green_kiosk/api/kiosk/purchase/mileage', 'POST', encodeURIComponent(JSON.stringify(smile)))];
            case 2:
                mileage = _a.sent();
                if (mileage.result) {
                    sessionStorage.setItem('mileage', JSON.stringify(mileage.body));
                    location.href = 'main.jsp';
                }
                else {
                    smileTextElement_2 = document.getElementById('smileText');
                    smileTextElement_2.innerHTML = '<span style="color: red;">등록되어 있지 않은 ';
                    smileTextElement_2.innerHTML += smileType === 'cardNumber' ? '카드' : '휴대폰';
                    smileTextElement_2.innerHTML += ' 번호입니다.</span>';
                    setTimeout(function () {
                        smileTextElement_2.innerHTML = '&nbsp;';
                    }, 3000);
                }
                _a.label = 3;
            case 3: return [2 /*return*/];
        }
    });
}); };
