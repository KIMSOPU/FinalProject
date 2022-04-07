<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel='stylesheet' type='text/css' media='screen'
	href='/shoeCream/resources/css/shopView.css'>
<link rel="stylesheet" href="/shoeCream/resources/css/styleProductFeed.css" />
<!--  모달 css - 프로젝트에 따라 경로만 수정  -->
<link rel="stylesheet" href="/shoeCream/resources/css/modal.css">


<div class="shopDetail-box">
	<!--전체를 감싸는 박스-->
	<div class="shopDetail-top tophidden" id="shop-detail-top">
		<div class="shopDetail-top-product">
			<div class="shopDetail-top_img">
				<img class="shopDetail-top_Realimg" src="javascript:;" />
			</div>
			<div class="shopDetail-product_text">
				<p class="procut-title"></p>
				<p class="product-subtitle"></p>
			</div>
		</div>
		<!--shopDetail-top-product-->

		<div class="shopDetail-top-button-wrap">
			<div class="shopDetail-top-button shopDetail-like top-like-btn">
				<a href="javascript:;" class="shopDetail-like-link"> 
					<i class="wish-link fa-regular fa-bookmark fa-lg"></i><span class="like-count">0</span>
				</a>
			</div>
			<!--첫번째버튼-->

			<div class="shopDetail-top-button shopDetail-buy">
				<a href="javascript:;" class="shopDetail-buy-link">
					<div class="button-title">
						<strong>구매</strong>
					</div>
					<div class="price">
						<span class="amount"><em class="num">-
						</em><span class="won">원</span></span><span class="desc">최소구매가</span>
					</div>
				</a>
			</div>
			<!--두번째버튼-->

			<div class="shopDetail-top-button shopDetail-sell">
				<a href="javascript:;" class="shopDetail-sell-link">
					<div class="button-title">
						<strong>판매</strong>
					</div>
					<div class="price">
						<span class="amount"><em class="num">-
						</em><span class="won">원</span></span><span class="desc">최소구매가</span>
					</div>
				</a>
			</div>
			<!--세번째버튼-->
		</div>
	</div>
	<!--shopDetail-top-->

	<div class="shopDetail-product-content">
		<div class="column-bind">
			<div class="left-column is_fixed" id="productImgDiv">
					<img id="productImg"/>
			</div>
	
			<div class="right-column product-detail">
				<div class="product-main-title-box">
					<a class="product-brand" href="javascript:;"></a>
					<p class="procut-title"></p>
					<p class="product-subtitle"></p>
				</div>
				<!--product-main-title-box-->
	
				<div class="product-size-box">
					<!-- <span class="product-size-txt">재고</span><span
						class="produxt-size-detail">사이즈 재고 보기<i
						class="fa-solid fa-angle-down"></i></span> -->
				</div>
				<div class="product-price-box">
					<div class="product-price-txt-box">
						<span class="product-price-txt">오늘의 시세</span>
					</div>
					<!--product-price-txt-box-->
	
					<div class="product-prict-deatil-box">
						<div class="amount">
							<span class="produxt-price-detail">-</span><span
								class="price-won">원</span>
						</div>
					</div>
					<!--product-prict-deatil-box-->
				</div>
	
				<!--버튼버튼버튼-->
	
				<div class="shopDetail-content-button2">
					<div class="shopDetail-buy">
						<a href="javascript:;" class="shopDetail-buy-link">
							<div class="button-title">
								<strong>구매</strong>
							</div>
							<div class="price">
								<span class="amount"><em class="num">-
								</em><span class="won">원</span></span><span class="desc">최소구매가</span>
							</div>
						</a>
					</div>
					<!--빨간버튼-->
	
					<div class="shopDetail-sell">
						<a href="javascript:;" class="shopDetail-sell-link">
							<div class="button-title">
								<strong>판매</strong>
							</div>
							<div class="price">
								<span class="amount"><em class="num">-
								</em><span class="won">원</span></span><span class="desc">최소구매가</span>
							</div>
						</a>
					</div>
					<!--초록버튼-->
				</div>
				<!--구매,판매-->
	
				<div class="shopDetail-like">
					<a href="javascript:;" class="shopDetail-like-link"> <i
						class="wish-link fa-regular fa-bookmark"></i><span>관심상품</span><span
						class="like-count" id="like-count">0</span></a>
				</div>
				<!--첫번째버튼-->
	
				<!--버튼버튼버튼-->
	
				<!--상품정보-->
	
				<div class="product-info-box">
					<h3>상품정보</h3>
					<div class="product-deatil-wrap">
						<div class="product-detail-info">
							<span class="model-number-title">모델번호</span><span
								class="model-number">-</span>
						</div>
						<div class="product-detail-info middle">
							<span class="model-release-date-title">출시일</span><span
								class="model-release-date">-</span>
						</div>
						<div class="product-detail-info">
							<span class="model-release-price-title">발매가</span><span
								class="model-release-price">-</span>
						</div>
					</div>
				</div>
	
				<!--상품정보-->
				<div class="delivery-way-wrap">
					<h3>배송정보</h3>
	
					<div class="delivery-way">
						<div class="delivery-way-text">
							<p>
								<strong>일반배송</strong> <span class="won">무료</span>
							</p>
							<p class="delivery-way-text-content">저희 상품은 배송비가 무료입니다!</p>
						</div>
					</div>
				</div>
				<!--delivery-way-wrap-->
	
				<div class="chart_div">
					<canvas id="myChart" style="width: 100%; height: 30vh;"></canvas>
				</div>
				<!--goto-event-pag-->
	
				<div class="confirm-wrap">
					<h3 class="confirm-title">구매 전 꼭 확인해주세요!</h3>
	
	
					<div class="drop-down-head" id="que-1">
						<p class="confirm-title">배송 기간 안내</p>
						<i class="fa-solid fa-angle-down"></i>
					</div>
	
					<div class="drop-down-content chang-style" id="ans-2">
					- 거래가 체결된 시점부터 48시간(일요일•공휴일 제외) 내에 판매자가 상품을 발송해야 하며, 통상적으로 발송 후 1-2일 내에 SHOECREAM 검수센터에 도착합니다.<br>
					- 검수센터에 도착한 상품은 입고 완료 후 3영업일 이내에 검수를 진행합니다. 검수 합격시 배송을 준비합니다.<br>
					* 상품 종류 및 상태에 따라 검수 소요 시간은 상이할 수 있으며, 구매의사 확인에 해당할 경우 구매자와 상담 진행으로 인해 지연이 발생할 수 있습니다.<br><br>

					- 검수센터 출고는 매 영업일에 진행하고 있으며, 출고 마감시간은 오후 5시입니다. 출고 마감시간 이후 검수 완료건은 운송장번호는 입력되지만 다음 영업일에 출고됩니다.
					</div>
	
	
	
					<div class="drop-down-head" id="que-2">
						<p class="confirm-title">검수안내</p>
						<i class="fa-solid fa-angle-down"></i>
					</div>
	
					<div class="drop-down-content chang-style">
					판매자의 상품이 검수센터에 도착하면 전담 검수팀이 철저한 분석과 검사로 정가품 확인을 진행합니다.<br><br>
					- 검수센터에서는 정가품 여부를 확인하기 위하여, 지속적으로 데이터를 쌓고 분석하여 기록하고 있습니다.<br>
					- 업계 전문가로 구성된 검수팀은 박스와 상품의 라벨에서 바느질, 접착, 소재 등 모든 것을 검수합니다.<br>
					검수 결과는 불합격•검수 보류•합격의 세가지 상태로 결과가 변경됩니다.<br><br>
					* 검수 합격: SHOECREAM 검수택(Tag)이 부착되어 배송을 준비함<br><br>
					
					* 검수 보류: 앱에서 사진으로 상품의 상태 확인 및 구매 여부를 선택. (24시간 이후 자동 검수 합격)<br><br>
					
					* 검수 불합격: 즉시 거래가 취소되고 구매하신 금액을 환불 처리함.(환불 수단은 결제 수단과 동일)
										
					</div>
	
	
	
					<div class="drop-down-head" id="que-3">
						<p class="confirm-title">구매환불/취소/교환안내</p>
						<i class="fa-solid fa-angle-down"></i>
					</div>
	
					<div class="drop-down-content chang-style">
					SHOECREAM은 익명 거래를 기반으로 판매자가 판매하는 상품을 구매자가 실시간으로 구매하여 거래를 체결합니다.<br><br>
					- 단순 변심이나 실수에 의한 취소/교환/반품이 불가능합니다. 상품을 원하지 않으시는 경우 언제든지 SHOECREAM에서 재판매를 하실 수 있습니다.<br>
					- 상품 수령 후, 이상이 있는 경우 SHOECREAM 고객센터로 문의해주시기 바랍니다.<br>
					</div>
	
				</div>
				<!--confirm-wrap-->
	
				<div class="point-guide-line">
					<ul>
						<li class="guide-list"><d.qiv class="guide-wrap">
							<div class="guide-img">
								<i class="fa-regular fa-thumbs-up fa-lg"></i>
							</div>
							<div class="guide-text-area">
								<p class="guide-title">100%정품보증</p>
								<p class="guide-text">SHOECREAM에서 검수한 상품이 정품이 아닐 경우, 구매가의 3배를
									보상합니다.</p>
							</div>
							</d.qiv>
							<div class="guide-wrap">
								<div class="guide-img">
									<i class="fa-solid fa-check-double fa-lg"></i>
								</div>
								<div class="guide-text-area">
									<p class="guide-title">엄격한 다중 검수</p>
									<p class="guide-text">모든 상품은 검수센터에 도착한 후, 상품별 전문가 그룹의 체계적인
										시스템을 거쳐 검수를 진행합니다.</p>
								</div>
							</div>
							<div class="guide-wrap">
								<div class="guide-img">
									<i class="fa-solid fa-box-open fa-lg"></i>
								</div>
								<div class="guide-text-area">
									<p class="guide-title">정품 인증 패키지</p>
									<p class="guide-text">검수에 합격한 경우에 한하여 SHOECREAM의 정품 인증 패키지가 포함된
										상품이 배송됩니다.</p>
								</div>
							</div></li>
					</ul>
				</div>
				<!--point-guide-line-->
	
				<div class="product-notice">
					<p>슈크림(주)는 통신판매 중개자로서 통신판매의 당사자가 아닙니다. 본 상품은 개별판매자가 등록한 상품으로 상품,
						상품정보, 거래에 관한 의무와 책임은 각 판매자에게 있습니다. 단, 거래과정에서 검수하고 보증하는 내용에 대한 책임은
						슈크림(주)에 있습니다.</p>
				</div>
			</div>
			<!--product-detail-->
		</div>
		<!-- column-bind -->
	</div>
	<!--shopDetail-product-content-->
	
	<div class="product-tag-style">
		<h2>스타일</h2>
		<div class="content-null-div"></div>
		<div class="styleboard-content"></div>	
	</div>
	<div class="add_btn_div">
		<a class="add_btn" href="javascript:;">더보기</a>
	</div>
</div>
<!--shopDetail-box-->
 
<div id="modal-sell" class="modal">
    <form action="/shoeCream/shop/shopSalesView/" class="modal-content-form" method="POST">
	    <div class="modal-window">
		        <div class="modal-title">
		            <h2 class="modal-title-text">모달제목</h2>
		        	<a href="javascript:;" class="close-area"><i class="fa-solid fa-xmark fa-lg"></i></a>
		        </div>
		        <div class="modal-content">
		            <p>모달 안에 넣을 내용</p>
		        </div>
		        <div class="modal-footer">
		            <p>모달 풋터</p>
		        </div>
	    </div>
    </form>
</div><!-- modal-sell -->

<script type="text/javascript"src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- 
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script> -->
<script type="text/javascript" src="/shoeCream/resources/js/shopView.js"></script>
<script type="text/javascript" src="/shoeCream/resources/js/shopStyleFeed.js"></script>


