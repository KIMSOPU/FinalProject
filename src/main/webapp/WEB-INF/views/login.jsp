<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="/shoeCream/resources/css/login.css">
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<form id="login_form">
<div class="login">
	<div class="login_title"><a herf="/shoeCream/index.jsp">SHOECREAM</a></div>
	
	<div class="input_box">
		<div class="username_box">
			<h3 class="input_title">아이디</h3>
			<input type="text" class="input_txt" id="input_username" placeholder="예) 영문, 숫자 5~15자" autocomplete="off">
			<p class="input_err" id="input_err_username"></p>
		</div>
	</div>
	
	<div class="input_box">
		<div class="pwd_box">
			<h3 class="input_title">비밀번호</h3>
			<input type="password" class="input_txt" id="input_pwd" autocomplete="off">
			<p class="input_err" id="input_err_pwd"></p>
		</div>
	</div>
	
	<div class="login_btn_box">
		<input type="button" class="login_btn" value="로그인">
	</div>
	
	<ul class="look_box">
		<li class="look_list"><a href="/shoeCream/user/join" class="look_link"> 회원가입 </a></li>
		<li class="look_list"><a href="/shoeCream/user/findUser" class="look_link"> 아이디 찾기 </a></li>
		<li class="look_list"><a href="/shoeCream/user/findPwd" class="look_link"> 비밀번호 찾기 </a></li>
	</ul>
			
	<div class="social_login">
		<button type="button" class="kakao_login_btn" id="kakao_login_btn" onclick="location.href='https://kauth.kakao.com/oauth/authorize?client_id=8f0cf6601a7a42e678ddd67614c593ab&redirect_uri=http://localhost:8090/shoeCream/user/kakaoLogin&response_type=code'">
			<img class="kakao_login" alt="kakao_logo" src="/shoeCream/images/kakao_login.png">
			<h3 class="txt">카카오로 로그인</h3>
		</button>
	</div>
</div>
</form>
<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- 카카오 로그인 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
$(function(){
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
	
	<!-- 비밀번호 유효성 검사 -->
	function isPwd(){
		const pwd = $('#input_pwd').val();
		const reg = RegExp(/^(?=.*[a-zA-Z])(?=.*[!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~])(?=.*[0-9]).{8,25}$/);
		
		if(!reg.test(pwd)){
		    $('#input_err_pwd').text('영문, 숫자, 특수문자를 조합하여 입력해주세요. (8-16자)');
		    $('.pwd_box').css('color', '#d5624f');
		    $('#input_pwd').attr('validation', 'false');
	    }else{
	    	$('#input_err_pwd').text('');
	    	$('.pwd_box').css('color', 'black');
	    	$('#input_pwd').attr('validation', 'true');
	    }	
	}
	
	$('#input_username').on('input', function(){
		isUsername();
		setBtn();
	});
	
	$('#input_pwd').on('input', function(){
		isPwd();
		setBtn();
	});

	<!-- 로그인 -->
	$('.login_btn').click(function(){
		if($(this).hasClass('login_btn_able')){
			$.ajax({
				type:'post',
				url:'/shoeCream/user/loginOk',
				data:{
					'username':$('#input_username').val(),
					'pwd':$('#input_pwd').val()
				},
				dataType:'text',
				success:function(data){
					console.log(data);
					if(data=='success'){
						//location.href='/shoeCream/index.jsp';
						// 뒤로 갈 히스토리가 있는 경우
						if (document.referrer) {
							window.location = document.referrer;   // 이전페이지로 돌아가 새로고침
						}
						// 히스토리가 없는 경우 (URL을 직접 입력하여 유입된 경우)
						else {
							location.href = "/shoeCream/index.jsp"; // 메인페이지로 
						}
					}else if(data=='fail'){
						Swal.fire({
							text: '아이디 또는 비밀번호를 확인해주세요.',
							icon: 'warning'
						})
					}else if(data=='restriction'){
						Swal.fire({
							title: '로그인이 제한된 계정입니다.',
							text: '회원님의 계정은 슈크림 운영원칙에 따라 이용이 제한되었습니다. 자세한 제한 사유 및 해제 요청 관련 문의는 1:1 문의하기로 요청해주세요.',
							icon: 'error'
						})
					}else if(data=='withdrawn'){
						Swal.fire({
							text: '해당 계정은 이미 탈퇴한 계정입니다.',
							icon: 'error'
						})
					}
				},
				error:function(){
					alert('Error: 로그인 실패');
				}
			}); // end ajax
		}
	});
	
	$('.input_txt').keydown(function(key){
	    if (key.keyCode==13) {
	        $('.login_btn').trigger('click');
	    }
	});
	 
	<!-- 버튼 활성화 -->
	function setBtn(){
		if($('#input_username').attr('validation')=='true'&&$('#input_pwd').attr('validation')=='true'){
			$('.login_btn').addClass('login_btn_able');
			$('.login_btn').removeClass('login_btn_disabled');
		}else{
			$('.login_btn').addClass('login_btn_disabled');
			$('.login_btn').removeClass('login_btn_able');
		}
	}
});

</script>
</body>
</html>