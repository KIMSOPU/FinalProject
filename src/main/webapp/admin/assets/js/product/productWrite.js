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


// 상품 이미지 선택 시 이미지표시
$(function(){

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(4)').addClass('active');
	
 var c = 0;
	$('#resetBtn').click(function(){
		 $('#Preview').empty();
	});
	
   $("#AddImgs").click(function(){   
      c = $('.delBtn').length;	   	  
	  console.log(c);
	  if(c > 3){
      	 alert("파일 업로드는 3개까지 가능합니다.");
      	 return false;
      }
   
   });
  //이미지 등록
  $("#AddImgs").change(function(e){
  	  var files = e.target.files;
      var arr = Array.prototype.slice.call(files);

      //업로드 가능 파일인지 체크
      if(files.length + c > 3){
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
	          swal('이미지 크기가 초과되었습니다.', '' , 'error').then(function(){
	              $("#AddImgs").val("");  //파일 초기화
              	  return false;
			  });//end swal
          }

          if(regex.test(fileName)){
	          	swal(' ', '' , 'error').then(function(){
	              alert('확장자명을 확인해주세요.');
	              $("#AddImgs").val("");  //파일 초기화
	              return false;
				
				});//end swal
          }
          return true;
      }

      function preview(arr){
          arr.forEach(function(f){
              var str = '<li class="ui-state-default">';

              //이미지 파일 미리보기
              if(f.type.match('image.*')){
                  //파일을 읽기 위한 FileReader객체 생성
                  var reader = new FileReader(); 
                  reader.onload = function (e) { 
                      //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                      str += '<img src="'+e.target.result+'" title="'+f.name+'" width=80 height=80>';
                      str += '<span class="delBtn" onclick="delImg(this);">x</span>';
                      str += '</li>';
                      $(str).appendTo('#Preview');
                  } 
                  
                  reader.readAsDataURL(f);
              }
          })
      }
  });
	  
});

//이미지 삭제
function delImg(ths){
   	  var ths = $(ths);   
	  ths.parent('li').remove();
}

// 상품등록
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
	
		var formData = new FormData($('#productWrite')[0]);
		$.ajax({
			type: 'post',
			url: '/shoeCream/adminViews/product/getProductWrite',
			encType: 'multipart/form-data',
		    processData: false,
		    contentType: false,
		    data: formData,
			success: function (data) {
				swal('상품 등록 완료', '' , 'success').then(function(){
					location.href='/shoeCream/adminViews/product/productList?pg=' + $('#pg').val();			
				
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
