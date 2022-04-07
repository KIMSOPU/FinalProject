<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<head>
  <link href="/shoeCream/admin/assets/css/question/question.css" rel="stylesheet" />

</head>
  
 <div class="card">     
       <div class="card-header">  
       		<div class="list">       		
               <h4 class="card-title" style="color: black">문의사항</h4>
             </div>
             <div class="write"> 
       		 </div>
         	</div>

        <input type="hidden" id="pg" name="pg" value="${param.pg}">
         
        <div class="card-body">
            <div class="table-responsive">          
                  <table class="table" id="questionListTable">
                   		  <tr class=" text-primary" style="border-top:hidden">
			                  <th><input type="checkbox" id="all" name="all" onclick="checkAll()"></th>
				              <th>글 번호</th>		                  
			                  <th>작성자</th>
			                  <th>제목</th>
			                  <th>등록일</th>
			                  <th>
				  				  <select name="option" id="option">
					            		<option value="all" id="all">전체</option>
									    <option value="standby" id="standby" >답변대기</option>
									    <option value="end" id="end" >답변완료</option>
								  </select>		  				  
			  				  </th>
			                  
		                  	  <th>삭제</th>
                   		  </tr>
                  </table>           
              
                       
              <div class="questionPagingDiv"></div>
              
               <br>
              <div id="deleteBtn">              
              		 <input type="button" id="deleteAll" name="deleteAll" value="  삭제  "> 
              </div>
              
             
              <div class="input-group no-border" id="searchDiv">
				    	<select name="searchOption" id="searchOption">
							<option value="title" >제목</option>
							<option value="qnaName" >작성자</option>
						</select>
							
						<input type="hidden" id="searchPg" name="searchPg" value="1">		
						<input type="text" class="form-control" placeholder="검색어 입력" id="inputWord" style="width: 80%">
					    <div class="input-group-append">
					           <div class="input-group-text"><i class="nc-icon nc-zoom-split"></i></div>
              		    </div>
			  </div>	

      </div>
    </div>
 </div>
 
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

$(load);
$('#option').change(load);

function load(){

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(8)').addClass('active');
	
	
	$('#questionListTable tr:gt(0)').remove();
	
	$.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/question/getQnaList',
		 data: {'pg':$('#pg').val(),
			 	'option': $('#option').val()},
		 dataType: 'JSON',
		 success: function(data){
			 
			 var result = '답변완료';
			$.each(data.list, function(index, items){
									
					if(items.status == '0'){ result = '답변대기'}else if(items.status == '1'){result = '답변완료'}else if(items.status == '2'){result = ' '};				
					$('<tr/>')					
					.append($('<td/>')
							.append($('<input/>', {type: 'checkbox', name:'check', value: items.qnaId})))
					.append($('<td/>', {text: items.qnaId}))
		 			.append($('<td/>', {text: items.qnaName}))
			 		.append($('<td/>')
			 				.append($('<a/>', {href: '/shoeCream/adminViews/question/qnaView?qnaId=' + items.qnaId, text: items.title, class: 'linkA titleMoim' + items.qnaId})))
		 			.append($('<td/>', {text: items.regDate}))
			 		.append($('<td/>', {text: result}))		 			
		 			.append($('<td/>')
			 				.append($('<a/>', {href: '/shoeCream/adminViews/question/deleteQna?qnaId=' + items.qnaId, text:'삭제' ,class: 'linkA'})))
			 	.appendTo($('#questionListTable'));
					
					
					if(items.pseq != items.qnaId){
			 			var blank = " ";
			 			for(i = 0; i < items.step; i++){
			 				blank += "&emsp;";
			 			}
											 
				 		let img = "<img alt='메렁' src='/shoeCream/images/Arrow-icon.png' width=15px height=12px>"
						$('.titleMoim' + items.qnaId).before(blank+img+"");
					}
			 }); // each문
			 			 	 			
			// 페이징처리
			$('.questionPagingDiv').html(data.questionPaging.pagingHTML);
			 
		 },
		 error: function(err){
				alert(err);
		}		 
	 });	
}

