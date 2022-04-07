<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>

<body>
	<div class="content_title">
		<h3 id="title_name">관심 상품</h3>
	</div>
	<div class="content_list">
		<c:if test="${empty wishList}">
			<div class="empty-area">
				<p>추가하신 관심 상품이 없습니다.</p>
				<a href="/shoeCream/shop/shopList" class="gray_btn mypage_btn">SHOP 바로가기</a>
			</div>
		</c:if>
		<ul>			
			<c:forEach var="i" items="${wishList}">
				<li>
					<a href=# class="productLink">
						<input type="hidden" id="productId" value="${i.productId}">
						<div class="shopDetail-top-product">
						    <div class="shopDetail-top_img">
						        <img class="shopDetail-top_Realimg" src='/shoeCream/images/productImg/${i.img}'>
						    </div>
						    <div class="shopDetail-product_text">
						        <p class="brand">${i.brand}</p>
						        <p class="product_name_en">${i.productName}</p>
						    </div>
						</div>
						<div class="shopDetail-buy">
						    <a href="#" class="shopDetail-buy-link">
						        <strong class="button-title">구매</strong>
						        <div class="price-div">
						        	<c:if test="${i.price == 0}">
						        		<span class="amount">-</span>
						        	</c:if>
					                <c:if test="${i.price != 0}">
						        		<span class="amount"><fmt:formatNumber value="${i.price}" pattern="###,###,###"/>원</span>
						        	</c:if>
						            <span class="desc">즉시구매가</span>
						        </div>
						    </a>
						    <a href=# class="delete-wish">삭제</a><input type="hidden" id="wishListId" value="${i.wishListId}">
						</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="pagingDiv" id="pagingDiv">${paging.pagingHTML}</div>
	<input type="hidden" id="pg" value="${pg}">
	<input type="hidden" id="wishListData" value="${wishList}">
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script type="text/javascript">
	 	function paging(pg) {
			location.href = '/shoeCream/my/wish?pg='+pg;
		}
	 	
	 	$(function(){
	 		// 관심상품 삭제
		 	$('.delete-wish').click(function(){
		 		var wishListId = $(this).next().val();
		 		$.ajax({
		 			type: 'post',
	 		        url: '/shoeCream/my/deleteWish',
	 		        data: {
	 		        	'wishListId' : wishListId
	 		        },
	 		        success: function(data){
	 		        	location.reload();
	 		        },
	 		        error: function(err){
	 		        	console.log(err);
	 		        }
		 		});//ajax
		 	});//관심상품 삭제
	 		
		 	//상품 페이지로 이동
 			$('.productLink').click(function(){
 				var productId = $(this).children().val();
 				location.href = '/shoeCream/shop/shopView?productId='+productId;
 			});
 			$('.shopDetail-buy-link').click(function(){
 				var productId = $(this).parent().prev().children().val();
 				location.href = '/shoeCream/shop/shopView?productId='+productId;
 			});
	 	})
 	</script>
</body>
</html>