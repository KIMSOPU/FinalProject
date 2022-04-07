// 달력위젯
$("#dueDate").datepicker({	 	 
     showOn:"button", 
     buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
     buttonImageOnly: true,
     changeMonth:true,
     dateFormat:"yy-mm-dd",
     dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
     dayNamesMin : ['월','화','수','목','금','토','일'],
     monthNamesShort:  [ "1월", "2월", "3월", "4월", "5월", "6월","7월", "8월", "9월", "10월", "11월", "12월" ],
 });

$('.ui-datepicker-trigger').attr('style','margin-top:-130px; margin-left:40px');


// 이벤트 이미지 선택 시 이미지표시
$(function(){

	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(3)').addClass('active');
	
    var c = 0;
	$('#resetBtn').click(function(){
		 $('#Preview').empty();
	});
   
   $("#AddImgs").click(function(){   
  	 console.log(c);	 
   	 c = $('.delBtn').length;
   	 console.log(c);	 
   });
   
   
  //이미지 등록
  $("#AddImgs").change(function(e){
  	  var files = e.target.files;
      var arr = Array.prototype.slice.call(files);

      //업로드 가능 파일인지 체크
      if(files.length + c > 1){	    	 
      	 alert("파일 업로드는 한 개까지 가능합니다.");
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

              //이미지 파일 미리보기
              if(f.type.match('image.*')){
                  //파일을 읽기 위한 FileReader객체 생성
                  var reader = new FileReader(); 
                  reader.onload = function (e) { 
                      //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                      str += '<img src="'+e.target.result+'" title="'+f.name+'" width=200 height=50>';
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

// 이벤트 등록
$('#writeBtn').click(function() {
	
	$('#titleDiv').empty();
	$('#contentsDiv').empty();
	$('#dueDateDiv').empty();

	if($('#title').val() == ''){
		$('#titleDiv').text('제목을 입력해주세요.');
	}else if($('#dueDate').val() == ''){
		$('#dueDateDiv').text('마감일을 입력해주세요.');
	}else if($('#contents').val() == ''){
		$('#contentsDiv').text('내용을 입력해주세요.');
	}else{
	
		var formData = new FormData($('#eventWrite')[0]);
		$.ajax({
			type: 'post',
			url: '/shoeCream/adminViews/event/writeEvent',
			encType: 'multipart/form-data',
		    processData: false,
		    contentType: false,
		    data: formData,
			success: function () {
				swal('이벤트 등록 완료', '' , 'success').then(function(){
					location.href='/shoeCream/adminViews/event/eventList?pg=' + $('#pg').val();			
				});//end swal
			},
			error: function (err) {
				alert(err);				
			}
		});
	}
});