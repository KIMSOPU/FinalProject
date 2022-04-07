<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<head>
  	<link href="/shoeCream/admin/assets/css/question/question.css" rel="stylesheet" />
  	<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>

    <div class="col-md-7">
    
    <input type="hidden" id="qnaId" name="qnaId" value="${qnaId}">
    <input type="hidden" id="pg" name="pg" value="${pg}">
    
            <div class="card card-user">
              <div class="card-header"><h5 class="card-title">1:1 문의사항</h5> 
            </div>
              
            <div class="card-body">
            
                <form id="questionView">
               
                  <div class="row">
                   <div class="col-md-12">
                      <div class="form-group">
                        <label>제목</label>
                        <input class="form-control" id="title" readonly="readonly">
                      </div>
                    </div>
                  </div>
                                 
                  <div class="row">
                    <div class="col-md-4 pr-1">
                      <div class="form-group">
                        <label>작성자</label>          
	                       <input class="form-control" id="qnaName" readonly>
                      </div>
                    </div>                   
                    <div class="col-md-4 pl-1">
                      <div class="form-group">
                        <label>작성일</label>
                        <input class="form-control" id="regDate" readonly>
                      </div>
                    </div>
                    <div class="col-md-4 pl-1">
                      <div class="form-group">
                        <label>글 비밀번호</label>
                        <input class="form-control" id="pwd" readonly>
                      </div>
                    </div>
                  </div>
                   
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                         <label>내용</label> 
                        	<textarea id="summernote" name="contents" disabled></textarea>                 
                       </div>
                      </div>
                  </div>
                                 
                   
				 <br><br>
                  <div class="row">               
                    <div class="update ml-auto mr-auto">
                      <button type="button" class="btn btn-primary btn-round" id="listBtn" onclick="location.href='/shoeCream/adminViews/question/qnaList?pg=${pg}'">목록</button>                                     
                      <button type="reset" class="btn btn-primary btn-round" id="writeBtn" onclick="location.href='/shoeCream/adminViews/question/qnaWrite?qnaId=${qnaId}'">답글작성</button>
                      <button type="button" class="btn btn-primary btn-round" id="updateBtn" onclick="location.href='/shoeCream/adminViews/question/updateQnaForm?qnaId=${qnaId}'">수정</button>  
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
	
	
	$("#updateBtn").hide();
	$("#writeBtn").hide();
	
	$j351.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/question/getQnaView',
		 data: {'qnaId' : $j351('#qnaId').val()},
		 success: function(data){			
			$j351('#title').val(data.title);
			$j351('#qnaName').val(data.qnaName);
			$j351('#regDate').val(data.regDate);
			$j351('#pwd').val(data.qnaPwd);
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

			if(data.pseq != data.qnaId){
				$("#updateBtn").show(); 
			}else{
				$("#writeBtn").show(); 
			}
		 },
		 error: function(err){
				alert(err);
		}		 
	
	});
	
});
</script>