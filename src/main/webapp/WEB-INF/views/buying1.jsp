<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



		<div class="purchase_head">
			<div class="head_product"><a href="#" class="btn_filter"> 전체 </a></div>
			
			
			<div class="head_status">
				<div class="status_box field_price"><a href="#" class="status_link"><span class="status_txt">구매가</span></a></div>							
			</div>
		</div>
	
		<div id="one"></div>
		<ul id="two"></ul>	

		<div class="pagingDiv" id="pagingDiv"></div>
		<input type="hidden" id="pg" value="${pg}">
		
		<input type="hidden" id="searchPg" name="searchPg" value="1"> 
		<input type="hidden" id="input" name="input">
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script type="text/javascript">
 	$(load);
 	
 	$('.month_link').click(load2);
 	$('.buyingBtn').click(load2);
 	
 	function load(){
 		
 		$('#ingBuying').click(function() {
 			$('.tab_item1').removeClass('tab_on');
 			$('.tab_item2').addClass('tab_on');	
 		});
 		
 		$.ajax({
			 type: 'post',
			 url: '/shoeCream/my/getBuyingList',
			 data: {'pg' : $('#pg').val()},
			 dataType: 'JSON',
			 success: function(data){

				 if(data.buyList.length == 0){					 
					 var row = '<div class="empty-area">';
		        		row	+= '<p>구매 입찰 내역이 없습니다.</p>';
		        		row	+= '<a href="/shoeCream/shop/shopList" class="gray_btn mypage_btn">SHOP 바로가기</a>';
		        		row += '</div>';
		        		
		        	$('#one').append(row);
				 }
				 
				
				 $.each(data.buyList, function(index, items){

					 var row = '';
					 	row +='<div class="purchase_item bid2" onclick="div_click('+items.purchaseId+', '+items.productId+')">';		
		        		row	+= 		'<div class="history_product">';
		        		row	+= 			'<div class="product_box">';
		        		row	+= 				'<div class="shopDetail-top_img">';
		        		row	+= 					'<img class="shopDetail-top_Realimg" src="/shoeCream/images/productImg/'+items.img +'">';
		        		row += 				'</div>';
		        		row += 			'</div>';
		        		row	+= 			'<div class="product_detail">';			        
		        		row	+= 				'<p class="name">' + items.productName +'</p>';
		        		row	+= 				'<p class="size"><span class="size_text">' + items.productSize +'</span></p>';		
		        		row += 			'</div>';
		        		row += 		'</div>';
		        		row	+= 		'<div class="history_status">';			
		        		row	+=			 '<div class="status_box field_price">';			
		        		row += 				'<span class="price">'+ (items.productPrice).toLocaleString("ko-KR") +'원</span>';
		        		row += 			 '</div>';
		        		row += 		'</div>';
		        		row += '</div>';
						
		        
		        		$('#two').append(row);		        		
		        	});//each문
		        	
		       $('#pagingDiv').html(data.paging.pagingHTML);	
		        	
			 },
			 error: function(err){
					alert(err);
			}		 
		 });
		
 		
	}
 	
 	function div_click(data1, data2){
		location.href = '/shoeCream/my/buyingView?purchaseId='+data1+'&productId='+data2+'&count=1';
	}

 	function load2(){
		$('#input').val(1); 
 		
			$.ajax({
				 type: 'post',
				 url: '/shoeCream/my/getMonthBuyingList',
				 data: {'pg' : $('#searchPg').val(),
					 	'option' : $(this).val(),
					 	'date1' : $('#date1').val(),
 					 	'date2' : $('#date2').val()
					},
				 dataType: 'JSON',
				 success: function(data){
					 console.log(data.monthBuyList);
					$('#one').empty();
					$('#two').empty();

					 if(data.monthBuyList.length == 0){					 
						 var row = '<div class="empty-area">';
			        		row	+= '<p>구매 입찰 내역이 없습니다.</p>';
			        		row	+= '<a href="/shoeCream/shop/shopList" class="gray_btn mypage_btn">SHOP 바로가기</a>';
			        		row += '</div>';
			        		
			        	$('#one').append(row);
					 }
					 
					
					 $.each(data.monthBuyList, function(index, items){
						 var row = '';
						 row +='<div class="purchase_item bid2" onclick="div_click('+items.purchaseId+', '+items.productId+')">';			
			        		row	+= 		'<div class="history_product">';
			        		row	+= 			'<div class="product_box">';
			        		row	+= 				'<div class="shopDetail-top_img">';
			        		row	+= 					'<img class="shopDetail-top_Realimg" src="/shoeCream/images/productImg/'+items.img +'">';
			        		row += 				'</div>';
			        		row += 			'</div>';
			        		row	+= 			'<div class="product_detail">';			        
			        		row	+= 				'<p class="name">' + items.productName +'</p>';
			        		row	+= 				'<p class="size"><span class="size_text">' + items.productSize +'</span></p>';		
			        		row += 			'</div>';
			        		row += 		'</div>';
			        		row	+= 		'<div class="history_status">';			
			        		row	+=			 '<div class="status_box field_price">';			
			        		row += 				'<span class="price">'+ (items.productPrice).toLocaleString("ko-KR") +'원</span>';
			        		row += 			 '</div>';
			        		row += 		'</div>';
			        		row += '</div>';
							
			        		$('#two').append(row);
			        	});//each문
			        	
			      $('#pagingDiv').html(data.paging.pagingHTML);	
			        	
				 },
				 error: function(err){
						alert(err);
				}		 
			 });
 		}
		
 		// 페이지 이동하기
 	 	function paging(pageValue) {
 	 			if($('#input').val() == ''){
 	 				location.href = '/shoeCream/my/buying?pg='+pageValue;
 				}else {
 					$('#searchPg').val(pageValue);
 					// 검색 
 					$('.month_link').trigger('click');
 					$('#searchPg').val(1);
 				} 
 	 	 }	
 		
 	</script>
	