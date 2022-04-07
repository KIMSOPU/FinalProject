<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet"  type="text/css" media="screen" href="/shoeCream/resources/css/index/notice.css" />

<!--공지-->
<content>
  <div class="notice_lg" style="margin-top: 107px">
    <!-- <a href="#">[공지]Essentials 3D 티셔츠 무상 검수 서비스 안내</a> -->
  </div>
  <!--공지-->
  <!--끊어가기-->
  <div class="banner_item">
    <jsp:include page="/WEB-INF/views/slickSlide/slickBanner.jsp"></jsp:include>
  </div>

  <!--끊어가기-->

  <div class="want_margin">
    <!--상품-->
    <div class="items_wrap">
      <div class="item_list">
        <div class="item_list-img">
          <img
            src="/shoeCream/images/brandLogo/nike_logo.jpg"
            style="height: 85px"/>
        </div>
        <p>나이키</p>
      </div>
      <div class="item_list">
        <div class="item_list-img">
          <img src="/shoeCream/images/brandLogo/adidas_logo.jpg" />
        </div>
        <p>아디다스</p>
      </div>
      <div class="item_list">
        <div class="item_list-img">
          <img src="/shoeCream/images/brandLogo/jordan_logo.png" />
        </div>
        <p>조던</p>
      </div>
      <div class="item_list">
        <div class="item_list-img">
          <img
            src="/shoeCream/images/brandLogo/new_balance_logo.jpg"
          />
        </div>
        <p>뉴발란스</p>
      </div>
      <div class="item_list">
        <div class="item_list-img">
          <img src="/shoeCream/images/brandLogo/asics_logo.svg" 
      	 	   style="width: auto;height: 80px;"/>
        </div>
        <p>아식스</p>
      </div>
    </div>
    <!--상품-->

	<section class="main-section product-section">
	    <div class="product-title">
	      <span class="realtitle">New in</span>
	      <div class="product-subtitle">신규 등록 상품</div>
	    </div>
	
	    <div class="product_wrap"></div>
	
	    <div class="btn">
	      <a class="add_btn" href="javascript:;">더보기</a>
	    </div>
	</section>

	
	<section class="main-section style-section">
	    <div class="product-title">
	      <span class="realtitle">Style Picks!</span>
	    </div>
	
	    <div class="style-slick-div">
	      <jsp:include page="/WEB-INF/views/slickSlide/styleSlick.jsp"></jsp:include>
	    </div>
	</section>
    
  </div>
</content>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/shoeCream/resources/js/index.js"></script>
