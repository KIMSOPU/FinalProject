<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<head>
	<link rel="stylesheet" href="/shoeCream/admin/assets/css/question/question.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>

    <div class="col-md-7">   
     
   			<div class="card card-user">
              <div class="card-header"><h5 class="card-title">답글 수정</h5> 
            </div>
                     
            <div class="card-body">
                <form id="updateQna">
                
                <input type="hidden" id="qnaId" name="qnaId" value="${param.qnaId}">
                <input type="hidden" id="pg" name="pg" value="${param.pg}">
                
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                       <label>제목</label>  
                        <input type="text" class="form-control" placeholder="제목을 입력하세요" id="title" name="title" value="[답글] 답변드립니다." readonly>
                      </div>
                    </div>
                  </div>
				
				 <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                         <label>내용</label> <span id="contentsDiv"></span>    
                        	<textarea id="summernote" name="contents" ></textarea>                       
                       </div>
                      </div>
                  </div>
                  
                  <div class="row">
                    <div class="update ml-auto mr-auto">
                      <button type="button" class="btn btn-primary btn-round" id="listBtn" onclick="location.href='/shoeCream/adminViews/question/qnaList?pg=${pg}'">목록</button>
                      <button type="button" class="btn btn-primary btn-round" id="updateBtn">수정</button>
                      </div>
                    </div>
                 </form>
              </div>
            </div> 
     	</div>

<script type="text/javascript">
var $j351 = jQuery.noConflict();

$j351(function(){	

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(8)').addClass('active');
	
	
	$j351.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/question/getQnaView',
		 data: {'qnaId' : $j351('#qnaId').val()},
		 success: function(data){		
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
	
	$j351('#contentsDiv').empty();
	
	if($j351('#summernote').val() == ''){
		$('#contentsDiv').text('내용을 입력해주세요.');
	}
		
	$j351.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/question/updateQna',
		 data: {
			 	'contents':$('#summernote').val(),
			 	'qnaId':$('#qnaId').val()
			 	}, 
		 success: function(){			
			 swal('답변 수정 완료', '' , 'success').then(function(){
				location.href='/shoeCream/adminViews/updateQnaForm?pg='+ $('#pg').val() + '&qnaId=' + $('#qnaId').val();
				 
			 });//end swal
		 },
		 error: function(err){
				alert(err);
		}		 
	 });
});

</script>
