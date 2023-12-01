var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
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
var PurchaseException = /** @class */ (function (_super) {
    __extends(PurchaseException, _super);
    function PurchaseException(reason) {
        var _this = _super.call(this) || this;
        _this.name = 'PurchaseException';
        _this.reason = reason;
        if (Error.captureStackTrace) {
            // Chrome and NodeJS
            Error.captureStackTrace(_this, PurchaseException);
        }
        else {
            // FF, IE 10+ and Safari 6+. Fallback for others
            _this.stack = new Error().stack || '';
        }
        return _this;
    }
    PurchaseException.prototype.toString = function () {
        return this.name + ': ' + this.reason;
    };
    return PurchaseException;
}(Error));
var State = /** @class */ (function () {
    function State() {
        this.time = new Date();
        this.foods = null;
        this.price = 0;
        this.discount = 0;
        this.coupon = null;
        this.type = null;
        this.use_mile = false;
        this.use_mile_amount = 0;
        this.add_mile = false;
        this.add_mile_amount = 0;
        this.is_maked = false;
        this.who = null;
        this.is_togo = null;
    }
    State.prototype.calcurPrice = function () {
        if (this.foods) {
            this.price = this.foods.reduce(function (acc, cur) {
                return acc + cur.amount * cur.price;
            }, 0);
        }
    };
    State.prototype.calcurDiscount = function () {
        if (this.foods) {
            this.discount = this.foods.reduce(function (arr, cur) {
                if (cur.hasOwnProperty('discount')) {
                    return arr + cur.discount;
                }
                else {
                    return arr;
                }
            }, 0);
        }
    };
    State.prototype.calcurCouponDiscount = function () {
        var _this = this;
        if (this.foods) {
            this.coupon.forEach(function (couponValue) {
                _this.foods.forEach(function (foodValue) {
                    if (Number(couponValue.menuNo) === Number(foodValue.index)) {
                        var sum = ((foodValue.price * foodValue.amount) / Math.floor(1000 / couponValue.discount)) * 10;
                        if ((foodValue.hasOwnProperty('discount') && foodValue.discount < sum) ||
                            !foodValue.hasOwnProperty('discount')) {
                            foodValue.discount = sum;
                        }
                    }
                });
            });
        }
    };
    State.prototype.calcurEventDiscount = function (eventMenuArray) {
        var _this = this;
        if (this.foods) {
            eventMenuArray.forEach(function (eventValue) {
                _this.foods.forEach(function (foodValue) {
                    if (eventValue.menuNo === foodValue.index) {
                        var sum = ((foodValue.price * foodValue.amount) / Math.floor(1000 / eventValue.discount)) * 10;
                        if ((foodValue.hasOwnProperty('discount') && foodValue.discount < sum) ||
                            !foodValue.hasOwnProperty('discount')) {
                            foodValue.discount = sum;
                        }
                    }
                });
            });
        }
    };
    State.prototype.toObject = function () {
        var foods = this.foods;
        if (foods === null) {
            foods = '';
        }
        return {
            order_time: this.time,
            order_foods: foods,
            order_price: this.price,
            order_discount: this.discount,
            order_coupon: this.coupon,
            order_type: this.type,
            order_use_mile: this.use_mile,
            order_use_amount: this.use_mile_amount,
            order_add_mile: this.add_mile,
            order_add_amount: this.add_mile_amount,
            order_is_maked: this.is_maked,
            order_who: this.who,
            order_is_togo: this.is_togo,
        };
    };
    return State;
}());
var Item = /** @class */ (function () {
    function Item(storage) {
        this.store = storage;
    }
    Item.prototype.get = function (str) {
        return this.store.getItem(str) === null ? null : this.store.getItem(str);
    };
    Item.prototype.set = function (str, data) {
        this.store.setItem(str, data);
    };
    return Item;
}());
var SVG_PATH = '../../assets/svg/';
var ARRAY_ICONS = ['bag', 'shop', 'coupon', 'smile', 'card', 'mobile'];
var ARRAY_HREF_ICONS = ['coupon', 'smile'];
var ARRAY_PAY_ICONS = ['card', 'mobile'];
var ARRAY_TOGO_ICONS = ['bag', 'shop'];
var PAIRS_ICONS = [
    ['bag', 'shop'],
    ['card', 'mobile'],
];
var state = new State(); // 데이터를 저장해서 페이지를 벗어나기 전까지 DOM과 상호작용 하기 위해 페이지 스코프를 줍니다.
var item = new Item(sessionStorage);
var formatSVGPath = function (str) {
    var svg = SVG_PATH + str + '.svg';
    return svg;
};
var inputDigits = function (num) {
    var str = num.toString();
    var length = str.length;
    var result = [];
    var j = 0;
    for (var k = length - 1; k >= 0; k--) {
        j++;
        result.push(str[k]);
        if (j % 3 === 0 && k !== 0)
            result.push(',');
    }
    return result.reverse().join('');
};
var drawArrayToHTMLElement = function (element, arr, drawCallback) {
    if (arr == null) {
        element.innerHTML = 'null';
    }
    else {
        var html = drawCallback(arr);
        element.innerHTML = html;
    }
};
var generateBasketPageHTML = function (arr, page) {
    if (page === void 0) { page = 0; }
    var html = '';
    var divCountValue = 10 * page;
    for (var i = 0 + divCountValue; i < 10 + divCountValue; i++) {
        html += "<div class='basket'>";
        html += "<span style='width: 100px;'>" + (i < arr.length ? arr[i].name : '&nbsp;') + "</span>";
        html += "<span style='width: 40px;'>" + (i < arr.length ? arr[i].amount : '&nbsp;') + "</span>";
        html += "<span style='width: 70px;'>" + (i < arr.length ? inputDigits(arr[i].price) : '&nbsp;') + "</span>";
        html += "</div>";
    }
    return html;
};
var generateBasketPageButtonHTML = function (arr) {
    var html = '';
    var pages = Math.ceil(arr.length / 10);
    for (var i = 1; i <= pages; i++) {
        html +=
            "<div class='purchase-page-button-main'" +
                "onClick='generateBasketPageHTML(state.foods, " +
                i +
                ")'>" +
                i +
                "</div>";
    }
    return html;
};
var drawPriceToHTMLElement = function (str, text, value) {
    document.querySelector(str).innerHTML =
        '<div class="flex-between">' +
            '<span class="price-name">' +
            text +
            ': </span>' +
            '<span class="price-value">' +
            inputDigits(value) +
            '</span>' +
            '</div>';
};
var handleClickCancle = function () {
    location.href = ''; //TODO: 장바구니 url
};
var isExistSessionStorage = function (str) {
    return item.get(str);
};
var parseJsonSessionStorage = function (str) {
    return JSON.parse(item.get(str));
};
var InitializeBasketHTML = function (str, foods) {
    drawArrayToHTMLElement(document.querySelector("".concat(str, "Element")), foods, generateBasketPageHTML);
    drawArrayToHTMLElement(document.querySelector("".concat(str, "ButtonElement")), foods, generateBasketPageButtonHTML);
};
(function () { return __awaiter(_this, void 0, void 0, function () {
    var couponArray, eventArray, eventMenuArray, mileage, mileAmount;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                state.foods = parseJsonSessionStorage('basketArray');
                InitializeBasketHTML('#basketPage', state.foods);
                if (!isExistSessionStorage('couponArray')) return [3 /*break*/, 2];
                return [4 /*yield*/, detailedFetch('/green_kiosk/api/kiosk/purchase/couponArray', 'POST', encodeURIComponent(item.get('couponArray')))];
            case 1:
                couponArray = _a.sent();
                state.coupon = couponArray.result ? couponArray.body : null;
                state.calcurCouponDiscount();
                _a.label = 2;
            case 2: return [4 /*yield*/, detailedFetch('/green_kiosk/api/kiosk/purchase/event', 'GET')];
            case 3:
                eventArray = _a.sent();
                if (!eventArray.result) return [3 /*break*/, 5];
                return [4 /*yield*/, detailedFetch('/green_kiosk/api/kiosk/purchase/eventMenu', 'POST', encodeURIComponent(JSON.stringify(eventArray.body.map(function (v) {
                        return v.no;
                    }))))];
            case 4:
                eventMenuArray = _a.sent();
                state.calcurEventDiscount(eventMenuArray);
                _a.label = 5;
            case 5:
                state.calcurPrice();
                drawPriceToHTMLElement('#priceElement', '주문금액', state.price);
                state.calcurDiscount();
                if (!isExistSessionStorage('mileage')) return [3 /*break*/, 7];
                return [4 /*yield*/, detailedFetch('/green_kiosk/api/kiosk/purchase/mileage', 'POST', encodeURIComponent(JSON.stringify(item.get('mileage'))))];
            case 6:
                mileage = _a.sent();
                if (mileage.result) {
                    mileAmount = Math.floor((state.price - state.discount) / 100);
                    state.add_mile = true;
                    state.add_mile_amount = mileAmount;
                    drawPriceToHTMLElement('#mileageElement', '적립마일리지', state.add_mile_amount);
                    if (mileage.body.type === 'cardNumber') {
                        state.use_mile = mileage.body.type === 'cardNumber' ? true : false;
                        state.use_mile_amount = mileAmount;
                        state.discount = state.discount + mileAmount;
                    }
                    state.who = mileage.body.index.toString();
                }
                _a.label = 7;
            case 7:
                drawPriceToHTMLElement('#discountElement', '할인금액', state.discount);
                drawPriceToHTMLElement('#discountedPriceElement', '결제할금액', state.price - state.discount);
                ARRAY_ICONS.forEach(function (value) {
                    var element = document.querySelector('#' + value);
                    element.src =
                        item.get(value) === null
                            ? formatSVGPath(value)
                            : JSON.parse(item.get(value)) === false
                                ? formatSVGPath(value)
                                : formatSVGPath('check');
                });
                return [2 /*return*/];
        }
    });
}); })();
var swapIcon = function (str) {
    var element = document.querySelector('#' + str);
    var boolean = false;
    boolean = item.get(str) === null ? false : JSON.parse(item.get(str)) === false ? false : true;
    boolean = !boolean;
    var togglePairIcon = function (icon1, icon2) {
        if (str === icon1 && JSON.parse(item.get(icon2)) === true) {
            item.set(icon2, JSON.stringify(false));
            var pairElement = document.querySelector('#' + icon2);
            pairElement.src = formatSVGPath(icon2);
        }
    };
    if (boolean) {
        for (var _i = 0, PAIRS_ICONS_1 = PAIRS_ICONS; _i < PAIRS_ICONS_1.length; _i++) {
            var pair = PAIRS_ICONS_1[_i];
            togglePairIcon(pair[0], pair[1]);
            togglePairIcon(pair[1], pair[0]);
        }
    }
    element.src = boolean ? formatSVGPath('check') : formatSVGPath(str);
    item.set(str, JSON.stringify(boolean));
};
var handleClickIcon = function (str) {
    swapIcon(str);
    for (var _i = 0, ARRAY_HREF_ICONS_1 = ARRAY_HREF_ICONS; _i < ARRAY_HREF_ICONS_1.length; _i++) {
        var icon = ARRAY_HREF_ICONS_1[_i];
        if (str === icon)
            location.href = icon + '.jsp';
    }
};
var allOpionSelected = function () {
    for (var _i = 0, PAIRS_ICONS_2 = PAIRS_ICONS; _i < PAIRS_ICONS_2.length; _i++) {
        var pair = PAIRS_ICONS_2[_i];
        if (!item.get(pair[0]) && !item.get(pair[1])) {
            return false;
        }
    }
    return true;
};
var changeLoreForOptionNotSelected = function () {
    var _loop_1 = function (i) {
        if (!item.get(PAIRS_ICONS[i][0]) || !item.get(PAIRS_ICONS[i][1])) {
            var element_1 = document.querySelector('#icon-' + i.toString());
            var originValue_1 = element_1.innerHTML;
            element_1.innerHTML = '<span style="color: red;">둘 중 하나를 선택해 주세요.</span>';
            setTimeout(function () {
                element_1.innerHTML = originValue_1;
            }, 2500);
        }
    };
    for (var i = 1; i <= PAIRS_ICONS.length; i++) {
        _loop_1(i);
    }
};
var handleClickOk = function () { return __awaiter(_this, void 0, void 0, function () {
    var orderObject;
    return __generator(this, function (_a) {
        if (allOpionSelected()) {
            if (item.get(ARRAY_PAY_ICONS[0]) || item.get(ARRAY_PAY_ICONS[1])) {
                state.type =
                    item.get(ARRAY_PAY_ICONS[0]) && JSON.parse(item.get(ARRAY_PAY_ICONS[0]))
                        ? ARRAY_PAY_ICONS[0]
                        : ARRAY_PAY_ICONS[1];
            }
            else {
                throw new PurchaseException('Unexpected error: item.get(icon) has null');
            }
            if (item.get(ARRAY_TOGO_ICONS[0]) || item.get(ARRAY_TOGO_ICONS[1])) {
                state.is_togo = item.get(ARRAY_TOGO_ICONS[0]) && JSON.parse(item.get(ARRAY_TOGO_ICONS[0])) ? false : true;
            }
            else {
                throw new PurchaseException('Unexpected error: item.get(icon) has null');
            }
            orderObject = state.toObject();
            item.set('order', JSON.stringify(orderObject));
            location.href = state.type + '.jsp';
        }
        else {
            changeLoreForOptionNotSelected();
        }
        return [2 /*return*/];
    });
}); };
