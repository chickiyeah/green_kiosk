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
var BARCODE_DICTIONARY = {
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
var Barcode = /** @class */ (function () {
    function Barcode(code, ctx, x, y) {
        this.ctx = ctx;
        this.ctx.canvas.width = x;
        this.ctx.canvas.height = y;
        this.code = typeof code === 'number' ? code.toString() : code;
        this.destructCode();
        this.size = { x: x, y: y };
        this.draw();
    }
    Barcode.prototype.destructCode = function () {
        this.lines = [];
        for (var i = 0; i < this.code.length; i++) {
            var digit = parseInt(this.code[i]);
            if (BARCODE_DICTIONARY[digit]) {
                this.lines.push(BARCODE_DICTIONARY[digit]);
            }
        }
    };
    Barcode.prototype.draw = function () {
        for (var i = 0; i < this.lines.length; i++) {
            for (var j = 0; j < 6; j++) {
                var lineCount = this.size.x / (this.code.length * 6);
                var x = lineCount * (i * 6 + j);
                var y = 0;
                var width = lineCount;
                var height = this.size.y - Math.round(this.size.y / 4);
                if (this.lines[i][j]) {
                    this.ctx.fillRect(x, y, width, height);
                }
                if (j === 2) {
                    var textX = x + width / 2;
                    var textY = this.size.y - Math.round(this.size.y / 7);
                    this.ctx.font = "".concat(Math.round(this.size.y / 8.5), "px SUIT Variable");
                    this.ctx.fillText(this.code[i], textX, textY);
                }
            }
        }
    };
    return Barcode;
}());
var Recipie = /** @class */ (function () {
    function Recipie(orderObject, mileage, pk) {
        this.no = 0;
        this.is_togo = orderObject.order_is_togo;
        this.timestamp = new Date();
        this.foods = orderObject.order_foods;
        this.price = orderObject.order_price;
        this.discount = orderObject.order_discount;
        this.tax = Math.round((this.price * 10) / 110);
        if (orderObject.order_who !== null) {
            this.mileage = true;
        }
        else {
            this.mileage = false;
        }
        if (this.mileage) {
            this.mileage_id = mileage.value;
            this.mileage_type = mileage.type;
            this.mileage_value = mileage.mileage;
        }
        this.payment_type = orderObject.order_type;
        this.barcode = Math.floor(Math.random() * Math.pow(10, 16));
        this.waitCount = pk;
    }
    return Recipie;
}());
var initSessionStorage = function () {
    var couponArray = sessionStorage.getItem('couponArray');
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
var handleClickCancleRecipie = function () {
    initSessionStorage();
    location.href = 'main.jsp';
};
var handleClickOkRecipie = function (orderObject, element, pk) {
    var mileage = JSON.parse(sessionStorage.getItem('mileage'));
    var recipie = new Recipie(orderObject, mileage, pk);
    // element에 영수증 출력해서 보여주기
    var html = '';
    html += "<div class='colbox' style='width:400px;'>";
    html += "<span style='font-size: 0.8rem'>[ \uBB34&nbsp;&nbsp;&nbsp;&nbsp;\uC778 ]</span>";
    html += "<span style='font-size: 1.2rem'>\uB300\uAE30\uBC88\uD638</span>";
    html += "<span style='font-size: 1.2rem'>".concat(recipie.waitCount, "</span>");
    html += "<span style='font-size: 1.2rem'>[&nbsp;".concat(recipie.is_togo ? '매장 식사' : '포장 주문', "&nbsp;]</span>");
    html += "<span>---------------------------------------------------------------------------</span>";
    html += "<div class='rowbox' style='justify-content:space-between'>";
    html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
    html += "<span>\uC81C\uD488\uBA85</span>";
    html += "<span>\uB2E8\uAC00</span>";
    html += "</div>";
    html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
    html += "<span>\uC218\uB7C9</span>";
    html += "<span>\uAE08\uC561</span>";
    html += "</div>";
    html += "</div>";
    html += "<span>---------------------------------------------------------------------------</span>";
    for (var i = 0; i < recipie.foods.length; i++) {
        var food = recipie.foods[i];
        html += "<div class='rowbox' style='justify-content:space-between'>";
        html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
        html += "<span>".concat(food.name, "</span>");
        html += "<span>".concat(food.price, "</span>");
        html += "</div>";
        html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
        html += "<span>".concat(food.amount, "</span>");
        html += "<span>".concat(food.price * food.amount, "</span>");
        html += "</div>";
        html += "</div>";
    }
    html += "<span>---------------------------------------------------------------------------</span>";
    html += "<div class='rowbox' style='justify-content:space-between'>";
    html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
    html += "<span>\uCD1D \uD569 \uACC4</span>";
    html += "<span>".concat(recipie.price, "</span>");
    html += "</div>";
    html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
    html += "<span>\uD560   \uC778</span>";
    html += "<span>".concat(recipie.discount, "</span>");
    html += "</div>";
    html += "</div>";
    html += "<div class='rowbox' style='justify-content:space-between'>";
    html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
    html += "<span>\uACFC\uC138\uAE08\uC561</span>";
    html += "<span>".concat(recipie.price - recipie.tax, "</span>");
    html += "</div>";
    html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
    html += "<span>\uBD80\uAC00\uC138</span>";
    html += "<span>".concat(recipie.tax, "</span>");
    html += "</div>";
    html += "</div>";
    html += "<div class='rowbox' style='justify-content:space-between'>";
    html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
    html += "<span>\uCCAD\uAD6C\uAE08\uC561</span>";
    html += "<span>".concat(recipie.price - recipie.tax, "</span>");
    html += "</div>";
    html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
    html += "<span>\uBC1B \uC740 \uB3C8</span>";
    html += "<span>".concat(recipie.price, "</span>");
    html += "</div>";
    html += "</div>";
    html += "<span>---------------------------------------------------------------------------</span>";
    if (recipie.mileage) {
        html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
        html += "<span>\uB9C8\uC77C\uB9AC\uC9C0</span>";
        html += "<span>".concat(recipie.mileage_id, "</span>");
        html += "</div>";
        html += "<div class='rowbox' style='justify-content:space-between;width:170px'>";
        html += "<span>\uC801\uB9BDPOINT</span>";
        html += "<span>".concat(Math.floor(recipie.price - recipie.discount) / 100, "</span>");
        html += "</div>";
        html += "<span>---------------------------------------------------------------------------</span>";
    }
    html += "<span>".concat(recipie.payment_type, "</span>");
    html += "<span>---------------------------------------------------------------------------</span>";
    html += "<canvas class=\"canvas\"></canvas>";
    html += "<div class=\"payment-cancle\" onClick=\"handleClickCancleRecipie()\">\uB2EB\uAE30</div>";
    html += "</div>";
    element.innerHTML = html;
    var canvas = document.querySelector('.canvas');
    var canvasCtx = canvas.getContext('2d');
    var barcode = new Barcode(recipie.barcode, canvasCtx, 400, 140);
    initSessionStorage();
};
var insertOrder_g = null;
var getPk = function () { return __awaiter(_this, void 0, void 0, function () {
    var response, json, error_1;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                _a.trys.push([0, 3, , 4]);
                return [4 /*yield*/, fetch('/green_kiosk/api/kiosk/purchase/order/primary-key', {
                        method: 'GET',
                        mode: 'cors',
                        cache: 'no-cache',
                        credentials: 'same-origin',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
                        },
                        redirect: 'follow',
                        referrerPolicy: 'no-referrer',
                    })];
            case 1:
                response = _a.sent();
                if (!response.ok) {
                    throw new Error("Network response was not ok: ".concat(response.statusText));
                }
                return [4 /*yield*/, response.json()];
            case 2:
                json = _a.sent();
                insertOrder_g = json.body.primaryKey + 1;
                return [3 /*break*/, 4];
            case 3:
                error_1 = _a.sent();
                // 네트워크 오류 및 JSON 파싱 오류에 대한 예외 처리
                console.error('Fetch error:', error_1);
                return [3 /*break*/, 4];
            case 4: return [2 /*return*/];
        }
    });
}); };
var element_g = document.querySelector('.modal__content');
var orderObject_g = JSON.parse(sessionStorage.getItem('order'));
(function () {
    setTimeout(function () {
        getPk();
    }, 100);
})();
