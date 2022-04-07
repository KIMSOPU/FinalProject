<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="card-body">
        <div class="table-responsive">
          <table class="table" id="bidPurchaseListTable"> <h4>입찰 구매내역</h4>
            <thead class=" text-primary">
              <th width="100">
                상풍번호
              </th>
              <th width="100">
                구매번호
              </th>
              <th width="100">
                구매현황
              </th>
              <th width="100">
                구매날짜
              </th>
              <th width="100">
                상품명
              </th>
            </thead>
          </table>
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
		//data: 'pg=' + $('#pg').val(),	
		//dataType: 'JSON',
		success: function(data){
			console.log('data', data);
			
			$.each(data, function(index, items){
				
				var ds = '';

				if(items.purchaseStatus == 0) {
					ds = '구매 진행중';
				} else if(items.purchaseStatus == 1) {
					ds = '구매 완료';
				} 
				
				 $('<tr/>')			
					.append($('<td/>', {    
						text: items.purchaseProductId // 상품번호 
					})).append($('<td/>', {
						text: items.purchaseId // 구매번호						
					})).append($('<td/>', {
						text: ds // 구매현황
					})).append($('<td/>', {
						text: items.purchaseDueDate // 구매날짜
					})).append($('<td/>', {
						text: items.productName // 상품명
					})).appendTo($('#bidPurchaseListTable'));
			
			});//end each
			
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload
</script>