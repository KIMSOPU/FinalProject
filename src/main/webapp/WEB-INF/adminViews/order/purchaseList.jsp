<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<input type="hidden" id="pg" value="${pg}">
<div class="row">
  <div class="col-md-12">
    <div class="card">
    
      <div class="card-header">
        <div>
		<h2 class="card-title" style="color: black;text-align:center;">구매 조회</h2>
        	<div style="text-align:center;">
		        <button class="btn btn-secondary" type="button" id="dropdownMenuButton"
		        onclick="location.href='/shoeCream/adminViews/order/orderList'">주문조회</button>
		        <!-- onclick="location.href='/shoeCream/adminViews/order/orderList'"> -->
		        <button class="btn btn-secondary" type="button" id="dropdownMenuButton"
		        onclick="location.href='/shoeCream/adminViews/order/dealList'">거래조회</button>
       		
       			<button class="btn btn-secondary" type="button" id="dropdownMenuButton"
	        onclick="location.href='/shoeCream/adminViews/order/purchaseList'">구매조회</button>
	        <button class="btn btn-secondary" type="button" id="dropdownMenuButton"
	        onclick="location.href='/shoeCream/adminViews/sales/salesList'">판매조회</button>
       		</div>
        
	     
	       
        </div>
      </div>
      
      <div class="card-body">
        <div class="table-responsive">
          <table class="table" id="purchaseListTable">
			<thead class=" text-primary">
				<tr>
					<th>구매번호</th>
					<th>회원번호</th>
					<th>상품번호</th>
					<th>가격</th>
					<th>구매상태</th>
					<th>상품사이즈</th><!-- <th class="text-right"> -->
					<th>구매등록일</th>
				</tr>
			</thead>
            <tbody id="tableBody"></tbody>
          </table>
        <div id="purchasePagingDiv" class="pagingDiv"></div>
     	       <div class="input-group no-border" id="searchDiv">
				    	<select name="searchOption" id="searchOption">
							 <option value="purchaseId">구매번호</option>
						     <option value="productSize">상품사이즈</option>
						</select>
							
						<input type="text" class="form-control" placeholder="검색어 입력" 
							   id="purchaseSearchText" name="purchaseSearchText" style="width: 80%">
					    <div class="input-group-append">
					           <div class="input-group-text" id="searchBtn"><i class="nc-icon nc-zoom-split"></i></div>					           					           
              		    </div>
			  </div><!-- searchDiv -->
			  <div id="searchDivText"></div>
        </div><!-- table-responsive -->
      </div><!-- card-body -->
    </div>
    
  </div>
  
</div>

      <!--  -->
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/shoeCream/admin/assets/js/order/purchaseList.js"></script>