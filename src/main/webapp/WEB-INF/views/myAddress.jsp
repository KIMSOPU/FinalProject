<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/shoeCream/resources/css/myAddress.css">

<body>
<div class="myAddress">
	<div class="content_title">
		<h3 id="title_name">주소록</h3>
		<div class="btn_box">
			<a href=javascript:; class="btn add_btn">
				<span class="txt_btn">+ 새 배송지 추가</span>
			</a>
		</div>
	</div>
	<div class="myAddress_info">
		<c:forEach var="item" items='${addressList}'>
		<c:if test="${item.defaultAddr=='Y'}">
		<div class="basic">
			<div class="basic_item" default-mark="기본 배송지">
				<div class="info_bind">
					<div class="name_box">
						<span class="name">${item.recipient}</span>
						<span class="mark">기본 배송지</span>
					</div>
					<div class="address_box">
						<span class="zipcode">${item.zipcode}</span>
						<span class="address">${item.addr1} ${item.addr2}</span>
					</div>
				</div>
				<div class="btn_bind">
					<button type="button" class="btn modify_btn"> 수정 </button>
					<button type="button" class="btn delete_btn"> 삭제 </button>
					<input type="hidden" id="addressId" value="${item.addressId}">
					<input type="hidden" id="defaultAddr" value="${item.defaultAddr}">
					<input type="hidden" id="recipient" value="${item.recipient}">
					<input type="hidden" id="zipcode" value="${item.zipcode}">
					<input type="hidden" id="addr1" value="${item.addr1}">
					<input type="hidden" id="addr2" value="${item.addr2}">
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${item.defaultAddr=='N'}">
		<div class="other">
			<div class="other_list">
				<div class="info_bind">
					<div class="name_box">
						<span class="name">${item.recipient}</span>
					</div>
					<div class="address_box">
						<span class="zipcode">${item.zipcode}</span>
						<span class="address">${item.addr1} ${item.addr2}</span>
					</div>
				</div>
				<div class="btn_bind">
					<button type="button" class="btn default_btn"> 기본 배송지 </button>
					<button type="button" class="btn modify_btn"> 수정 </button>
					<button type="button" class="btn delete_btn"> 삭제 </button>
					<input type="hidden" id="addressId" value="${item.addressId}">
					<input type="hidden" id="defaultAddr" value="${item.defaultAddr}">
					<input type="hidden" id="recipient" value="${item.recipient}">
					<input type="hidden" id="zipcode" value="${item.zipcode}">
					<input type="hidden" id="addr1" value="${item.addr1}">
					<input type="hidden" id="addr2" value="${item.addr2}">
				</div>
			</div>
		</div>
		</c:if>
		</c:forEach>
	</div>
</div>
<div class="pagingDiv" id="pagingDiv">${paging.pagingHTML}</div>
<input type="hidden" id="pg" value="${pg}">
<input type="hidden" id="addressList" value="${addressList}">

<!-- 모달 -->
<div class="layer_delivery layer">
	<div class="layer_container">
		<div class="layer_header">
			<h2 class="title"></h2>
		</div>
		<div class="layer_content">
			<div class="delivery_bind">
				<div class="delivery_input">
					<div class="input_box">
						<h5 class="input_title">수령인</h5>
						<input type="text" class="input_txt" id="input_recipient" autocomplete="off" placeholder="수령인의 이름">
						<p class="input_err">올바른 이름을 입력해주세요. (2-4자)</p>
					</div>
					<div class="input_box">
						<h5 class="input_title">우편번호</h5>
						<input type="text" class="input_txt" id="input_zipcode" autocomplete="off" placeholder="우편 번호를 검색하세요" readonly>
						<a href="#" class="btn zipcode_btn"> 우편번호 </a>
					</div>
					<div class="input_box">
						<h5 class="input_title">주소</h5>
						<input type="text" class="input_txt" id="input_addr1" autocomplete="off" placeholder="우편 번호 검색 후, 자동입력 됩니다" readonly>
					</div>
					<div class="input_box">
						<h5 class="input_title">상세 주소</h5>
						<input type="text" class="input_txt" id="input_addr2" autocomplete="off" placeholder="건물, 아파트, 동/호수 입력">
					</div>
				</div>
				<div class="delivery_check">
					<div class="checkbox_item">
						<label for="check1" class="check_label">
							<input type="checkbox" id="check1">
							<span class="label_txt">기본 배송지로 설정</span>
						</label>
					</div>
				</div>
			</div>
			<div class="layer_btn">
				<a href=javascript:; class="btn cancel_btn"> 취소 </a>
				<a href=javascript:; class="btn save_btn"> 저장 </a>
				<input type="hidden" id="target">
			</div>
		</div>
		<div>
			<a href=javascript:; class="layer_close_btn"><i class="fa-solid fa-xmark"></i></a>
		</div>
	</div>
