<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="/shoeCream/resources/css/findPwdResult.css">
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="help_success">
	<div class="help_notice">
		<p class="notice_txt">
		 임시 비밀번호를 전송하였습니다.
		 <br>
		 전송받은 임시 비밀번호로 로그인해주세요.
		</p>
	</div>
	<a href="/shoeCream/user/login" class="login_btn">로그인</a>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>