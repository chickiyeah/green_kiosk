var menuType = "all";
var priceSumdaily = [0,0,0,0,0,0,0];
var priceSumDate = ['','','','','','',''];

function updateMenu(menuType) {
    document.cookie = "menuType=" + menuType;
    $.ajax({
        type: "POST",
        url: "./index/getMenuData?type=" + menuType,
        dataType: "json",
        data: {
            type: menuType
        },
        contentType: "application/json; charset=UTF-8",
        success: function (response) {
            if (response && response.length > 0) {
                // Separate concerns: processing data and updating HTML
                var { priceSumDay, priceSumWeek, priceSumMonth, foodCount, foodSales, allOrderFoods, allTime, priceSumdaily } = processMenuData(response);
                
				
				let	totalAmountByNameCookie = getCookieValue("totalAmountByName");
				let totalAmountByNameCookieObject = JSON.parse(totalAmountByNameCookie);
				
				let totalAmountByNameFromCookie =  new Map(Object.entries(totalAmountByNameCookieObject));
				totalAmountByNameFromCookie.forEach((value, key) => {
				});
                // Update HTML
                updateHTML(priceSumDay, priceSumWeek, priceSumMonth, priceSumdaily);

            } else {
                console.error("No data received or data is empty.");
            }
        },

        error: function (xhr, status, error) {
            console.error("Ajax request failed:", status, error);
        }
    });
}

function processMenuData(response) {
    var foodSales = {};
    var foodCount = {};
    var priceSumDay = 0;
    var priceSumWeek = 0;
    var priceSumMonth = 0;
    var priceSumYear = 0;
    var allOrderFoods = [];
    var allTime = [];
    var currentDate = new Date().toISOString().slice(0, 10);
	var currentDay = new Date(currentDate).getDay();
	
	var daysOfWeek = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
	var dayOfWeekString = daysOfWeek[currentDay];
	
    for (var i = 0; i < response.length; i++) {
        var order_time = response[i].order_time;
        var orderDate = new Date(order_time).toISOString().slice(0, 10);
        var order_price = response[i].order_price;
	    var order_foods = response[i].order_foods; // 주문 음식 정보를 JSON으로 파싱
       allOrderFoods.push(order_foods);
       allTime.push(order_time);   
	    var orderDay = new Date(orderDate).getDay();
	    
	    
        if (orderDate == currentDate) {
            priceSumDay += order_price;
		} 
		
        if (dateDiff(orderDate, currentDate) >= 0 && dateDiff(orderDate, currentDate) < 7) {
            priceSumWeek += order_price;
      		  if (!priceSumDate.includes(orderDate)) {
        			priceSumDate[orderDay] = orderDate; 
        			}
            priceSumdaily[orderDay] += order_price;
        }
		
        if (dateDiff(orderDate, currentDate) >= 0 && dateDiff(orderDate, currentDate) <= 30) {
            priceSumMonth += order_price;
        }
        
        
    }   
    return { priceSumDay, priceSumWeek, priceSumMonth, foodCount, foodSales, allOrderFoods, allTime, priceSumdaily };
}

function updateHTML(priceSumDay, priceSumWeek, priceSumMonth, totalAmountByNameFromCookie) {
var htmlTemplate =
    '<div class="col-xl-3 col-md-6 mb-4">' +
    createCard2('일일 매출', priceSumDay) +
    '</div>' +
    '<div class="col-xl-3 col-md-6 mb-4">' +
    createCard2('주간 매출', priceSumWeek) +
    '</div>' +
    '<div class="col-xl-3 col-md-6 mb-4">' +
    createCard2('월간 매출', priceSumMonth) +
    '</div>';
    $('.getMenuList').empty().html(htmlTemplate);
}



window.addEventListener('DOMContentLoaded', function() {
    updateMenu(menuType);
});


function formatNumber(number) {
    // 숫자를 3자리마다 쉼표로 구분
    var df = new Intl.NumberFormat('ko-KR');
    return df.format(number);
}

function dateDiff(start_date, end_date) {
    let startDate = new Date(start_date);
    let endDate = new Date(end_date);

    let diffInMonths = (endDate.getFullYear() - startDate.getFullYear()) * 12 + endDate.getMonth() - startDate.getMonth();

    // Adjust for day differences
    let startDateCopy = new Date(startDate.getTime());
    startDateCopy.setMonth(startDateCopy.getMonth() + diffInMonths);

    if (startDateCopy > endDate) {
        diffInMonths--;
    }

    // Calculate the remaining days
    let daysInMonth = new Date(endDate.getFullYear(), endDate.getMonth() + 1, 0).getDate();
    let remainingDays = (endDate - startDateCopy) / (1000 * 60 * 60 * 24);

    return diffInMonths * daysInMonth + remainingDays;
}


function createCard(title, amount) {
    return (
        '<div class="card border-left-warning shadow h-100 py-1">' +
        '<div class="card-body">' +
        '<div class="row no-gutters align-items-center">' +
        '<div class="col mr-2">' +
        `<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">${title}</div><br/><div>${formatNumber(amount)} 원 </div>` +
        '<div class="h5 mb-0 font-weight-bold text-gray-800"></div>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>'
    );
}

function createCard2(title, amount) {
    return (
        `<div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">${title}</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800">${formatNumber(amount)} 원</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>`
    );
}




	
function openPopup(url) {
  var popupWidth = 500;
  var popupHeight = 300;
  var popupX = (window.screen.width/2) - (popupWidth/2);
  var popupY = (window.screen.height/2) - (popupHeight/2);
  var popup = window.open(url, 'PopupWindow', 'width=popupWidth, height=popupHeight, scrollbars=yes, left=popupX, top=popupY');
}


function getCookieValue(cookieName) {
	const name = cookieName + "=";
	const decodedCookie = decodeURIComponent(document.cookie);
	const cookieArray = decodedCookie.split(';');
		
	for (let i = 0; i < cookieArray.length; i++) {
		let cookie = cookieArray[i].trim();
		if (cookie.indexOf(name) === 0) {
			return cookie.substring(name.length, cookie.length);
		}
	}
	return "";
}

function cookieSeparate(cookieObject) {
    const keyValuePairs = Array.from(cookieObject.entries()).map(([key, value]) => `${key}: ${value}`);
    
    // Join the array into a single string
    return keyValuePairs.join("<br>");
}
