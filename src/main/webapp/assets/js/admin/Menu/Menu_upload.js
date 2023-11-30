

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