<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="/shoeCream/resources/css/styleProductFeed.css" />

<div id="user_header_scroll" class= "scroll-hidden">
	<div class="user_header">
		<img class="product-img profile-img-sm" src="/shoeCream/images/productImg/${productInfo.img1}">
		<span class="product-name">${productInfo.productName}</span>
	</div>
</div>
<div class="userFeedContainer">

	<div class="userFeed_header">
		<img class="product-img" src="/shoeCream/images/productImg/${productInfo.img1}" />
		<div class="profile-infobox"><span class="product-name header-product-name">${productInfo.productName}</span></div>
		<div class="profile-sub"><span class="amount"><fmt:formatNumber value="${productPrice}" pattern="#,###" />원</span></div>
	</div>
	
	<div class="content-null-div"></div>
	<div class="styleboard-content">
		
	</div>
</div>

<jsp:include page="../footer.jsp"></jsp:include>
<input type="hidden" id="productId" value="${productId}">
<input type="hidden" id="ssUserId" value="${ssUserId}">
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	var page = 1;
	nextLoad();
	
	function nextLoad(){
		// 페이지 로드 시 유저정보+유저피드 4개*3줄 로드 . 게시글 없을 경우 띄워줄 페이지도 만들기..
		// if page=1 이면 appendTo($('.styleboard-content')) , 아니면 appendTo($('.card-box'))
		$.ajax({
			type: 'post',
		    url: '/shoeCream/style/getProductsFeed', 
		    data: 'productId='+$('#productId').val(),
		    success: function(data){
		    	console.log(JSON.stringify(data));
		    	
		    	// 게시물이 없을 경우
		    	if(data.length === 0) {
		    		let noContentDiv = '';
		    			noContentDiv += "<div class='content-null'>";
		    			noContentDiv += "<i class='fa-solid fa-camera-retro fa-4x'></i>";
		    			noContentDiv += "<p>게시물 없음</p>";
		    			noContentDiv += "</div>"; 
		    		$('.content-null-div').append(noContentDiv);
		    		
		    	} else {
			    	// 게시물이 있을 경우 
			    	
			    	// 유저 프로필 이미지 설정
		    		const img = $('#userImg').val();
			    	let src = '';
			    	if(chkUrl(img)){
			    		src = img;
			    	} else {
			    		src = "/shoeCream/images/userProfile/"+img;
			    	}
			    	
			    	$.each(data, function(index, item){
			    		
			    		//card 부분 데이터
			    		$('<div/>', {class: 'card-box'}).append(
			    			$('<img/>', {
			    				class:'style-img_real',
			    				src: '/shoeCream/images/style_board/'+item.img1
			    				}),
			    			$('<div/>', {class: 'style-feed_detail'}).append(
			    				$('<a/>', {class: 'style-detail-link'}).append(
			    					$('<div/>', {class:'style_user-box'}).append(
			    						$('<img/>', {
			    							class: 'userProfile-img profile-img-sm',
			    							src: "/shoeCream/images/userProfile/"+item.img
			    							}),
			    						$('<span/>', {
			    							class: 'userFeed-username',
			    							text: item.username
			    							})),
			    					$('<span/>', {
			    						class: 'style_contents-box',
			    						text: item.contents
			    						})),
			    				$('<input/>', {type: 'hidden', value: item.styleId}), //url용 id
			    				$('<div/>', {class: 'style_btn-box'}).append(
			    					$('<a/>', {class: 'style_smile-link', href:'javascript:;'}).append(
			    						$('<i/>', {
			    							class: 'likeBtn likeBtn_'+item.styleId+' fa-solid fa-face-smile'}),
			    						$('<span/>', {
			    							class: 'style_like-count likeCount_'+item.styleId,
			    							text: item.likeCount
			    							})),
			    					$('<a/>', {class:'style_comment-link'}).append(
		    							$('<i/>', {class: 'fa-solid fa-message'}),
			    						$('<span/>', {
			    							class: 'style_comment-count', 
			    							text: item.replyCount
			    							})))),
			    			$('<input/>', {type: 'hidden', value: item.productId}), //url용 id
			    		).appendTo($('.styleboard-content'));		
			    					    		
			    		//게시글 당 좋아요 여부 체크하고 아이콘 반영
			    		likeOnOff(item.styleId, item.likeOnOff);
			    		
			    	});//each
			    	
			    	/* 공감버튼 클릭 */
			    	$('.style_smile-link').click(function(){
			    		if($('#ssUserId').val() == "") location.href = "/shoeCream/user/login";
			    		else {
			    			var styleId = $(this).parent().prev().val();
			    			//console.log('styleId: ' + styleId);
			    			$.ajax({
			    				type: 'post',
			    			    url: '/shoeCream/style/switchLike', 
			    			    data: 'styleId=' + styleId,
			    			    success: function(result){
			    			    	//console.log(JSON.stringify(result));
			    			    	likeOnOff(styleId, result); //아이콘 변경
			    			    	likeCountChange(styleId, result); //개수 변경
			    			    },
			    			    error: function(err){
			    			    	console.log(err);
			    			    }
			    			});//ajax
			    		}
			    	});//공감버튼
			    	
			    	/* 게시글 사진 클릭(상세보기 페이지) */
			    	$('.style-img_real').click(function(){
			    		var styleId = $(this).next().children().next().val();
			    		//console.log(styleId);
			    		location.href = "/shoeCream/style/details?styleId="+styleId;
			    	});
			    	
			    	/* 게시글 내용 클릭(상세보기 페이지) */
			    	$('.style-detail-link').click(function(){
			    		var styleId = $(this).next().val();
			    		location.href = "/shoeCream/style/details?styleId="+styleId;
			    	});
			    	
			    	/* 상품사진, 상품명 클릭 */
					$('.product-img, .product-name').click(function(){
						var productId = $('#productId').val();
						location.href = "/shoeCream/shop/shopView?productId="+productId;
					});//상품태그
			    	
		    	} //else
		    },
		    error: function(err){
		    	console.log(err);
		    }
		});//ajax
	}
	
	
}); // onload

	//스크롤 시 헤더 오픈/클로즈
	const box = document.getElementById("user_header_scroll");
	const basedBox = document.querySelector(".userFeed_header");
	const basedNum = -10;
	window.addEventListener("scroll", scrollEvent);
	
	function scrollEvent() {
	  const position = basedBox.getBoundingClientRect().top;
	
	  if (position < basedNum) box.classList.remove("scroll-hidden");
	  else box.classList.add("scroll-hidden");
	}
	
	/* 카카오 로그인 시 url 형식 체크 */
	function chkUrl(url){
	    const reg = /^http[s]?\:\/\//i;
	    return reg.test(url);
	}
	
	/* 좋아요 여부 on/off에 따라 아이콘 클래스 변경 */
	function likeOnOff(styleId, result){
		if(result == 'on'){
			$('.likeBtn_'+styleId).removeClass('fa-face-smile');
			$('.likeBtn_'+styleId).addClass('fa-heart');
		} else if(result == 'off'){
			$('.likeBtn_'+styleId).removeClass('fa-heart');
			$('.likeBtn_'+styleId).addClass('fa-face-smile');
		}
	}
	
	/* 좋아요 여부 on/off에 따라 공감 수 +- */
	function likeCountChange(styleId, result){
		var likeCount = $('.likeCount_'+styleId).text();
			likeCount *= 1; //text를 숫자로 변환
		var resultCount;
		if(result == 'on'){
			resultCount = likeCount+1;
		} else if(result == 'off'){
			resultCount = likeCount-1;
		}
		$('.likeCount_'+styleId).text(resultCount);
	}
	
</script>