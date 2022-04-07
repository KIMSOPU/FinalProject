<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<body>
	<div class="content_title">
		<h3 id="title_name">공지사항</h3>
	</div>
	<div class="content_detail">
		<div class="content_detail_head">
			<span class="content_detail_title">${content.title }</span>
			<span class="hit">조회수 ${content.hit }</span>
			<span class="regDate"><fmt:formatDate value="${content.regDate}" pattern="yyyy.MM.dd"/></span>
		</div>
		<div class="content_detail_body">
			<pre style="white-space: pre-line; word-break: break-all;">
		   		<span id="contentSpan">${content.contents }</span>
		   	</pre>
		</div>
		<div class="btn_center_div">
			<a href=# class="service_btn gray_btn" id="gray_btn">목록보기</a>
		</div>
	</div>
	<input type="hidden" id="pg" value="${pg}">
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script type="text/javascript">
 		
 		$(function(){ 			
 			//버튼 클릭
 			$('#gray_btn').click(function(){  //페이지 번호 가져와야 함
 				location.href = '/shoeCream/serviceCenter/announcement?pg='+$('#pg').val();
 			});
 		});
 	</script>
	
</body>
</html>