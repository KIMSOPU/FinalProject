<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
<link rel="stylesheet" href="/shoeCream/resources/css/joinSocial.css">

</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<form id="join_form">
<div class="join">
	<h2 class="join_title">회원가입</h2>
	
	<div class="input_box">
		<div class="email_box">
			<h3 class="input_title">카카오 ID로 연결됨*</h3>
			<input type="text" class="input_txt" id="input_email" value="${userInfo.email}" readonly="readonly">
			<p class="input_sub" id="input_sub_text">카카오 계정 > 개인 정보 > 카카오계정으로 가입됩니다.</p>
		</div>
	</div>
	
	<div class="input_box">
		<div class="username_box">
			<h3 class="input_title">아이디*</h3>
			<input type="text" class="input_txt" id="input_username" value="${userInfo.email.split('@')[0]}" placeholder="예) 영문, 숫자 5~15자" autocomplete="off">
			<p class="input_err" id="input_err_username"></p>
		</div>
	</div>
	
	<div class="input_box">
		<div class="phoneNum_box">
			<h3 class="input_title">휴대폰 번호*</h3>
			<input type="text" class="input_txt" id="input_phoneNum" placeholder="" autocomplete="off">
			<p class="input_err" id="input_err_phoneNum"></p>
		</div>
	</div>
	
	<div class="join_terms">
		<div class="check_main">
			<div class="checkbox_item">
			<label for="group_1" class="check_label">
				<input type="checkbox" class="checkbox" id="group_1">
				<span>[필수] 만 14세 이상이며 모두 동의합니다.</span>
			</label>
			<a href=javascript:; class="btn essential"><i class="fa-solid fa-plus"></i></a>
			</div>
		</div>
		<div class="check_sub" id="check_sub_essential">
			<div class="checkbox_item">
			<label for="allow_agreement" class="check_label">
				<input type="checkbox" class="checkbox" id="allow_agreement" name="check_essential">
				<span>이용약관 동의</span>
			</label>
			<a href=javascript:; class="view_btn" id="agreement_btn">내용보기</a>
			</div>
			<div class="checkbox_item">
			<label for="allow_privacy" class="check_label">
				<input type="checkbox" class="checkbox" id="allow_privacy" name="check_essential">
				<span>개인정보 수집 및 이용 동의</span>
			</label>
			<a href=javascript:; class="view_btn" id="privacy_btn">내용보기</a>
			</div>
		</div>
			
		<div class="check_main">
			<div class="checkbox_item">
				<label for="group_2" class="check_label">
					<input type="checkbox" class="checkbox" id="group_2">
					<span class="span_txt">[선택] 광고성 정보 수신에 모두 동의합니다.</span>
				</label>
				<a href=javascript:; class="btn option"><i class="fa-solid fa-plus"></i></a>
			</div>
		</div>
		<div class="check_sub" id="check_sub_option">
			<div class="checkbox_item">
				<label for="allow_app" class="check_label">
					<input type="checkbox" class="checkbox" id="allow_app" name="check_option">
					<span>앱 푸시</span>
				</label>
			</div>
			<div class="checkbox_item">
				<label for="allow_sms" class="check_label">
					<input type="checkbox" class="checkbox" id="allow_sms" name="check_option">
					<span>문자 메시지</span>
				</label>
			</div>
			<div class="checkbox_item">
				<label for="allow_email" class="check_label">
					<input type="checkbox" class="checkbox" id="allow_email" name="check_option">
					<span>이메일</span>
				</label>
			</div>
		</div>
		<p class="input_err" id="input_err_checkbox"></p>
	</div>
	
	<input type="button" class="join_btn" value="가입하기">
	<input type="hidden" id="chkUsername">
	<input type="hidden" id="chkPhoneNum">
	<input type="hidden" id="authPhone">
</div>

