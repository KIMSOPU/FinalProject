
let productId;
let userInputPrice;
let userProductSize;
let priceTotal;
let account;
let IMG_SRC = "/shoeCream/images/productImg/";
let addr = [];
let addrMain;

$(function(){
	productId = $('#productId').val();
	userInputPrice = $('#userInputPrice').val();
	userProductSize = $('#userProductSize').val();
	priceTotal = Math.floor(userInputPrice) - Math.floor(userInputPrice*0.05) - Math.floor(userInputPrice*0.03);
	
	console.log('productId', productId);
	console.log('userInputPrice', userInputPrice);
	console.log('userProductSize', userProductSize);
	
	$.ajax({
		type: 'POST',
		url: '/shoeCream/shop/getShop',
		data: {productId: productId},
		success: function(data){
			console.log('data', data);
			
			//let IMG_SRC = "/shoeCream/images/productImg/";
			$('.shopDetail-top_Realimg').attr('src', IMG_SRC + data.shopDTO.img1);
			$('.product_modelId').text(data.shopDTO.modelId);
			$('.product_name').text(data.shopDTO.productName);
			$('.product_name_translate').text(data.shopDTO.productNameKor);
			
			$('.shopDetail-content').append(
				$('<h3/>', {text:'제품 사이즈: '+userProductSize}),
				$('<dl/>', {}).append(
					$('<dt/>', {text:'판매 희망가'}),
					$('<dd/>', {text:Math.floor(userInputPrice).toLocaleString() + '원'})
				)
			);
			$('.shopDetail-content2').append(
				$('<dl/>', {}).append(
					$('<dt/>', {text:'검수비'}),
					$('<dd/>', {text:Math.floor(userInputPrice * 0.05).toLocaleString() + '원'})
				),
				$('<dl/>', {}).append(
					$('<dt/>', {text:'판매 수수료'}),
					$('<dd/>', {text:Math.floor(userInputPrice * 0.03).toLocaleString() + '원'})
				),
				$('<dl/>', {}).append(
					$('<dt/>', {text:'배송비'}),
					$('<dd/>', {text:'무료'})
				)
			);
			$('.shopDetail-content3').append(
				$('<dl/>', {}).append(
					$('<dt/>', {text:'입금 예정금액'}),
					$('<dd/>', {text: priceTotal.toLocaleString() + '원'})
				),
				$('<input/>', {type:'button', class:'continue-sell-button sell-page2', value:'판매 계속'})
			);
		},
		error: function(err) {
	        alert("페이지 에러났습니다");
	        console.log(err);
	    }
		
	});//end ajax
	
	$.ajax({
		type: 'GET',
		url: '/shoeCream/my/getMyAccount',
		success: function(accountData){
			console.log('accountData', accountData);
			account = accountData;
			console.log('account', account);
		},
		error: function(err) {
	        alert("계좌 에러났습니다");
	        console.log(err);
	    }
	}); // end ajax
	
/*	$.ajax({
		type: 'GET',
		url: '/shoeCream/my/getMyAddress',
		success: function(addressData){
			console.log('addressData', addressData);
			address = addressData;
			console.log('address', address);
		},
		error: function(err) {
	        alert("주소 에러났습니다");
	        console.log(err);
	    }
	}); // end ajax */
	
	
});//end onload

