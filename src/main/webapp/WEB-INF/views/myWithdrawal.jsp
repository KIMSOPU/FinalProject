<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/shoeCream/resources/css/myWithdrawal.css">
<body>
<div class="myWithdrawal">
	<div class="content_title">
		<h3 id="title_name">회원탈퇴</h3>
	</div>
	<div class=content_area>
		<h4 class="withdrawal_title">회원탈퇴에 앞서 아래 내용을 반드시 확인해 주세요.</h4>
		<div class="withdrawal_terms">
			<div class="terms_box">
				<div class="terms_title">
					<div class="checkbox_item">
						<input id="title0" type="checkbox">
						<label for="title0" class="check_label">
							<span class="label_txt">SHOECREAM을 탈퇴하면 회원 정보 및 서비스 이용 기록이 삭제됩니다.</span>
						</label>
					</div>
				</div>
				<div class="terms_detail">
					<ul class="terms_list">
						<li class="terms_item">내 프로필, 거래내역(구매/판매), 관심상품, 보유상품, STYLE 게시물(게시물/댓글), 미사용 보유 포인트 등 사용자의 모든 정보가 사라지며 재가입 하더라도 복구가 불가능합니다.</li>
						<li class="terms_item">탈퇴 14일 이내 재가입할 수 없으며, 탈퇴 후 동일 아이디로 재가입할 수 없습니다.</li>
					</ul>
				</div>
			</div>
				
			<div class="terms_box">
				<div class="terms_title">
					<div class="checkbox_item">
						<input id="title1" type="checkbox">
						<label for="title1" class="check_label">
							<span class="label_txt">관련 법령 및 내부 기준에 따라 별도 보관하는 경우에는 일부 정보가 보관될 수 있습니다.</span>
						</label>
					</div>
				</div>
				<div class="terms_detail">
					<h6 class="terms_subtitle"> 1. 전자상거래 등 소비자 보호에 관한 법률 </h6>
					<ul class="terms_list">
						<li class="terms_item">계약 또는 청약철회 등에 관한 기록: 5년 보관</li>
						<li class="terms_item">대금결제 및 재화 등의 공급에 관한 기록: 5년 보관</li>
						<li class="terms_item">소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관</li>
					</ul>
				</div>
				<div class="terms_detail">
					<h6 class="terms_subtitle"> 2. 통신비밀보호법 </h6>
					<ul class="terms_list">
						<li class="terms_item">접속 로그 기록: 3개월 보관</li>
					</ul>
				</div>
				<div class="terms_detail">
					<h6 class="terms_subtitle">  3. 내부 기준에 따라 별도 보관 </h6>
					<ul class="terms_list">
						<li class="terms_item">부정이용 방지를 위해 이름, 이메일(로그인ID), 휴대전화번호, CI/DI: 3년 보관</li>
					</ul>
				</div>
			</div>
			
			<div class="terms_box">
				<div class="terms_title">
					<div class="checkbox_item">
						<input id="title2" type="checkbox">
						<label for="title2" class="check_label">
							<span class="label_txt">SHOECREAM 탈퇴가 제한된 경우에는 아래 내용을 참고하시기 바랍니다.</span>
						</label>
					</div>
				</div>
				<div class="terms_detail">
					<ul class="terms_list">
						<li class="terms_item">진행 중인 거래(판매/구매)가 있을 경우: 해당 거래 종료 후 탈퇴 가능</li>
						<li class="terms_item">진행 중인 입찰(판매/구매)가 있을 경우: 해당 입찰 삭제 후 탈퇴 가능</li>
						<li class="terms_item">미납 수수료(착불 발송비/페널티)가 있을 경우: 해당 결제 완료 후 탈퇴 가능</li>
						<li class="terms_item">이용 정지 상태인 경우: 이용 정지 해제 후 탈퇴 가능</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="withdrawal_check">
		<div class="checkbox_item">
			<input id="check1" type="checkbox">
			<label for="check1" class="check_label">
				<span class="label_txt">회원탈퇴 안내를 모두 확인하였으며 탈퇴에 동의합니다.</span>
			</label>
		</div>
	</div>
	<div class="withdrawal_btn_box">
		<a class="btn withdrawal_btn"> 탈퇴하기 </a>
		<a class="btn cancel_btn"> 취소하기 </a>
	</div>
</div>

<!-- 모달 -->
<div class="layer_withdrawal layer">
	<div class="layer_container">
		<div class="layer_header">
			<h2 class="title"> 정말 탈퇴하시겠습니까? </h2>
		</div>
		<div class="layer_content">
			<p class="withdrawal_desc">
				탈퇴하기 클릭 시 바로 탈퇴 처리됩니다.
				<br>
				재가입 시 동일 아이디를 사용할 수 없습니다.
			</p>
			<div class="withdrawal_btn_box">
				<div class="checkbox_item">
					<input type="checkbox" id="undefined">
					<label for="undefined" class="check_label">
						<span class="label_txt">SHOECREAM 회원을 탈퇴하겠습니다.</span>
					</label>
				</div>
				<button type="button" class="btn cancel_btn"> 탈퇴 안 할래요 </button>
				<a class="link_withdrawal"> 탈퇴하기 </a>
			</div>
			<a class="btn_layer_close"></a>
		</div>
		<a href=javascript:; class="layer_close_btn"><i class="fa-solid fa-xmark"></i></a>
	</div>
</div>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>	
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$('.withdrawal_btn').click(function(){
	if($('.myWithdrawal input:checkbox').length==$('.myWithdrawal input:checkbox:checked').length){
		<!-- 모달 -->
		$('.layer').css('display', 'flex');
		$('body').css('overflow', 'hidden');
		
	}else{
		Swal.fire({
			text: '회원탈퇴 내용을 모두 동의해 주셔야 탈퇴가 가능합니다.',
			icon: 'warning'
		})
	}
});

$('.layer_close_btn, .cancel_btn').click(function(){
	$('#undefined').prop('checked', false);
	$('.layer').css('display', 'none');
	$('body').css('overflow', 'auto');
});

$('.link_withdrawal').click(function(){
	if($('#undefined').prop('checked')){
		$.ajax({
			type:'get',
			url:'/shoeCream/my/withdrawal',
			success:function(){
				Swal.fire({
					title: '회원탈퇴가 완료되었습니다.',
					text: '그동안 서비스를 이용해 주셔서 감사합니다.',
					icon: 'success'
				}).then((result) => {
                	location.href='/shoeCream/index.jsp';
            	});
			},
			error:function(){
				alert('Error: 회원탈퇴');
			}
		}); // end ajax
	}
});	
</script>
</body>
</html>