
function copyToClipboard(currentUrl) {

    // Create a temporary input element
    var tempInput = document.createElement('input');
    tempInput.value = currentUrl;

    // Append the input element to the DOM
    document.body.appendChild(tempInput);

    // Select the text inside the input element
    tempInput.select();
    tempInput.setSelectionRange(0, 99999); /*For mobile devices*/

    // Copy the selected text to the clipboard
    document.execCommand('copy');

    // Remove the temporary input element
    document.body.removeChild(tempInput);

    // Alert the user (you can customize this part)
    alert('해당 게시글 주소가 복사되었습니다. ' + "\n" + currentUrl);
}

        




/*function updateBoard(post_no) {

    $.ajax({
        type: "POST",
        url: "../getBoardData?post_no=" + post_no,
        dataType: "json",
        contentType: "application/json; charset=UTF-8", 
        success: function (response) {
            if (response && response.length > 0) {
                
                // 예시: 받아온 목록을 HTML로 만들어 어딘가에 추가
               
               var post_likecount = response.post_likecount;
               var post_viewcount = response.post_viewcount;
               
               var HTML_likecount = 
               `	<span class="recommend-label">추천 ${post_likecount} </span>`;
				
				var HTML_viewcount =
                    chatListHtml += htmlTemplate;                    
                
                // Update the content of the main element
                $('.recommend-loading').html(HTML_likecount);
 
            } else {
                alert("Failed to fetch chat list.");
            }
        },
        error: function (xhr, status, error) {
            console.error("Ajax request failed:", status, error);
        }
    });
}*/

function increaseViewcount(post_no){
	    $.ajax({
        type: "POST",
        url: "./increaseViewcount",
        data: { post_no: post_no },
        dataType: "json",
        cache: false, //한번 cache 막아봅시다.
        success: function (response) {
            if (response && response.post_viewcount !== undefined) {
                // 성공적으로 서버에서 응답을 받으면 추천 수 업데이트
                console.log("post_viewcount : " + response.post_viewcount);
                updatePostViewcount(post_no, response.post_viewcount);
            } else {
                console.log("올바르지 않은 JSON format 입니다.");
            }
        },
        error: function (xhr, status, error) {
            console.error("추천에 실패했습니다.:", status, error);
        }
    });
}

function increaseRecommendation(post_no) {
    $.ajax({
        type: "POST",
        url: "./increaseRecommendation",
        data: { post_no: post_no },
        dataType: "json",
        success: function (response) {
            if (response && response.post_likecount !== undefined) {
                // 성공적으로 서버에서 응답을 받으면 추천 수 업데이트
                updateRecommendationCount(post_no, response.post_likecount);
            } else {
                console.log("올바르지 않은 JSON format 입니다.");
            }
        },
        error: function (xhr, status, error) {
            console.error("추천에 실패했습니다.:", status, error);
        }
    });
}



function updateRecommendationCount(post_no, post_likecount) {
    // 새로운 추천 수를 화면에 업데이트
               var HTML_likecount = 
               `	<span class="recommend-label">추천 ${post_likecount} </span>`;            
                var HTML_likecount2 = 
               `	<span class="recommend-label2">${post_likecount} </span>`;            
                // Update the content of the main element
                $('.recommend-loading').html(HTML_likecount);
                $('.recommend-loading2').html(HTML_likecount2);
}


function updatePostViewcount(post_no, post_viewcount) {
			var HTML_viewcount =
			`<span class="viewcount-label id="viewcount-label">${post_viewcount} </span>`;
			$('viewcount-loading').html(HTML_viewcount);
}
