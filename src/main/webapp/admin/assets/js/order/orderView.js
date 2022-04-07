let data1;

$(function(){
	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(2)').addClass('active');
	
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/order/getOrderView',
		data: 'orderId=' + $('#orderIdText').val(),	
		//dataType: 'JSON',
		success: function(data){
			console.log('data', data);
			data1 = data;
			
			$('.tdForView').empty();
			$('.tdForView').eq(0).text(data.orderId); //거래 번호

			$('.tdForView').eq(1).append(
				$('<a/>', {href:'/shoeCream/shop/shopView?productId='+data.productId, text:data.productName})
			);
			$('.tdForView').eq(2).append(
				$('<a/>', {href:'/shoeCream/adminViews/user/userView?userId='+data.userId, text:data.username})
			);
			$('.tdForView').eq(3).text(data.orderPhoneNum); 
			$('.tdForView').eq(4).text(data.price.toLocaleString() + "원"); 
			$('.tdForView').eq(5).text(data.orderDate);
			
			$('.tdForView').eq(6).text(data.addr1);
			$('.tdForView').eq(7).text(data.addr2);
			$('.tdForView').eq(8).text(data.bank);
			$('.tdForView').eq(9).text(data.accountHolder);
			
			if(data.deliveryStatus != 0) { 
				$('#trackingNumInput').val(data.trackingNum);
				$('#trackingNumInput').attr('disabled', true);
			} else {
				$('.table-responsive').append(
					$('<div/>', {class:'insert_delivery_btn_div'}).append(
						$('<input>', {type:'button', class:'btn btn-secondary btn-round', id:'insertDeliveryBtn', value:'운송장 추가'})				
					)
				);
			}//end if
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload

$(document).on('click', '#insertDeliveryBtn', function(){
	if( $('#trackingNumInput').val() != '' 
		&& !isNaN($('#trackingNumInput').val())){
		$.ajax({
			type: 'POST',
			url: '/shoeCream/adminViews/order/updateDelivery',
			data: {
				deliveryId: data1.deliveryId,
				deliveryStatus: 1,
				trackingNum: $('#trackingNumInput').val()
			},
			success: function(){
				swal('운송장번호 입력 성공', '', 'success').then(function(){
					location.reload();
				});
			},
			error: function(err){
				swal('운송장번호 입력 실패', '', 'error').then(function(){
					console.log(err);
				});
			}
		});//end ajax
	
	} else {
		swal('운송장 번호가 잘못 되었습니다.', '', 'warning');
	}//end if
});//end click