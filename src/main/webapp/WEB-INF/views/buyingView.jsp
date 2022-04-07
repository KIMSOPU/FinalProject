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
				<div class="title"><h3>���ų��� &gt; ���� ��<input type="hidden" id="option" value="����"></h3></div>
			</c:if>
			<c:if test = "${count eq '2'}">	
				<div class="title"><h3>���ų��� &gt; ���� ��<input type="hidden" id="option" value="����"></h3></div>
			</c:if>
			<c:if test = "${count eq '3'}">	
				<div class="title"><h3>���ų��� &gt; �ŷ��Ϸ�<input type="hidden" id="option" value="�Ϸ�"></h3></div>
			</c:if>
			
			
		</div>
		<div class="order_info_wrap">
			<div class="section_title order_title">
			
			<c:choose>
    			<c:when test = "${count eq '1'}">
					<div class="title_box"><h3 class="title"> ������ȣ <em class="order_number"><span id="order_number"></span></em></h3></div>
				</c:when>
				<c:otherwise> 
					<c:if test="${empty info.ORDERID}">
						<div class="title_box"><h3 class="title"> �ֹ�/�ŷ� ��ȣ <em class="order_number"><span id="order_number"></span></em></h3></div>
					</c:if>
					<c:if test="${info.ORDERID}">
						<div class="title_box"><h3 class="title"> �ֹ�/�ŷ� ��ȣ <em class="order_number"><span id="order_number"></span></em></h3></div>
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
					<div class="view_btn_box"><a href="#" class="btn outlinegrey small"> ��ǰ �󼼺��� </a></div>
				</div>					
			</div>
		</div>
		
		<br>
		<div class="purchase_history_wrap">
			<div class="section_title">
				<div class="title_box"><h3 class="title"> ���� ���� ���� </h3></div>
			</div>
			<div class="purchase_history bidding">
				<div class="history_detail">
					<div class="main_box">
						<dl class="main_item">
							<dt class="title">���Ű�</dt>
								<dd class="price">
									<span class="amount"></span>
									<span class="unit">��</span>
								</dd>
						</dl>
					</div>
				<div class="detail_box">
					<dl class="price_addition">
						<dt class="price_title dark"><span >�� �����ݾ�</span></dt><dd class="price_text bold buy"></dd>
					</dl>
				</div>
				
								
				<c:choose>
    			<c:when test = "${count eq '3'}">
					<div item="[object Object]" class="detail_box">
						<dl class="price_addition">
							<dt class="price_title dark"><span >�ŷ���¥</span></dt><dd class="price_text date3"></dd>
						</dl>
					</div>
				</c:when>
				<c:otherwise> 
					<div item="[object Object],[object Object]" class="detail_box">
						<dl class="price_addition">
							<dt class="price_title dark"><span >������</span></dt><dd class="price_text date1"></dd>
						</dl>
					</div>
				</c:otherwise>
			 </c:choose>
				
								
			</div>
		</div>
		<br>
		<div class="shipping_address_wrap">
			<div class="section_title">
				<div class="title_box"><h3 class="title"> ��� �ּ� </h3></div><p class="noti">��� ��, �߼ۿϷ�, �԰�Ϸ� ���¿����� ����� ������ �����մϴ�.</p>
			</div>
			<div class="shipping_address">
				<dl class="address_item">
					<dt class="address_title">�޴� ���</dt><dd class="address_txt"><span id="add1"></span></dd>
				</dl>
				<dl class="address_item">
					<dt class="address_title">�޴��� ��ȣ</dt><dd class="address_txt"><span id="add2"></span></dd>
				</dl>
				<dl class="address_item">
					<dt class="address_title">�ּ�</dt><dd class="address_txt"><span id="add3"></span></dd>
				</dl>
			</div>
		</div>
		</div>
		<div class="detail_btn_box"><a href="#" class="btn btn_view_list outlinegrey medium" id="listBtn"> ��Ϻ��� </a></div>
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
	// ���â ���� / ����
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