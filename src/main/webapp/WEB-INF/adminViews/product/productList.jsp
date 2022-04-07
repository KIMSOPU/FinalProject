<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<head>
	<link href="/shoeCream/admin/assets/css/product/productList.css" rel="stylesheet" />
</head> 

 <input type="hidden" id="pg" name="pg" value="${pg}">
 <div class="card">
 
       <div class="card-header">
       	 <div class="list">
       		<h4 class="card-title">상품목록</h4>
       	</div>
       	<div class="write">
       		<input type="button" id="productWriteBtn" name="productWriteBtn" value="상품등록" onclick="location.href='/shoeCream/adminViews/product/productWrite'">
       	</div>     		
       </div>

        <div class="card-body">
            <div class="table-responsive">
            
                  <table class="table" id="productListTable">
                    <tr class=" text-primary" style="border-top:hidden">	                    	  
	                   		  <th><input type="checkbox" id="allCb" name="allCb" onclick="checkAll()"></th>
			                  <th>번호</th>
			                  <th>이미지</th>
			                  <th>상품명</th>
			                  <th>오늘시세</th>
			                  <th>수정</th>
			                  <th>삭제</th>
			                  <th>재고</th>
			                  <tr>
                  
                  </table>   
                  
              <input type="hidden" id="searchPg" name="searchPg" value="1"> 	                  
              <div class="productPagingDiv"></div>
              <br>
		 		
		 	    	 	   
		 	    <div id="deleteBtn">              
              		 <input type="button" id="deleteAll" name="deleteAll" value="  삭제  "> 
                </div>
               
               <div class="input-group no-border" id="searchDiv">
				    	<select name="searchOption" id="searchOption">
							<option value="productName">상품명</option>
							<option value="brandName" >브랜드</option>
						</select>
							
						<input type="text" class="form-control" placeholder="검색어 입력" id="inputWord" style="width: 80%">
					    <div class="input-group-append">
					           <div class="input-group-text"><i class="nc-icon nc-zoom-split"></i></div>
              		    </div>
			  </div>	  

      </div>
    </div>
 </div>
 
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/shoeCream/admin/assets/js/product/productList.js"></script> 
 