
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




// 여기는 댓글

function getCommentList(post_no, post_writer)
{
	 $.ajax({
        type: "POST",
        url: "./getCommentList",
        data: { post_no: post_no },
        dataType: "json",
        cache: false, //한번 cache 막아봅시다.
        success: function (response) {
            if (response && response.length > 0) {
                updateCommentList(post_no, response, post_writer);
            } else {
                console.log("올바르지 않은 JSON format 입니다.");
            }
        },
        error: function (xhr, status, error) {
            console.error("댓글 목록 로딩 실패.:", status, error);
        }
    });
}

function updateCommentList(post_no, commentList, post_writer) {
    var HTML_commentList = commentList.map(function (comment) {
	var commentWriterCheck = (String(comment.comment_writer) === String(post_writer)) ? '작성자' : '';

	var decodedContent;
	try {
		  decodedContent = decodeURIComponent(comment.comment_content, "UTF-8");
	} catch (error) {
		console.log("내용 디코딩 오류 : ", error);
		decodedContent = "";
	}
	
        return `
            <div class="comment_list_Map" id="comment_list_Map">
                <p> ${comment.comment_writer_id} <span class="commentWriterCheck">${commentWriterCheck}
                <br/></span>&nbsp;<span class="date"> ${comment.comment_time}</span></p>
                <p>&nbsp;${decodedContent}</p>
            </div><hr/>
        `;
    }).join(''); 
    
    var totalCommentCount = commentList.length;
    $('#list_amount').text(` (${totalCommentCount}개)`);
    $('#board_commentUpdate').html(HTML_commentList);
}


function inputComment() {
    var commentContent = $('.comment_content').val();
    var commentWriter = $('[name="comment_writer"]').val();
    var commentPostNo = $('[name="comment_post_no"]').val();

    var encodedContent = encodeURIComponent(commentContent);

    $.ajax({
        type: "POST",
        url: "./inputComment",
        data: {
            comment_content: encodedContent,
            comment_writer: commentWriter,
            comment_post_no: commentPostNo
        },
        dataType: "json",
        cache: false,
        success: function (response) {
            getCommentList(commentPostNo, commentWriter);
			$('.comment_content').val('');
			//$('html, body').animate({ scrollTop: $(document).height() }, 'slow');
     		 // $('#scrollTop').css('display', 'block').animate({ scrollTop: $('#scrollTop').offset().top }, 'slow');
	     	var currentScrollTop = $(window).scrollTop();
	        var newScrollTop = currentScrollTop + 200;
	        $('html, body').animate({ scrollTop: newScrollTop }, 'slow');

        },
        error: function (xhr, status, error) {
            console.error("댓글 입력 실패:", status, error);
            console.log("Server response:", xhr.responseText);
        }
    });
}



// board delete empty @return redirect to index page
function board_delete_Action(post_no)
{
	    var isConfirmed = confirm("정말로 삭제하시겠습니까?");
		
		if (isConfirmed) {
			performDelete(post_no);
		} else {
			console.log("삭제 취소");
		}
}
function performDelete(post_no) {
	    $.ajax({
        type: "POST",
        url: "./deleteBoardAction",
        data: {
	 		post_no : post_no
        },
        dataType: "text",
        cache: false,
        success: function (response) {
			console.log("삭제 성공");
			window.location.href = contextPath + "/board/index.jsp";
        },
        error: function (xhr, status, error) {
            console.error("삭제 실패:", status, error);
        }
    });
}
//board edit @return
function board_edit_Action(post_no)
{
			window.location.href = contextPath + `/board/write/edit.jsp?post_no=${post_no}`;
}
/*
function board_edit_Action(post_no)
{
	    $.ajax({
        type: "POST",
        url: "./editBoardAction",
        data: {
	 		post_no : post_no
        },
        dataType: "text",
        cache: false,
        success: function (response) {
			console.log("삭제 성공");
			window.location.href = contextPath + "/board/index.jsp";
        },
        error: function (xhr, status, error) {
            console.error("삭제 실패:", status, error);
        }
    });
}*/