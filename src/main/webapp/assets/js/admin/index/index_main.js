var menuType = "all";
var priceSumdaily = [0,0,0,0,0,0,0];
var priceweekily = [0,0,0,0,0,0,0];
var priceSumDate = ['','','','','','',''];
var menuAmountMap = new Map();
var menuAmountTermMap = new Map();
var week_total = 0;
let allPriceSumAvg = 0;

function updateMenu(type, time) {
    $.ajax({
        type: "POST",
        url: "./index/getMenuData?type=" + type + "&time=" + time,
        dataType: "json",
        data: {
            type: menuType
        },
        contentType: "application/json; charset=UTF-8",
        success: function (response) {
            if (response && response.length > 0) {
                if (type == "all" && time == "month"){
                var { allOrderFoods} = processMenuData(response);
					var orderInfoArray = JSON.parse("[" + allOrderFoods + "]");
										
					orderInfoArray.forEach(function(order) {
				    order.forEach(function(item) {
				        var menuName = item.name;
				        var amount = parseInt(item.amount);
										        
				        if (menuAmountMap.has(menuName)) {
				            menuAmountMap.set(menuName, menuAmountMap.get(menuName) + amount);
				        } else {
				            menuAmountMap.set(menuName, amount);
				        }
				    });
				});
				                				     
				barChart3();
				barChart2();
				} else if (type == "all" && time == "all")
				{
					getAvgPrice(response);
				}
				//response if's else 
            } else {
                console.error("No data received or data is empty.");
            }
        },

        error: function (xhr, status, error) {
            console.error("Ajax request failed:", status, error);
        }
    });
}



//이번 달 고정 매출 계산 

function getindexinfo(type) {
    $.ajax({
        type: "POST",
        url: "./index/getIndexInfo?type=" + type,
        dataType: "json",
        data: {
            type: menuType
        },
        contentType: "application/json; charset=UTF-8",
        success: function (response) {
            if (response && response.length > 0) {
                if (type == "all"){
                var { priceSumDay, priceSumWeek, priceSumMonth, priceSumdaily } = processMenuData(response);
				
                // Update HTML
                
                updateHTML(priceSumDay, priceSumWeek, priceSumMonth, priceSumdaily);
				     
				} else {
					getWeekinfo();
				}
				//response if's else 
            } else {
                console.error("No data received or data is empty.");
            }
        },

        error: function (xhr, status, error) {
            console.error("Ajax request failed:", status, error);
        }
    });
}


function getWeekinfo() {
	let type = "all"
    $.ajax({
        type: "POST",
        url: "./index/getMenuData?time=week&type=" + type,
        dataType: "json",
        data: {
            type: menuType
        },
        contentType: "application/json; charset=UTF-8",
        success: function (response) {
            if (response && response.length > 0) {
                if (type == "all"){
                processMenuData(response, "week");
								     
				}
				//response if's else 
            } else {
                console.error("No data received or data is empty.");
            }
        },

        error: function (xhr, status, error) {
            console.error("Ajax request failed:", status, error);
        }
    });
}

function getAvgPrice(response)
{
	let count = 0;
	let allPriceSum = 0;
	for (let i = 0; i < response.length; i++){
		let order_price = response[i].order_price;
		
		count ++;
		allPriceSum += order_price;
	}
		allPriceSumAvg = allPriceSum / count;
}

