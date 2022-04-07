<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



		<div class="purchase_head">
			<div class="head_product"><a href="#" class="btn_filter" style="padding-bottom: 5px;"> 전체 </a></div>
			
			
			<div class="head_status">		
				<div class="status_box field_expires_at"><a  href="#" class="status_link"><span class="status_txt">거래일</span></a></div>
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
	$('.sellingBtn').click(load2);
 	
 	function load(){
		
 		$.ajax({
			 type: 'post',
			 url: '/shoeCream/my/getEndSellingList',
			 data: {'pg' : $('#pg').val()},
			 dataType: 'JSON',
			 success: function(data){
				 console.log(data);
				 $('#one').empty();
				 $('#two').empty();
				 
				 if(data.sellList.length == 0){					 
					 var row = '<div class="empty-area">';
		        		row	+= '<p>거래 내역이 없습니다.</p>';
		        		row += '</div>';
		        		
		        	$('#one').append(row);
				 }
				 
				
				 $.each(data.sellList, function(index, items){
					 
					 var row = '';
					 row +='<div class="purchase_item bid2" onclick="div_click('+items.salesId+', '+items.dealId+')">';	
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
		        		row += 				'<span class="date">'+ items.tradeDate +'</span>';
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
 		
 		$('.tab_item1').removeClass('tab_on');
 		$('.tab_item2').removeClass('tab_on');
		$('.tab_item3').addClass('tab_on');	
 		
 	 };
 	
 	function div_click(data, data1){
		location.href = '/shoeCream/my/sellingView?salesId='+data+'&count=3'+'&dealId='+data1;
	}	

	function load2(){
		$('#input').val(1);
 		$.ajax({
			 type: 'post',
			 url: '/shoeCream/my/getMonthEndSellingList',
			 data: {'pg' : $('#searchPg').val(),
				 	'option' : $(this).val(),
				 	'date1' : $('#date1').val(),
				 	'date2' : $('#date2').val()
					},
			 dataType: 'JSON',
			 success: function(data){
				 console.log(data);
				 $('#one').empty();
				 $('#two').empty();
				 
				 if(data.sellList.length == 0){					 
					 var row = '<div class="empty-area">';
		        		row	+= '<p>거래 내역이 없습니다.</p>';
		        		row += '</div>';
		        		
		        	$('#one').append(row);
				 }
				 
				
				 $.each(data.sellList, function(index, items){
					 
					 var row = '';
					 row +='<div class="purchase_item bid2" onclick="div_click('+items.salesId+')">';			
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
		        		row += 				'<span class="date">'+ items.tradeDate +'</span>';
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
 				location.href = '/shoeCream/my/endSelling?pg='+pageValue;
			}else {
				$('#searchPg').val(pageValue);
				// 검색 
				$('.month_link').trigger('click');
				$('#searchPg').val(1);
			} 
 	 }
 		
 	</script>
	