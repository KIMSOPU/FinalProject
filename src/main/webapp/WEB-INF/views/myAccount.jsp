<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/shoeCream/resources/css/myAccount.css">

<body>
<div class="myAccount">
	<div class="content_title">
		<h3 id="title_name">정산 계좌 등록</h3>
	</div>
	
	<div class="content_area">
		<c:if test="${accountDTO!=null}">
		<div class="registered_account_box">
			<h4 class="box_title">등록된 계좌 정보</h4>
			<p class="box_account_info">
				<span class="account">${accountDTO.bank}${accountDTO.accountNum}</span>
				<span class="account_devider">/</span>
				<span class="name">${accountDTO.accountHolder}</span>
			</p>
		</div>
		</c:if>
		
		<div class="account_registeration">
			<div class="input_companies input_box">
				<h4 class="input_title">은행명</h4>
				<input type="text" class="input_txt" id="input_bank" placeholder="선택하세요" readonly="readonly" autocomplete="off">
				<button type="button" class="dropdown_btn"><i class="fa-solid fa-circle-chevron-down"></i></button>
				<div class="layer_dropdown layer">
					<div class="layer_container">
						<div class="layer_content">
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">국민은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">신한은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">우리은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">하나은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">기업은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">농협은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">우체국</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">부산은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">제주은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">SC은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">한국씨티은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">산업은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">카카오뱅크</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="input_box">
				<h4 class="input_title">계좌번호</h4>
				<input type="text" class="input_txt" id="input_accountNum" placeholder="- 없이 입력하세요" autocomplete="off">
				<p class="input_err">올바른 계좌번호를 입력해주세요.</p>
			</div>
			<div class="input_box">
				<h4 class="input_title">예금주</h4>
				<input type="text" class="input_txt" id="input_accountHolder" placeholder="예금주명을 정확히 입력하세요." autocomplete="off">
				<p class="input_err">올바른 이름을 입력해주세요. (2-50자)</p>
			</div>
		</div>
		<div class="registeration_btn_box">
			<a href=javascript:; class="btn save_btn"> 저장하기 </a>
		</div>
	</div>
</div>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	<!-- 등록된 계좌 확인 -->
	if('${accountDTO}'!=''){
		$('.save_btn').attr('class','btn modify_btn');
		$('.modify_btn').text(' 변경하기 ');
		$('#title_name').text('정산 계좌 변경');
		
		$('.account').text('${accountDTO.bank}'+maskingAccountNum('${accountDTO.accountNum}'));
		$('.name').text(maskingAccountHolder('${accountDTO.accountHolder}'));
	}
	
	$('#input_bank').click(function(){
		$('.layer').toggle('show');
	});
	
	$('.drop_link').click(function(){
		const item = $(this).text();
		$('.input_companies .input_txt').val(item);
		$('.layer').hide();
		$('#input_bank').attr('validation', 'true');
		setBtn();
	});
	
	$('#input_accountNum').on('input', function(){
		<!-- 숫자만 입력 -->
		$(this).val($(this).val().replace(/[^0-9]/g,''));
		isAccountNum();
		setBtn();
	});
	
	$('#input_accountHolder').on('input', function(){
		isAccountHolder();
		setBtn();
	});
	
	<!-- 정산 계좌 등록 -->
	$('.save_btn').click(function(){
		if($(this).hasClass('btn_able')){
			$.ajax({
				type:'post',
				url:'/shoeCream/my/registerAccount',
				data:{
					'bank':$('#input_bank').val(),
					'accountNum':$('#input_accountNum').val(),
					'accountHolder':$('#input_accountHolder').val()
				},
				success:function(){
					location.reload();
				},
				error:function(){
					alert('Error: 계좌 변경');
				}
			});
		}
	})
	
	<!-- 정산 계좌 변경 -->
	$('.modify_btn').click(function(){
		if($(this).hasClass('btn_able')){
			$.ajax({
				type:'post',
				url:'/shoeCream/my/updateAccount',
				data:{
					'bank':$('#input_bank').val(),
					'accountNum':$('#input_accountNum').val(),
					'accountHolder':$('#input_accountHolder').val()
				},
				success:function(){
					location.reload();
				},
				error:function(){
					alert('Error: 계좌 변경');
				}
			});
		}
	})
	
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
	
	<!-- 버튼 활성화 -->
	function setBtn(){
		if($('#input_bank').attr('validation')=='true'&&$('#input_accountNum').attr('validation')=='true'&&$('#input_accountHolder').attr('validation')=='true'){
			$('.btn').addClass('btn_able');
		}else{
			$('.btn').removeClass('btn_able');
		}
	}
	
	<!-- 은행 유효성 검사 -->
	function isBank(){
		if($('#input_bank').val()==''){
			setErr(false, '#input_bank');
		}else{
			setErr(true, '#input_bank');
		}
	}
	
	
	<!-- 계좌번호 유효성 검사 -->
	function isAccountNum(){
		const len = $('#input_accountNum').val().length;
		
		if($('#input_accountNum').val()==''){
			setErr(false, '#input_accountNum');
			return;
		}
		
		if(len<2){
			setErr(false, '#input_accountNum');
		}else{
			setErr(true, '#input_accountNum');
		}
	}
	
	<!-- 예금주 유효성 검사 -->
	function isAccountHolder(){
		const accountHolder = $('#input_accountHolder').val();
		const reg = RegExp(/^[가-힣]{2,4}$/);
		
		if($('#input_accountHolder').val()==''){
			setErr(false, '#input_accountHolder');
			return;
		}
		
		if(!reg.test(accountHolder)){
			setErr(false, '#input_accountHolder');
		}else{
			setErr(true, '#input_accountHolder');
		}
	}
	
	<!-- 마스킹 처리 -->
	function maskingAccountNum(accountNum){
		return accountNum.replace(/(?<=.{4})./gi, '*');
	}
	
	function maskingAccountHolder(accountHolder){
		return accountHolder.replace(/(?<=.{1})./gi, '*');
	}
	
});

</script>
</body>
</html>