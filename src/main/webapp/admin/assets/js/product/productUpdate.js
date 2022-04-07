// 달력위젯

$("#releaseDate").datepicker({	 	 
     showOn:"button", 
     buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
     buttonImageOnly: true,
     changeMonth:true,
     dateFormat:"yy-mm-dd",
     dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
     dayNamesMin : ['월','화','수','목','금','토','일'],
     monthNamesShort:  [ "1월", "2월", "3월", "4월", "5월", "6월","7월", "8월", "9월", "10월", "11월", "12월" ],
     beforeShow:function(input,inst){
    	 setTimeout(function(){
        	 $('#ui-datepicker-div').css({'top':'100px'});
    	 },1);
     }
 });

$('.ui-datepicker-trigger').attr('style','margin-top:-130px; margin-left:40px');

// 원 상품의 정보입력
$(function() {

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(4)').addClass('active');
	
	$.ajax({
			type: 'post',
			url: '/shoeCream/adminViews/product/getProductInfo',
		    data: {'modelId' : $('#modelId2').val()},
		    dataType: 'JSON',
			success: function (data) {
			console.log(data.productDTO.brandName);
					$('#productName').val(data.productDTO.productName);
					$('#productNameKor').val(data.productDTO.productNameKor);
					$('#modelId').val(data.productDTO.modelId);
						if(brandName == ''){
							$('#brandName').val("브랜드 선택").prop("selected", true);							
						}else{
							$('#brandName').val(data.productDTO.brandName).prop("selected", true);
						}
					
					$('#productCollection').val(data.productDTO.productCollection);
					$('#releasePrice').val((data.productDTO.releasePrice).toLocaleString());
					$("#releaseDate").val(data.productDTO.releaseDate);					
					
					$.each(data.list, function(index, items){ 						
						if(items != null){
								var str = '';
								str += '<li class="ui-state-default">';
								str += '<img src="/shoeCream/images/productImg/'+items+'" title="'+items+'" width=80 height=80>';						
					        	str += '<span class="delBtn" onclick="delImg(this)">x</span>';
					        	str += '<input type="hidden" id="img2[]" name="img2[]" value="'+items+'">';
					            str += '</li>';
					        	$(str).appendTo('#Preview');
					        				        	
				        	}													
					}); // each문
			},
			error: function (err) {
				alert(err);				
			}
		});
});

// 상품 이미지 선택 시 이미지표시
$(function(){
    // 상품 수정 시 원래 가지고 있던 이미지의 갯수
	var count;

	$("#AddImgs").click(function(){   	 
   	  count = $( '.ui-state-default' ).length;
	  console.log(count);
	  if(count > 3){
      	 alert("파일 업로드는 3개까지 가능합니다.");
      	 return false;
      }
      
     });
   

  //이미지 등록
  $("#AddImgs").change(function(e){	  

      var files = e.target.files;
      var arr = Array.prototype.slice.call(files);

      // 업로드는 3개까지만 가능
      if(files.length + count > 3){
      	 alert("파일 업로드는 3개까지 가능합니다.");
      	 return false;
      }
      
      for(var i=0; i<files.length; i++){
          if(!checkExtension(files[i].name,files[i].size)){
              return false;
          }
      }
      
      preview(arr);
      
      function checkExtension(fileName,fileSize){
          var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
          var maxSize = 20971520;  //20MB

          if(fileSize >= maxSize){
              alert('이미지 크기가 초과되었습니다.');
              $("#AddImgs").val("");  //파일 초기화
              return false;
          }

          if(regex.test(fileName)){
              alert('확장자명을 확인해주세요.');
              $("#AddImgs").val("");  //파일 초기화
              return false;
          }
          return true;
      }

      function preview(arr){
          arr.forEach(function(f){
              var str = '<li class="ui-state-default">';

              if(f.type.match('image.*')){
                  var reader = new FileReader(); 
                  reader.onload = function (e) { 
                      str += '<img src="'+e.target.result+'" title="'+f.name+'" width=80 height=80>';
                      str += '<span class="delBtn" onclick="delImg(this)">x</span>';
                      str += '</li>';
                      $(str).appendTo('#Preview');
                  } 
                  
                  reader.readAsDataURL(f);
              }
          })
      }
  })
});

//이미지 삭제
function delImg(_this){
   $(_this).parent('li').remove()
}

// 상품수정
$('#writeBtn').click(function() {

	$('#productNameDiv').empty();
	$('#productNameKorDiv').empty();
	$('#modelIdDiv').empty();
	$('#brandDiv').empty();
	$('#realesePriceDiv').empty();
	$('#datepickerDiv').empty();

	if($('#productName').val() == ''){
		$('#productNameDiv').text('상품명(영어)을 입력해주세요.');
	}else if($('#productNameKor').val() == ''){
		$('#productNameKorDiv').text('상품명(한글)을 입력해주세요.');
	}else if($('#modelId').val() == ''){
		$('#modelIdDiv').text('모델번호를 입력해주세요.');
	}else if($('#brandId').val() == '브랜드 선택'){
		$('#brandDiv').text('브랜드를 선택해주세요.');
	}else if($('#relesePrice').val() == ''){
		$('#relesePricePriceDiv').text('발매가를 입력해주세요.');
	}else if($('#releaseDate').val() == ''){
		$('#datepickerDiv').text('발매일을 입력해주세요.');
	}else{		
		var formData = new FormData($('#productUpdate')[0]);	
		$.ajax({
			type: 'post',
			url: '/shoeCream/adminViews/product/productUpdate',
			encType: 'multipart/form-data',
		    processData: false,
		    contentType: false,
		    data: formData,
			success: function (data) {
				swal('상품 수정 완료', '' , 'success').then(function(){
					location.href='/shoeCream/adminViews/product/productList?pg=' + $('#pg').val() + '&modelId=' + $('#modelId2').val();		
				});//end swal
			},
			error: function (err) {
				alert(err);				
			}
		});
		
		
		}
});

// 천 단위 콤마
function inputNumberFormat(obj) {
     obj.value = comma(uncomma(obj.value));
 }
 function comma(str) {
     str = String(str);
     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
 }
 function uncomma(str) {
     str = String(str);
     return str.replace(/[^\d]+/g, '');
 }