<!-- 모달 -->
<div class="layer_agreement layer">
	<div class="layer_container">
		<div class="layer_header">
			<h2 class="title">이용약관</h2>
		</div>
		<div class="layer_content">
			<div class="agreement_viewer">
				<strong>제 1 조 (목적)</strong>
				<p>이 약관은 "회원" 개인 상호 간 또는 “제휴 사업자”와 “회원” 개인 간에 상품 등을 매매하는 것을 중개하고, "상품" 등에 관한 정보를 상호 교환할 수 있도록 슈크림 주식회사(이하 "회사"라 합니다)가 운영, 제공하는 KREAM 서비스(이하 "서비스")에 대한 것으로 본 약관에서는 "서비스"의 이용과 관련하여 "회사"와 "회원"과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정합니다.</p>
			</div>
			<div class="agreement_viewer">
				<strong>제 2 조 (용어의 정의)</strong>
				<p>이 약관에서 사용하는 용어의 정의는 다음 각 호와 같으며, 정의되지 않은 용어에 대한 해석은 관계 법령 및 지침, 본 이용약관, 개인정보취급방침, 상관례 등에 의합니다.</p>
				<ul>
					<li>"서비스"라 함은 회사가 PC 및/또는 모바일 환경에서 제공하는 KREAM 서비스 및 관련 제반 서비스를 말합니다.</li>
					<li>"회원"이라 함은 "회사"의 "서비스"에 접속하여 이 약관에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다.</li>
				</ul>
			</div>		
			<div class="agreement_viewer">
				<strong>제 3 조 (약관의 명시, 효력 및 변경)</strong>
				<p>이 약관은 "회원" 개인 상호 간 또는 “제휴 사업자”와 “회원” 개인 간에 상품 등을 매매하는 것을 중개하고, "상품" 등에 관한 정보를 상호 교환할 수 있도록 슈크림 주식회사(이하 "회사"라 합니다)가 운영, 제공하는 KREAM 서비스(이하 "서비스")에 대한 것으로 본 약관에서는 "서비스"의 이용과 관련하여 "회사"와 "회원"과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정합니다.</p>
			</div>		
			<div class="agreement_viewer">
				<strong>제 4 조 (약관의 해석)</strong>
				<p>이 약관은 "회원" 개인 상호 간 또는 “제휴 사업자”와 “회원” 개인 간에 상품 등을 매매하는 것을 중개하고, "상품" 등에 관한 정보를 상호 교환할 수 있도록 슈크림 주식회사(이하 "회사"라 합니다)가 운영, 제공하는 KREAM 서비스(이하 "서비스")에 대한 것으로 본 약관에서는 "서비스"의 이용과 관련하여 "회사"와 "회원"과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정합니다.</p>
			</div>		
			<div class="agreement_viewer">
				<strong>제 5 조 (이용계약의 체결)</strong>
				<p>1. 이용계약은 "회원"이 되고자 하는 자(이하 "가입신청자")가 약관의 내용에 대하여 동의를 한 후 회원가입신청을 하고 "회사"가 이러한 신청에 대하여 승낙함으로써 체결됩니다. "회사"는 "가입신청자"의 신청에 대하여 서비스 이용을 승낙함을 원칙으로 합니다. 다만, "회사"는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않거나, 사후에 이용계약을 해지할 수 있습니다.</p>
				<p>2. "회사"는 "서비스" 관련 설비의 여유가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다.</p>
				<p>3. 회원가입신청의 승낙을 하지 아니하거나 유보한 경우, "회사"는 원칙적으로 이를 "가입신청자"에게 알리도록 합니다.</p>
				<p>4. 이용계약의 성립 시기는 "회사"가 가입완료를 신청절차 상에서 표시한 시점으로 합니다.</p>
				<p>5. "회사"는 "회원"에 대해 회사정책에 따라 등급별로 구분하여 이용시간, 이용횟수, 서비스 메뉴 등을 세분하여 이용에 차등을 둘 수 있습니다.</p>			
			</div>		
			<div class="agreement_viewer">
				<strong>제 6 조 ("회원"의 "아이디" 및 "비밀번호"의 관리에 대한 의무)</strong>
				<p>1. "회원"의 "아이디"와 "비밀번호"에 관한 관리책임은 "회원"에게 있으며, 이를 제3자가 이용하도록 하여서는 안 됩니다.</p>
				<p>2. "회사"는 "회원"의 "아이디"가 개인정보 유출 우려가 있거나, 회사 및 회사의 운영자로 오인한 우려가 있는 경우 등 "회원" 및 "서비스" 보호에 필요한 경우 해당 "아이디"의 이용을 제한할 수 있습니다.</p>
				<p>3. "회원"은 "아이디"및 "비밀번호"가 도용되거나 제3자가 사용하고 있음을 인지한 경우에는 이를 즉시 "회사"에 통지하고 "회사"의 안내에 따라야 합니다.</p>
				<p>4. 제3항의 경우에 해당 "회원"이 "회사"에 그 사실을 통지하지 않거나, 통지한 경우에도 "회사"의 안내에 따르지 않아 발생한 불이익에 대하여 "회사"는 책임지지 않습니다.</p>
			</div>				
		</div>
		<div>
			<a href=javascript:; class="layer_close_btn"><i class="fa-solid fa-xmark"></i></a>
		</div>
	</div>
