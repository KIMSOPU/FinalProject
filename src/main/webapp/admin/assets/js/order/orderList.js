$(function(){
	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(2)').addClass('active');

	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/order/getOrderList',
		data: 'pg=' + $('#pg').val(),	
		//dataType: 'JSON',
		success: function(data){
			console.log('data', data);
			
			//gt(0)는 0보다 큰 애를 뜻한다(Greater Than)
			//즉, th말고 다른줄들은 싹 다 지운다
			$('#orderListTable tr:gt(0)').remove(); 
			
			$.each(data.list, function(index, items){
				var ds = '배송전';
				if(items.deliveryStatus == 1) {
					ds = '배송중';
				} else if(items.deliveryStatus == 2) {
					ds = '배송완료';
				}
				$('<tr/>',{class:'dataTr'}).append($('<td/>', { // 주문번호
						text: items.orderId
					})).append($('<td/>', { // 상품이름
						text: items.productName
					})).append($('<td/>', {	// 구매자아이디
						text: items.username
					})).append($('<td/>', {	// 배송상태
						text: ds
					})).append($('<td/>', {	// 결제일자
						text: items.orderDate
					})).appendTo($('#orderListTable'));	
			});//end each
			
			// 페이징 처리
			$('#orderPagingDiv').html(data.orderPaging.pagingHTML);
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		},
		beforeSend: function(){
			$('#orderSearchDiv').text('로딩중입니다.');				
		},
		complete: function(){
			//$('#loadingDiv').hide();
			
		}
	});//end ajax
});//end onload

function orderPaging(newPg){
	location.href = '/shoeCream/adminViews/order/orderList?pg='+newPg;
}

$('#searchBtn').click(function(){
	$('#searchDivText').text('');
	
	if($('#orderSearchText').val() == '') {
		$('#searchDivText').text('값을 입력해주세요');
	} else {
		
		if($('#orderSearchText').val() == '') {
			$('#searchDivText').text('값을 입력해주세요');
		} else if($('#searchOption').val() == 'orderId'
					&& isNaN($('#orderSearchText').val())){
			$('#searchDivText').text('숫자만 입력해주세요.');
		} else {
			$('#orderPagingDiv').empty();
			$.ajax({
				type: 'POST',
				url: '/shoeCream/adminViews/order/getOrderSearchList',
				data: {
					searchOption: $('#searchOption').val(),
					keyword: $('#orderSearchText').val(),
					pg: '1'
				},
				success: function(data){
					$('#orderListTable tr:gt(0)').remove(); 
				
					$.each(data.list, function(index, items){
						var ds = '배송전';
						if(items.deliveryStatus == 1) {
							ds = '배송중';
						} else if(items.deliveryStatus == 2) {
							ds = '배송완료';
						}
						$('<tr/>',{class:'dataTr'}).append($('<td/>', { // 주문번호
							text: items.orderId
						})).append($('<td/>', { // 상품이름
							text: items.productName
						})).append($('<td/>', {	// 구매자아이디
							text: items.username
						})).append($('<td/>', {	// 배송상태
							text: ds
						})).append($('<td/>', {	// 결제일자
							text: items.orderDate
						})).appendTo($('#orderListTable'));	
					});//end each
				},
				error: function(err){
					alert('오류났다아~~~');
					console.log(err);
				},
				beforeSend: function(){
					$('#orderSearchDiv').text('로딩중입니다.');				
				},
				complete: function(){
					//$('#loadingDiv').hide();
					
				}
			});//end ajax
		
		}
	}//end if
});//end click


$(document).on('click', '.dataTr', function(){
	console.log(this.children[0].innerText);
	location.href='/shoeCream/adminViews/order/orderView?orderId='+this.children[0].innerText;
});