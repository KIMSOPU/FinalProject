<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
<title>슈크림</title>
</head>
<body>
	<div id="container">
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
	</div>

	<div class="body">
		<!--  style="height: 200vh;" -->
		<!-- display가 없을 때 -->
		<c:if test="${empty display}">
			<jsp:include page="/WEB-INF/views/indexBody.jsp"></jsp:include>
		</c:if>

		<!-- display가 있을 때 -->
		<c:if test="${not empty display}">
			<jsp:include page="${display}"></jsp:include>
		</c:if>
	</div>

	 <div id="footer">
	 	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	 </div>
</body>
</html>