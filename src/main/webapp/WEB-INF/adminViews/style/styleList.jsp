<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
  <link href="/shoeCream/admin/assets/css/style/adminStyle.css" rel="stylesheet" />
</head>
    
<div class="card">

       <div class="card-header">    				
                 <h4 class="card-title" style="color: black">게시글목록</h4>
        </div>
        
        <input type="hidden" id="pg" name="pg" value="${param.pg}">
        
        <div class="card-body">
            <div class="table-responsive">
            
                  <table class="table" id="styleListTable">
                    <tr class=" text-primary" style="border-top:hidden">
		                  <th><input type="checkbox" id="all" name="all" onclick="checkAll()"></th>
			              <th>글 번호</th>
		                  <th>이미지</th><!-- 대표이미지 하나 -->
		                  <th>내용</th>
		  				  <th>
			  				  <select name="option" id="option">
				            		<option value="all" id="all">신고수</option>
								    <option value="standby" id="standby" >처리대기</option>
							  </select>		  				  
		  				  </th>
		                  <th>삭제</th>
                    </tr>
                  </table>
                  
                  <div class="stylePagingDiv"></div>
                  
				<br>
				<div id="deleteBtn">
					<input type="button" id="deleteAll" name="deleteAll" value="  삭제  ">
				</div>
		
				<div class="input-group no-border" id="searchDiv">
					    	<select name="searchOption" id="searchOption">
								<option value="contents">내용</option>
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
	$('.nav li:nth-child(6)').addClass('active');
	
	
	$('#styleListTable tr:gt(0)').remove();
	$.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/style/getStyleList',
		 data: {'pg':$('#pg').val(),
			 	'option': $('#option').val()},
		 dataType: 'JSON',
		 success: function(data){ 
			 
			$.each(data.list, function(index, items){

					$('<tr/>')					
					.append($('<td/>')
							.append($('<input/>', {type: 'checkbox', name:'check', value: items.styleId})))
		 			.append($('<td/>', {text: items.styleId}))
		 			.append($('<td/>')
			 				.append($('<img/>', {src: '/shoeCream/images/style_board/' + items.img1, style: 'width: 50px; height: 50px; cursor: pointer;', class: 'img' }))
			 				)
			 		.append($('<td/>')
			 				.append($('<a/>', {href: '/shoeCream/style/details?styleId=' + items.styleId, text: items.contents, class: 'linkA'})))
		 			.append($('<td/>', {text: items.reportCount}))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/style/deleteStyle?styleId=' + items.styleId, text: '삭제', class: 'linkA'})))
			 	.appendTo($('#styleListTable'));
			 }); // each문
			 			 
		
			// 페이징처리
			$('.stylePagingDiv').html(data.styleBoardPaging.pagingHTML);
			 
		 },
		 error: function(err){
				alert(err);
		}		 
	 });
	
	
	
}	
	// 검색		
	$('.input-group-append').click(function(){
				
		if($('#inputWord').val() == ''){
			swal('검색어를 입력하세요.', '' , 'warning').then(function(){});//end swal
		 }else{
			 $.ajax({
				 type: 'post',
				 url: '/shoeCream/adminViews/style/searchStyleList',
				 data: {'searchOption':$('#searchOption').val(),
					    'inputWord':$('#inputWord').val(),
					    'searchPg' : $('#searchPg').val(),
					    'option':$('#option').val()},			   
				 dataType: 'JSON',
				 success: function(data){
				 
				 	// 현재 생성되어 있던 테이블 지우기
					$('#styleListTable tr:gt(0)').remove();
					$.each(data.list, function(index, items){

						$('<tr/>')					
						.append($('<td/>')
								.append($('<input/>', {type: 'checkbox', name:'check', value: items.styleId})))
			 			.append($('<td/>', {text: items.styleId}))
			 			.append($('<td/>')
				 				.append($('<img/>', {src: '/shoeCream/images/style_board/' + items.img1, style: 'width: 50px; height: 50px; cursor: pointer;', class: 'img' }))
				 				)
				 		.append($('<td/>')
				 				.append($('<a/>', {href: '/shoeCream/style/details?styleId=' + items.styleId, text: items.contents, class: 'linkA'})))
			 			.append($('<td/>', {text: items.reportCount}))
				 		.append($('<td/>')
			 					.append($('<a/>', {href: '/shoeCream/adminViews/style/deleteStyle?styleId=' + items.styleId, text: '삭제', class: 'linkA'})))
				 	.appendTo($('#styleListTable'));
				 }); // each문
				 			 
			
				// 페이징처리
				$('.stylePagingDiv').html(data.styleBoardPaging.pagingHTML);
					 
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

	// 체크된 이벤트 전체삭제
	$('#deleteAll').click(function(){
			
			if($("input:checkbox[name='check']:checked").length == 0){
				swal('삭제할 항목을 선택하세요', '' , 'warning').then(function(){});//end swal
			}else{
				
				if(confirm('정말로 삭제하시겠습니까?')){				
					 var checkBoxArr = [];
		
					 $("input:checkbox[name='check']:checked").each(function() {
					 	 checkBoxArr.push($(this).val());   // 체크된 것만 값을 뽑아서 배열에 push
						});
					 				 
					 $.ajax({			 
						 type: 'post',
						 url: '/shoeCream/adminViews/style/deletStyleList',
						 data: { 'checkBoxArr' : checkBoxArr },
						 success: function(){
							 swal('삭제 성공', '' , 'success').then(function(){
								 location.href='/shoeCream/adminViews/style/styleList';
								 
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
	function boardPaging(pageValue) {	
		
		var inputWord = $('#inputWord').val();
		if(inputWord == ''){
			location.href = '/shoeCream/adminViews/style/styleList?pg='+pageValue;
		}else {
			$('#searchPg').val(pageValue);
			// 검색 
			$('.input-group-append').trigger('click');
			$('#searchPg').val(1)
		}		
	}


</script>

    