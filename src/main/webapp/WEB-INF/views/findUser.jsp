<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="/shoeCream/resources/css/findUser.css">
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="help">
	<h2 class="help_title">아이디 찾기</h2>

	<div class="help_notice">
		<p class="notice_txt">
			가입 시 등록한 휴대폰 번호를 입력하면
			<br>
			아이디의 일부를 알려드립니다.
		</p>
	</div>

	<div class="input_box">
		<div class="phone_box">
			<h3 class="input_title">휴대폰 번호</h3>
			<input type="text" class="input_txt" id="input_phoneNum" name="phoneNum" placeholder="가입하신 휴대폰 번호" autocomplete="off">
		</div>
	</div>

	<input type="button" class="find_btn" value="아이디 찾기">
	<input type="hidden" id="username" name="username">
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
$(function(){
	<!-- 휴대폰 번호 유효성 검사 -->
	$('#input_phoneNum').on('input', function(){
		<!-- 숫자만 입력 -->
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		
		const phoneNum = $('#input_phoneNum').val();
		const reg = RegExp(/^(?:(010\d{4})|(01[1|6|7|8|9]\d{3,4}))(\d{4})$/);
		
		<!-- 버튼 활성화 -->
		if (!reg.test(phoneNum)){
			$('.find_btn').addClass('find_btn_disabled');
			$('.find_btn').removeClass('find_btn_able');
		}else{
			$('.find_btn').addClass('find_btn_able');
			$('.find_btn').removeClass('find_btn_disabled');
		}
	});
	
	<!-- 아이디 찾기 -->
	$('.find_btn').click(function(){
		if($(this).hasClass('find_btn_able')){
			$.ajax({
				type:'post',
				url:'/shoeCream/user/findUserOk',
				data:'phoneNum='+$('#input_phoneNum').val(),
				dataType:'text',
				success:function(data){
					if(data=='not_exist'){
						swal('일치하는 사용자 정보를 찾을 수 없습니다.', '' , 'error').then(function(){
							location.reload();
							
						});//end swal
					}else{
						<!-- 마스킹 처리 -->
						const result = data.replace(/(?<=.{2})./gi, '*');
						location.href = "/shoeCream/user/findUserResult?username="+result
					}
				},
				error:function(){
					alert('Error: 아이디 찾기 실패');
				}
			}); // end ajax
		}
	});
	
	$('.input_txt').keydown(function(key){
	    if (key.keyCode==13) {
	        $('.find_btn').trigger('click');
	    }
	});
});
</script>
</body>
</html>