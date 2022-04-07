<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
	<link rel="stylesheet" href="/shoeCream/admin/assets/css/event/event.css">	
	<link rel="stylesheet" href="/shoeCream/resources/css/date.css">
</head>

<input type="hidden" id="pg" name="pg" value="${pg}">

    <div class="col-md-7">
            <div class="card card-user">
              <div class="card-header"><h5 class="card-title">이벤트 등록</h5> 
            </div>
              
            <div class="card-body">
                <form id="eventWrite">
               
                  <div class="row">
                    <div class="col-md-8 pr-1">
                      <div class="form-group">
                        <label>제목</label> <span id="titleDiv"></span>    
                        <input type="text" class="form-control" placeholder="제목을 입력하세요" id="title" name="title">
                      </div>
                    </div>
                    <div class="col-md-4 pl-1">
                       <div class="form-group">
                        <label>마감일</label>  
                         <span id="dueDateDiv" ></span>                                     
	                      <input type="text" class="form-control" id="dueDate" name="dueDate">	                     
                      </div>
                    </div>
                  </div>
				
				 <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                       <label>내용</label> <span id="contentsDiv"></span>    
                       	 <textarea id="contents" name="contents" placeholder="내용을 입력하세요"></textarea>                       
                      </div>
                    </div>
                  </div>
                  
                  
                  <label>파일 업로드</label>
                  <div class="row">
	                   <div class="filebox clearfix">
					    <div class="inputFile"></div> 
					        <label for="AddImgs" class="addImgBtn">+</label>
					        <input type="file" name="img[]" id="AddImgs" class="upload-hidden" accept=".jpg, .png, .gif" multiple style="display:none;">					        
					    </div>
					    <ul id="Preview"></ul>					  
				   </div> 
				   
                  <br><br>
                  <div class="row">               
                    <div class="update ml-auto mr-auto">
                     <div id="btnR" style="margin-right: 20px">
                      <input type="button" class="btn btn-primary btn-round" id="listBtn" value="목록" style="margin-right: 400px;" onclick="location.href='/shoeCream/adminViews/event/eventList?pg=${pg}'">
                    </div>  
                    <div id="btnL">
                      <input type="reset" class="btn btn-primary btn-round" id="resetBtn" value="다시작성">
                      <input type="button" class="btn btn-primary btn-round" id="writeBtn" value="등록">
                   </div>  
                    </div>                   
                  </div>
                  
                </form>
              </div>
     </div>
 </div>

<!-- 달력 위젯 -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="/shoeCream/admin/assets/js/event/eventWrite.js"></script>
