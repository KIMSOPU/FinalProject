<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/shoeCream/resources/css/myProfile.css">
<body>
<form id="myProfileForm">
	<div class="myProfile">
		<div class="content_title">
			<h3 id="title_name">프로필 정보</h3>
		</div>
		<div class="myProfile_info">
			<div class="user_profile">
				<div class="profile_thumb">
					<img class="thumb_img" src="#" alt="사용자 이미지">
					<input type="hidden" id="thumb_img" value='${userDTO.img}'>
				</div>
				<div class="profile_detail">
					<strong class="name">${userDTO.username}</strong>
					<div class="unit">
						<c:if test="${not empty userDTO.introMsg}">
							<p class="desc introMsg">${userDTO.introMsg}</p>
						</c:if>
						<c:if test="${empty userDTO.introMsg}">
							<p class="desc introMsg">나를 소개하세요</p>
						</c:if>
						<a class="modify_btn" id="modify_introMsg_btn"><i class="fa-solid fa-pencil"></i></a>
					</div>
					<div class="modify">
						<div class="input_box">
							<input type="text" class="input_txt" id="input_introMsg" autocomplete="off" placeholder="나를 소개하세요" maxlength='50'>
							<a id="cancel_introMsg"><i class="fa-solid fa-xmark"></i></a>
							<a id="save_introMsg"><i class="fa-solid fa-check"></i></a>
							<p class="input_err"></p>
						</div>
					</div>				
					<div class="profile_btn_box">
						<a class="btn" id="modify_img_btn">
							<label for="image"> 이미지 변경 </label>
							<input type="file" id="image" name="image">
						</a>
						<a class="btn" id="delete_img_btn"> 삭제 </a>
					</div>
				</div>
			</div>
			
			<div class="myProfile_group">
				<h4 class="group_title">로그인 정보</h4>
				<div class="unit">
					<h5 class="title">아이디</h5>
					<p class="desc username">${userDTO.username}</p>
					<button type="button" class="btn modify_btn"> 변경 </button>
				</div>
				<div class="modify">
					<h5 class="input_title">아이디 변경</h5>
					<div class="input_box">
						<h5 class="input_title">새로운 아이디</h5>
						<input type="text" class="input_txt" id="input_username" autocomplete="off" placeholder="예) 영문, 숫자 5~15자">
						<p class="input_err">영문 소문자와 숫자를 입력해주세요. (4~16자)</p>
					</div>
				</div>
				<div class="modify_btn_box">
					<button type="button" class="btn cancel_btn"> 취소 </button>
					<button type="button" class="btn save_btn" id="save_username"> 저장 </button>
				</div>
				<div class="unit">
					<h5 class="title">이메일 주소</h5>
					<p class="desc email">${userDTO.email}</p>
					<button type="button" class="btn modify_btn" id="modify_email"> 변경 </button>
				</div>
				<div class="modify">
					<h5 class="input_title">이메일 주소 변경</h5>
					<div class="input_box">
						<h5 class="input_title">새 이메일 주소</h5>
						<input type="email" class="input_txt" id="input_email" autocomplete="off" placeholder="">
						<p class="input_err">이메일 주소를 정확히 입력해주세요.</p>				
						<button type="button" class="btn auth_btn" id="auth_email_btn"> 인증 메일 발송 </button>
					</div>
					<div class="input_box">
						<h5 class="input_title">인증번호 입력</h5>
						<input type="text" class="input_txt" id="input_authEmail" autocomplete="off" placeholder="인증번호 입력">
						<p class="input_msg">인증번호를 정확히 입력해주세요.</p>				
					</div>
				</div>
				<div class="modify_btn_box">
					<button type="button" class="btn cancel_btn"> 취소 </button>
					<button type="button" class="btn save_btn" id="save_email"> 저장 </button>
				</div>
				<c:if test="${empty ssAccessToken}">
				<div class="unit">
					<h5 class="title">비밀번호</h5>
					<p class="desc pwd">●●●●●●●●●</p>
					<button type="button" class="btn modify_btn"> 변경 </button>
				</div>
				<div class="modify">
					<h5 class="input_title">비밀번호 변경</h5>
					<div class="input_box">
						<h5 class="input_title">이전 비밀번호</h5>
						<input type="password" class="input_txt input_pwd" id="input_oldPwd" autocomplete="off" placeholder="영문, 숫자, 특수문자 조합 8-16자">
						<p class="input_err">영문, 숫자, 특수문자를 조합해서 입력해주세요. (8-16자)</p>
					</div>
					<div class="input_box">
						<h5 class="input_title">새 비밀번호</h5>
						<input type="password" class="input_txt input_pwd" id="input_newPwd" autocomplete="off" placeholder="영문, 숫자, 특수문자 조합 8-16자">
						<p class="input_err">영문, 숫자, 특수문자를 조합해서 입력해주세요. (8-16자)</p>
					</div>
				</div>
				<div class="modify_btn_box">
					<button type="button" class="btn cancel_btn"> 취소 </button>
					<button type="button" class="btn save_btn" id="save_pwd"> 저장 </button>
				</div>
				</c:if>
			</div>
			
			<div class="myProfile_group">
				<h4 class="group_title">개인 정보</h4>
				<div class="unit">
					<h5 class="title">이름</h5>
					<p class="desc fullName">${userDTO.fullName}</p>
					<button type="button" class="btn modify_btn"> 변경 </button>
				</div>
				<div class="modify">
					<h5 class="input_title">이름 변경</h5>
					<div class="input_box">
						<h5 class="input_title">새로운 이름</h5>
						<input type="text" class="input_txt" id="input_fullName" autocomplete="off" placeholder="고객님의 이름">
						<p class="input_err">올바른 이름을 입력해주세요. (2-50자)</p>
					</div>
				</div>
				<div class="modify_btn_box">
					<button type="button" class="btn cancel_btn"> 취소 </button>
					<button type="button" class="btn save_btn" id="save_fullName"> 저장 </button>
				</div>
				
				<div class="unit">
					<h5 class="title">휴대폰 번호</h5>
					<p class="desc phoneNum">${userDTO.phoneNum}</p>
					<button type="button" class="btn modify_btn"> 변경 </button>
				</div>
				<div class="modify">
					<h5 class="input_title">휴대폰 번호 변경</h5>
					<div class="input_box">
						<h5 class="input_title">새로운 휴대폰 번호</h5>
						<input type="text" class="input_txt" id="input_phoneNum" autocomplete="off">
						<p class="input_err">휴대폰 번호를 정확히 입력해주세요.</p>
						<button type="button" class="btn auth_btn" id="auth_phoneNum_btn"> 인증 문자 발송 </button>
					</div>
					<div class="input_box">
						<h5 class="input_title">인증번호 입력</h5>
						<input type="text" class="input_txt" id="input_authPhoneNum" autocomplete="off" placeholder="인증번호 입력">
						<p class="input_msg">인증번호를 정확히 입력해주세요.</p>				
					</div>
				</div>
				<div class="modify_btn_box">
					<button type="button" class="btn cancel_btn"> 취소 </button>
					<button type="button" class="btn save_btn" id="save_phoneNum"> 저장 </button>
				</div>
				
			</div>
			<a href="/shoeCream/my/myWithdrawal" class="withdrawal_btn"> 회원 탈퇴 </a>
		</div>
		<input type="hidden" id="chkUsername">
		<input type="hidden" id="chkEmail">
		<input type="hidden" id="chkPhoneNum">
		<input type="hidden" id="authEmail">
		<input type="hidden" id="authPhoneNum">
		<input type="hidden" id="profileImg">
	</div>
