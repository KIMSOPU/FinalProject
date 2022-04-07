<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<body>
	<div class="content_title">
		<h3 id="title_name">1:1 문의</h3>
	</div>
	<div class="content_list">
		<table id="qna_table">
			<colgroup>
				<col style="width:100px;">
				<col style="width:auto;">
				<col style="width:100px;">
				<col style="width:100px;">
			</colgroup>
		
			<tr>
				<th>번호</th>
		   		<th>제목</th>
		   		<th>작성자</th>
		   		<th>작성일</th>
			</tr>
		</table>
	</div>
	<div class="pagingDiv" id="pagingDiv">${paging.pagingHTML}</div>
	<div class="btn_right_div">
		<a href="#" class="service_btn gray_btn" id="gray_btn">문의글 작성</a>
	</div>
	<input type="hidden" id="pg" value="${pg}">
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		
		function paging(pg) {
			location.href = '/shoeCream/serviceCenter/qna?pg='+pg;
		}
		
		//post 방식 페이지 이동
		function goQnaDetail(pg, qnaId) { 
			let f =  document.createElement('form');
			
			let obj;
		    obj = document.createElement('input');
		    obj.setAttribute('type', 'hidden');
		    obj.setAttribute('name', 'qnaId');
		    obj.setAttribute('value', qnaId);
			f.appendChild(obj);
			
			f.setAttribute('method', 'post');
			f.setAttribute('action', '/shoeCream/serviceCenter/qnaDetail?pg='+pg);
			document.body.appendChild(f);
			f.submit();
		}
		
		$(function(){
 			
			//목록 가져오기
 			$.ajax({
 				type: 'post',
 		        url: '/shoeCream/serviceCenter/getQnaList',
 		        data: 'pg=' + $('#pg').val(),
 		        dataType: 'json',
 		        success: function(data){
 		        	//console.log(JSON.stringify(data));
 		        	
 		        	$.each(data, function(index, item){
 		        		var row = '<tr>';
 		        		row	+= '<td>'+item.qnaId+'</td>';
 		        		row	+= '<td class="td_left">';
 		        		row	+= '<a href="#" class="link">'
 		        		
 		        		var maskingName = item.qnaName.replace(/(?<=.{1})./gi,"*");
 		        		
	        			if(item.step === 1) { //답글
	        				row += '<i class="fa-solid fa-angles-right"></i>'+item.title;
	        			} else if(item.step === 0) { //문의글
	        				row += item.title;
	        			}
 		        		
 		        		row += '</a><i class="fa-solid fa-lock fa-sm"></i></td>';
 		        		
 		        		if(item.step === 1) { //답글
	        				row += '<td>슈크림</td>';
	        			} else if(item.step === 0) { //문의글
	        				row += '<td>'+maskingName+'</td>';
	        			}
 						row += '<td>'+item.regDate+'</td></tr>';
 						
 						$('#qna_table').append(row);
 						
 		        	})//each문

 		        	//상세페이지로 이동
		 			$('.link').click(function(){
		 				let qnaId = $(this).parent().prev().text();
		 				let qnaPwd = prompt('문의글은 비밀글입니다. 비밀번호를 입력하세요.');
		 				
		 				if(qnaPwd != null) {
			 				$.ajax({
			 					type: 'post',
			 	 		        url: '/shoeCream/serviceCenter/checkPwd',
			 	 		        data: {'qnaId':qnaId, 'qnaPwd':qnaPwd},
			 	 		        dataType: 'text',
			 	 		        success: function(data){
			 	 		        	if(data === 'true'){
			 	 		        		goQnaDetail($('#pg').val(), qnaId); //post 방식으로 페이지 이동
					 				} else if(data === 'false'){
					 					swal('비밀번호가 맞지 않습니다', '' , 'warning');//end swal
					 				}
			 	 		        },
			 	 		        error: function(err){
			 	 		        	console.log(err);
			 	 		        }
			 				})//ajax
		 				}
		 			});//link 끝
 		        },
 		        error: function(err){
 		        	console.log(err);
 		        }
 			});//ajax
 			
 			//글 작성 버튼 클릭
 			$('#gray_btn').click(function(){  
 				location.href = '/shoeCream/serviceCenter/qnaWrite';
 			});
 		})
 	
 	</script>
</body>
</html>