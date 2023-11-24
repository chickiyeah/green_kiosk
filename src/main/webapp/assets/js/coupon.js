function cate_pop(cate, can_cate, couname) {
	let s_category = document.querySelector("."+cate)
	document.querySelector(".one").attributes.onclick.value = "cate_pop('one',\""+can_cate+"\", '"+couname+"')"
	document.querySelector(".set").attributes.onclick.value = "cate_pop('set',\""+can_cate+"\", '"+couname+"')"
	document.querySelector(".side").attributes.onclick.value = "cate_pop('side',\""+can_cate+"\", '"+couname+"')"
	document.querySelector(".drink").attributes.onclick.value = "cate_pop('drink',\""+can_cate+"\", '"+couname+"')"
	let can_cates = JSON.parse(can_cate.replaceAll("\'", "\""))
	let a_cates = ""
	can_cates.forEach((a_cate) => {
		a_cates += a_cate+", "
	})
	
	//금지작업
	if (a_cates.includes("단품") == false) {
		document.querySelector(".one").classList.add("cant_use")
	} else {
		document.querySelector(".one").classList.remove("cant_use")
	}
	
	if (a_cates.includes("세트") == false) {
		document.querySelector(".set").classList.add("cant_use")
	} else {
		document.querySelector(".set").classList.remove("cant_use")
	}
	
	if (a_cates.includes("사이드") == false) {
		document.querySelector(".side").classList.add("cant_use")
	} else {
		document.querySelector(".side").classList.remove("cant_use")
	}
	
	if (a_cates.includes("음료") == false) {
		document.querySelector(".drink").classList.add("cant_use")
	} else {
		document.querySelector(".drink").classList.remove("cant_use")
	}
	
	
	a_cates = a_cates.substring(0, a_cates.length-2)
	document.getElementById("pop_ava_cate").innerText = a_cates
	can_cate = can_cate.replaceAll("\'","squot")
	if (s_category != null) {
		if (s_category.classList.contains("cant_use") == false) {
			let categorys = document.querySelectorAll(".cate_pop");
			let pop_menu = document.querySelector(".kiosk_box")
			categorys.forEach((category) => {				
				if (category.classList.contains(cate)) {
					category.classList.add("on");
					pop_menu.innerHTML = ""
					if (cate == "one") {
						pop_one.forEach((menu) => {
							let html = `<div onclick="pop_select('${menu.name}', '${menu.cate}', '${can_cate}', '${couname}')">
					                    	<img src="${menu.img}" style="height:165px">
					                    	<span>${menu.name}</span>
					                    </div>`
					                    
					        pop_menu.insertAdjacentHTML("beforeend", html)
						})
					}
					
					if (cate == "set") {
						pop_set.forEach((menu) => {
							let html = `<div onclick="pop_select('${menu.name}', '${menu.cate}', '${can_cate}', '${couname}')">
					                    	<img src="${menu.img}" style="height:165px">
					                    	<span>${menu.name}</span>
					                    </div>`
					                    
					        pop_menu.insertAdjacentHTML("beforeend", html)
						})
					}
					
					if (cate == "side") {
						pop_side.forEach((menu) => {
							let html = `<div onclick="pop_select('${menu.name}', '${menu.cate}', '${can_cate}', '${couname}')">
					                    	<img src="${menu.img}" style="height:165px">
					                    	<span>${menu.name}</span>
					                    </div>`
					                    
					        pop_menu.insertAdjacentHTML("beforeend", html)
						})
					}
					
					if (cate == "drink") {
						pop_drink.forEach((menu) => {
							let html = `<div onclick="pop_select('${menu.name}', '${menu.cate}', '${can_cate}', '${couname}')">
					                    	<img src="${menu.img}" style="height:165px">
					                    	<span>${menu.name}</span>
					                    </div>`
					                    
					        pop_menu.insertAdjacentHTML("beforeend", html)
						})
					}
					
				} else {
					category.classList.remove("on");
				}
			})
		}
	}
}

//쿠폰 음식 선택
function pop_select(name, cate, can_cate, couname) {
	let context = sessionStorage.getItem("context")
	let can_cates = JSON.parse(can_cate.replaceAll("squot", "\""))
	if (can_cates.includes(cate)) {
		let con = confirm(`정말 ${couname} 으로\n${name} 쿠폰을 발급하시겠습니까?\n이 작업은 취소할 수 없습니다!`)
		if (con) {
			fetch(context+"/api/coupon/get", {
				method: "POST",
				body: JSON.stringify({
					"name": couname,
					"menu": name,
					"menu_cate": cate
				})
			}).then((response) => {
				if (response.status == 200) {
					location.reload();
				}
				
				if (response.status == 400) {
					alert(`쿠폰 발급에 실패하였습니다.\n쿠폰정보가 올바르지 않습니다.`)
				}
				
				if (response.status == 401) {
					alert("로그인이 필요합니다.");
					location.href = context+"/"
				}
			})
		}
	} else {
		alert("해당 쿠폰으로 발급할수 없는 메뉴입니다!")
	}
}