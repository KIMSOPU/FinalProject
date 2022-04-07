<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="card-body">
        <div class="table-responsive">
          <table class="table" id="sellListTable"> <h4>판매내역</h4>
            <thead class=" text-primary">
              <th width="100">
                판매번호
              </th>
              <th width="100">
                상품번호
              </th>
              <th width="100">
                거래상태
              </th>
              <th width="100">
                가격
              </th>
              <th width="100">
                판매날짜
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

				if(items.salesStatus == 0) {
					ds = '판매 진행중';
				} else if(items.salesStatus == 1) {
					ds = '판매 완료';
				} 
			
			
				
				 $('<tr/>')			
					.append($('<td/>', {    
						text: items.salesId
					})).append($('<td/>', {
						text: items.salesProductId						
					})).append($('<td/>', {
						text: ds
					})).append($('<td/>', {
						text: items.salesPrice
					})).append($('<td/>', {
						text: items.salesDueDate
					})).append($('<td/>', {
						text: items.productProductName
					})).appendTo($('#sellListTable'));
			
			});//end each
			
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload
</script>