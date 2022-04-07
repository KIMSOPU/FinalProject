<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
	<link rel="stylesheet" href="/shoeCream/admin/assets/css/content/content.css">	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>

<input type="hidden" id="pg" name="pg" value="${pg}">
<body>
    <div class="col-md-9">
            <div class="card card-user">
              <div class="card-header"><h5 class="card-title">공지사항 작성</h5> 
            </div>
              
            <div class="card-body">
                <form id="announceWriteForm">
               
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label>제목</label> <span id="titleDiv"></span>    
                        <input type="text" class="form-control" placeholder="제목을 입력하세요" id="title" name="title">
                      </div>
                    </div>
                  </div>
				
				 <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                       <label>내용</label> <span id="contentsDiv"></span>    
                        	<textarea id="summernote" name="contents"></textarea>                       
                      </div>
                    </div>
                  </div>
                  
                  <div class="row">
                    <div class="update ml-auto mr-auto">
                    	<input type="button" id="listBtn" class="btn btn-primary btn-round" value="목록" onclick="location.href='/shoeCream/adminViews/content/announceList?pg=${pg}'">
	   		  		    <input type="button" id="writeBtn" class="btn btn-primary btn-round" value="등록">
                      </div>
                    </div>
                  
                </form>
              </div>
     </div>
 </div>
</body>

<script type="text/javascript">

var $j351 = jQuery.noConflict();
$j351(function(){
	var str = "<div class='form-group note-form-group note-group-select-from-files'>";
    $j351('.note-modal-body')[1].innerHTML= str += "<input id='note-dialog-image-file-16469853985891' class='note-image-input form-control-file note-form-control note-input' style='opacity: inherit; position: inherit;' type='file' name='files' multiple>";
    										str += "</div>";
	$j351('.note-modal-footer')[1].style.height="64px";
});

$j351('#summernote').summernote({
	placeholder: '내용을 입력해주세요.',
    tabsize: 1,
    height: 300,
    toolbar: [
        ['fontname', ['fontname']],
       ['fontsize', ['fontsize']],
       ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
       ['color', ['forecolor','color']],
       ['para', ['ul', 'ol', 'paragraph']],
       ['height', ['height']],
       ['insert',['picture']]
     ],
     	fontNames: ['맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
   		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
});

$j351('#writeBtn').click(function(){
	
	$j351('#titleDiv').empty();
	$j351('#contentsDiv').empty();
	
	if($j351('#title').val() == ''){
		$j351('#titleDiv').text('제목을 입력해주세요.');
	}else if($j351('#summernote').val() == ''){
		$('#contentsDiv').text('내용을 입력해주세요.');
	}
		
	$j351.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/content/writeAnnounce',
		 data: $('#announceWriteForm').serialize(), 
		 success: function(){		
			 swal('공지사항 등록 완료', '' , 'success').then(function(){
				location.href='/shoeCream/adminViews/content/announceList';
				 
			 });//end swal
		 },
		 error: function(err){
		}		 
	 });
});

</script>
