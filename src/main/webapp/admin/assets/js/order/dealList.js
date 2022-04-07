$(function(){
	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(2)').addClass('active');
	
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/order/getDealList',
		data: 'pg=' + $('#pg').val(),	
		success: function(data){
			console.log('dealData', data);
			
			$('#dealListTable tr:gt(0)').remove(); 
			
			$.each(data.list, function(index, items){
				var ds = '배송전';
				var cs = '검수전';
				if(items.deliveryStatus == 1) {
					ds = '배송중';
				} else if(items.deliveryStatus == 2) {
					ds = '배송완료';
				}
				if(items.checkState == 1) {
					cs = '검수중';
				} else if(items.checkState == 2) {
					cs = '검수완료';
				}
				
				$('<tr/>', {class:'dataTr'}).append(
					$('<td/>', {text: items.dealId}),
					$('<td/>', {text: items.productName}),
					$('<td/>', {text: items.pusername}),
					$('<td/>', {text: items.username}),
					$('<td/>', {text: cs}),
					$('<td/>', {text: ds})
				).appendTo($('#dealListTable #tableBody'));	
				
			});//end each
			
			// 페이징 처리
			$('#dealPagingDiv').empty();
			$('#dealPagingDiv').html(data.dealPaging.pagingHTML);
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload


$('#searchBtn').click(function(){
	$('#searchDivText').text('');
	
	if($('#dealSearchText').val() == '') {
		$('#searchDivText').text('값을 입력해주세요');
	} else if($('#searchOption').val() == 'dealId'
				&& isNaN($('#dealSearchText').val())){
		$('#searchDivText').text('숫자만 입력해주세요.');
	} else {
		$('#dealPagingDiv').empty();
		$.ajax({
			type: 'POST',
			url: '/shoeCream/adminViews/order/getDealSearchList',
			data: {
				searchOption: $('#searchOption').val(),
				keyword: $('#dealSearchText').val(),
				pg: '1'
			},
			success: function(data){
				$('#dealListTable tr:gt(0)').remove(); 
				console.log('searchData', data)

				$.each(data.list, function(index, items){
				var ds = '배송전';
				if(items.deliveryStatus == 1) {
					ds = '배송중';
				} else if(items.deliveryStatus == 2) {
					ds = '배송완료';
				}
				var cs = '검수전';
				if(items.checkState == 1) {
					cs = '검수중';
				} else if(items.checkState == 2) {
					cs = '검수완료';
				}
				
				$('<tr/>', {class:'dataTr'}).append(
					$('<td/>', {text: items.dealId}),
					$('<td/>', {text: items.productName}),
					$('<td/>', {text: items.pusername}),
					$('<td/>', {text: items.username}),
					$('<td/>', {text: cs}),
					$('<td/>', {text: ds})
				).appendTo($('#dealListTable #tableBody'));	

			});//end each
			},
			error: function(err){
				alert('오류났다아~~~');
				console.log(err);
			}
		});//end ajax
	}//end if
});//end click

$(document).on('click', '.dataTr', function(){
	console.log(this.children[0].innerText);
	location.href='/shoeCream/adminViews/order/dealView?dealId='+this.children[0].innerText;
});



function dealPaging(newPg){
	location.href = '/shoeCream/adminViews/order/dealList?pg='+newPg;
}