function processMenuData(response, type) {

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
	
    for (var i = 0; i < response.length; i++) {
        var order_time = response[i].order_time;
        var orderDate = new Date(order_time).toISOString().slice(0, 10);
        var order_price = response[i].order_price;
	    var order_foods = response[i].order_foods; // 주문 음식 정보를 JSON으로 파싱
	    var order_type = response[i].order_type;
       allOrderFoods.push(order_foods);
       allTime.push(order_time);   
	    var orderDay = new Date(orderDate).getDay();

		
		 if (type == "week") {
			 if (orderDate == currentDate) {
           		 priceSumDay += order_price;
			} 
	        if (dateDiff(orderDate, currentDate) >= 0 && dateDiff(orderDate, currentDate) < 7) {
	      		  if (!priceSumDate.includes(orderDate)) {
	        			priceSumDate[orderDay] = orderDate; 
	        			}
	            priceweekily[orderDay] += order_price;
	           	priceSumWeek += order_price;
	        }
	        
	        if (dateDiff(orderDate, currentDate) >= 0 && dateDiff(orderDate, currentDate) <= 30) {
	            week_total += order_price;
	        }
		} else if (type == "term") {
			
			} else {
			 if (orderDate == currentDate) {
           		 priceSumDay += order_price;
			} 
			
			//orderDate == startDate, currentDate == endDate //
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
    }   

    return { priceSumDay, priceSumWeek, priceSumMonth, foodCount, foodSales, allOrderFoods, allTime, priceSumdaily };
}

function updateHTML(priceSumDay, week_total, priceSumMonth) {
	const pathname = "/" + window.location.pathname.split("/")[1] + "/";
	const origin = window.location.origin;
	const contextPath = origin + pathname;
var htmlTemplate =
    '<div class="col-xl-3 col-md-6 mb-4"  onclick="openPopup(\'' + contextPath + '/admin/index/sales_list.jsp?term=day' + '\')">' +
    createCard2('일일 매출', priceSumDay) +
    '</div>' +
    '<div class="col-xl-3 col-md-6 mb-4"  onclick="openPopup(\'' + contextPath + '/admin/index/sales_list.jsp?term=week' + '\')">' +
    createCard2('이번 주 매출', week_total) +
    '</div>' +
    '<div class="col-xl-3 col-md-6 mb-4" onclick="openPopup(\'' + contextPath + '/admin/index/sales_list.jsp?term=month' + '\')">' +
    createCard2('이번 달 매출', priceSumMonth) +
/*    '</div>' +
     '<div class="col-xl-3 col-md-6 mb-4">' +
    createCard3('고객 평균 지불 금액 ', allPriceSumAvg) +*/
	'</div>';
    $('.getMenuList').empty().html(htmlTemplate);
}


window.addEventListener('DOMContentLoaded', function() {
updateMenu('all', 'month');
/*updateMenu('all', 'week');*/
getWeekinfo("week");
getindexinfo('all');
barChart4();
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

function createCard3(title, amount) {
    return (
        `<div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">${title}</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800">${amount} 원</div>
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




function updateChartInterval(startDate, endDate) {
    $.ajax({
        type: "POST",
        url: "./index/getChartWithDate?startDate=" + startDate + "&endDate=" + endDate,
        dataType: "json",
        data: {
            type: menuType
        },
        contentType: "application/json; charset=UTF-8",
        success: function (response) {
            if (response && response.length > 0) {
                var {allOrderFoods, allTime} = processMenuData(response, "term");
					
					let orderInfoArray1 = JSON.parse("[" + allOrderFoods + "]");
					menuAmountTermMap = new Map()
										
					orderInfoArray1.forEach(function(order) {
				    order.forEach(function(item) {
				        var menuName = item.name;
				        var amount = parseInt(item.amount);
						
				        if (menuAmountTermMap.has(menuName)) {
				            menuAmountTermMap.set(menuName, menuAmountTermMap.get(menuName) + amount);
				        } else {
				            menuAmountTermMap.set(menuName, amount);
				        }
				    });
				});

				
				barChart4();
				
            } else {
                console.error("No data received or data is empty.");
            }
        },

        error: function (xhr, status, error) {
            console.error("Ajax request failed:", status, error);
        }
    });
}


function updateChart() {
    const startDate1 = new Date(document.getElementById('startDate').value);
    const endDate1 = new Date(document.getElementById('endDate').value);
    
    const startDate = changeDateFormat(startDate1);
    const endDate = changeDateFormat(endDate1);
    

    updateChartInterval(startDate, endDate);
}
// datePicker로 받은 date 형식 변경하기
function changeDateFormat(value) {
	const year = value.getFullYear();
	const month = (value.getMonth() + 1).toString().padStart(2, '0');
	const day = value.getDate().toString().padStart(2, '0');
	
	const dateString = year + '-' + month + '-' + day;
	
	return dateString;
}

