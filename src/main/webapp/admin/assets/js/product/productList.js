// 상품 목록 불러오기
$(function(){	 

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(4)').addClass('active');
	
	 $.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/product/getproductList',
		 data: 'pg='+$('#pg').val(),
		 dataType: 'JSON',
		 success: function(data){ 
		 console.log(data);
			$.each(data.list, function(index, items){			
					$('<tr/>')
		 			.append($('<td/>')
							.append($('<input/>', {type: 'checkbox', name:'check', value: items.modelId})))
		 			.append($('<td/>', {text: items.productId}))
		 			.append($('<td/>')
			 				.append($('<img/>', {src: '/shoeCream/images/productImg/' + items.img1, style: 'width: 50px; height: 50px; cursor: pointer;', class: 'img', onclick: 'go("'+items.productId+'")' }))
			 				)
			 		.append($('<td/>', {text: items.productName}))
			 		.append($('<td/>', {text: (items.todaysPrice).toLocaleString("ko-KR") + "원", style:'font-weight: bold; font-size: 16px;'}))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/product/updateProduct?pg=' + $('#pg').val() + '&modelId=' + items.modelId, text: '수정', class: 'linkA'})))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/product/deleteProduct?modelId=' + items.modelId, text: '삭제', class: 'linkA'})))
		 			.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/product/stockView?modelId=' + items.modelId + '&pg=' + $('#pg').val() + '&productId=' + items.productId, text: '재고량', class: 'linkA'})))
			 		.appendTo($('#productListTable'));
					
			 }); // each문			 			 
		
			// 페이징처리
			$('.productPagingDiv').html(data.productPaging.pagingHTML);
			 
		 },
		 error: function(err){
				alert(err);
		}		 
	 });	 
});

function go(data){
	location.href='/shoeCream/shop/shopView?productId=' + data;
}

// 검색		
$('.input-group-append').click(function(){
			
	if($('#inputWord').val() == ''){
		 alert('검색어를 입력하세요.');
	 }else{
		 $.ajax({
			 type: 'post',
			 url: '/shoeCream/adminViews/product/searchProduct',
			 data: {'searchOption':$('#searchOption').val(),
				    'inputWord':$('#inputWord').val(),
				    'searchPg' : $('#searchPg').val()},			   
			 dataType: 'JSON',
			 success: function(data){
			 
			 	// 현재 생성되어 있던 테이블 지우기
				$('#productListTable tr:gt(0)').remove();
				 
				$.each(data.list, function(index, items){
					$('<tr/>')
		 			.append($('<td/>')
							.append($('<input/>', {type: 'checkbox', name:'check', value: items.modelId})))
		 			.append($('<td/>', {text: items.productId}))
		 			.append($('<td/>')
			 				.append($('<img/>', {src: '/shoeCream/images/productImg/' + items.img1, style: 'width: 50px; height: 50px; cursor: pointer;', class: 'img' }))
			 				)
			 		.append($('<td/>', {text: items.productName}))
			 		.append($('<td/>', {text: (items.todaysPrice).toLocaleString("ko-KR") + "원", style:'font-weight: bold; font-size: 16px;'}))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/content/updateEventView?pg=' + $('#pg').val() + '&modelId=' + items.modelId, text: '수정', class: 'linkA'})))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/product/deleteProduct?modelId=' + items.modelId, text: '삭제', class: 'linkA'})))
		 			.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/product/stockView?productId=' + items.productId, text: '재고량', class: 'linkA'})))
			 		.appendTo($('#productListTable'));
				 }); // each문
				 
				// 페이징처리
				$('.productPagingDiv').html(data.productPaging.pagingHTML);
				 
			 },
			 error: function(err){
					alert(err);
			}		 
	 	}); 
	 	
	 	
		 
	 } // else
			
	});
	
	
	
// 체크박스 처리
$('#all').click(function(){
	
	if($('#all').prop('checked')){
		$('input[name=check]').prop('checked', true);
	}else{
		$('input[name=check]').prop('checked', false);
	}
	
});



// 페이지 이동하기
function boardPaging(pageValue) {	

	var inputWord = $('#inputWord').val();
	if(inputWord == ''){
		location.href = '/shoeCream/adminViews/product/productList?pg='+pageValue;
	}else {
		$('#searchPg').val(pageValue);
		// 검색 
		$('.input-group-append').trigger('click');
		$('#searchPg').val(1)
	}
}

// 체크박스 표시 된 상품 전체삭제
$('#deleteAll').click(function(){
	
	if($("input:checkbox[name='check']:checked").length == 0){
		alert('삭제할 항목을 선택하세요');
	}else{
		
		if(confirm('정말로 삭제하시겠습니까?')){
			
			 var checkBoxArr = [];

			 $("input:checkbox[name='check']:checked").each(function() {
			 	 checkBoxArr.push($(this).val());   // 체크된 것만 값을 뽑아서 배열에 push
				});
			 			 
			 $.ajax({
			 
				 type: 'post',
				 url: '/shoeCream/adminViews/product/deleteProductList',
				 data: { 'checkBoxArr' : checkBoxArr },
				 success: function(){
					 alert('삭제성공');
					 location.href='/shoeCream/adminViews/product/productList';
				 },
				 error: function(err){
					alert(err);
				} 
			 
			}); 
		}
	}
	
});	  
