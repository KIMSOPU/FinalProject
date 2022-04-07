<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
	<link href="/shoeCream/admin/assets/css/check/check.css" rel="stylesheet" />
</head>

 <input type="hidden" id="pg" name="pg" value="${pg}">

<div class="row">
  <div class="col-md-12">
    <div class="card">
    
      <div class="card-header">
        <h4 class="card-title" style="float:left;">검수관리</h4>
      </div>   
        <div class="input-group no-border"  id="searchDiv">
		   <select id="selectBtn1" class="searchOption">
		     <option value="0">검사전</option>		   
		     <option value="1">검수중</option>
		     <option value="2">검수완료</option>
		     
		   </select>
		   
		   <select id="selectBtn2" class="searchOption">
		     <option value="0">불합격</option>		   
		     <option value="1">합격</option>
		     		     
		   </select>
      
          	 <div class="input-group-append" >
             	<div class="input-group-text" id="searchBtn"><i class="nc-icon nc-zoom-split"></i></div>
           	</div>
        </div>


	
	<div class="col-md-12">
            <div class="card card-plain">
              <div class="card-header">
              </div>
              <div class="card-body">
                <div class="table-responsive">
                  <table class="table" id="checkListTable">
                    <thead class=" text-primary">
                      <tr><th>
                        검수번호
                      </th>
                     
                      <th>
                        상품명
                      </th>
                      <th>
                        회원 아이디
                      </th>
                       <th>
                       	검수현황
                      </th>
                       <th>
                        검수결과
                      </th>
                       
                    </tr></thead>
                
                  </table>
                  
              <div class="pagingDiv" ></div>

                  <input type="hidden" id="searchPg" name="searchPg" value="1"> 	                  
              <div class="PagingDiv"></div>
                  
                  
                </div>
              </div>
            </div>
          </div>

</body>
</html>


<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(7)').addClass('active');
	
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/check/getCheckForm',
		data: 'pg=' + $('#pg').val(),	
		dataType: 'JSON',
		success: function(data){
			console.log('data', data);
			
			//$('#orderListTable tr:gt(0)').remove(); 
			

			$.each(data.list, function(index, items){
				
				var ds = '';
				var vs = '';
				if(items.checkState == 0) {
					ds = '검수 전';
				} else if(items.checkState == 1) {
					ds = '검수 중';
				} else if(items.checkState == 2) {
					ds = '검수 완료';
				} 
			
				if(items.checkResult == 0) {
					vs = '불합격';
				} else if(items.checkResult == 1) {
					vs = '합격';
				} 
				
				 $('<tr/>')			
					.append($('<td/>', {    // 유저아이디
						text: items.checkId					
					})).append($('<td/>', {
						text: items.productName
					})).append($('<td/>', {
						
					}).append($('<a/>',{
						href: '/shoeCream/adminViews/check/checkView?checkId='+items.checkId ,
						text: items.salesId,
						class:'subjectA		subject_' + items.seq	
					}))).append($('<td/>', {
						text: ds
					})).append($('<td/>', {
						text: vs
					})).appendTo($('#checkListTable'));
			
			});//end each
		
			$('.pagingDiv').html(data.checkPaging.pagingHTML); 

			
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload


</script>




<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

// 검색필터
$('#searchBtn').click(function(){

	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/check/searchBtnForm',
		data: 	{ 'searchOption1' : $('#selectBtn1').val(),
				  'searchOption2' : $('#selectBtn2').val(),
				   }		
		,
		
		dataType: 'JSON',
		success: function(data){
			
			 $('#checkListTable tr:gt(0)').remove(); 

			console.log('data', data);
			
			
			
	$.each(data, function(index, items){
				
				var ds = '';
				var vs = '';
				if(items.checkState == 0) {
					ds = '검수 전';
				} else if(items.checkState == 1) {
					ds = '검수 중';
				} else if(items.checkState == 2) {
					ds = '검수 완료';
				} 
			
				if(items.checkResult == 0) {
					vs = '불합격';
				} else if(items.checkResult == 1) {
					vs = '합격';
				} 
				
				$('<tr/>')			
				.append($('<td/>', {    // 유저아이디
					text: items.checkId					
				})).append($('<td/>', {
					text: items.productName
				})).append($('<td/>', {
					
				}).append($('<a/>',{
					href: '/shoeCream/adminViews/user/userView?userId='+items.userId ,
					text: items.userName,
					class:'subjectA		subject_' + items.seq	
				}))).append($('<td/>', {
					text: ds
				})).append($('<td/>', {
					text: vs
				})).appendTo($('#checkListTable'));
			
			});//end each
			
		$('.pagingDiv').html(data.checkPaging.pagingHTML);
			
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});


//페이지 이동하기
function boardPaging(pageValue) {	

		location.href = '/shoeCream/adminViews/check/checkForm?pg='+pageValue;
		$('#searchPg').val(pageValue);
	
}	


</script>