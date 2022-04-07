<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>

<body>
	<div class="content_title">
		<h3 id="title_name">공지사항</h3>
	</div>
	<div class="content_list">
		<ul>			
			<c:forEach var="i" items="${list}">
				<li>
					<a href="#" class="link">${i.title} <input type="hidden" id="announcementId" value="${i.announcementId}"></a>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="pagingDiv" id="pagingDiv">${paging.pagingHTML}</div>
	<input type="hidden" id="pg" value="${pg}">
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script type="text/javascript">
 	
	 	function paging(pg) {
			location.href = '/shoeCream/serviceCenter/announcement?pg='+pg;
		}
 	
 		$(function(){
 			//상세페이지로 이동
 			$('.link').click(function(){
 				var announcementId = $(this).children().val();
 				location.href = '/shoeCream/serviceCenter/announcementDetail?pg='+$('#pg').val()+'&announcementId='+announcementId;
 			});
 		})
 	
 	</script>
</body>
</html>