//체크박스 처리
$('#all').click(function(){
	
	if($('#all').prop('checked')){
		$('input[name=check]').prop('checked', true);
	}else{
		$('input[name=check]').prop('checked', false);
	}
});

// 체크된 이벤트 전체삭제
$('#deleteAll').click(function(){
		
		if($("input:checkbox[name='check']:checked").length == 0){
			swal('삭제할 항목을 선택하세요', '' , 'warning');//end swal
		}else{
			
			if(confirm('정말로 삭제하시겠습니까?')){				
				 var checkBoxArr = [];
	
				 $("input:checkbox[name='check']:checked").each(function() {
				 	 checkBoxArr.push($(this).val());   // 체크된 것만 값을 뽑아서 배열에 push
					});
				 				 
				 $.ajax({			 
					 type: 'post',
					 url: '/shoeCream/adminViews/question/deletQnaList',
					 data: { 'checkBoxArr' : checkBoxArr },
					 success: function(){
						 swal('삭제 성공', '' , 'success').then(function(){
							 location.href='/shoeCream/adminViews/question/qnaList';
							 
						 });//end swal
					 },
					 error: function(err){
						alert(err);
					} 
				 
				}); 
			}
		}
		
	});	

// 페이지 이동하기
function qnaPaging(pageValue) {	
	
	var inputWord = $('#inputWord').val();
	if(inputWord == ''){
		location.href = '/shoeCream/adminViews/question/qnaList?pg='+pageValue;
	}else {
		$('#searchPg').val(pageValue);
		// 검색 
		$('.input-group-append').trigger('click');
		$('#searchPg').val(1)
	}		
}

// 검색		
$('.input-group-append').click(function(){
			
	if($('#inputWord').val() == ''){
		swal('검색어를 입력하세요', '' , 'warning')
	 }else{
		 $.ajax({
			 type: 'post',
			 url: '/shoeCream/adminViews/question/searchQnaList',
			 data: {'searchOption':$('#searchOption').val(),
				    'inputWord':$('#inputWord').val(),
				    'searchPg' : $('#searchPg').val(),
				    'option':$('#option').val()},			   
			 dataType: 'JSON',
			 success: function(data){ 
					
					$('#questionListTable tr:gt(0)').remove();
					
					var result = '답변완료';
					$.each(data.list, function(index, items){
							
						   if(items.status == '0'){ result = '답변대기'}else if(items.status == '1'){result = '답변완료'}else if(items.status == '2'){result = ' '};				
							
						   $('<tr/>')					
							.append($('<td/>')
									.append($('<input/>', {type: 'checkbox', name:'check', value: items.qnaId})))
							.append($('<td/>', {text: items.qnaId}))
				 			.append($('<td/>', {text: items.qnaName}))
					 		.append($('<td/>')
					 				.append($('<a/>', {href: '/shoeCream/adminViews/question/qnaView?qnaId=' + items.qnaId, text:items.title,class: 'linkA titleMoim' + items.qnaId})))
				 			.append($('<td/>', {text: result}))
				 			.append($('<td/>', {text: items.regDate}))
				 			.append($('<td/>')
					 				.append($('<a/>', {href: '/shoeCream/adminViews/question/deleteQna?qnaId=' + items.qnaId, text:'삭제' ,class: 'linkA'})))
					 	.appendTo($('#questionListTable'));
							
							
							if(items.pseq != items.qnaId){
					 			var blank = " ";
					 			for(i = 0; i < items.step; i++){
					 				blank += "&emsp;";
					 			}
													 
						 		let img = "<img alt='메렁' src='/shoeCream/images/Arrow-icon.png' width=15px height=12px>"
								$('.titleMoim' + items.qnaId).before(blank+img+"");
							}
					 }); // each문
					 			 	 			
					// 페이징처리
					$('.questionPagingDiv').html(data.questionPaging.pagingHTML);
					 
				 },
			 error: function(err){
					alert(err);
			}		 
	 	}); 			 
	 } // else
			
	});

</script>
 