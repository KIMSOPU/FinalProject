// 이벤트 목록 불러오기
$(load);
$('#option').change(load);	 

function load(){

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(3)').addClass('active');
	
$('#eventListTable tr:gt(0)').remove();
	
	$.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/event/getEventList',
		 data: {'pg':$('#pg').val(),
				'option':$('#option').val()},
		 dataType: 'JSON',
		 success: function(data){ 
					var result = '마감';
			$.each(data.list, function(index, items){	
	
					if(items.status == '0'){ result = '진행중'}else if(items.status == '1'){result = '마감'};

					$('<tr/>')					
					.append($('<td/>')
							.append($('<input/>', {type: 'checkbox', name:'check', value: items.eventId})))
		 			.append($('<td/>', {text: items.eventId}))
		 			.append($('<td/>')
			 				.append($('<img/>', {src: '/shoeCream/images/logo/' + items.img1, style: 'width: 100px; height: 30px; cursor: pointer;', class: 'img' }))
			 				)
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/event/updateEventForm?pg=' + $('#pg').val() + '&eventId=' + items.eventId, text: items.title, class: 'linkA'})))
			 		
		 			.append($('<td/>', {text: result}))
		 			
			 		
			 		
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/event/deleteEvent?eventId=' + items.eventId, text: '삭제', class: 'linkA'})))
			 	.appendTo($('#eventListTable'));
			 }); // each문
			 			 
		
			// 페이징처리
			$('.eventPagingDiv').html(data.eventPaging.pagingHTML);
			 
		 },
		 error: function(err){
				alert(err);
		}		 
	 });

};

// 검색		
$('.input-group-append').click(function(){
			
	if($('#inputWord').val() == ''){
		 alert('검색어를 입력하세요.');
	 }else{
		 $.ajax({
			 type: 'post',
			 url: '/shoeCream/adminViews/event/searchEvent',
			 data: {'searchOption':$('#searchOption').val(),
				    'inputWord':$('#inputWord').val(),
				    'searchPg' : $('#searchPg').val(),
				    'option':$('#option').val()},			   
			 dataType: 'JSON',
			 success: function(data){
			 
			 	// 현재 생성되어 있던 테이블 지우기
				$('#eventListTable tr:gt(0)').remove();
				
				 var result = '마감';
				$.each(data.list, function(index, items){
					if(items.status == '0'){ result = '진행중'}else if(items.status == '1'){result = '마감'};

					$('<tr/>')					
					.append($('<td/>')
							.append($('<input/>', {type: 'checkbox', name:'check', value: items.eventId})))
		 			.append($('<td/>', {text: items.eventId}))
		 			.append($('<td/>')
			 				.append($('<img/>', {src: '/shoeCream/images/logo/' + items.img1, style: 'width: 100px; height: 30px; cursor: pointer;', class: 'img' }))
			 				)
			 		.append($('<td/>', {text: items.title}))
		 			.append($('<td/>', {text: result}))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/event/updateEventForm?pg=' + $('#pg').val() + '&eventId=' + items.eventId, text: '수정', class: 'linkA'})))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/event/deleteEvent?eventId=' + items.eventId, text: '삭제', class: 'linkA'})))
			 	.appendTo($('#eventListTable'));
			 }); // each문
				 
				 // 페이징처리
				 $('.eventPagingDiv').html(data.eventPaging.pagingHTML);
				 
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
			alert('삭제할 항목을 선택하세요');
		}else{
			
			if(confirm('정말로 삭제하시겠습니까?')){				
				 var checkBoxArr = [];
	
				 $("input:checkbox[name='check']:checked").each(function() {
				 	 checkBoxArr.push($(this).val());   // 체크된 것만 값을 뽑아서 배열에 push
					});
				 				 
				 $.ajax({			 
					 type: 'post',
					 url: '/shoeCream/adminViews/event/deletEventList',
					 data: { 'checkBoxArr' : checkBoxArr },
					 success: function(){
						 alert('삭제성공');
						 location.href='/shoeCream/adminViews/event/eventList';
					 },
					 error: function(err){
						alert(err);
					} 
				 
				}); 
			}
		}
		
	});	

// 페이지 이동하기
function eventPaging(pageValue) {	

	var inputWord = $('#inputWord').val();
	if(inputWord == ''){
		location.href = '/shoeCream/adminViews/event/eventList?pg='+pageValue;
	}else {
		$('#searchPg').val(pageValue);
		// 검색 
		$('.input-group-append').trigger('click');
		$('#searchPg').val(1)
	}
}

