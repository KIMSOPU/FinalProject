<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="/shoeCream/resources/css/findPwd.css">
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<form id="help">
<div class="help">
	<h2 class="help_title">비밀번호 찾기</h2>
	
	<div class="help_notice">
		<p class="notice_txt">
		 가입 시 등록한 휴대폰 번호와 아이디를 입력하시면,
		 <br>
		 휴대폰으로 임시 비밀번호를 전송해 드립니다.
		</p>
	</div>
	
	<div class="input_box">
		<div class="phone_box">
			<h3 class="input_title">휴대폰 번호</h3>
			<input type="text" class="input_txt" id="input_phoneNum" placeholder="가입하신 휴대폰 번호" autocomplete="off">
			<p class="input_err" id="input_err_phoneNum"></p>
		</div>
	</div>
	<div class="input_box">
		<div class="username_box">
			<h3 class="input_title">아이디</h3>
			<input type="text" class="input_txt" id="input_username" placeholder="예) 영문, 숫자 5~15자" autocomplete="off">
			<p class="input_err" id="input_err_username"></p>
		</div>
	</div>
	
	<input type="button" class="find_btn" value="문자 발송하기">
</div>
</form>
<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
$(function(){
	<!-- 휴대폰 번호 유효성 검사 -->
	function isPhoneNum(){
		const phoneNum = $('#input_phoneNum').val();
		const reg = RegExp(/^(?:(010\d{4})|(01[1|6|7|8|9]\d{3,4}))(\d{4})$/);
		
		if (!reg.test(phoneNum)){
			$('#input_err_phoneNum').text('휴대폰 번호를 정확히 입력해주세요.');
			$('.phone_box').css('color', '#d5624f');
			$('#input_phoneNum').attr('validation', 'false');
		}else{
			$('#input_err_phoneNum').text('');
			$('.phone_box').css('color', 'black');
			$('#input_phoneNum').attr('validation', 'true');
		}
	}
	
	<!-- 아이디 유효성 검사 -->
	function isUsername(){
		const username = $('#input_username').val();
		const reg = RegExp(/^[a-zA-Z0-9]{4,16}$/g);
		
		if($('#input_username').val()==''){
			$('#input_err_username').text('필수 정보입니다.');
			$('#input_username').attr('validation', 'false');
			return;
		}
		
		if(!reg.test(username)){
			$('#input_err_username').text('영문 소문자와 숫자를 입력해주세요. (4~16자)');
		    $('.username_box').css('color', '#d5624f');
		    $('#input_username').attr('validation', 'false');
	    }else{
	    	$('#input_err_username').text('');
	    	$('.username_box').css('color', 'black');
	    	$('#input_username').attr('validation', 'true');
	    }	
	}
	
	$('#input_phoneNum').on('input', function(){
		<!-- 숫자만 입력 -->
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		isPhoneNum();
		setBtn();
	});
	
	$('#input_username').on('input', function(){
		isUsername();
		setBtn();
	});
	
	<!-- 비밀번호 찾기 -->
	$('.find_btn').click(function(){
		if($(this).hasClass('find_btn_able')){
			<!-- 등록한 휴대폰 번호와 이메일 확인 -->
			$.ajax({
				type:'post',
				url:'/shoeCream/user/findPwdOk',
				data:{
					'phoneNum':$('#input_phoneNum').val(),
					'username':$('#input_username').val()
				},
				dataType:'text',
				success:function(data){
					if (data=='not_exist'){
						Swal.fire({
							text: '일치하는 사용자 정보를 찾을 수 없습니다.',
							icon: 'warning'
						}).then((result) => {
							location.reload();
						});
					}else if (data=='exist'){
						// 문자 인증
						$.ajax({
							type:'post',
							url:'/shoeCream/user/sendSMS',
							data:{
								'phoneNum':$('#input_phoneNum').val(),
								'username':$('#input_username').val()
							},
							success:function(data){
								if(data=='success'){
									location.href="/shoeCream/user/findPwdResult"
								}
							},
							error:function(){
								alert('Error: 문자 인증');
								location.reload();
							}
						}); // end ajax
					}
				},
				error:function(){
					alert('Error:비밀번호 찾기');
				}
			}); // end ajax
		}
	});
	
	$('.input_txt').keydown(function(key){
	    if (key.keyCode==13) {
	        $('.find_btn').trigger('click');
	    }
	});
	
	<!-- 버튼 활성화 -->
	function setBtn(){
		if($('#input_phoneNum').attr('validation')=='true'&&$('#input_username').attr('validation')=='true'){
			$('.find_btn').addClass('find_btn_able');
			$('.find_btn').removeClass('find_btn_disabled');
		}else{
			$('.find_btn').addClass('find_btn_disabled');
			$('.find_btn').removeClass('find_btn_able');
		}
	}
	
});
</script>
</body>
</html>