</div>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
$(function(){
	$('.add_btn').click(function(){
		$('.layer_delivery .title').text('새 주소 추가');
		$('.layer_delivery').css('display', 'flex');
		$('body').css('overflow', 'auto');
	});	
	
	$('.modify_btn').click(function(){
		$('#target').val($(this).siblings('#addressId').val());
		
		/* 모달은 정보 입력된 상태로 보여주기 */
		$('#input_zipcode').val($(this).siblings('#zipcode').val());
		$('#input_addr1').val($(this).siblings('#addr1').val());
		$('#input_addr2').val($(this).siblings('#addr2').val());
		
		if($(this).siblings('#defaultAddr').val()=='Y'){
			$('#check1').prop('checked', true);
		}
		
		$('.layer_delivery .title').text('배송지 수정');
		$('.layer_delivery').css('display', 'flex');
		$('body').css('overflow', 'hidden');
	});
	
	$('.save_btn').click(function(){
		if($(this).hasClass('save_btn_able')){
			<!-- 체크박스 확인 -->
			let defaultAddr = ''
			const checked = $('#check1').is(':checked');
			
			if(!checked){
				defaultAddr = 'N'
			}else{
				defaultAddr = 'Y'
			}
			
			<!-- 배송지 추가 -->
			if($('.title').text()=='새 주소 추가'){
				$.ajax({
					type:'get',
					url:'/shoeCream/my/registerAddress',
					data:{
						'recipient':$('#input_recipient').val(),
						'zipcode':$('#input_zipcode').val(),
						'addr1':$('#input_addr1').val(),
						'addr2':$('#input_addr2').val(),
						'defaultAddr':defaultAddr
					},
					success:function(){
						location.href="/shoeCream/my/myAddress";
					},
					error:function(){
						alert('Error: 새 주소 추가')
					}
				}); // end ajax
			
			<!-- 배송지 수정 -->	
			}else if($('.title').text()=='배송지 수정'){
				$.ajax({
					type:'get',
					url:'/shoeCream/my/updateAddress',
					data:{
						'recipient':$('#input_recipient').val(),
						'zipcode':$('#input_zipcode').val(),
						'addr1':$('#input_addr1').val(),
						'addr2':$('#input_addr2').val(),
						'defaultAddr':defaultAddr,
						'addressId':$('#target').val()
					},
					success:function(){
						location.href="/shoeCream/my/myAddress";
					},
					error:function(){
						alert('Error: 배송지 수정')
					}
				}); // end ajax
			}
		}
	});
	
	<!-- 배송지 삭제 -->
	$('.delete_btn').click(function(){
		$('#target').val($(this).siblings('#addressId').val());
		const defaultAddr = $(this).siblings('#defaultAddr').val();
		
		if(defaultAddr=='Y'){
			Swal.fire({
            	text:'다른 주소를 기본배송지로 변경 후, 삭제할 수 있습니다.',
            	icon:'info'
          	})
		}else if(defaultAddr=='N'){
			$.ajax({
				type:'get',
				url:'/shoeCream/my/deleteAddress',
				data:'addressId='+$('#target').val(),
				success:function(){
					location.reload();
				},
				error:function(){
					alert('Error: 배송지 삭제');
				}
			}); // end ajax
		}
		
	});	
	
	<!-- 기본 배송지 -->
	$('.default_btn').click(function(){
		const addressId = $(this).siblings('#addressId').val();

		$.ajax({
			type:'get',
			url:'/shoeCream/my/setDefaultAddr',
			data:'addressId='+addressId,
			success:function(){
				location.href="/shoeCream/my/myAddress"
			},
			error:function(){
				alert('Error: 기본 배송지 설정')
			}
		}); // end ajax
	});

	$('.zipcode_btn').click(function(){
		checkPost();
	});
	
	$('.cancel_btn, .layer_close_btn').click(function(){
		$('.layer_delivery').css('display', 'none');
		$('body').css('overflow', 'auto');
		
		$('.input_txt').val('');
		$('#check1').prop('checked', false);
		$('.input_err').hide();
	});
	
	$('#input_recipient').on('input', function(){
		isRecipient();
		setBtn();
	});
	
	<!-- readonly input box -->
	$('#input_zipcode, #input_addr1').on('input', function(){
		console.log("Input text changed!" + $(this).val());
		isAddress();
	});
	
	(function ($) {
		var originalVal = $.fn.val;
	    $.fn.val = function (value) {
	        var res = originalVal.apply(this, arguments);
	 
	        if (this.is('input:text') && arguments.length >= 1) {
	            this.trigger("input");
	        }
	        
	        return res;
	    };
	})(jQuery);
	
	$('#input_addr2').on('input', function(){
		isAddress();
		setBtn();
	});
})

	<!-- 페이징 -->
	function paging(pg) {
		location.href = '/shoeCream/my/myAddress?pg='+pg;
	}
	
	<!-- 유효성 검사 -->
	function isRecipient(){
		const recipient = $('#input_recipient').val();
		const reg = RegExp(/^[가-힣]{2,4}$/);
		
		if(recipient==''){
			$('#input_recipient').attr('validation', 'false');
			$('.input_err').show();
			return;
		}
		
		if(!reg.test(recipient)){
			$('#input_recipient').attr('validation', 'false');
			$('.input_err').show();
		}else{
			$('#input_recipient').attr('validation', 'true');
			$('.input_err').hide();
		}
	}
	
	function isAddress(){
		const zipcode = $('#input_zipcode').val();
		const addr1 = $('#input_addr1').val();
		const addr2 = $('#input_addr2').val();
		
		if(zipcode==''){
			$('#input_zipcode').attr('validation', 'false');
		}else{
			$('#input_zipcode').attr('validation', 'true');
		}
		
		if(addr1==''){
			$('#input_addr1').attr('validation', 'false');
		}else{
			$('#input_addr1').attr('validation', 'true');
		}
		
		if(addr2==''){
			$('#input_addr2').attr('validation', 'false');
		}else{
			$('#input_addr2').attr('validation', 'true');
		}
	}
	
	<!-- 버튼 활성화 -->
	function setBtn(){
		const recipient = $('#input_recipient').attr('validation');
		const zipcode = $('#input_zipcode').attr('validation');
		const addr1 = $('#input_addr1').attr('validation');
		const addr2 = $('#input_addr2').attr('validation');
		
		if(recipient=='true'&&zipcode=='true'&&addr1=='true'&&addr2=='true'){
			$('.save_btn').addClass('save_btn_able');
		}else{
			$('.save_btn').removeClass('save_btn_able');
		}
	}
		
	<!-- 다음 우편 번호 서비스 -->
	function checkPost() {
		new daum.Postcode({
			oncomplete : function(data) {
				var addr = '';
				
				if (data.userSelectedType === 'R') {
					addr = data.roadAddress;
					
				} else {
					addr = data.jibunAddress;
				}
				
				$('#input_zipcode').val(data.zonecode);
				$('#input_addr1').val(addr);
				$('#input_addr2').val(''); // 초기화
				$('#input_addr2').focus();
			}
		}).open();
	}
	
	<!-- 마스킹 처리 -->
	function maskingRecipient(recipient){
		return recipient.replace(/(?<=.{1})./gi, '*');
	}

</script>
</body>
</html>