<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<head>
	<link href="/shoeCream/admin/assets/css/user/userView.css" rel="stylesheet" />
</head>

<input type="hidden" id="checkIdHidden" value="${param.checkId}">

      <div class="content">
        <div class="row">
         
          </div>
          <div class="col-md-4" style="margin: auto;">
            <div class="card card-user">
              <div class="card-header">
                <h5 class="card-title" >검수현황 및 검수결과 수정</h5>
              </div>
              <div class="card-body" id="checkTable">
                <form>
                  <div class="row" >
                    <div class="col-md-4 pr-1" >
                      <div class="form-group">
                          <label>검수번호 </label>
                     	   <input type="text" class="form-control" value="1" id="checkId" readonly>
                   		 	  </div>
                  	 	  	 </div>
                  		 	<div class="col-md-4 px-1">
                   		   <div class="form-group">
                      
                      
                        <label>판매번호 </label>
                        <input type="text" class="form-control" value="1" id="userId" readonly>
                      </div>
                    </div>
                    <div class="col-md-4 pl-1">
                      <div class="form-group">
                        <label>상품번호</label>
                        <input type="text" class="form-control" readonly>
                      </div>
                    </div>                
                  </div>
                  
                  <div class="row">
                  <div class="col-md-5 pr-1">
                      <div class="form-group">
                        <label for="exampleInputEmail1" style="margin-top: 30px;">검수현황</label>
                        <input type="email" class="form-control" readonly>
                      </div>
                    </div>
                  
                    <div class="col-md-5 px-1" >
                      <div class="form-group" style="margin-top: 30px;" >
                        <label>검수현황 변경</label>
                        
						  <select name="chkSituationChg" id="chkSituationChg" class="form-control" >
 							<option >현황선택</option>
						    <option value="0">검수전</option>
						    <option value="1">검수중</option>
						    <option value="2">검수완료</option>						    
						  </select>
							</div> 
						  </div>
						   
						  <div class="col-md-2 px-1" >
                      		<div class="form-group" style="margin-top: 60px;" >
						  		<input type="button" value="수정" id="chkSituationChgBtn" class="form-group">
	                        </div>
	                      </div>
                     
                                                                  
                  </div>
                  
                  
                    <div class="row">
                    
                    <div class="col-md-5 pr-1">
                      <div class="form-group">
                        <label for="exampleInputEmail1" style="margin-top: 30px; ">검수결과</label>
                        <input type="email" class="form-control" readonly>
                      </div>
                    </div>
                    
                    <div class="col-md-5 px-1" >
                      <div class="form-group" style="margin-top: 30px; " >
                        <label>검수결과 변경</label>
                        
						  <select name="chkResultChg" id="chkResultChg" class="form-control">
 							<option >결과선택</option>
						    <option value="0">불합격</option>
						    <option value="1">합격</option>

						    
						  </select>
						  </div>
                   		 </div>
						  <div class="col-md-2 px-1" >
                      		<div class="form-group" style="margin-top: 60px;" >
						  		<input type="button" value="수정" id="chkResultChgBtn" class="form-group">
	                        </div>
	                      </div>                        
                                        
                  </div>
                  
                
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                       
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="update ml-auto mr-auto">
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer footer-black  footer-white ">
        <div class="container-fluid">
          <div class="row">
                    
          </div>
        </div>
      </footer>
    </div>
  </div>

</body></html>






<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

$(function(){

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(7)').addClass('active');
	
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/check/getCheckChgForm',
		data: 'checkId=' + $('#checkIdHidden').val(),	
		//dataType: 'JSON',
		success: function(data){
			
			console.log('data', data);	
			
$.each(data, function(index, items){
				
				var ds = '';
				var vs = '';
				if(data.checkState == 0) {
					ds = '검수 전';
				} else if(data.checkState == 1) {
					ds = '검수 중';
				} else if(data.checkState == 2) {
					ds = '검수 완료';
				} 
			
				if(data.checkResult == 0) {
					vs = '불합격';
				} else if(data.checkResult == 1) {
					vs = '합격';
				} 
			
	
			console.log('data', data);
			let input=$('#checkTable input');
			input[0].setAttribute('value',data.checkId); 
			input[1].setAttribute('value',data.salesId);
			input[2].setAttribute('value',data.productId);
			input[3].setAttribute('value', ds);
			input[5].setAttribute('value', vs); 
		
		})
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload
	
</script>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">	
	
$('#chkSituationChgBtn').click(function(){
	
	 $.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/check/situationChg',
	     data: { 'chkSituationChg': $('#chkSituationChg').val(),
	    		 'checkId': $('#checkIdHidden').val() }	     	
	     ,
		 success: function(){			
			 swal('검수현황이 수정 되었습니다.', '' , 'success').then(function(){
				location.reload();
			 });//end swal
		 },
		 error: function(err){
			 swal('검수현황 선택 후 수정버튼을 눌러주세요.', '' , 'error');
		}	
	
});
	});
	
	
$('#chkResultChgBtn').click(function(){
	
	 $.ajax({
		 type: 'post',
		 url: '/shoeCream/adminViews/check/resultChg',
	     data: { 'chkResultChg': $('#chkResultChg').val(),
	    		 'checkId': $('#checkIdHidden').val() }	     	
	     ,
		 success: function(){			
			 swal('검수결과가 수정 되었습니다.', '' , 'success').then(function(){
				location.reload();
			 });//end swal
		 },
		 error: function(err){
			 swal('검수결과 선택 후 수정버튼을 눌러주세요.', '' , 'error');
		}	
	
});
	});



</script>












