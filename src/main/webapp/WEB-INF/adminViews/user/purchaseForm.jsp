<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <input type="hidden" id="pg" name="pg" value="${pg}">
    
    
<div class="card-body">
        <div class="table-responsive">
          <table class="table" id="purchaseListTable"> <h4>즉시 구매내역</h4>
            <thead class=" text-primary">
              <th width="100">
                주문번호
              </th>
              <th width="100">
                재고번호
              </th>
              <th width="100">
                주문날짜
              </th>
              <th width="100">
                상품번호
              </th>
              <th width="100">
                가격
              </th>
            </thead>
          </table>
          
            	  <div id="purchasePagingDiv"></div>
          
          
        </div>
      </div>
      
      
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){ 
	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(5)').addClass('active');
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/user/getTradeForm',
		data: 'pg=' + $('#pg').val(),	
		dataType: 'JSON',
		success: function(data){
			console.log('data', data);
			
			$.each(data, function(index, items){
				 $('<tr/>')			
					.append($('<td/>', {   
						text: items.orderId // 주문번호
					})).append($('<td/>', { 
						text: items.stockId	// 재고번호					
					})).append($('<td/>', { 
						text: items.orderDate // 주문날짜
					})).append($('<td/>', { 
						text: items.stockProductId // 상품번호
					})).append($('<td/>', { 
						text: items.pricePrice // 가격
					})).appendTo($('#purchaseListTable'));
			
			});//end each
			
			$('#purchasePagingDiv').html(data.userPaging.pagingHTML); // 이걸 어디서 받아오는지 

			
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload
//페이지 이동하기
function boardPaging(pageValue) {	

		location.href = '/shoeCream/adminViews/user/purchaseForm?pg='+pageValue;
		$('#searchPg').val(pageValue);
	
}	

</script>