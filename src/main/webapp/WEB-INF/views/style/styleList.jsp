<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/shoeCream/resources/css/styleList.css" />
<link rel="stylesheet" href="/shoeCream/resources/css/modal.css">

<div class="style-tab-list">
  <a href="#" class="sylte-tab_item_tab_on">인기</a>
  <a href="/shoeCream/style/newest" class="sylte-tab_item">최신</a>
  <a href="#" class="sylte-tab_item" id="writeModalBtn"><i class="fa-solid fa-camera-retro fa-lg"></i></a>
</div>

<jsp:include page="styleWriteModal.jsp"></jsp:include>



<div class="style-want-center"></div>
<!--style-want-center-->
<input type="hidden" id="sessionId" value='${ssUserId}'>
<script src="/shoeCream/resources/js/styleList.js"></script>
