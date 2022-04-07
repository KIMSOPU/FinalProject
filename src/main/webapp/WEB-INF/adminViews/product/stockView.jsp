<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
	<link rel="stylesheet" href="/shoeCream/admin/assets/css/product/productWrite.css">
</head>



    <div class="col-md-7">
			
            <div class="card card-user">
              <div class="card-header"><h5 class="card-title">상품 재고</h5> 
            </div>
             <input type="hidden" id="modelId" name="modelId" value="${modelId}">       
            <div class="card-body">            
                <form id="productWrite">
                       
                  <div class="row">
                     <div class="col-md-4 pr-1">
                      <div class="form-group">
                        <label>225</label>
                        <input type="hidden" class="form-control" id="225" name="225" value="225">
                        <input type="number" class="form-control" id="225stock" value="0">
                      </div>
                    </div>     
                    <div class="col-md-4 px-1">
                      <div class="form-group">
                        <label>230</label>                                          
	                    <input type="hidden" class="form-control" id="230" name="230" value="230">
	                    <input type="number" class="form-control" id="230stock" value="0">
                      </div>
                    </div>                
                    <div class="col-md-4 pl-1">
                      <div class="form-group">
                         <label>235</label>
                         <input type="hidden" class="form-control" id="235" name="235" value="235">
                         <input type="number" class="form-control" id="235stock" value="0">
                      </div>
                    </div>
                  </div>
                 
                 
                  <div class="row">    
                    <div class="col-md-4 pr-1">
                      <div class="form-group">
                        <label>240</label>                                          
	                    <input type="hidden" class="form-control" id="240" name="240" value="240">
	                    <input type="number" class="form-control" id="240stock" value="0">
                      </div>
                    </div>                
                    <div class="col-md-4 px-1">
                      <div class="form-group">
                         <label>245</label>
                         <input type="hidden" class="form-control" id="245" name="245"  value="245">
                         <input type="number" class="form-control" id="245stock" value="0">
                      </div>
                    </div>
                    <div class="col-md-4 pl-1">
                      <div class="form-group">
                        <label>250</label>
                        <input type="hidden" class="form-control" id="250" name="250"  value="250">
                        <input type="number" class="form-control" id="250stock" value="0">
                      </div>
                    </div>  
                  </div>
                  
                   <div class="row">
                      
                    <div class="col-md-4 pr-1">
                      <div class="form-group">
                        <label>255</label>                                          
	                    <input type="hidden" class="form-control" id="255" name="255"  value="255">
	                    <input type="number" class="form-control" id="255stock" value="0">
                      </div>
                    </div>                
                    <div class="col-md-4 px-1">
                      <div class="form-group">
                         <label>260</label>
                         <input type="hidden" class="form-control" id="260" name="260"  value="260">
                         <input type="number" class="form-control" id="260stock" value="0">
                      </div>
                    </div>
                    <div class="col-md-4 pl-1">
                      <div class="form-group">
                        <label>265</label>
                        <input type="hidden" class="form-control" id="265" name="265"  value="265">
                        <input type="number" class="form-control" id="265stock" value="0">
                      </div>
                    </div> 
                  </div>
                  
                   <div class="row">
                       
                    <div class="col-md-4 pr-1">
                      <div class="form-group">
                        <label>270</label>                                          
	                    <input type="hidden" class="form-control" id="270" name="270"  value="270">
	                    <input type="number" class="form-control" id="270stock" value="0">
                      </div>
                    </div>                
                    <div class="col-md-4 px-1">
                      <div class="form-group">
                         <label>275</label>
                         <input type="hidden" class="form-control" id="275" name="275"  value="275">
                         <input type="number" class="form-control" id="275stock" value="0">
                      </div>
                    </div>
                    <div class="col-md-4 pl-1">
                      <div class="form-group">
                        <label>280</label>
                        <input type="hidden" class="form-control" id="280" name="280"  value="280">
                        <input type="number" class="form-control" id="280stock" value="0">
                      </div>
                    </div>
                  </div>
                  
                  <div class="row">
                        
                    <div class="col-md-4 pr-1">
                      <div class="form-group">
                        <label>285</label>                                          
	                    <input type="hidden" class="form-control" id="285" name="285"  value="285">
	                    <input type="number" class="form-control" id="285stock" value="0">
                      </div>
                    </div>                
                    <div class="col-md-4 px-1">
                      <div class="form-group">
                         <label>290</label>
                         <input type="hidden" class="form-control" id="290" name="290"  value="290">
                         <input type="number" class="form-control" id="290stock" value="0">
                      </div>
                    </div>
                  </div>
  
                  <div class="row">               
                    <div class="update ml-auto mr-auto">
                      <button type="submit" class="btn btn-primary btn-round" id="writeBtn">등록</button>
                      <button type="reset" class= "btn btn-primary btn-round" id="resetBtn">다시작성</button>
                      <!-- <input type="button" class="btn btn-primary btn-round" id="returnBtn" onclick="location.href='/shoeCream/adminViews/product/productList?pg='+"pg>목록</button> -->
                    </div>                   
                  </div>
                  
                </form>
              </div>
     </div>
 </div>
 
 <script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
 <script type="text/javascript">
//상품 재고 불러오기
 $(function(){	
	 
 	 $.ajax({ 		 
 		 type: 'post',
 		 url: '/shoeCream/adminViews/product/getProductStock',
 		 data: {"225" : $('#225').val(),
 				"230" : $('#230').val(),
 				"235" : $('#235').val(),
 				"240" : $('#240').val(),
 				"245" : $('#245').val(),
 				"250" : $('#250').val(),
 				"255" : $('#255').val(),
 				"260" : $('#260').val(),
 				"265" : $('#265').val(),
 				"270" : $('#270').val(),
 				"275" : $('#275').val(),
 				"280" : $('#280').val(),
 				"285" : $('#285').val(),
 				"290" : $('#290').val(),
 			    "modelId" : $('#modelId').val()},
 		 dataType: 'JSON',
 		 success: function(data){ 
 			 console.log(data[0].productSize);
 			 $.each(data, function(index, items){
 				 console.log(items.productSize);
 				$('#'+items.productSize+'stock').val(Number($('#'+items.productSize+'stock').val())+1);
 			 });  
 		 },
 		 error: function(err){
 				alert(err);
 		}	 
 	 }); // 1	 
 });
 
 </script> 