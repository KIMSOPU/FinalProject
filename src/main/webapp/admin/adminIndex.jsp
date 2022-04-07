<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="/shoeCream/admin/assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="/shoeCream/admin/assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    관리자 페이지
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="/shoeCream/admin/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="/shoeCream/admin/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
  <!-- shoeCream CSS -->
  <link rel="stylesheet" href="/shoeCream/admin/assets/css/order/orderList.css">
</head>

<body class="">

<div class="wrapper ">
  <div class="sidebar" data-color="white" data-active-color="danger">
    <div class="sidebar-wrapper">     
      <div id="nav">
    	<jsp:include page="/WEB-INF/adminViews/main/adminSidebar.jsp"></jsp:include>
      </div>      
    </div>     
  </div>
  
<div class="main-panel" style="height: 1200px">
    <jsp:include page="/WEB-INF/adminViews/main/adminNavbar.jsp"></jsp:include>
    
    <div class="content"> <!--  style="height: 200vh;" -->
	    <!-- display가 없을 때 -->
	    <c:if test="${empty display}">
	        <div class="row">
	          <div class="col-md-12">
	            <h3 class="description">display</h3>
	          </div>
	        </div>
	    </c:if>
	    
	    <!-- display가 있을 때 -->
	    <c:if test="${not empty display}">
		    <jsp:include page="${display}"></jsp:include>
		</c:if>
	</div>

  <footer class="footer" style="position: absolute; bottom: 0; width: -webkit-fill-available;">
    <jsp:include page="/WEB-INF/adminViews/main/adminFooter.jsp"></jsp:include>
  </footer>
</div>
  
  
</div>
  
  <!--   Core JS Files   -->
  <script src="/shoeCream/admin/assets/js/core/jquery.min.js"></script>
  <script src="/shoeCream/admin/assets/js/core/popper.min.js"></script>
  <script src="/shoeCream/admin/assets/js/core/bootstrap.min.js"></script>
  <script src="/shoeCream/admin/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
  <!--  Google Maps Plugin    -->
  <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
  <!-- Chart JS -->
  <script src="/shoeCream/admin/assets/js/plugins/chartjs.min.js"></script>
  <!--  Notifications Plugin    -->
  <script src="/shoeCream/admin/assets/js/plugins/bootstrap-notify.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="/shoeCream/admin/assets/js/paper-dashboard.min.js?v=2.0.1" type="text/javascript"></script>
</body>
<!-- 
<script type="text/javascript">
$(function(){
	 $("li").each(function(){
		 $(this).click(function() {
             $(this).addClass("active");                //클릭된 부분을 상단에 정의된 CCS인 selected 클래스로 적용
             $(this).siblings().removeClass("active");  //siblings:형제요소들, removeClass:선택된 클래스의 특성을 없앰
		 });//end click
	 });//end each
});//end onload 



/* 
function getDisplay(url){
	console.log('getDisplay 실행')
	$('.content').load(url);
}
 */
</script> -->

</html>