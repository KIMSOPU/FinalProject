
$(function(){	 

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(3)').addClass('active');

// 공지사항 목록 불러오기
	 $.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/content/getAnnounceList',
		 data: 'pg='+$('#pg').val(),
		 dataType: 'JSON',
		 success: function(data){ 
		 console.log(data.list);
			$.each(data.list, function(index, items){
					$('<tr/>')
					.append($('<td/>')
							.append($('<input/>', {type: 'checkbox', name:'check', value: items.announcementId})))
		 			.append($('<td/>', {text: items.announcementId}))
			 		.append($('<td/>')
			 				.append($('<a/>', {href: '/shoeCream/serviceCenter/announcementDetail?announcementId=' + items.announcementId + '&pg=' + $('#pg').val(), text: items.title, class: 'linkA'})))
		 			.append($('<td/>', {text: items.regDate}))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/content/updateAnnounceView?pg=' + $('#pg').val() + '&announcementId=' + items.announcementId, text: '수정', class: 'linkA'})))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/content/deleteAnnounce?announcementId=' + items.announcementId, text: '삭제', class: 'linkA'})))
			 	.appendTo($('#announceListTable'));
			 }); // each문
			 			 
		
			// 페이징처리
			$('.announcePagingDiv').html(data.announcePaging.pagingHTML);
			 
		 },
		 error: function(err){
				alert(err);
		}		 
	 });
	 
	 
// 검색		
$('.input-group-append').click(function(){
			
	if($('#inputWord').val() == ''){
		 alert('검색어를 입력하세요.');
	 }else{
		 $.ajax({
			 type: 'post',
			 url: '/shoeCream/adminViews/content/searchAnnounce',
			 data: {'searchOption':$('#searchOption').val(),
				    'inputWord':$('#inputWord').val(),
				    'searchPg' : $('#searchPg').val()},			   
			 dataType: 'JSON',
			 success: function(data){
			 
			 	// 현재 생성되어 있던 테이블 지우기
				$('#announceListTable tr:gt(0)').remove();
				 
				$.each(data.list, function(index, items){
					$('<tr/>')
					.append($('<td/>')
							.append($('<input/>', {type: 'checkbox', name:'check', value: items.announcementId})))
		 			.append($('<td/>', {text: items.announcementId}))
			 		.append($('<td/>')
			 				.append($('<a/>', {href: '/shoeCream/serviceCenter/announcementDetail?announcementId=' + items.announcementId + '&pg=' + $('#pg').val(), text: items.title, class: 'linkA'})))
		 			.append($('<td/>', {text: items.regDate}))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/content/updateAnnounceView?pg=' + $('#pg').val() + '&announcementId=' + items.announcementId, text: '수정', class: 'linkA'})))
			 		.append($('<td/>')
		 					.append($('<a/>', {href: '/shoeCream/adminViews/content/deleteAnnounce?announcementId=' + items.announcementId, text: '삭제', class: 'linkA'})))
			 	.appendTo($('#announceListTable'));
				 }); // each문
				 
				 // 페이징처리
				 $('.announcePagingDiv').html(data.announcePaging.pagingHTML);
				 
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
					 url: '/shoeCream/adminViews/content/deleteAllAnnounce',
					 data: { 'checkBoxArr' : checkBoxArr },
					 success: function(){
						 alert('삭제성공');
						 location.href='/shoeCream/adminViews/content/announceList';
					 },
					 error: function(err){
						alert(err);
					} 
				 
				}); 
			}
		}
		
	});	

});

// 페이지 이동하기
function contentPaging(pageValue) {	

	var inputWord = $('#inputWord').val();
	if(inputWord == ''){
		location.href = '/shoeCream/adminViews/content/announceList?pg='+pageValue;
	}else {
		$('#searchPg').val(pageValue);
		// 검색 
		$('.input-group-append').trigger('click');
		$('#searchPg').val(1)
	}
}