</form>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
$(function(){
	$('.email').text(maskingEmail('${userDTO.email}'));
	$('.phoneNum').text(maskingPhoneNum('${userDTO.phoneNum}'));
	
	/* 이미지 경로 설정 */
    let img = $('#thumb_img').val();
    let src = '';
    
    if(chkUrl(img)){
       src=img;
    }else{
       src="/shoeCream/images/userProfile/"+img;
    }
    $('.thumb_img').attr('src', src);
    
    if('${ssAccessToken}'!=''){
    	$('.email').siblings('.modify_btn').css('color', '#ebebeb');
    }

	/* 이미지 파일 선택시 발생하는 이벤트 */
	$('#image').on('change', function(){
		const formData = new FormData($('#myProfileForm')[0]);
		
		$.ajax({
			type:'post',
			url:'/shoeCream/my/updateProfileImg',
			enctype:'multipart/form-data',
			processData:false,
			contentType:false,
			data:formData,
			success:function(){
				location.reload();
			},
			error:function(){
				alert('Error: 프로필 이미지 변경')
			}
		}); // end ajax
	});
	
	$('#delete_img_btn').click(function(){
		if('${userDTO.img}'!='blank_profile.png'){
			$.ajax({
				type:'post',
				url:'/shoeCream/my/deleteProfileImg',
				data:'img='+'${userDTO.img}',
				success:function(){
					location.reload();
				},
				error:function(){
					alert('Error: 프로필 이미지 삭제')
				}
			}); // end ajax
		}
	});
	
	$('.modify_btn').click(function(){
		if($(this).attr('id')=='modify_email'){
			if('${ssAccessToken}'!=''){
				Swal.fire({
					text: '소셜 이메일 주소는 변경할 수 없습니다.',
					icon: 'warning'
				})
				return;
			}
		}
		
		<!-- 변경은 unit 하나씩만 -->
		$('.cancel_btn').trigger('click');
		
		$(this).parent('div').hide();
		$(this).parent('div').nextUntil('.unit').show();
	});
	
	$('.cancel_btn').click(function(){
		<!-- 초기화 -->
		$('.input_txt').val('');
		$('.input_err').hide();
		$('.input_msg').hide();
		$('.input_box').css('color', 'black');
		$('#authEmail').val('');
		$('#authPhoneNum').val('');
		
		$(this).parent('div').hide();
		$(this).parent('div').prevUntil('.unit').hide();
		$(this).parent('div').siblings('.unit').show();
	});
	
	$('#input_username').on('input', function(){
		isUsername();
		chkUsername();
	});
	
	$('#input_email').on('input', function(){
		$('#input_authEmail').attr('validation', 'false');
		isEmail();
		chkEmail();
	});
	
	$('#input_authEmail, #input_authPhoneNum').on('input', function(){
		<!-- 숫자만 입력 -->
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});

	$('#input_oldPwd, #input_newPwd').on('input', function(){
		const id = $(this).attr('id');
		isPwd(id);
	})
	
	$('#input_fullName').on('input', function(){
		isFullName();
	});
	
	$('#input_phoneNum').on('input', function(){
		$('#input_authPhone').attr('validation', 'false');
		<!-- 숫자만 입력 -->
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		isPhoneNum();
		chkPhoneNum();
	});
	
	<!-- 소개 변경 -->
	$('#save_introMsg').click(function(){
		$.ajax({
			type:'get',
			url:'/shoeCream/my/updateIntroMsg',
			data:'introMsg='+$('#input_introMsg').val(),
			success:function(){
				location.reload();
			},
			error:function(){
				alert('Error: 소개 변경');
			}
		}); // end ajax		
	});
	
	$('#cancel_introMsg').click(function(){
		$(this).parents('.modify').hide();
		$(this).parents('.modify').siblings('.unit').show();
	});
	
	<!-- 아이디 변경 -->
	$('#save_username').click(function(){
		isUsername();
		chkUsername();
		
		if($('#input_username').attr('validation')=='true'&&$('#chkUsername').attr('validation')=='true'){
			$.ajax({
				type:'get',
				url:'/shoeCream/my/updateUsername',
				data:'username='+$('#input_username').val(),
				success:function(){
					location.reload();
				},
				error:function(){
					alert('Error: 이메일 주소 변경')
				}
			}); // end ajax
		}
	});
	
	<!-- 이메일 주소 인증 -->
	$('#auth_email_btn').click(function(){
		isEmail();
		chkEmail();
		
		if($('#input_email').attr('validation')=='true'&&$('#chkEmail').attr('validation')=='true'){
			$.ajax({
				type:'post',
				url:'/shoeCream/user/authEmail',
				data:'email='+$('#input_email').val(),
				dataType:'text',
				success:function(data){
					$('.input_msg').text('인증 이메일이 발송되었습니다.');
					setErr(false, '#input_authEmail');
					$('#authEmail').val(data);
					$('#input_authEmail').focus();
				},
				error:function(){
					alert('Error: 이메일 인증')
				}
			}); // end ajax
		}
	});
	
	<!-- 이메일 주소 변경 -->
	$('#save_email').click(function(){
		isEmail();
		chkEmail();
		isAuthEmail();
		
		if($('#input_email').attr('validation')=='true'&&$('#chkEmail').attr('validation')=='true'&&$('#input_authEmail').attr('validation')=='true'){
			if($('#input_authEmail').val()==$('#authEmail').val()){
				$.ajax({
					type:'get',
					url:'/shoeCream/my/updateEmail',
					data:'email='+$('#input_email').val(),
					success:function(){
						location.reload();
					},
					error:function(){
						alert('Error: 이메일 주소 변경')
					}
				}); // end ajax
			}else{
				$('.input_msg').text('인증번호를 정확히 입력해주세요.');
				setErr(false, '#input_authEmail');
			}
		}
	})
	
	<!-- 비밀번호 변경 -->
	$('#save_pwd').click(function(){
		isPwd('input_oldPwd');
		isPwd('input_newPwd');
		
		if($('#input_oldPwd').attr('validation')=='true'&&$('#input_newPwd').attr('validation')=='true'){
			$.ajax({
				type:'get',
				url:'/shoeCream/my/updatePwd',
				data:{
					'username':'${userDTO.username}',
					'oldPwd':$('#input_oldPwd').val(),
					'newPwd':$('#input_newPwd').val()
				},
				success:function(data){
					if(data=='success'){
						Swal.fire({
		                	text:'회원정보가 변경되었습니다. 다시 로그인 해주세요.',
		                	icon:'success'
		              	}).then((result) => {
		                	location.href='/shoeCream/user/login';
		            	});
					}else{
						$('.input_err').text('기존 비밀번호가 일치하지 않습니다.');
						setErr(false, '#input_oldPwd');
					}
				},
				error:function(){
					alert('Error: 비밀번호 변경');
				}
			}) // end ajax
		}
	});

	<!-- 이름 변경 -->
	$('#save_fullName').click(function(){
		isFullName();
		
		if($('#input_fullName').attr('validation')=='true'){
			$.ajax({
				type:'get',
				url:'/shoeCream/my/updateFullName',
				data:'fullName='+$('#input_fullName').val(),
				success:function(){
					location.reload();
				},
				error:function(){
					alert('Error: 이름 변경');
				}
			}); // end ajax
		}
	});
	
	<!-- 휴대폰 번호 인증 -->
	$('#auth_phoneNum_btn').click(function(){
		isPhoneNum();
		chkPhoneNum();
		
		if($('#input_phoneNum').attr('validation')=='true'&&$('#chkPhoneNum').attr('validation')=='true'){
			$.ajax({
				type:'post',
				url:'/shoeCream/user/authPhoneNum',
				data:'phoneNum='+$('#input_phoneNum').val(),
				success:function(data){
					if(data.result=='success'){
						$('.input_msg').text('인증 문자가 발송되었습니다.');
						setErr(false, '#input_authPhoneNum');
						$('#authPhoneNum').val(data.randomNumber);
						$('#input_authPhoneNum').focus();	
					}	
				},
				error:function(){
					alert('Error: 휴대폰 번호 인증')
				}
			}); // end ajax
		}
	});
	
	<!-- 휴대폰 번호 변경 -->
	$('#save_phoneNum').click(function(){
		isPhoneNum();
		chkPhoneNum();
		isAuthPhoneNum();
		
		if($('#input_phoneNum').attr('validation')=='true'&&$('#chkPhoneNum').attr('validation')=='true'&&$('#input_authPhoneNum').attr('validation')=='true'){
			if($('#input_authPhoneNum').val()==$('#authPhoneNum').val()){
				$.ajax({
					type:'get',
					url:'/shoeCream/my/updatePhoneNum',
					data:'phoneNum='+$('#input_phoneNum').val(),
					success:function(){
						location.reload();
					},
					error:function(){
						alert('Error: 휴대폰 번호 변경')
					}
				}); // end ajax
			}else{
				$('.input_msg').text('인증번호를 정확히 입력해주세요.');
				setErr(false, '#input_authPhoneNum');
			}
		}
	});
	
	<!-- 에러 메세지 -->
	function setErr(result, id){
		if(!result){
			$(id).next('p').show();
			$(id).parent('div').css('color', '#d5624f');
			$(id).attr('validation', 'false');
		}else{
			$(id).next('p').hide();
	    	$(id).parent('div').css('color', 'black');
	    	$(id).attr('validation', 'true');
		}	
	}
	
	<!-- 아이디 유효성 검사 -->
	function isUsername(){
		const username = $('#input_username').val();
		const reg = RegExp(/^[a-zA-Z0-9]{4,16}$/g);
		
		if($('#input_username').val()==''){
			$('.input_err').text('영문 소문자와 숫자를 입력해주세요. (4~16자)');
			setErr(false, '#input_username');
			return;
		}
		
		if(!reg.test(username)){
			$('.input_err').text('영문 소문자와 숫자를 입력해주세요. (4~16자)');
			setErr(false, '#input_username');
	    }else{
	    	setErr(true, '#input_username');
	    }	
	}
	
	<!-- 아이디 중복체크 -->
	function chkUsername(){
		const username = $('#input_username').val();
		
		if($('#input_username').attr('validation')=='true'){
			$.ajax({
				type:'post',
				url:'/shoeCream/user/chkUsername',
				data:'username='+username,
				dataType:'text',
				success:function(data){
					if(data=='exist'){
						$('.input_err').text('이미 사용 중인 아이디입니다.');
						setErr(false, '#input_username');
						$('#chkUsername').attr('validation', 'false');
					}else if(data=='not_exist'){
						setErr(true, '#input_username');
						$('#chkUsername').attr('validation', 'true');
					}
				},
				error:function(err){
					alert("Error: 아이디 중복체크");
				}
			}); // end ajax
		}
	}
	
	<!-- 이메일 주소 유효성 검사 -->
	function isEmail(){
		const email = $('#input_email').val();
		const reg = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
		
		if($('#input_email').val()==''){
			$('.input_err').text('이메일 주소를 정확히 입력해주세요.');
			setErr(false, '#input_email');
			return;
		}
		
		if(!reg.test(email)){
			$('.input_err').text('이메일 주소를 정확히 입력해주세요.');
			setErr(false, '#input_email');
		}else{
			setErr(true, '#input_email');
	    }
	}
	
	<!-- 이메일 중복체크 -->
	function chkEmail(){
		const email = $('#input_email').val();
		
		if($('#input_email').attr('validation')=='true'){
			$.ajax({
				type:'post',
				url:'/shoeCream/user/chkEmail',
				data:'email='+email,
				dataType:'text',
				success:function(data){
					if(data=='exist'){
						$('.input_err').text('이미 사용 중인 이메일입니다.');
						setErr(false, '#input_email');
						$('#chkEmail').attr('validation', 'false');
					}else if(data=='not_exist'){
						setErr(true, '#input_email');
						$('#chkEmail').attr('validation', 'true');
					}
				},
				error:function(err){
					alert("Error: 이메일 중복체크");
				}
			}); // end ajax
		}
	}
	
	<!-- 이메일 인증 검사 -->
	function isAuthEmail(){
		if($('#input_authEmail').val()==''){
			$('.input_msg').text('이메일 인증을 완료해주세요.');
			setErr(false, '#input_authEmail');
		}else{
			setErr(true, '#input_authEmail');
		}
	}
	
	<!-- 비밀번호 유효성 검사 -->
	function isPwd(id){
		const pwd = $('#'+id).val();
		const reg = RegExp(/^(?=.*[a-zA-Z])(?=.*[!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~])(?=.*[0-9]).{8,25}$/);
		
		if(pwd==''){
			$('.input_err').text('영문, 숫자, 특수문자를 조합해서 입력해주세요. (8-16자)');
			setErr(false, '#'+id);
			return;
		}
		
		if(!reg.test(pwd)){
			$('.input_err').text('영문, 숫자, 특수문자를 조합해서 입력해주세요. (8-16자)');
			setErr(false, '#'+id);
	    }else{
	    	setErr(true, '#'+id);
	    }	
	}
	
	<!-- 이름 유효성 검사 -->
	function isFullName(){
		const fullName = $('#input_fullName').val();
		const reg = RegExp(/^[가-힣]{2,4}$/);
		
		if(!reg.test(fullName)){
			$('.input_err').text('올바른 이름을 입력해주세요. (2-50자)');
			setErr(false, '#input_fullName');
		}else{
			setErr(true, '#input_fullName');
		}
	}
	
	<!-- 휴대폰 번호 유효성 검사 -->
	function isPhoneNum(){
		const phoneNum = $('#input_phoneNum').val();
		const reg = RegExp(/^(?:(010\d{4})|(01[1|6|7|8|9]\d{3,4}))(\d{4})$/);
		
		if($('#input_phoneNum').val()==''){
			$('.input_err').text('휴대폰 번호를 정확히 입력해주세요.');
			setErr(false, '#input_phoneNum');
			return;
		}
		
		if (!reg.test(phoneNum)){
			$('.input_err').text('휴대폰 번호를 정확히 입력해주세요.');
			setErr(false, '#input_phoneNum');
		}else{
			setErr(true, '#input_phoneNum');
		}
	}
	
	<!-- 휴대폰 번호 중복체크 -->
	function chkPhoneNum(){
		const phoneNum = $('#input_phoneNum').val();
		
		if($('#input_phoneNum').attr('validation')=='true'){
			$.ajax({
				type:'post',
				url:'/shoeCream/user/chkPhoneNum',
				data:'phoneNum='+phoneNum,
				dataType:'text',
				success:function(data){
					if(data=='exist'){
						$('.input_err').text('이미 가입된 번호입니다.');
						setErr(false, '#input_phoneNum');
				    	$('#chkPhoneNum').attr('validation', 'false');
					}else if(data=='not_exist'){
						setErr(true, '#input_phoneNum');
				    	$('#chkPhoneNum').attr('validation', 'true');
					}
				},
				error:function(err){
					alert("Error: 휴대폰 번호 중복체크");
				}
			}); // end ajax
		}
	}
	
	<!-- 휴대폰 번호 인증 검사 -->
	function isAuthPhoneNum(){
		if($('#input_authPhoneNum').val()==''){
			$('.input_msg').text('휴대폰 번호 인증을 완료해주세요.');
			setErr(false, '#input_authPhoneNum');
		}else{
			setErr(true, '#input_authPhoneNum');
		}
	}
	
	<!-- 개인 정보 마스킹 -->
	function maskingEmail(email){
		const id = email.split('@')[0].replace(/(?<=.{2})./gi,'*');		
		const mail = email.split('@')[1]
		const maskingEmail = id+'@'+mail;
		return maskingEmail;
	}
	
	function maskingPhoneNum(phoneNum){
		// 휴대폰 번호 하이픈(-) 추가
		const str = phoneNum.replace(/([0-9]{3})([0-9]{3,4})([0-9]{4})$/, '$1-$2-$3');
		let maskingPhoneNum = '';
		
		// 마스킹(*) 처리
		if(/-[0-9]{3}-/.test(str)) { // 휴대폰 번호가 10자리일 때
			maskingPhoneNum = str.replace(/-[0-9]{3}-/g, '-***-');
			
		}else if(/-[0-9]{4}-/.test(str)) { // 휴대폰 번호가 11자리일 때
			maskingPhoneNum = str.replace(/-[0-9]{4}-/g, '-****-');
		}
		return maskingPhoneNum;
	}
	
	<!-- url 형식 체크 -->
	function chkUrl(url){
	    const reg = /^http[s]?\:\/\//i;
	    return reg.test(url);
	}
});
	

</script>
</body>
</html>