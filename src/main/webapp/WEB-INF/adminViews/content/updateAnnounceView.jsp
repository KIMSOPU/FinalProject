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
              <div class="card-header"><h5 class="card-title">공지사항 수정</h5> 
            </div>
              
            <div class="card-body">
                <form id="announceUpdateForm">

			   <input type="hidden" id="announcementId" name="announcementId" value="${announcementId}"> 

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
                    	<input type="button" id="listBtn" class="btn btn-primary btn-round" value="수정취소" onclick="location.href='/shoeCream/adminViews/content/announceList?pg=${pg}'">
	   		  		    <input type="button" id="updateBtn" class="btn btn-primary btn-round" value="수정">
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
	
	$j351.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/content/getUpdateView',
		 data: {'announcementId' : $j351('#announcementId').val()},
		 success: function(data){			
			$j351('#title').val(data.title);
			$j351('#summernote').val(data.contents);		
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
		 },
		 error: function(err){
				alert(err);
		}		 
	
	});
	
});
	
$j351('#updateBtn').click(function(){
	
	$j351('#titleDiv').empty();
	$j351('#contentsDiv').empty();
	
	if($j351('#title').val() == ''){
		$j351('#titleDiv').text('제목을 입력해주세요.');
	}else if($j351('#summernote').val() == ''){
		$j351('#contentsDiv').text('내용을 입력해주세요.');
	}
		
	$j351.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/content/updateAnnounce',
		 data: $('#announceUpdateForm').serialize(), 
		 success: function(){			
			 swal('공지사항 수정 완료', '' , 'success').then(function(){
				location.href='/shoeCream/adminViews/content/announceList?pg='+$j351('#pg').val();
				 
			 });//end swal
		 },
		 error: function(err){
		}		 
	 });
});

</script>

