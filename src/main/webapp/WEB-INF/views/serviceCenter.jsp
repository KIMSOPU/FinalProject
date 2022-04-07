<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="/shoeCream/resources/css/serviceCenter.css">
</head>
<body>
	<jsp:include page="top.jsp"></jsp:include>
	<div id="main"> 		
		<div class="left_nav">
 			<ul class="left_menu">
 				<li>
 					<a href="/shoeCream/serviceCenter/announcement"><h2>고객센터</h2></a>
 				</li>
 				<li id="announcement" class="nav-item active">
 					<a href="#" class="nav-link">공지사항</a>
 				</li>
 				<li id="qna" class="nav-item">
 					<a href="#" class="nav-link">1:1 문의</a>
 				</li>
 			</ul>
 			<form id="frm" method="post" action="">
				<input type="hidden" name="pageName" id="pageName">	 			
 			</form>
		</div>
			
		<div id="content_area">
			<jsp:include page="${display }"/>
		</div>
 	</div>
 	<jsp:include page="footer.jsp"></jsp:include>
 	<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script type="text/javascript">
 		//left nav 속성 부여 
	 	$(function(){
			$(".nav-item").removeClass("active");
			var pageName = "<c:out value='${pageName}' />";
			$("#"+pageName).addClass("active"); 
		})
 	
 		//클릭시 page name과 include할 jsp 불러오는 함수를 객체 리터럴 방식으로 생성
 		var left = {
 			pageSubmitFn : function(menu){ //menu는 클릭시 들어올 id값
				if(menu === 'announcement') {
					$('#frm').attr('action', '/shoeCream/serviceCenter/announcement');
					$('#pageName').val('announcement');
				}else if(menu === 'qna') {
					$('#frm').attr('action', '/shoeCream/serviceCenter/qna');
					$('#pageName').val('qna');
				}
				$("#frm").submit();
			}
 		}
 		
 		//클릭 이벤트
		$(".nav-item").click(function(){
			var menu = $(this).attr("id");
			left.pageSubmitFn(menu);  //객체 리터럴 방식으로 최초 한 번 스스로 인스턴스화 하면 클래스 안에 있는 메서드 호출 가능
		})
 	</script>
</body>
</html>