<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<link rel="stylesheet" href="/shoeCream/resources/css/mypage.css">
</head>
<body>
	<jsp:include page="top.jsp"></jsp:include>
	<div id="main"> 		
		<div class="left_nav">
			<div class="left_nav_title">
				<a href="#"><h2>마이페이지</h2></a>
			</div>
			<nav class="left_nav_menu">
	 			<ul class="left_menu">
	 				<li class="nav-item-title nav-item-title-first">
	 					<strong>쇼핑 정보</strong>
	 				</li>
	 				<li id="buying" class="nav-item">
	 					<a href="/shoeCream/my/buying" class="nav-link">구매 내역</a>
	 				</li>
	 				<li id="selling" class="nav-item">
	 					<a href="/shoeCream/my/selling" class="nav-link">판매 내역</a>
	 				</li>
	 				<li id="wish" class="nav-item">
	 					<a href="#" class="nav-link">관심 상품</a>
	 				</li>
	 				<li class="nav-item-title nav-item-title-second">
	 					<strong>내 정보</strong>
	 				</li>
	 				<li id="myProfile" class="nav-item">
	 					<a href="#" class="nav-link">프로필 정보</a>
	 				</li>
	 				<li id="myAddress" class="nav-item">
	 					<a href="#" class="nav-link">주소록</a>
	 				</li>
	 				<li id="myAccount" class="nav-item">
	 					<a href="#" class="nav-link">판매 정산 계좌</a>
	 				</li>
	 				<li id="myStyle">
	 					<a href="#" class="nav-link">내 스타일</a>
	 				</li>
	 			</ul>
	 		</nav>
 			<form id="frm" method="post" action="">
				<input type="hidden" name="pageName" id="pageName">	 			
 			</form>
		</div>
			
		<div id="content_area">
			<jsp:include page="${display}"/>
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
				if(menu === 'buying') {
					$('#frm').attr('action', '/shoeCream/my/buying');
					$('#pageName').val('buying');
				}else if(menu === 'selling') {
					$('#frm').attr('action', '/shoeCream/my/selling');
					$('#pageName').val('selling');
				}else if(menu === 'wish') {
					$('#frm').attr('action', '/shoeCream/my/wish');
					$('#pageName').val('wish');
				}else if(menu === 'myProfile') {
					$('#frm').attr('action', '/shoeCream/my/myProfile');
					$('#pageName').val('myProfile');
				}else if(menu === 'myAddress') {
					$('#frm').attr('action', '/shoeCream/my/myAddress');
					$('#pageName').val('myAddress');
				}else if(menu === 'myAccount') {
					$('#frm').attr('action', '/shoeCream/my/myAccount');
					$('#pageName').val('myAccount');
				}
				$("#frm").submit();
			}
		}
			
		//클릭 이벤트
		$(".nav-item").click(function(){
			var menu = $(this).attr("id");
			left.pageSubmitFn(menu);  //객체 리터럴 방식으로 최초 한 번 스스로 인스턴스화 하면 클래스 안에 있는 메서드 호출 가능
		})
		
		$("#myStyle").click(function(){
			/* var username = "<c:out value='${ssUsername}' />"; */
			location.href='/shoeCream/style/user';
		})
 	
 	</script>
</body>
</html>