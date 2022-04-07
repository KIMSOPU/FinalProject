<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 찾기 성공</title>
<link rel="stylesheet" href="/shoeCream/resources/css/findUserResult.css">
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="help_success">
	<h2 class="help_title_success">아이디 찾기에 성공하였습니다.</h2>
	
	<div class="success_notice">
		<p class="success_notice_title">아이디</p>
		<p class="success_notice_txt">${username}</p>
	</div>
	
	<div class="success_btn_box">
		<a href="/shoeCream/user/findPwd" class="btn" id="find_pwd_btn">비밀번호 찾기</a>
		<a href="/shoeCream/user/login" class="btn" id="login_btn">로그인</a>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>