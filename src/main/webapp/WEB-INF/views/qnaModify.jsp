<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>
<body>
	<div class="content_title">
		<h3 id="title_name">1:1 문의</h3>
	</div>	
	<form name="qnaUpdateForm" id="qnaUpdateForm">
		<input type="hidden" id="qnaId" name="qnaId" value="${qnaId}">
		<input type="hidden" id="pg" name="pg" value="${pg}">
		<div class="content_list">
			<table id="qna_table">
				<colgroup>
					<col style="width:100px;">
					<col style="width:auto;">
				</colgroup>
				<tr>
					<th>제목</th>
			   		<td class="td_left">
			   			<input type="text" name="title" id="title" class="input_box" size="60" height="5" value="${content.title} " readonly>
			   		</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td class="td_left">
						<input type="text" name="qnaName" id="qnaName" class="input_box" value="${content.qnaName}" readonly>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					 	<textarea id="summernote" name="contents">${content.contents}</textarea>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td class="td_left">
						<input type="password" name="qnaPwd" id="qnaPwd" class="input_box">
					</td>
				</tr>
			</table>
		</div>
		
	</form>	
	<div class="btn_center_div">
		<a href="#" class="service_btn black_btn" id="update_btn" onclick="return false;">수정</a>
		<a href="#" class="service_btn gray_btn" id="cancel_btn">취소</a>
	</div>		
	
</body>
<script type="text/javascript">
	var $j351 = jQuery.noConflict();
	
	$j351(function(){
		//에디터 load
		$j351('#summernote').summernote({
			placeholder: '문의하실 내용을 입력하세요',
	        tabsize: 2,
	        height: 400,
	        focus: true,
	        toolbar: [
	        	['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['picture']]
	        ],
	        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
		});
		
		//유효성검사 후 강조표시 해제
		$('.input_box').focusout(function(){
			if($(this).val().replace(/\s|　/gi, "").length != 0) {
				$(this).removeClass("input_empty");
			}
		});
		
		//등록버튼 유효성 검사
		$j351('#update_btn').click(function(){
			if ($j351('#title').val().replace(/\s|　/gi, "").length == 0){
				swal('제목을 입력하세요.', '' , 'warning').then(function(){
					$j351('#title').addClass("input_empty");
					$j351('#title').focus();
					
				});//end swal
			} else if ($j351('#qnaName').val().replace(/\s|　/gi, "").length == 0){
				swal('이름을 입력하세요.', '' , 'warning').then(function(){
					$j351('#qnaName').addClass("input_empty");
					$j351('#qnaName').focus();
					
				});//end swal
			} else if ($j351('#summernote').val().replace(/\s|　/gi, "").length == 0){
				swal('내용을 입력하세요.', '' , 'warning').then(function(){
					$j351('#summernote').focus();
					
				});//end swal
			} else if ($j351('#qnaPwd').val().replace(/\s|　/gi, "").length == 0){
				swal('비밀번호를 입력하세요.', '' , 'warning').then(function(){
					$j351('#qnaPwd').addClass("input_empty");
					$j351('#qnaPwd').focus();
					
				});//end swal
			} else if ($j351('#qnaPwd').val().search(/\s/) != -1){
				swal('비밀번호는 공백 없이 입력해주세요.', '' , 'warning').then(function(){
					$j351('#qnaPwd').addClass("input_empty");
					$j351('#qnaPwd').focus();
					
				});//end swal
			} else {
				//수정
				$j351.ajax({
					type: 'post',
			        url: '/shoeCream/serviceCenter/qnaUpdate',
			       	data: $('#qnaUpdateForm').serialize(), // qnaId, title, qnaName, contents, qnaPwd
			       //data : {'id':$('#qnaId').val()}
			       success: function(){
			        	location.href='/shoeCream/serviceCenter/qna';
			        	//goQnaDetail($('#pg').val(), $('#qnaId').val());
			        },
			        error: function(err){
			        	console.log(err);
			        }
				});//ajax
				
			}
		});
		
		//취소 버튼
		$j351('#cancel_btn').click(function(){
			goQnaDetail($('#pg').val(), $('#qnaId').val());
		});
		
		//post 방식 페이지 이동
		function goQnaDetail(pg, qnaId) { 
			let f =  document.createElement('form');
			
			let obj;
		    obj = document.createElement('input');
		    obj.setAttribute('type', 'hidden');
		    obj.setAttribute('name', 'qnaId');
		    obj.setAttribute('value', qnaId);
			f.appendChild(obj);
			
			f.setAttribute('method', 'post');
			f.setAttribute('action', '/shoeCream/serviceCenter/qnaDetail?pg='+pg);
			document.body.appendChild(f);
			f.submit();
		}
	})
</script>

</html>