$(document).on("click", ".sell-page2", function(){
	$.ajax({
		type: 'POST',
		url: '/shoeCream/shop/getShopSalesView',
		data: {
			productId: productId,
			userInputPrice: userInputPrice,
			userProductSize: userProductSize
		},
		success: function(data){
			console.log(data);
			$('.shopDetail-content').empty();
			$('.shopDetail-content2').empty();
			$('.shopDetail-content3').empty();
			
			$('.shopDetail-content').append(
				$('<div/>', {}).append(
					$('<h3/>', {text:'판매 정산 계좌'})
				)
				
			)//end shopDetail-content
			
			if(account != null){
				$('.shopDetail-content').append(
					$('<div/>', {class:'registered_account_box'}).append(
						$('<div/>', {class:'account_div'}).append(
							$('<p/>', {class:'registered_account_text', text:'등록된 계좌 정보'}),
							$('<p/>', {}).append(
								$('<span/>', {class:'account', text: account.bank+' '+account.accountNum}),
								$('<span/>', {class:'account_devider', text:' / '}),
								$('<span/>', {class:'name', text: account.accountHolder})
							)
						),
						$('<input>', {type:'button', value:'계좌 변경', class:'continue-sell-button btn-sm view-account-btn'})
					)
				)//end shopDetail-content
				$('.layer_account .title').text('계좌 변경');
			} else {
				$('.shopDetail-content').append(
					$('<div/>', {class:'account_div'}).append(
						$('<p/>', {text:'계좌를 추가 해주세요.'}),
						$('<input>', {type:'button', value:'계좌 추가', class:'continue-sell-button btn-sm view-account-btn'})
					)
				)//end shopDetail-content
			}
			
			$('.shopDetail-content2').append(
				$('<div/>', {class:'address_div'}).append(
					$('<h3/>', {text:'반송 주소'})
				),
				
				$('<div/>', {class:'registered_account_box'}).append(
					$('<div/>', {class:''}).append(
						$('<p/>', {class:'registered_account_text', text:'기본 배송지'}),
						$('<p/>', {class:'registered_account_change_text1', text:$('.basic .name').text()}),
						$('<div/>', {class:'registered_account_change_text_div'}).append(
							$('<p/>', {class:'registered_account_change_text2', text:$('.basic .zipcode').text()}),	//text: data.addrMain
							$('<p/>', {class:'registered_account_change_text3', text:$('.basic .address').text()})
						)
					),
					$('<div/>', {class:'address_btn_div'}).append(
						$('<input>', {type:'button', value:'배송지 목록', class:'continue-sell-button btn-sm address-btn'}),
						$('<input>', {type:'button', value:'주소 추가', class:'continue-sell-button btn-sm view-address-btn'})
					)
				)
				
			)//end shopDetail-content2
			
			$('.shopDetail-content3').append(
				$('<div/>', {class:''}).append(
					$('<h3/>', {text:'발송 방법'}),
					$('<div/>', {class:''})
				)
			)//end shopDetail-content3
			
			$('.body').append(
				$('<div/>', {class:'shopDetail-content4'}).append(
					$('<h3/>', {text:'최종 주문 정보'}),
					$('<dl/>', {}).append(
						$('<dt/>', {text:'입금 예정금액'}),
						$('<dd/>', {text:priceTotal.toLocaleString() + '원'})
					),
					$('<input/>', {type:'button', class:'continue-sell-button wrap-up-sell', value:'판매 등록하기'})
				)
			)
		},
		error: function(err) {
	        alert("넘어가다가 페이지 에러났습니다");
	        console.log(err);
	    }
	});//end ajax
	
});//end click

// 주소 모달창
$(document).on("click", '.view-address-btn', function(){
	$('.layer_delivery').css('display', 'flex');
	$('body').css('overflow', 'auto');
	
	/*
	$('.layer_content').empty();
	
	$('.layer_content').append(
		$('<div/>', {class:'delivery_bind'}).append(
			$('<div/>', {class:'delivery_input'}).append(
				$('<div/>', {class:'input_box'}).append(
					$('<h5/>', {class:'input_title', text:'수령인'}),
					$('<input>', {class:'input_txt', type:'text', id:'input_recipient', autocomplete:'off', placeholder:'수령인의 이름'}),
					$('<p/>', {class:'input_err', text:'올바른 이름을 입력해주세요. (2~4자)'})
				),
				$('<div/>', {class:'input_box'}).append(
					$('<h5/>', {class:'input_title', text:'우편번호'}),
					$('<input>', {class:'input_txt', type:'text', id:'input_zipcode', autocomplete:'off', placeholder:'우편 번호를 검색하세요', readonly:'true'}),
					$('<a/>', {class:'btn zipcode_btn', href:"#", text:'우편번호'})
				),
				$('<div/>', {class:'input_box'}).append(
					$('<h5/>', {class:'input_title', text:'주소'}),
					$('<input>', {class:'input_txt', type:'text', id:'input_addr1', autocomplete:'off', placeholder:'우편 번호 검색 후, 자동입력 됩니다', readonly:'true'})
				),
				$('<div/>', {class:'input_box'}).append(
					$('<h5/>', {class:'input_title', text:'상세 주소'}),
					$('<input>', {class:'input_txt', type:'text', id:'input_addr2', autocomplete:'off', placeholder:'건물, 아파트, 동/호수 입력'})
				)
			),
			$('<div/>', {class:'delivery_check'}).append(
				$('<div/>', {class:'checkbox_item'}).append(
					$('<label/>', {class:'check_label', for:'check1'}).append(
						$('<input/>', {type:'checkbox', id:'check1'}),
						$('<span/>', {class:'label_txt', text:'기본 배송지로 설정'})
					)
				)
			)
		),//end append .delivery_bind
		$('<div/>', {class:'layer_btn'}).append(
			$('<a/>', {class:'btn cancel_btn', href:'javascript:;', text:'취소'}),
			$('<a/>', {class:'btn save_btn', href:'javascript:;', text:'저장'})
		)
	);//end append .layer_content
	
	$('<div/>', {}).append(
		$('<a/>', {class:'layer_close_btn', href:'javascript:;'}).append(
			$('<i/>', {class:'fa-solid fa-xmark'})
		)
	).appendTo('.layer_container');
	*/
});// end click '.view-address-btn'