</div>

<!-- 모달 -->
<div class="layer_auth layer">
	<div class="layer_container">
		<div class="layer_header">
			<h2 class="title">인증번호를 입력해주세요.</h2>
		</div>
		<div class="layer_content">
			<div class="input_box">
				<h3 class="input_title"></h3>
				<input type="text" class="input_txt" id="input_authPhone" placeholder="인증번호 입력" autocomplete="off">
				<input type="button" class="check_btn" value="확인">
				<p class="input_msg" id="input_msg"></p>
			</div>
		</div>
		<div>
			<a href=javascript:; class="layer_close_btn"><i class="fa-solid fa-xmark"></i></a>
		</div>
	</div>
</div>
</form>
<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
$(function(){
	const group1 = $('#group_1');
	const group2 = $('#group_2');
	const group1List = [$('#allow_agreement'), $('#allow_privacy')];
	const group2List = [$('#allow_app'), $('#allow_sms'), $('#allow_email')];
	
	<!-- 토글버튼 -->
	$('.btn').click(function(){
		$(this).children('i').toggleClass('fa-solid fa-minus fa-solid fa-plus');
	
		if($(this).hasClass('essential')){
			$('#check_sub_essential').toggle();
		}else if($(this).hasClass('option')){
			$('#check_sub_option').toggle();
		}
	});
	
 	$('#group_1').click(function(){
		const checked = $('#group_1').is(':checked');
		
		if(checked){
			checkAll(group1List);
		}else{
			resetAll(group1List);
		}
	});
	
	$('#group_2').click(function(){
		const checked = $('#group_2').is(':checked');
		
		if(checked){
			checkAll(group2List);
		}else{
			resetAll(group2List);
		}
	});
	
	$('input:checkbox[name="check_essential"]').click(function(){
		const listSize = $('input:checkbox[name="check_essential"]').length;
		const checkCount = $('input:checkbox[name="check_essential"]:checked').length;
		
		setCheckbox(listSize, checkCount, group1);
	});
	
	$('input:checkbox[name="check_option"]').click(function(){
		const listSize = $('input:checkbox[name="check_option"]').length;
		const checkCount = $('input:checkbox[name="check_option"]:checked').length;
		
		setCheckbox(listSize, checkCount, group2);
	});
	
	$('#input_username').on('input change keyup keydown', function(){
		isUsername();
		chkUsername();
	});
	
	$('#input_phoneNum').on('input', function(){
		<!-- 숫자만 입력 -->
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		isPhoneNum();
		chkPhoneNum();
	});
	
	$('#group_1, #allow_agreement, #allow_privacy').click(function(){
		isCheckbox();
	});
	
	<!-- 회원가입 -->
	$('.join_btn').click(function(){
		$('.input_msg').text('');
		
		<!-- 유효성 검사 -->
		isUsername();
		chkUsername();
		isPhoneNum();
		chkPhoneNum();
		isCheckbox();
		
		const username = $('#input_username').attr('validation');
		const validUsername = $('#chkUsername').attr('validation');
		const phoneNum = $('#input_phoneNum').attr('validation');
		const validPhoneNum = $('#chkPhoneNum').attr('validation');
		const checkbox = $('#group_1').attr('validation');
		
		if(username=='true'&&validUsername=='true'&&phoneNum=='true'&&validPhoneNum=='true'&&checkbox=='true'){
			<!-- 휴대폰 본인인증 -->
			$.ajax({
	        	type:'post',
	            url:'/shoeCream/user/authPhoneNum',
	            data:{
	               'phoneNum':$('#input_phoneNum').val()
	            },
	            success:function(data){
	            	if(data.result=='success'){
	            		$('.layer_auth').css('display', 'flex');
		        		$('body').css('overflow', 'hidden');
		            	
		            	$('#authPhone').val(data.randomNumber);
		            	$('#input_authPhone').focus();
	            	}
	            },
	            error:function(){
	               alert('Error: 휴대폰 본인인증');
	        	}
	    	}); // end ajax(본인인증)
		}
	});
	
	<!-- 휴대폰 인증번호 확인 -->
	$('.check_btn').click(function(){
		if($('#input_authPhone').val()==''){
			$(this).next('p').text('인증번호를 정확히 입력해주세요.');
		}else{
			if($('#input_authPhone').val()==$('#authPhone').val()){
				$.ajax({
					type:'post',
					url:'/shoeCream/user/joinSocialOk',
					data:{
						'email':$('#input_email').val(),
						'username':$('#input_username').val(),
						'phoneNum':$('#input_phoneNum').val(),
						'fullName':'${userInfo.nickname}',
						'img':'${userInfo.profile_image}',
						'accessToken':'${accessToken}'
					},
					success:function(){
						Swal.fire({
							text:'회원가입이 완료되었습니다.',
							icon:'success'
						}).then((result) => {
							location.href='/shoeCream/index.jsp';
						});
					},
					error:function(){
						alert('Error: 소셜 회원가입');
					}
				}); // end ajax(회원가입)			
			}else{
				$(this).next('p').text('인증번호를 정확히 입력해주세요.');
			}			
		}			
	});
	
	<!-- 약관 보기 -->
	$('.view_btn').click(function(){
		$('.layer_agreement').css('display', 'flex');
		$('body').css('overflow', 'hidden');
	});
	
	$('.layer_close_btn').click(function(){
		$('.layer').css('display', 'none');
		$('body').css('overflow', 'auto');
		$('#authPhone').val('');
	});
	
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
						$('#input_err_username').text('이미 사용 중인 아이디입니다.');
				    	$('.username_box').css('color', '#d5624f');
				    	$('#chkUsername').attr('validation', 'false');
					}else if(data=='not_exist'){
						$('#input_err_username').text('');
						$('.username_box').css('color', 'black');
				    	$('#chkUsername').attr('validation', 'true');
					}
				},
				error:function(err){
					alert("Error: 아이디 중복체크");
				}
			}); // end ajax
		}
	}
	
	<!-- 휴대폰 번호 유효성 검사 -->
	function isPhoneNum(){
		const phoneNum = $('#input_phoneNum').val();
		const reg = RegExp(/^(?:(010\d{4})|(01[1|6|7|8|9]\d{3,4}))(\d{4})$/);
		
		if($('#input_phoneNum').val()==''){
			$('#input_err_phoneNum').text('필수 정보입니다.');
			$('#input_phoneNum').attr('validation', 'false');
			return;
		}
		
		if (!reg.test(phoneNum)){
			$('#input_err_phoneNum').text('휴대폰 번호를 정확히 입력해주세요.');
			$('.phoneNum_box').css('color', '#d5624f');
			$('#input_phoneNum').attr('validation', 'false');
		}else{
			$('#input_err_phoneNum').text('');
	    	$('.phoneNum_box').css('color', 'black');
	    	$('#input_phoneNum').attr('validation', 'true');
			
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
						$('#input_err_phoneNum').text('이미 가입된 번호입니다.');
				    	$('.phoneNum_box').css('color', '#d5624f');
				    	$('#chkPhoneNum').attr('validation', 'false');
					}else if(data=='not_exist'){
						$('#input_err_phoneNum').text('');
						$('.phoneNum_box').css('color', 'black');
				    	$('#chkPhoneNum').attr('validation', 'true');
					}
				},
				error:function(err){
					alert("Error: 휴대폰 번호 중복체크");
				}
			}); // end ajax
		}
	}
	
	<!-- 체크박스 유효성 검사 -->
	function isCheckbox(){
		if(!$('#group_1').prop('checked')){
			$('#input_err_checkbox').text('슈크림 이용약관과 개인정보 수집 및 이용에 대한 안내 모두 동의해주세요.');
			$('#group_1').attr('validation', 'false');
		}else{
			$('#input_err_checkbox').text('');
			$('#group_1').attr('validation', 'true');
		}
	}
	
	<!-- 전체선택 -->
	function checkAll(list){
		list.forEach(function(item){
			$(item).prop('checked', true);
		});
	}
	
	<!-- 전체해제 -->
	function resetAll(list){
		list.forEach(function(item){
			$(item).prop('checked', false);
		});
	}
	
	<!-- 서브 체크박스가 모두 체크되면 그룹 체크박스 체크/하나라도 체크가 해제되면 그룹 체크박스 언체크 -->
	function setCheckbox(size, count, group){
		if(size==count){
			$(group).prop('checked', true);
		}else{
			$(group).prop('checked', false);
		}
	}
});

</script>
</body>
</html>