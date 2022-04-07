<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nav Bar</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Archivo+Black&family=Bangers&family=Crete+Round&display=swap"/>
<!-- jQuery -->
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="/shoeCream/resources/css/top.css">
<link rel="stylesheet" type="text/css" media="screen" href="/shoeCream/resources/css/main.css" />
<script src="https://kit.fontawesome.com/805c8222dc.js" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<div class="header">
		<ul class="list_menu">
			<li><a href="/shoeCream/serviceCenter/announcement">고객센터</a></li>
			<li><a href="/shoeCream/my/wish">관심상품</a></li>
			<li><a href="/shoeCream/my/myProfile">마이페이지</a></li>
			<c:if test="${ssAdmin!=null}">
				<li><a href="/shoeCream/adminViews/stats/statsView">관리자페이지</a></li>
			</c:if>
			<c:if test="${ssUserId==null}">
				<li><a href="/shoeCream/user/login">로그인</a></li>
			</c:if>
			<c:if test="${ssUserId!=null}">
				<li><a class="logout_btn">로그아웃</a></li>
			</c:if>
		</ul>
		<hr>
	
		<nav class="navbar">
	        <div class="kream-header__title">
	        	<span><a href="/shoeCream/index.jsp">ShoeCREAM</a></span>
	        </div>
			
			<ul class="navbar__menu">
				<li><a href="/shoeCream/style/trending">STYLE</a></li>
				<li><a href="/shoeCream/shop/shopList">SHOP</a></li>
				<li><a href=#>ABOUT</a></li>
				<li><a href=# class="search_btn" id="top_search_btn"><i class="fa-solid fa-magnifying-glass fa-lg"></i></a></li>
			</ul>
		</nav>
	</div>

	<!-- 모달 -->
	<div class="layer_search">
		<div class="layer_container">
			<div class="layer_header"></div>
			<div class="layer_content">
				<div class="search_container">
					<!-- 검색 -->
					<div class="search_wrap">
						<div class="search_area">
							<div class="search">
								<i class="fa-solid fa-magnifying-glass" id="search-icon"></i>
								<input type="text" id="input_search" placeholder="상품명 입력" title="검색창" autocomplete='off'>
								<button type="button" class="btn search_delete_btn"><i class="fa-solid fa-x" id="search-back-icon"></i></button>
							</div>
						</div>
						<button type="button" class="close_btn">취소</button>
					</div>
				</div>
				<div class="search_content_wrap">
					<div class="recent_area">
						<!-- 최근 검색어 -->
						<div class="recent_box">
							<strong class="recent_title">최근 검색어</strong>
							<button type="button" class="btn delete_btn"><i class="fa-solid fa-circle-xmark" id="delete-icon"></i></button>
							<ul class="search_list"></ul>
						</div>
						<!-- 브랜드 -->
						<ul class="brand_list">
							<li class="brand_item">
								<a class="brand_box">
									<img class="brand_img" src="/shoeCream/images/productImg/Jordan 3 Retro Cardinal Red.png">
									<p class="brand_name">조던</p>
								</a>
							</li>
							<li class="brand_item">
								<a class="brand_box">
									<img class="brand_img" src="/shoeCream/images/productImg/Adidas Yeezy Boost 350 V2 Dazzling Blue.png">
									<p class="brand_name">아디다스</p>
								</a>
							</li>
							<li class="brand_item">
								<a class="brand_box">
									<img class="brand_img" src="/shoeCream/images/productImg/Nike Dunk Low Retro Black.png">
									<p class="brand_name">나이키</p>
								</a>
							</li>
							<li class="brand_item">
								<a class="brand_box">
									<img class="brand_img" src="/shoeCream/images/productImg/Asics x I4P Gel-1130 Mink Glacier Grey.png">
									<p class="brand_name">아식스</p>
								</a>
							</li>
							<li class="brand_item">
								<a class="brand_box">
									<img class="brand_img" src="/shoeCream/images/productImg/New Balance 530 Steel Grey.png">
									<p class="brand_name">뉴발란스</p>
								</a>
							</li>
						</ul>
					</div>
					<!-- 검색어 자동완성 -->
					<div class="suggest_wrap">
						<div class="suggest_area">
						
							<div class="suggest_title_area">
								<p class="suggest_title"></p>
							</div> 
							
								<!-- 검색 결과 -->
							<div class="suggest_list"></div> 
							
							<div class="result_nodata">
								<p class="nodata_main">검색하신 결과가 없습니다.</p>
								<p class="nodata_sub">
									상품 등록 요청은
									<span class="emphasis"> 1:1 문의하기 </span>
									로 요청해주세요. 
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>	
	</div>	
