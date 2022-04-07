<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/shoeCream/resources/css/buyingView.css">
</head>
<body>
<input type="hidden" id="pg" name="pg" value="${pg}">
<input type="hidden" id="productId" name="productId" value="${productId}">
<input type="hidden" id="purchaseId" name="purchaseId" value="${purchaseId}">
<input type="hidden" id="orderId" name="orderId" value="${orderId}">
<input type="hidden" id="dealId" name="dealId" value="${dealId}">
<input type="hidden" id="count" name="count" value="${count}">


	<div class="my_buying_detail bidding">
		<div class="content_title">
		
			<c:if test = "${count eq '1'}">	
				<div class="title"><h3>구매내역 &gt; 입찰 중<input type="hidden" id="option" value="입찰"></h3></div>
			</c:if>
			<c:if test = "${count eq '2'}">	
				<div class="title"><h3>구매내역 &gt; 진행 중<input type="hidden" id="option" value="진행"></h3></div>
			</c:if>
			<c:if test = "${count eq '3'}">	
				<div class="title"><h3>구매내역 &gt; 거래완료<input type="hidden" id="option" value="완료"></h3></div>
			</c:if>
			
			
		</div>
		<div class="order_info_wrap">
			<div class="section_title order_title">
			
			<c:choose>
    			<c:when test = "${count eq '1'}">
					<div class="title_box"><h3 class="title"> 입찰번호 <em class="order_number"><span id="order_number"></span></em></h3></div>
				</c:when>
				<c:otherwise> 
					<c:if test="${empty info.ORDERID}">
						<div class="title_box"><h3 class="title"> 주문/거래 번호 <em class="order_number"><span id="order_number"></span></em></h3></div>
					</c:if>
					<c:if test="${info.ORDERID}">
						<div class="title_box"><h3 class="title"> 주문/거레 번호 <em class="order_number"><span id="order_number"></span></em></h3></div>
					</c:if>
				</c:otherwise>
			</c:choose>
				
			</div>
			<div class="order_info">
				<div class="order_product">
					<div class="product_box">
						<div class="product" style="background-color: rgb(235, 240, 245);"></div>
					</div>
					<div class="product_detail">
						<strong class="number modelId"></strong>
						<p class="name"></p><p class="size"><span class="size_text"></span></p>
					</div>
					<div class="view_btn_box"><a href="#" class="btn outlinegrey small"> 상품 상세보기 </a></div>
				</div>					
			</div>
		</div>
		
		<br>
		<div class="purchase_history_wrap">
			<div class="section_title">
				<div class="title_box"><h3 class="title"> 구매 입찰 내역 </h3></div>
			</div>
			<div class="purchase_history bidding">
				<div class="history_detail">
					<div class="main_box">
						<dl class="main_item">
							<dt class="title">구매가</dt>
								<dd class="price">
									<span class="amount"></span>
									<span class="unit">원</span>
								</dd>
						</dl>
					</div>
				<div class="detail_box">
					<dl class="price_addition">
						<dt class="price_title dark"><span >총 결제금액</span></dt><dd class="price_text bold buy"></dd>
					</dl>
				</div>
				
								
				<c:choose>
    			<c:when test = "${count eq '3'}">
					<div item="[object Object]" class="detail_box">
						<dl class="price_addition">
							<dt class="price_title dark"><span >거래날짜</span></dt><dd class="price_text date3"></dd>
						</dl>
					</div>
				</c:when>
				<c:otherwise> 
					<div item="[object Object],[object Object]" class="detail_box">
						<dl class="price_addition">
							<dt class="price_title dark"><span >입찰일</span></dt><dd class="price_text date1"></dd>
						</dl>
					</div>
				</c:otherwise>
			 </c:choose>
				
								
			</div>
		</div>
		<br>
		<div class="shipping_address_wrap">
			<div class="section_title">
				<div class="title_box"><h3 class="title"> 배송 주소 </h3></div><p class="noti">대기 중, 발송완료, 입고완료 상태에서만 배송지 변경이 가능합니다.</p>
			</div>
			<div class="shipping_address">
				<dl class="address_item">
					<dt class="address_title">받는 사람</dt><dd class="address_txt"><span id="add1"></span></dd>
				</dl>
				<dl class="address_item">
					<dt class="address_title">휴대폰 번호</dt><dd class="address_txt"><span id="add2"></span></dd>
				</dl>
				<dl class="address_item">
					<dt class="address_title">주소</dt><dd class="address_txt"><span id="add3"></span></dd>
				</dl>
			</div>
		</div>
		</div>
		<div class="detail_btn_box"><a href="#" class="btn btn_view_list outlinegrey medium" id="listBtn"> 목록보기 </a></div>
	</div>
	
</body>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

$(function() {
	$.ajax({
		 type: 'post',
		 url: '/shoeCream/my/getByingInfo',
		 data: { 'option' : $('#option').val(), 'productId' : $('#productId').val(), 'purchaseId' : $('#purchaseId').val(), 'orderId' : $('#orderId').val(), 'dealId' : $('#dealId').val()},
		 dataType: 'JSON',
		 success: function(data){
			 console.log(data);
			 date1 = new Date(data.REGDATE);
			 date3 = new Date(data.TRADEDATE);
			 
			 row = '<img class="image" src="/shoeCream/images/productImg/'+ data.IMG1 +'">';
			 $('.product').append(row);	
			 
			 $('.modelId').val(data.MODELID);
			 
			 if(data.PURCHASEID != 0){
				 $('#order_number').text(data.PURCHASEID);
			 }else if(data.DEALID != 0 && data.ORDERID == 0){
				 $('#order_number').text(data.DEALID);
			 }else if(data.ORDERID != 0 && data.DEALID == 0){
				 $('#order_number').text(data.ORDERID);
			 }	 
			 $('.name').text(data.PRODUCTNAME);
			 $('.size_text').text(data.PRODUCTSIZE);
			 $('.amount').text(Math.floor(data.PRODUCTPRICE).toLocaleString());
			 $('.price_text').text((Math.floor(data.PRODUCTPRICE) + Math.floor(data.PRODUCTPRICE)*0.02).toLocaleString());
			 $('.date1').text(date1.toLocaleString());
			 $('#add1').text(data.USERNAME);
			 $('#add2').text(data.USERNUM);
			 $('#add3').text(data.ADDR);	
			 
			 if($('#count').val() == "3"){
				 $('.date3').text(date3.toLocaleString());
			 }
		 },
		 error: function(err){
				alert(err);
		}		 
	});
	
	
	$('.layer').hide();
	// 모달창 열기 / 끄기
	$('.deleteBtn').click(function(){$('.layer').show()});
	$('.btn_layer_close').click(function(){$('.layer').hide()}); 	
	
	$('#listBtn').click(function() {
		if($('#count').val() == 1){
			location.href = '/shoeCream/my/buying?pg='+$('#pg').val();	
		}else if($('#count').val() == 2){
			location.href = '/shoeCream/my/ingBuying?pg='+$('#pg').val();	
		}else{
			location.href = '/shoeCream/my/endBuying?pg='+$('#pg').val();	
		}
		
	})
	
	$('.view_btn_box').click(function() {
		location.href = '/shoeCream/shop/shopView?productId='+$('#productId').val();
	})
	
})
</script>
</html>