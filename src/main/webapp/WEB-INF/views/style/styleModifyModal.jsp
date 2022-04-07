<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="/shoeCream/resources/css/modal.css">
<link rel="stylesheet" href="/shoeCream/resources/css/styleWrite.css">
</head>
<body>

<div id="modifyModal" class="modal">
    <div class="modal-window modal-window-styleModify">
        <div class="modal-title">
            <h2>스타일 수정</h2>
        	<a href="#" class="close-area"><i class="fa-solid fa-xmark fa-lg"></i></a>
        </div>
   		<div class="modal-content">
        	<div class="write-modal-content">
        		<form name="styleModifyForm" id="styleModifyForm">
        			<input type="hidden" name="styleId" id="styleId" value="">
                    <div class="imgDiv-modify" id="uploded_img_div">
                        <p class="modify-tip">😥 사진, 상품태그는 수정이 불가능합니다.</p>
                    </div>
                    <div class="styleContents">
                        <textarea class="contentsTextArea-md" name="contents" id="contentsTextArea-md"></textarea>
                    </div>
                    
					<div class="register-btn-div btn_center_div">
						<a href="#" class="styleWrite_btn black_btn" id="update_btn">수정</a>
					</div>		  
				</form>              
        	</div>
      	</div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		// 모달 클로즈 (x버튼 클릭)
		$('.close-area').click(function(){
			$('.modal').css('display', 'none');
			$('body').css('overflow', 'auto');
		});	
		
        // 수정 버튼 클릭
        $('#update_btn').click(function(){
            if ($('.contentsTextArea-md').val() == ''){
                alert('내용을 작성하세요.');
                $('.contentsTextArea-md').addClass("input_empty");
			} else {
				
                $.ajax({
                   method: 'post',
                   url: '/shoeCream/style/styleModify',
                   data: $('#styleModifyForm').serialize(),
                   success: function(){
	                    $('.modal').css('display', 'none');
	           			$('body').css('overflow', 'auto');
                        location.reload();
                   },
                   error: function(err){
                	   swal('수정 실패', '' , 'error').then(function(){});//end swal
                   }
                });//ajax
            }
        }); //글 작성 끝

        // 유효성 검사 후 커서가 밖으로 나가면 강조표시 해제
        $('.contentsTextArea-md').focusout(function(){
			if($(this).val() != '') {
				$(this).removeClass("input_empty");
			}
		});
	})	
</script>
</body>
