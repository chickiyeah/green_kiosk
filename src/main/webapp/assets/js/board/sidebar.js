
function openPopupMember(url) {
  var popupWidth = 300;
  var popupHeight = 400;
  var popupX = window.screen.width / 2 - popupWidth / 2;
  var popupY = window.screen.height / 2 - popupHeight / 2;

  // Check if the popup would go off the screen
  if (popupX < 0) {
    popupX = 0;
  }
  if (popupY < 0) {
    popupY = 0;
  }

  var popup = window.open(url, 'PopupWindow', 'width=' + popupWidth + ', height=' + popupHeight + ', scrollbars=yes, left=' + popupX + ', top=' + popupY);
}

	
function openPopup(url) {
  var popupWidth = 500;
  var popupHeight = 300;
  var popupX = (window.screen.width/2) - (popupWidth/2);
  var popupY = (window.screen.height/2) - (popupHeight/2);
  var popup = window.open(url, 'PopupWindow', 'width=popupWidth, height=popupHeight, scrollbars=yes, left=popupX, top=popupY');
}

function loadContent(url) {
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      // Ajax 요청이 완료되고 페이지를 가져온 경우 메인 페이지를 업데이트
      document.getElementById('mainContent').innerHTML = xhr.responseText;
      // 맨 상단으로 가도록
/*      window.scrollTo(0, 0);
*/    }
  };
  xhr.open('GET', url, true);
  xhr.send();
}

/*function updateProfileImg(mem_id){
	    $.ajax({
        type: "POST",
        url: "./boardSideBar",
        data: { mem_id : mem_id },
        dataType: "json",
        cache: false, //한번 cache 막아봅시다.
        success: function (response) {
            if (response && response.post_viewcount !== undefined) {

            $("#profileImage").attr("src", response.mem_profile_img);
            } else {
                console.log("올바르지 않은 JSON format 입니다.");
            }
        },
        error: function (xhr, status, error) {
            console.error("추천에 실패했습니다.:", status, error);
        }
    });
}
*/