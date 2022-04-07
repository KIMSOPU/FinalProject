$(function(){
	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(2)').addClass('active');
	
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/order/getPurchaseList',
		data: 'pg=' + $('#pg').val(),	
		success: function(data){
			console.log('data', data);
			
			$('#purchaseListTable tr:gt(0)').remove(); 
			
			$.each(data.list, function(index, items){
				var ds = '';
				if(items.status== 0) {
					ds = '구매중';
				} else if(items.status== 1) {
					ds = '구매완료';
				}
			
				$('<tr/>', {class:'dataTr', style:'cursor:default'}).append(
					$('<td/>', {text: items.purchaseId}),
					$('<td/>', {}).append(
						$('<a/>', {href:'/shoeCream/adminViews/user/userView?userId='+items.userId,
									text: items.userId})
					),
					$('<td/>', {}).append(
						$('<a/>', {href:'/shoeCream/shop/shopView?productId='+items.productId,
									text: items.productId})
					),
					$('<td/>', {text: items.price.toLocaleString() + '원'}),
					$('<td/>', {text: ds}),
					$('<td/>', {text: items.productSize}),
					$('<td/>', {text: items.regDate})
				).appendTo($('#purchaseListTable #tableBody'));	
				
			});//end each
			
			// 페이징 처리
			$('#purchasePagingDiv').html(data.purchasePaging.pagingHTML);
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload

$('#searchBtn').click(function(){
	$('#searchDivText').text('');
	
	if($('#purchaseSearchText').val() == '') {
		$('#searchDivText').text('값을 입력해주세요');
	} else if($('#searchOption').val() == 'purchaseId'
				&& isNaN($('#purchaseSearchText').val())){
		$('#searchDivText').text('숫자만 입력해주세요.');
	} else {
		$('#purchasePagingDiv').empty();
		$.ajax({
			type: 'POST',
			url: '/shoeCream/adminViews/order/getPurchaseSearchList',
			data: {
				searchOption: $('#searchOption').val(),
				keyword: $('#purchaseSearchText').val()
			},
			success: function(data){
				console.log(data);
				$('#purchaseListTable tr:gt(0)').remove(); 
			
				$.each(data.list, function(index, items){
					var ds = '';
					if(items.status== 0) {
						ds = '구매중';
					} else if(items.status== 1) {
						ds = '구매완료';
					}
				
					$('<tr/>', {class:'dataTr', style:'cursor:default'}).append(
						$('<td/>', {text: items.purchaseId}),
						$('<td/>', {}).append(
							$('<a/>', {href:'/shoeCream/adminViews/user/userView?userId='+items.userId,
										text: items.userId})
						),
						$('<td/>', {}).append(
							$('<a/>', {href:'/shoeCream/shop/shopView?productId='+items.productId,
										text: items.productId})
						),
						$('<td/>', {text: items.price.toLocaleString() + '원'}),
						$('<td/>', {text: ds}),
						$('<td/>', {text: items.productSize}),
						$('<td/>', {text: items.regDate})
					).appendTo($('#purchaseListTable #tableBody'));	
					
				});//end each
			},
			error: function(err){
				alert('오류났다아~~~');
				console.log(err);
			}
		});//end ajax
	}//end if
});//end click



function purchasePaging(newPg){
	location.href = '/shoeCream/adminViews/order/purchaseList?pg='+newPg;
}