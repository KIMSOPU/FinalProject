<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" media="screen" href="/shoeCream/resources/css/shopList.css" />
<div class="shop-title">
	<h2>SHOP</h2>
</div>

<div class="shop-content-box">
	<div class="search_filter">
		<div class="filter_status">
			<div class="status_box">
				<span class="status_txt">필터</span>
				<span class="status_num"></span>
			</div>
			<a class="btn delete_status_num">모두 삭제</a>
		</div>
		<!-- filter_list -->
		<div class="filter_list" id="brand_list">
			<div class="filter_title">
				<div class="title_box">
					<span class="main_title">브랜드</span>
					<span class="placeholder">모든 브랜드</span>
				</div>
				<div class="icon_box"><i class="fa-solid fa-plus"></i></div>
			</div>
			<div class="filter_menu" id="brand_menu"></div>
		</div>
		<div class="filter_list" id="size_list">
			<div class="filter_title">
				<div class="title_box">
					<span class="main_title">사이즈</span>
					<span class="placeholder">모든 사이즈</span>
				</div>
				<div class="icon_box"><i class="fa-solid fa-plus"></i></div>
			</div>
			<div class="filter_menu" id="size_menu"></div>
		</div>
		<div class="filter_list" id="price_list">
			<div class="filter_title">
				<div class="title_box">
					<span class="main_title">가격</span>
					<span class="placeholder">모든 가격</span>
				</div>
				<div class="icon_box"><i class="fa-solid fa-plus"></i></div>
			</div>
			<div class="filter_menu" id="price_menu"></div>
		</div>
	</div> 
	
	<div class="product-conent-box">
		<div class="shop-search-option">
			<button type="button" class="sorting sorting_title">인기순</button>
			<ul class="sorting_list sorting">
			    <li class="sorting_item item_on sorting" id="popular">
			    	<a class="sorting_link">
			            <div class="sorting_desc">
			                <p class="main_desc">인기순</p>
			                <p class="sub_desc">많이 판매된 순서대로 정렬합니다.</p>
			            </div>
			        </a>
			   	</li>
			    <li class="sorting sorting_item" id="lowest">
			    	<a class="sorting_link">
			            <div class="sorting_desc">
			                <p class="main_desc">즉시 구매가순</p>
			                <p class="sub_desc">즉시 구매가가 낮은 순서대로 정렬합니다.</p>
			            </div>
			        </a>
			    </li>
			    <li class="sorting sorting_item" id="highest">
			    	<a class="sorting_link">
			            <div class="sorting_desc">
			                <p class="main_desc">즉시 판매가순</p>
			                <p class="sub_desc">즉시 판매가가 높은 순서대로 정렬합니다.</p>
			            </div>
			        </a></li>
			    <li class="sorting sorting_item" id="releaseDate">
			  		<a class="sorting_link">
			            <div class="sorting_desc">
			                <p class="main_desc">발매일순</p>
			                <p class="sub_desc">최신 상품 순서대로 정렬합니다. 아직 발매 전인 상품이 노출될 수 있습니다.</p>
			            </div>
			        </a>
			    </li>
			</ul>
		</div>
		<div class="filter_tag"></div>
		<div class="product-content-list">
			<div class="product_wrap">
			</div>
		</div>
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
<input type="hidden" id="ssUserId" value="${ssUserId}">	
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/shoeCream/resources/js/shopList.js"></script>