</body>
<script type="text/javascript">
	let searchList = new Array();
	let productList = [];
	let keyword;
	
	openSearchBar();	// 브랜드 자동입력 위해 한번 열고닫음
	closeSearchBar();
	
	$('#input_search').on('input', function(){
		keyword = $('#input_search').val().toLowerCase();
		
		if(keyword!='') {
			$('.result_nodata').show();
			checkOutKeyword(keyword);
		} else { // keyword==''
			$('.suggest_wrap').css('display', 'none');
			$('.suggest_list').empty();
			$('.recent_area').show();
		}
	});
	
	$(document).on('click', '.suggest_item', function(){
		$('.search_item').remove(); // 초기화
		
		const item = {
			"model":$(this).find('.model_sub_info').text(),
			"productId":this.children[0].value
		}
		
		if(localStorage.length!=0){
			searchList = JSON.parse(localStorage.getItem('searchList'));
		}
		
		searchList.push(item);
		
		if(searchList.length > 5)
			searchList.shift(); // 5개만 담기
		
		console.log(searchList);
		
		localStorage.setItem('searchList', JSON.stringify(searchList));
		setResentList();
		
		location.href = "/shoeCream/shop/shopView?productId="+this.children[0].value;
	});//end click
	
	$('.recent_box .delete_btn').click(function(){
		localStorage.clear();
		setResentList();
	});
	
	$('#top_search_btn').click(function(){
		setResentList();
		openSearchBar();
	});
		
	$('.layer_search .close_btn').click(function(){
		closeSearchBar();
	});
		
	// 모달 밖 영역 클릭 시 닫기
	$('html').click(function(e){
		if($('.layer_search').is(e.target)){
			closeSearchBar();
		}		
	});
	
	$(document).on("click", ".product-brand", function(){
		openSearchBar();
		
		$('#input_search').val($(".product-brand").text());
		keyword = $('#input_search').val().toLowerCase();
		checkOutKeyword(keyword);
		$('#input_search').trigger('input');
	});//end click
	
	$(document).on('click', '.item_list-img', function(){
		openSearchBar();
		
		$('#input_search').val(this.nextElementSibling.innerText);
		keyword = $('#input_search').val().toLowerCase();
		checkOutKeyword(keyword);
		$('#input_search').trigger('input');
	});//end click
	
	// 로그아웃
 	$('.logout_btn').click(function(){
 		if('${ssAccessToken}'==''){
			$.ajax({
				type:'get',
				url:'/shoeCream/user/logout',
				success:function(){
					location.href = "/shoeCream/index.jsp";
				},
				error:function(){
					alert('Error: 로그아웃');
				}
			}); // end ajax
 		}else{
 			location.href="https://kauth.kakao.com/oauth/logout?client_id=8f0cf6601a7a42e678ddd67614c593ab&logout_redirect_uri=http://localhost:8090/shoeCream/user/logout";
 		}
	});
	
 	function setResentList(){
		const recentList = JSON.parse(localStorage.getItem('searchList'));
		
		$('.search_item').remove(); // 초기화
		
		if(localStorage.length!=0){
			// 최신 검색 순으로 출력
			for(i = recentList.length-1; i >= 0; i--){
				$('<li/>')
				.append($('<a/>',{class:'search_item', text:recentList[i].model, href:'/shoeCream/shop/shopView?productId='+recentList[i].productId}))
				.appendTo($('.search_list'))
			}
			$('.recent_box').css('display', 'block');
		}else{
			$('.recent_box').css('display', 'none');
		}
	}
	
	function getProductListForSearch() {
		$.ajax({
			type:'POST',
			url:'/shoeCream/search/product/getProductListForSearch',
			success: function(data){
				productList.splice(0, productList.length);
				console.log(productList);
				$.each(data, function(index, item) {
					productList.push(item);
				});
			},
			error:function(){
				alert('Error: 검색');
			}
		}); //end ajax 
	};
	
	function checkOutKeyword(keyword){
		$('.suggest_list').empty();
		
		$('.suggest_wrap').css('display', 'block');
		$('.recent_area').css('display', 'none');
		$('.suggest_title_area, .suggest_list').show();
		$('.suggest_title').text($('#input_search').val());  
		
		for(let i = 0; i < productList[0].length; i++) {
			if(productList[0][i].productName.includes(keyword) 
				|| productList[0][i].productNameKor.includes(keyword)
				|| productList[0][i].brandName.includes(keyword)) {
				
				$('.result_nodata').hide();
				
				const img_src = "/shoeCream/images/productImg/"+productList[0][i].img1;
				$('<div/>',{class:'suggest_item'})
				.append(
						$('<input>', {type:'hidden', value: productList[0][i].productId}), 
						$('<a/>',{class:'suggest_link'})
						.append($('<div/>',{class:'suggest_thumb'})
								.append($('<img/>',{class:'thumb_img',src:img_src})))
								.append($('<div/>',{class:'suggest_info'})
										.append($('<p/>',{class:'model_title',text:productList[1][i].productName}))
										.append($('<p/>',{class:'model_sub_info',text:productList[1][i].productNameKor}))))
				.appendTo($('.suggest_list'));
			}
			
		}; // end for
	};
	
	function closeSearchBar(){
		$('.layer_search').css('display', 'none');
		$('body').css('overflow', 'auto');
		$('#input_search').val('');
	};
	
	function openSearchBar(){
		getProductListForSearch();
		
		$('.suggest_wrap').hide();
		$('.recent_area').show();
		$('.suggest_title').text('');
		$('.layer_search').css('display', 'block');
		$('body').css('overflow', 'hidden');
	};
</script>
</html>