// 계좌 모달창
$(document).on("click", '.view-account-btn', function(){
	$('.layer_account').css('display', 'flex');
	$('body').css('overflow', 'auto');
});

$('.cancel_btn, .layer_close_btn').click(function(){ 
	$('.layer').css('display', 'none');
	$('body').css('overflow', 'auto');
	$('.input_txt').val('');
	$('#check1').prop('checked', false);
	$('.input_err').hide();
});

/* 계좌 변경 */
$('#input_bank').click(function(){ 
	$('.layer_dropdown').toggle('show');
});

$('.drop_link').click(function(){
	const item = $(this).text();
	$('#input_bank').val(item);
	isBank();
	setAccountBtn();
	$('.layer_dropdown').toggle('hide');
});

$('#input_accountNum').on('input', function(){
	$(this).val($(this).val().replace(/[^0-9]/g,''));
	isAccountNum();
	setAccountBtn();
});
	
$('#input_accountHolder').on('input', function(){
	isAccountHolder();
	setAccountBtn();
});

$('#save_address').click(function(){
	if($(this).hasClass('save_btn_able')){
		// 기본 배송지로 설정 확인
		let defaultAddr = ''
		const checked = $('#check1').is(':checked');
		
		if(!checked){
			defaultAddr = 'N'
		} else {
			defaultAddr = 'Y'
		}
		
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
				// 수정 정보
				
				$('.cancel_btn, .layer_close_btn').trigger('click');
				location.reload();
			},
			error:function(){
				alert('Error: 새 주소 추가')
			}
		}); // end ajax
	}
});

$('#save_account').click(function(){
	if($(this).hasClass('save_btn_able')){
		$.ajax({
			type:'post',
			url:'/shoeCream/my/updateAccount',
			data:{
				'bank':$('#input_bank').val(),
				'accountNum':$('#input_accountNum').val(),
				'accountHolder':$('#input_accountHolder').val()
			},
			success:function(){
				$('.shopDetail-content .account').text($('#input_bank').val()+ ' ' +$('#input_accountNum').val());
				$('.shopDetail-content .name').text($('#input_accountHolder').val());
				$('.cancel_btn, .layer_close_btn').trigger('click');
			},
			error:function(){
				alert('Error: 계좌 변경');
			}
		}); // end ajax
	}
});

/* 주소 추가 */
$('.zipcode_btn').click(function(){
	checkPost();
});

$('#input_recipient').on('input', function(){
	isRecipient();
	setAddressBtn();
});

// readonly input box
$('#input_zipcode, #input_addr1').on('input', function(){
	console.log("Input text changed!" + $(this).val());
	isAddress();
	
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
});


$('#input_addr2').on('input', function(){
	isAddress();
	setAddressBtn();
});

/* 판매 완료하기 버튼 */
$(document).on('click', '.wrap-up-sell', function(){
	$.ajax({
		type: 'POST',
		url: '/shoeCream/shop/insertSalesData',
		data: {
			productId: productId,
			price: userInputPrice,
			status: 0,
			productSize: userProductSize,
			addressId: $('.basic #addressId').val()
		},
		success: function(){
			swal('등록 완료', '' , 'success').then(function(){
				location.href='/shoeCream/my/selling';
			});//end swal
		},
		error: function(err){
			swal('등록 실패', '' , 'error');//end swal
		}
	});//end ajax
	
});






// 유효성 검사
function isBank(){
	if($('#input_bank').val()==''){
		setErr(false, '#input_bank');
	}else{
		setErr(true, '#input_bank');
	}
}

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

function setErr(result, id){
	if(!result){
		$(id).next('p').show();
		$(id).attr('validation', 'false');
	}else{
		$(id).next('p').hide();
    	$(id).attr('validation', 'true');
	}	
}

function setAccountBtn(){
	if($('#input_bank').attr('validation')=='true'&&$('#input_accountNum').attr('validation')=='true'&&$('#input_accountHolder').attr('validation')=='true'){
		$('.save_btn').addClass('save_btn_able');
	}else{
		$('.save_btn').removeClass('save_btn_able');
	}
}

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
	
function setAddressBtn(){
	const recipient = $('#input_recipient').attr('validation');
	const zipcode = $('#input_zipcode').attr('validation');
	const addr1 = $('#input_addr1').attr('validation');
	const addr2 = $('#input_addr2').attr('validation');
	
	if(recipient=='true'&&zipcode=='true'&&addr1=='true'&&addr2=='true'){
		$('.save_btn').addClass('save_btn_able');
	} else {
		$('.save_btn').removeClass('save_btn_able');
	}
}
		
// 다음 우편 번호 서비스
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
			$('#input_addr2').val('');
			$('#input_addr2').focus();
		}
	}).open();
}
	
// 마스킹 처리
function maskingRecipient(recipient){
	return recipient.replace(/(?<=.{1})./gi, '*');
}
