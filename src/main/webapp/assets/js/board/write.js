
function tinymce_editor(){
	tinymce.init({
	
	    selector: '#editor',
		forced_root_block: 'p',
	    height: 500, // 원하는 편집기 높이 설정
	    menubar: false, // 기본 메뉴바 제거
		plugins: 'image link | image | media | link',
	    toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist | outdent indent | forecolor backcolor | image | media | link',
	    images_upload_url: '/usr/local/tomcat/webapps/downloadfile2',
	    images_upload_base_path: '/usr/local/tomcat/webapps/downloadfile2',
		relative_urls: false, // 상대 URL 사용 비활성화
	    remove_script_host: false, // 스크립트 호스트 제거 비활성화
		content_css: `/assets/css/board/custom_tinymce.css`,
		setup: function (editor) {
	        editor.on('change', function () {
	            // 에디터 내용이 변경될 때 호출되는 함수
	            adjustYouTubeIframes(editor);
	        });
	    }
	  });
 }
 
 
   function adjustYouTubeIframes(editor) {
    // 에디터 내용에서 모든 YouTube iframe을 선택
    var iframes = editor.dom.select('iframe[src*="youtube.com"]');
    
    for (var i = 0; i < iframes.length; i++) {
        var iframe = iframes[i];
        iframe.setAttribute('width', '100%'); // 너비를 100%로 설정
        iframe.removeAttribute('height'); // 높이 속성 제거 (반응형으로 조정)
    }
  }
  
  window.addEventListener('DOMContentLoaded', function() {
    tinymce_editor();
});
/*
function uploadFile() {
    const fileInput = document.getElementById('file_input');
    const file = fileInput.files[0];

    if (file) {
        const formData = new FormData();
        formData.append('file', file);

        $.ajax({
            type: 'POST',
            url: './FileUpload',
            data: formData,
            contentType: false,
            processData: false,
            enctype: 'multipart/form-data',
            dataType: 'text',
            success: function (data) {
				console.log("data => " + data);
                // 파일 업로드 성공 시, 파일 URL을 텍스트 영역에 삽입
                const editor = tinymce.get('editor');
                editor.insertContent(`<img src="${data}" alt="Uploaded Image"/>`);
            },
            error: function (error) {
                console.error('파일 업로드 실패.', error);
            }
        });
    } else {
        console.error('파일을 선택하세요.');
    }
}*/




function uploadFile() {
    const fileInput = document.getElementById('file_input');
    const files = fileInput.files;

    if (files.length > 0) {
        const formData = new FormData();
        
        for (let i = 0; i < files.length; i++) {
        	formData.append('files', files[i]);
        }

        $.ajax({
            type: 'POST',
            url: './MultipleFileUpload',
            data: formData,
            contentType: false,
            processData: false,
            enctype: 'multipart/form-data',
            dataType: 'json',
            success: function (data) {
				console.log("data => " + data);
                // 파일 업로드 성공 시, 파일 URL을 텍스트 영역에 삽입
                const editor = tinymce.get('editor');
                data.forEach(fileUrl => {
                editor.insertContent(`<p style="text-align: center;"><img src="${fileUrl}" alt="Uploaded Image"/></p>`);
                fileInputChange();
                });
            },
            error: function (error) {
                console.error('파일 업로드 실패.', error);
            }
        });
    } else {
        console.error('파일을 선택하세요.');
    }
}


function fileInputChange()
{
	  document.getElementById('file_input').addEventListener('change', handleFileSelect);

        function handleFileSelect(event) {
            const files = event.target.files;
            const fileInputLabel = document.getElementById('fileInputLabel');
            const selectedFilesDiv = document.getElementById('selectedFiles');

            if (files.length > 0) {
                fileInputLabel.innerHTML = `${files.length}개 파일 선택됨`;

                // 파일 이름들을 표시
                selectedFilesDiv.innerHTML = '';
                for (let i = 0; i < files.length; i++) {
                    const fileNameDiv = document.createElement('div');
                    fileNameDiv.textContent = files[i].name;
                    selectedFilesDiv.appendChild(fileNameDiv);
                }
            } else {
                fileInputLabel.innerHTML = '파일 선택';
                selectedFilesDiv.innerHTML = '';
            }
        }
}



