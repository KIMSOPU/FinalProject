
const IMG_SRC_STYLE = '/shoeCream/images/style_board/';
const IMG_SRC_USER = '/shoeCream/images/userProfile/';

$(function() {
    $.noConflict();
    
  //style 데이터 불러오기
  $.ajax({
    type: "POST",
    url: "/shoeCream/style/getPopularList",
    data: "pg=" + 1,
    success: function (styleData) {
    	console.log('styleData', styleData);
        
        for(let i = 1; i <= 6; i++) {
		    $('.style_wrap').append(
		    	$('<div/>', {class:'style_wrap-imgbox'}).append(
            $('<input>', {type:'hidden', value:styleData[i].styleId}),
		    		$('<img>', {class:'style-user-img item style_'+styleData[i].styleId, src:IMG_SRC_STYLE+styleData[i].img1}),
		    		$('<div/>', {class:'style_wrap-img'}).append(
		    			$('<img>', {class:'style-user-profile-img', src:IMG_SRC_USER+styleData[i].img})
		    		),
		    		$('<p/>', {class:'style-user-id', text:'@'+styleData[i].username})
		    	)
		    );//end append '.style_wrap'

        $('.style_'+styleData[i].styleId).click(function(){
          let styleId = $(this).prev().val();
          location.href='/shoeCream/style/details?styleId='+styleId;
        });

	    }//end for
    },
    error: function (err) {
      alert("스타일 에러났습니다");	
      console.log(err);
    },
  }); //end ajax
    
    
    $(".slider").not(".slick-initialized").slick();
    
	/*
    //style 슬릭 슬라이드
    $(".style_wrap").slick({
      // prevArrow : ".prev", // 이전 화살표 모양 설정
	  // nextArrow : ".next", 
      slidesToShow: 6,
      arrows: true,
      infinite: false,
      dots: true
    });
    //$(".style_wrap").slick("init");
    
    */
});