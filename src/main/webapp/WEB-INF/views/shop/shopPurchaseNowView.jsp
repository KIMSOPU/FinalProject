<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel='stylesheet' type='text/css' media='screen'
	href='/shoeCream/resources/css/shopPurchaseBidView.css'>



<input type="hidden" id="productId" value="${map.productId}">
<input type="hidden" id="todaysPrice" value="${map.todaysPriceHidden}">
<input type="hidden" id="userProductSize" value="${map.userProductSize}">
<input type="hidden" id="salesId" value="${map.salesIdHidden}">
<input type="hidden" id="stockId" value="${map.stockIdHidden}">

<div class="shopDetail-top" id="shop-detail-top">
	<div class="shopDetail-top-product">
		<div class="shopDetail-top_img">
			<img class="shopDetail-top_Realimg" src="">
		</div>
		<div class="shopDetail-product_text">
			<p class="product_modelId"></p>
			<p class="product_name"></p>
			<p class="product_name_translate"></p>
		</div>
	</div>
	<!--shopDetail-top-product-->
</div>
<div class="shopDetail-content"></div>
<div class="shopDetail-content2"></div>
<div class="shopDetail-content3"></div>

<!-- 주소보기 모달 -->
<div class="layer_delivery layer" style="display: none;">
	<div class="layer_container">
		<div class="layer_header">
			<h2 class="title">새 주소 추가</h2>
		</div>
		<div class="layer_content">
			<div class="delivery_bind">
				<div class="delivery_input">
					<div class="input_box">
						<h5 class="input_title">수령인</h5>
						<input type="text" class="input_txt" id="input_recipient" autocomplete="off" placeholder="수령인의 이름">
						<p class="input_err">올바른 이름을 입력해주세요. (2-4자)</p>
					</div>
					<div class="input_box">
						<h5 class="input_title">우편번호</h5>
						<input type="text" class="input_txt" id="input_zipcode" autocomplete="off" placeholder="우편 번호를 검색하세요" readonly>
						<a href="#" class="btn zipcode_btn"> 우편번호 </a>
					</div>
					<div class="input_box">
						<h5 class="input_title">주소</h5>
						<input type="text" class="input_txt" id="input_addr1" autocomplete="off" placeholder="우편 번호 검색 후, 자동입력 됩니다" readonly>
					</div>
					<div class="input_box">
						<h5 class="input_title">상세 주소</h5>
						<input type="text" class="input_txt" id="input_addr2" autocomplete="off" placeholder="건물, 아파트, 동/호수 입력">
					</div>
				</div>
				<div class="delivery_check">
					<div class="checkbox_item">
						<label for="check1" class="check_label">
							<input type="checkbox" id="check1">
							<span class="label_txt">기본 배송지로 설정</span>
						</label>
					</div>
				</div>
			</div>
			<div class="layer_btn">
				<a href=javascript:; class="btn cancel_btn"> 취소 </a>
				<a href=javascript:; class="btn save_btn" id="save_address"> 주소 추가 </a>
			</div>
		</div>
		<div>
			<a href=javascript:; class="layer_close_btn"><i class="fa-solid fa-xmark"></i></a>
		</div>
	</div>
</div><!-- .layer_delivery layer -->
 

<div class="layer_account layer" style="display: none;"><!-- layer -->
	<div class="layer_container">
		<div class="layer_header">
			<h2 class="title">계좌선택</h2>
		</div><!-- end layer_header -->
		<div class="layer_content" style="margin: 0 30px;">
			<div class="input_companies input_box">
				<h4 class="input_title">은행명</h4>
				<input type="text" class="input_txt" id="input_bank" placeholder="선택하세요" readonly="readonly" autocomplete="off">
				<button type="button" class="dropdown_btn"><i class="fa-solid fa-circle-chevron-down"></i></button>
				<div class="layer_dropdown">
					<div class="items_layer_container">
						<div class="items_layer_content">
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">국민은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">신한은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">우리은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">하나은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">기업은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">농협은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">우체국</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">부산은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">제주은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">SC은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">한국씨티은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">산업은행</a></li>
							</ul>
							<ul class="drop_list">
								<li class="drop_item"><a href="javascript:;" class="drop_link">카카오뱅크</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		
			<div class="input_box">
				<h4 class="input_title">계좌번호</h4>
				<input type="text" class="input_txt" id="input_accountNum" placeholder="- 없이 입력하세요" autocomplete="off">
				<p class="input_err">올바른 계좌번호를 입력해주세요.</p>
			</div>
			
			<div class="input_box">
				<h4 class="input_title">예금주</h4>
				<input type="text" class="input_txt" id="input_accountHolder" placeholder="예금주명을 정확히 입력하세요." autocomplete="off">
				<p class="input_err">올바른 이름을 입력해주세요. (2-50자)</p>
			</div>
			
			<div class="layer_btn">
				<a href=javascript:; class="btn cancel_btn"> 취소 </a>
				<a href=javascript:; class="btn save_btn" id="save_account"> 계좌 변경 </a>
			</div>
		</div><!-- end layer_content -->
		<div>
			<a href=javascript:; class="layer_close_btn"><i class="fa-solid fa-xmark"></i></a>
		</div>
	</div>
</div><!-- .layer_delivery layer -->


<jsp:include page="/WEB-INF/views/shop/shopAddressList.jsp"></jsp:include>



<script type="text/javascript"src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="/shoeCream/resources/js/shopPurchaseNowView.js"></script>



