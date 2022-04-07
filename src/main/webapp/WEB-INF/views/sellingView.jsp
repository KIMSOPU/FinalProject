<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/shoeCream/resources/css/buyingView.css">
</head>
<body>
<input type="hidden" id="dealId" name="dealId" value="${dealId}">
<input type="hidden" id="salesId" name="salesId" value="${salesId}">
<input type="hidden" id="pg" name="pg" value="${pg}">
<input type="hidden" id="count" name="count" value="${count}">

	<div class="my_buying_detail bidding">
		<div class="content_title">
		
		<c:if test = "${count eq '1'}">	
			<div class="title"><h3 >�Ǹų��� &gt; ���� ��</h3></div>			
		</c:if>
		<c:if test = "${count eq '2'}">	
				<div class="title"><h3 >�Ǹų��� &gt; ���� ��</h3></div>
			</c:if>
			<c:if test = "${count eq '3'}">	
				<div class="title"><h3 >�Ǹų��� &gt; �ŷ��Ϸ�</h3></div>
			</c:if>
			
		</div>
		<div class="order_info_wrap">
			<div class="section_title order_title">
				<c:choose>
    			<c:when test = "${count eq '1'}">
					<div class="title_box"><h3 class="title"> �ֹ���ȣ <em class="order_number"><span id="order_number1">${salesId}</span></em></h3></div>
				</c:when>
				<c:otherwise> 
					<div class="title_box"><h3 class="title"> �ֹ�/�ŷ� ��ȣ <em class="order_number"><span id="order_number2">${dealId}</span></em></h3></div>
				</c:otherwise>
			</c:choose>
		
			</div>
			<div class="order_info">
				<div class="order_product">
					<div class="product_box">
						<div class="product" style="background-color: rgb(235, 240, 245);"></div>
					</div>
					<div class="product_detail">
						<strong class="number"></strong>
						<p class="name"></p><p class="size"><span class="size_text"></span></p>
					</div>
					<div class="view_btn_box"><a href="#" class="btn outlinegrey small"> ��ǰ �󼼺��� </a></div>
				</div>
			</div>
		</div>
		
		<br>
		<div class="purchase_history_wrap">
			<div class="section_title">
				<div class="title_box"><h3 class="title"> �Ǹ� ���� ���� </h3></div>
			</div>
			<div class="purchase_history bidding">
				<div class="history_detail">
					<div class="main_box">
						<dl class="main_item">
							<dt class="title">�Ǹ� �����</dt>
								<dd class="price">
									<span class="amount"></span>
									<span class="unit">��</span>
								</dd>
						</dl>
					</div>
				<div class="detail_box">
					<dl class="price_addition">
						<dt class="price_title dark"><span >�� ����ݾ�</span></dt><dd class="price_text bold buy"></dd>
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
		
		</div>
		
		<div class="detail_btn_box"><a href="#" class="btn btn_view_list outlinegrey medium" id="listBtn"> ��Ϻ��� </a></div>
	</div>
	
</body>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function() {
	$.ajax({
		 type: 'post',
		 url: '/shoeCream/my/getSellingInfo',
		 data: { 'salesId' : $('#salesId').val(), 'dealId' : $('#dealId').val()},
		 dataType: 'JSON',
		 success: function(data){
			 console.log(data);
			 date1 = new Date(data.REGDATE);
			 date3 = new Date(data.TRADEDATE);
			 
			 row = '<img class="image" src="/shoeCream/images/productImg/'+ data.IMG1 +'">';
			 $('.product').append(row);	
			 
			 $('.modelId').val(data.MODELID);
			 
			 $('.name').text(data.PRODUCTNAME);
			 $('.size_text').text(data.PRODUCTSIZE);
			 $('.amount').text(Math.floor(data.PRODUCTPRICE).toLocaleString());
			 $('.price_text').text((Math.floor(data.PRODUCTPRICE)-Math.floor(data.PRODUCTPRICE)*0.08).toLocaleString());
			 $('.date1').text(date1.toLocaleString());
			 
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
	$('.box2').click(function(){$('.layer').show()});
	$('.btn_layer_close, .status_item2').click(function(){$('.layer').hide()}); 

	$('#listBtn').click(function() {
		if($('#count').val() == 1){
			location.href = '/shoeCream/my/selling?pg='+$('#pg').val();	
		}else if($('#count').val() == 2){
			location.href = '/shoeCream/my/ingSelling?pg='+$('#pg').val();	
		}else{
			location.href = '/shoeCream/my/endSelling?pg='+$('#pg').val();	
		}
		
	})
	
	$('.view_btn_box').click(function() {
		location.href = '/shoeCream/shop/shopView?productId='+$('#productId').val();
	})
	
	$('.box2').click(function() {
		$.ajax({
			 type: 'post',
			 url: '/shoeCream/my/deleteSelling',
			 data: {'pg' : $('#pg').val(),
				 'option' : $(this).text()
				 },
			 dataType: 'JSON',
			 success: function(data){
				 swal('�ŷ��� ���� �Ǿ����ϴ�.', '' , 'success').then(function(){});//end swal
			 },
			 error: function(err){
					alert(err);
			}		 
		});
	})
})

</script>
</html>