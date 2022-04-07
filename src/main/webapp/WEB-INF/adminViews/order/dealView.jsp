<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/shoeCream/admin/assets/css/order/dealView.css">

<input type="hidden" id="dealIdText" value="${dealId}">
<div class="row">
  <div class="col-md-12">
    <div class="card">
    
      <div class="card-header">
		<h2 class="card-title" style="color: black;text-align:center;">거래 조회</h2>
        <button class="btn btn-secondary" type="button" id="dropdownMenuButton"
	        onclick="location.href='/shoeCream/adminViews/order/dealList'">목록</button>
      </div>
      
      <div class="card-body">
        <div class="table-responsive">
          <table class="table" id="dealListTable">
          
            <thead class=" text-primary">
				<tr>
					<th colspan="4" style="text-align:center">거래번호</th>
				</tr>
			</thead>
            <tbody>
            	<tr>
	            	<td class="tdForView"
	            	 colspan="4" style="text-align:center">1</td>
            	</tr>
            </tbody>
            
            <thead class=" text-primary">
				<tr>
					<th colspan="4" style="text-align:center">상품이름</th>
				</tr>
			</thead>
            <tbody>
            	<tr>
	            	<td class="tdForView" colspan="4" style="text-align:center">2</td>
            	</tr>
            </tbody>
            
            <thead class=" text-primary">
				<tr>
					<th>구매자아이디</th>
					<th>판매자아이디</th>
					<th>거래 가격</th>
					<th>거래 생성일</th>
				</tr>
			</thead>
            <tbody>
            	<tr>
	            	<td class="tdForView"></td>
	            	<td class="tdForView"></td>
	            	<td class="tdForView"></td>
	            	<td class="tdForView">2</td>
            	</tr>
            </tbody>
            
            
            
            <thead class=" text-primary">
				<tr>
					<th colspan="2" style="text-align:center">검수상태</th>
					<th colspan="2" style="text-align:center">운송장번호</th>
				</tr>
			</thead>
            <tbody>
            	<tr>
	            	<td class="tdForView" colspan="2" style="text-align:center"></td>
	            	<td colspan="2" style="text-align:center">
	            		<input type="text" id="trackingNumInput">
	            	</td>
            	</tr>
            </tbody>
            
            
          </table>
        </div>
        <div id="dealPagingDiv" class="pagingDiv"></div>
      </div>
      
    </div>
    
  </div>
  
</div>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/shoeCream/admin/assets/js/order/dealView.js"></script>
