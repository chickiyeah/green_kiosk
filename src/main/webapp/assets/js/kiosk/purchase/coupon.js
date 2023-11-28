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
var couponRegex = /^[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}$/;
var handleKeypad = function (num) {
    var input = document.querySelector('#couponCode');
    var length = input.value.length;
    var temp = '';
    if (length < 19) {
        if ((length + 1) % 5 === 0) {
            temp = '-';
        }
        input.value += temp + num;
    }
};
var generateCouponHTML = function (arr) {
    var couponHTML = '';
    if (arr && arr.length > 0) {
        document.getElementById('couponDOM2').style.display = 'inline-block';
        for (var i = 0; i < arr.length; i++) {
            couponHTML += "<div class='rowbox' style='border: solid #ddd; border-width: 0 0 2px 0; align-self: center; padding: 3px 0;'>";
            couponHTML += "<span style='width: 200px;'>" + arr[i].name + "</span>";
            couponHTML += "</div>";
        }
    }
    else {
        document.getElementById('couponDOM2').style.display = 'none';
    }
    var couponElement = document.getElementById('couponDOM');
    couponElement.innerHTML = couponHTML;
};
(function () {
    var couponArray = [];
    var couponItem = sessionStorage.getItem('couponArray');
    if (couponItem !== null && couponItem !== undefined) {
        couponArray = JSON.parse(sessionStorage.getItem('couponArray'));
    }
    generateCouponHTML(couponArray);
})();
var handleClickCancle2 = function () {
    var couponItem = sessionStorage.getItem('couponArray');
    if (couponItem === null || couponItem === undefined) {
        sessionStorage.setItem('coupon', JSON.stringify(false));
    }
    location.href = 'main.jsp';
};
var clearKeypad = function () {
    var input = document.querySelector('#couponCode');
    input.value = '';
};
var handleCouponForm = function () { return __awaiter(_this, void 0, void 0, function () {
    var couponCodeElement, couponCode, couponTextElement_1, coupon, fetchCoupon, couponItem, couponArray, body, couponTextElement_2;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                couponCodeElement = document.querySelector('#couponCode');
                couponCode = couponCodeElement.value;
                if (!!couponRegex.test(couponCode)) return [3 /*break*/, 1];
                couponTextElement_1 = document.getElementById('couponText');
                couponTextElement_1.innerHTML = '<span style="color: red;">올바르지 않은 쿠폰 코드입니다.</span>';
                setTimeout(function () {
                    couponTextElement_1.innerHTML = '할인 쿠폰 코드를 입력해 주세요.';
                }, 3000);
                return [3 /*break*/, 3];
            case 1:
                couponCode = couponCode.replace(/-/g, '');
                coupon = {
                    'code': couponCode,
                };
                return [4 /*yield*/, detailedFetch('/green_kiosk/api/kiosk/purchase/coupon', 'POST', encodeURIComponent(JSON.stringify(coupon)))];
            case 2:
                fetchCoupon = _a.sent();
                if (fetchCoupon.result) {
                    couponItem = sessionStorage.getItem('couponArray');
                    couponArray = [];
                    body = fetchCoupon.body;
                    if (couponItem !== null && couponItem !== undefined) {
                        couponArray = JSON.parse(sessionStorage.getItem('couponArray'));
                        couponArray.push(body);
                    }
                    else {
                        couponArray = [body];
                    }
                    sessionStorage.setItem('couponArray', JSON.stringify(couponArray));
                    generateCouponHTML(couponArray);
                    couponCodeElement.value = '';
                }
                else {
                    couponTextElement_2 = document.getElementById('couponText');
                    if (fetchCoupon.body === 'invalid') {
                        couponTextElement_2.innerHTML = '<span style="color: red;">유효하지 않은 쿠폰입니다.</span>';
                    }
                    else if (fetchCoupon.body === 'over-time') {
                        couponTextElement_2.innerHTML = '<span style="color: red;">현재 사용 불가능한 쿠폰입니다.</span>';
                    }
                    setTimeout(function () {
                        couponTextElement_2.innerHTML = '할인 쿠폰 코드를 입력해 주세요.';
                    }, 3000);
                }
                _a.label = 3;
            case 3: return [2 /*return*/];
        }
    });
}); };
