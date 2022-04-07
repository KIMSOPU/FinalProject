<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
  <link href="/shoeCream/admin/assets/css/content/content.css" rel="stylesheet" />
</head>

<div class="card">
<input type="hidden" id="pg" name="pg" value="${param.pg}">

       <div class="card-header"> 
       	<div class=list>       				
			  <a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="text-decoration-line: none;">
                 <h4 class="card-title" style="color: black">이벤트<span class="caret"></span></h4>
              </a>
              <div class="dropdown-menu dropdown-menu-left" aria-labelledby="navbarDropdownMenuLink">
                <a class="dropdown-item" href="/shoeCream/adminViews/content/announceList">공지사항</a>
              </div>  
             </div>
             
             <div class="write">              
             	<input type="button" id="eventWriteBtn" name="eventWriteBtn" value="글 작성" onclick="location.href='/shoeCream/adminViews/event/eventWrite?pg='+${pg}">   
       		 </div> 
       		 
        </div>
        <div class="card-body">
            <div class="table-responsive">
                  <table class="table" id="eventListTable">	                   
	                    	  <tr class=" text-primary" style="border-top:hidden">	                    	  
	                   		  <th><input type="checkbox" id="all" name="all" onclick="checkAll()"></th>
			                  <th>글 번호</th>
			                  <th>이미지</th>
			                  <th>제목</th>
			                  <th>
			                  <select name="option" id="option">
			            				<option value="all" id="all">진행상태</option>
							    		<option value="going" id="going" >진행중</option>
										<option value="end" id="end">마감</option>
							 </select>
			                  </th>
			                  <th>삭제</th>
			                  <tr>
                  </table>
                  
                  <div class="eventPagingDiv"></div>
                   <br>
                   
                   <div id="deleteBtn">              
              		 <input type="button" id="deleteAll" name="deleteAll" value="  삭제  "> 
                   </div>
                  
                   <input type="hidden" id="searchPg" name="searchPg" value="1"> <!-- 검색을 위한 페이지 고정 -->	                 
                  	 <div class="input-group no-border" id="searchDiv">
				    	<select name="searchOption" id="searchOption">
				    		<option value="title">제목</option>
						</select>
							    	
						<input type="text" class="form-control" placeholder="검색어 입력" id="inputWord" name="inputWord" style="width: 80%">
					    <div class="input-group-append">
					           <div class="input-group-text"><i class="nc-icon nc-zoom-split"></i></div>
              		    </div>
			  	</div>
      </div>
    </div>
 </div>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/shoeCream/admin/assets/js/event/eventList.js"></script>