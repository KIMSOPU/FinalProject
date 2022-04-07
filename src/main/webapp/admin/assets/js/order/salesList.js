$(function(){
	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(2)').addClass('active');
	
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/sales/getSalesList',
		data: 'pg=' + $('#pg').val(),	
		success: function(data){
			console.log('data', data);
			
			$('#salesListTable tr:gt(0)').remove(); 
			
			$.each(data.list, function(index, items){
				var ds = '';
				if(items.status == 0) {
					ds = '판매중';
				} else if(items.status == 1) {
					ds = '판매완료';
				} else if(items.status == 2) {
					ds = '판매취소';
				}
				
				
				$('<tr/>', {class:'dataTr', style:'cursor:default'}).append(
					$('<td/>', {text: items.salesId}),
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
				).appendTo($('#salesListTable #tableBody'));	
				
			});//end each
			
			// 페이징 처리
			$('#salesPagingDiv').html(data.salesPaging.pagingHTML);
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload

function salesPaging(newPg){
	location.href = '/shoeCream/adminViews/sales/salesList?pg='+newPg;
}