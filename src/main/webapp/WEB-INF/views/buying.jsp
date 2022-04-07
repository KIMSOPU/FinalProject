<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/shoeCream/resources/css/buying.css">
	<link rel="stylesheet" href="/shoeCream/resources/css/date.css">
</head>
<body>

<div class="my_purchase">
	<div class="title"><div class="title"><h3>구매 내역</h3></div></div>
		<div class="purchase_list_tab detail_tab">
			<div class="tab_item tab_on tab_item1">
				<a href="/shoeCream/my/buying" class="tab_link">
					<dl class="tab_box">
						<dt class="title">구매 입찰</dt>
						<dd class="count">
							<c:if test = "${empty totalCount}">	
								0
							</c:if>
							<c:if test = "${!empty totalCount}">	
								${totalCount}
							</c:if>
						</dd>
					</dl>
				</a>
			</div>
			<div class="tab_item tab_item2">
				<a href="/shoeCream/my/ingBuying" class="tab_link" id="ingBuying">
					<dl class="tab_box">
						<dt class="title">거래 중</dt>
						<dd class="count">
							<c:if test = "${empty ingCount}">	
								0
							</c:if>
							<c:if test = "${!empty ingCount}">	
								${ingCount}
							</c:if>
						</dd>
					</dl>
				</a>
			</div>
			<div class="tab_item tab_item3">
				<a href="/shoeCream/my/endBuying" class="tab_link">
					<dl class="tab_box">
						<dt class="title">거래완료</dt>
						<dd class="count">
							<c:if test = "${empty endCount}">	
								0
							</c:if>
							<c:if test = "${!empty endCount}">	
								${endCount}
							</c:if>
						</dd>
					</dl>
				</a>
			</div>
			</div>		
	</div>
			 
	<div class="period_search">
		<div class="period_month">
			<ul class="month_list">		
				<li class="month_item"><input type="button" class="month_link" value="최근 2개월"></li>
				<li class="month_item"><input type="button" class="month_link" value="4개월"></li>
				<li class="month_item"><input type="button" class="month_link" value="6개월"></li>
			
				<li class="month_item"><input type="text" disabled="disabled" class="month_link link1 link2" id="date1"></li>
				<li><span class="swung_dash">~</span></li>
				<li class="month_item"><input type="text" disabled="disabled" class="month_link link1" id="date2"></li>				
				<li class="month_item"><div class="period_btn_box"><button class="btn_search buyingBtn is_active">조회</button></div></li>
			</ul>
		</div>

	</div>
	
	<ul class="search_info">
		<li class="info_item"><p>조회 가능한 기간은 2년 전 까지입니다.</p></li>
		<li class="info_item"><p>기간별 조회 결과는 입찰일 기준으로 노출됩니다.</p></li>
	</ul>
	
	<div class="purchase_list bidding bid">
		<jsp:include page="${display2}"></jsp:include>
	</div>

</body>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	<script type="text/javascript"> 
 	var $j351 = jQuery.noConflict();
 	$j351(function() {  
 		fn_default_datepicker();
 	});	
 	
 	function fn_default_datepicker()
 	{
 	    var start =  $j351( "#date1" ).datepicker({
 	    	 showOn:"button", 
	 	     buttonImage: "/shoeCream/images/calendar.png",
	 	     buttonImageOnly: true,
	 	     changeYear: true, 
	 	     changeMonth:true,
	 	     dateFormat:"yy-mm-dd",
	 	     dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
	 	     dayNamesMin : ['월','화','수','목','금','토','일'],
	 	     monthNamesShort:  [ "1월", "2월", "3월", "4월", "5월", "6월","7월", "8월", "9월", "10월", "11월", "12월" ],
	 	     minDate: "-24M",
	 	     maxDate: "today -1"
 	    });
 	        
 	    var end =  $j351( "#date2" ).datepicker({
 	    	showOn:"button", 
	 	     buttonImage: "/shoeCream/images/calendar.png",
	 	     buttonImageOnly: true,
	 	     changeYear: true, 
	 	     changeMonth:true,
	 	     dateFormat:"yy-mm-dd",
	 	     dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
	 	     dayNamesMin : ['월','화','수','목','금','토','일'],
	 	     monthNamesShort:  [ "1월", "2월", "3월", "4월", "5월", "6월","7월", "8월", "9월", "10월", "11월", "12월" ],
 	    	 minDate: "-24M"
	        ,maxDate: "0M"
 	      });
 	    
 	    //초기값을 오늘 날짜로 설정
 	  	 $j351('#date2').datepicker('setDate', 'today');  
	     $j351('#date1').datepicker('setDate', '-6M');
 	}
 
	
 	</script>
</html>