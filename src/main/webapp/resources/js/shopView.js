//location.search 는 url에 '?' 뒤로 다 짤라온다.
let pId = new URLSearchParams(location.search).get("productId");
let uDTO = null;
let productData;
let todaysPrice;
let lowestPriceSalesDTO;

const IMG_SRC = "/shoeCream/images/productImg/";

$(function () {
	
		$.ajax({
			type: 'POST',
			url: '/shoeCream/get/sales/getLowestPriceSalesDTO',
			data: {productId: pId},
			success: function(data){
				lowestPriceSalesDTO = data;
				console.log('lowestPriceSalesDTO', data);
				
				if(data.length != 0){
					$('.shopDetail-buy .num').text(data.price.toLocaleString());
					$('.shopDetail-sell .num').text(data.price.toLocaleString());				
				}
			},
			error: function(err) {
		        alert("낮은 가격 에러났습니다");
		        console.log(err);
		    }
		}); // end ajax

  $.ajax({
    type: "POST",
    url: "/shoeCream/shop/getShop",
    data: { productId: pId },
    success: function (data) {
      todaysPrice = data.shopDTO.todaysPrice;
      console.log('getShopData: ', data);
	  if(data.userDTO != null){
	  	uDTO = 'not null';
	  }
	 
	  productData = data;
	 
      $(".fluctuation-decrease-increse").empty();

      $(".product-brand").text(data.shopDTO.brandName);
      $("#productImg").attr("src", IMG_SRC + data.shopDTO.img1);
      $(".shopDetail-top_Realimg").attr("src", IMG_SRC + data.shopDTO.img1);
      $(".procut-title").text(data.shopDTO.productName);
      $(".product-subtitle").text(data.shopDTO.productNameKor);
      $(".produxt-price-detail").text(data.shopDTO.todaysPrice.toLocaleString());
      $(".like-count").text(data.shopDTO.wishListCount);
      $(".model-number").text(data.shopDTO.modelId);
      $(".model-release-date").text(data.shopDTO.releaseDate);
      $(".model-release-price").text(data.shopDTO.releasePrice.toLocaleString() + "원");

	  getWishResult(); //관심상품 등록 여부 아이콘 반영
    },
    error: function (err) {
      alert("샵뷰 페이지 에러났습니다");
      console.log(err);
    }
  }); //end ajax
  
  $.ajax({
  	type: 'POST',
  	url: '/shoeCream/get/stats/getPriceDataForShop',
  	data: 'productId='+pId,
  	success: function(data){
  		let xAxisForChart = [];			// ['x1','x2','x3','x4','x5','x6']  =>  오늘요일-6 ~ 오늘요일 
		let dataForChart = [];			// [21, 19, 25, 20, 23, 56]  =>   이 상품의 7일간 가격
		
		console.log(data);
		
		$.each(data, function(index, items){
			xAxisForChart.push(items.regDate);
			dataForChart.push(items.price);
			
		
		});//end each
	  		makeChart(xAxisForChart, dataForChart);
  	},
  	error: function (err) {
      alert("차트js 데이터 에러났습니다");
      console.log(err);
    }
  });//end ajax

  makeStyleFeed(); //상품이 태그된 스타일 피드 가져오기
}); //end onload


/* 서림씨코드 */
const box = document.getElementById("shop-detail-top");
const buttonBox = document.querySelector(".shopDetail-content-button2");
const buttonNum = -20;
window.addEventListener("scroll", scrollEvent);

function scrollEvent() {
  /* 스크롤: 구매/판매 버튼 안보이면 hidden 제거*/
  const text = buttonBox.getBoundingClientRect().top;
  if (text < buttonNum) box.classList.remove("tophidden");
  else box.classList.add("tophidden");

  /* 스크롤: 스타일 피드 보이면 fixed -> absolute 변경*/
  var currentScrollValue = document.documentElement.scrollTop;
  //console.log('currentScrollValue is ' + currentScrollValue);
  if(currentScrollValue > 905) {
	document.getElementById("productImgDiv").classList.remove("is_fixed");  
	document.getElementById("productImgDiv").classList.add("is_absolute");
  } else {
	  document.getElementById("productImgDiv").classList.remove("is_absolute");  
	  document.getElementById("productImgDiv").classList.add("is_fixed");
  }
  //const changePoint = document.querySelector(".product-notice").getBoundingClientRect().bottom;
  //const imgbottom = document.getElementById("productImg").getBoundingClientRect().bottom;  
  //console.log('changePointbottom:: '+ changePoint);
  //console.log('imgbottom:: '+ imgbottom);
}

const showBox = document.querySelectorAll(".drop-down-head");
// for (let i = 0; i < showBox.length; i++) {
//   showBox[i].addEventListener("click", (e) => console.log(e.target));
// }

showBox.forEach((item) => {
  item.addEventListener("click", (e) => {
    const sibling = e.currentTarget.nextElementSibling;
    sibling.classList.toggle("drop-down-content");
    e.currentTarget.classList.toggle("add-bold");
  });
});


// 모달 오픈(구매)
$('.shopDetail-buy-link').click(function(){	
	if(uDTO == null){
		location.href='/shoeCream/user/login';
	} else {
		$('.modal-title-text').empty();
		$('.modal-content').empty();
		$('.modal-footer').empty();
		$('#modal-content-warning-div').empty();
		
		$('.modal').css('display', 'flex');
		$('body').css('overflow', 'hidden'); //모달창 켜졌을때 스크롤 금지
		
		$('.modal-title-text').text('구매하기');
		
		$('<div/>', {class:'style_suggest_item'}).append(
				$('<div/>',{class:'style_suggest_link'}).append(
						$('<div/>',{class:'style_suggest_thumb'}).append(
								$('<img/>',{class:'style_thumb_img', src:IMG_SRC + productData.shopDTO.img1}))).append(
										$('<div/>',{class:'style_suggest_info'}).append(
												$('<p/>',{class:'style_model_title', text:productData.shopDTO.productName})).append(
														$('<p/>',{class:'style_model_sub_info', text:productData.shopDTO.productNameKor}),
														$('<p/>',{class:'style_model_sub_price', text:productData.shopDTO.todaysPrice.toLocaleString()+'원'})
												)
								)
			)
		.appendTo($('.modal-content'));
		
		$('.modal-content').append(
			$('<input>', {type:'hidden', name:'productId', value:pId}),
			$('<input>', {type:'hidden', name:'lowestPriceHidden', value:lowestPriceSalesDTO.price}),
			$('<input>', {type:'hidden', name:'todaysPriceHidden', value:todaysPrice}),
			$('<input>', {type:'hidden', name:'salesIdHidden', value:lowestPriceSalesDTO.salesId})
		);
		$('.modal-content').append(
			$('<div/>', {class:'select-button-div'}).append(
				$('<input>', {type: 'button', class:'modal-content-select-btn', id:'buyNow', value:'즉시구매'}), 
				$('<input>', {type: 'button', class:'modal-content-select-btn', id:'buyBid', value:'입찰구매'})
			)
		);
		$('.modal-content').append(
			    $('<select>', {class:'modal-content-input-select', name:'userProductSize'}).append(
					$('<option/>', {value:'-1', text:'사이즈 선택'})
				  , $('<option/>', {value:'225', text:'225'})	
				  , $('<option/>', {value:'230', text:'230'})	
				  , $('<option/>', {value:'235', text:'235'})	
				  , $('<option/>', {value:'240', text:'240'})	
				  , $('<option/>', {value:'245', text:'245'})	
				  , $('<option/>', {value:'250', text:'250'})	
				  , $('<option/>', {value:'255', text:'255'})	
				  , $('<option/>', {value:'260', text:'260'})	
				  , $('<option/>', {value:'265', text:'265'})	
				  , $('<option/>', {value:'270', text:'270'})
				  , $('<option/>', {value:'275', text:'275'})	
				  , $('<option/>', {value:'280', text:'280'})	
				  , $('<option/>', {value:'285', text:'285'})	
				  , $('<option/>', {value:'290', text:'290'})
				),
			$('<div/>', {class: 'low_price_div'}).append(
				$('<p/>', {text: '가장 낮은 입찰가격 '}),
				$('<p/>', {text: +lowestPriceSalesDTO.productSize 
								 +' / '
								 +lowestPriceSalesDTO.price+'원'})
			)
		);
		$('.modal-content').append($('<div/>', {id:'modal-content-warning-div'}));
		$('.modal-footer').append($('<input>', {type:'button', value:'상품 구매', class:'modal-content-btn purchase', id:'purchaseBtn'}));
		
	  	resetButton();	
	  
	}//end if
});//end click

// 모달 오픈(판매)
$('.shopDetail-sell-link').click(function(){
	if(uDTO == null){
		location.href='/shoeCream/user/login';
	} else {
		$('.modal-title-text').empty();
		$('.modal-content').empty();
		$('.modal-footer').empty();
		$('#modal-content-warning-div').empty();
		
		$('.modal').css('display', 'flex');
		$('body').css('overflow', 'hidden'); //모달창 켜졌을때 스크롤 금지
		
		$('.modal-title-text').text('판매하기');
		
		$('<div/>', {class:'style_suggest_item'}).append(
				$('<div/>',{class:'style_suggest_link'}).append(
						$('<div/>',{class:'style_suggest_thumb'}).append(
								$('<img/>',{class:'style_thumb_img', src:IMG_SRC + productData.shopDTO.img1}))).append(
										$('<div/>',{class:'style_suggest_info'}).append(
												$('<p/>',{class:'style_model_title', text:productData.shopDTO.productName})).append(
														$('<p/>',{class:'style_model_sub_info', text:productData.shopDTO.productNameKor}),
														$('<p/>',{class:'style_model_sub_price', text:productData.shopDTO.todaysPrice.toLocaleString()+'원'})
												)
								)
			)
		.appendTo($('.modal-content'));
		
		$('.modal-content').append($('<input>', {type:'hidden', name:'productId', value:pId}));
		$('.modal-content').append(
			$('<div/>', {class:'select-button-div'}).append(
				$('<input>', {type: 'button', class:'modal-content-select-btn', id:'sellNow', value:'즉시판매'}), 
				$('<input>', {type: 'button', class:'modal-content-select-btn', id:'sellBid', value:'입찰판매'})
			)
		);
		$('.modal-content').append(
			    $('<div/>', {class:'modal-content-input-div'}).append(
					$('<input>', {type:'text', placeholder:'판매희망가 입력', class:'modal-content-input-price', name:'userInputPrice', autocomplete:'off'})
				),
			    $('<select>', {class:'modal-content-input-select', name:'userProductSize'}).append(
					$('<option/>', {value:'-1', text:'사이즈 선택'})
				  , $('<option/>', {value:'225', text:'225'})	
				  , $('<option/>', {value:'230', text:'230'})	
				  , $('<option/>', {value:'235', text:'235'})	
				  , $('<option/>', {value:'240', text:'240'})	
				  , $('<option/>', {value:'245', text:'245'})	
				  , $('<option/>', {value:'250', text:'250'})	
				  , $('<option/>', {value:'255', text:'255'})	
				  , $('<option/>', {value:'260', text:'260'})	
				  , $('<option/>', {value:'265', text:'265'})	
				  , $('<option/>', {value:'270', text:'270'})
				  , $('<option/>', {value:'275', text:'275'})	
				  , $('<option/>', {value:'280', text:'280'})	
				  , $('<option/>', {value:'285', text:'285'})	
				  , $('<option/>', {value:'290', text:'290'})
				)
		);
		$('.modal-content').append($('<div/>', {id:'modal-content-warning-div'}));
		$('.modal-footer').append($('<input>', {type:'button', value:'상품 판매', class:'modal-content-btn sell', id:'sellBtn'}));
		
	  	resetButton();	
	  
	}//end if
});//end click

// 페이지 로드 시 관심상품 여부에 따라 아이콘 반영
function getWishResult(){
	$.ajax({
		type: 'post',
		url: '/shoeCream/my/checkWish', 
		data: 'productId=' + pId,
		success: function(result){
			//console.log(result);
			if(result == 'on'){
				$('.wish-link').addClass('fa-solid');
			} else if(result == 'off'){
				$('.wish-link').removeClass('fa-solid');
			}
		},
		error: function(err){
			console.log(err);
		}
	});//ajax
}

// 관심상품 버튼 클릭
$('.shopDetail-like').click(function(){
	if(uDTO == null) location.href = "/shoeCream/user/login";
	else{
		$.ajax({
			type: 'post',
			url: '/shoeCream/my/addWish', 
			data: 'productId=' + pId,
			success: function(result){
				//console.log(result);
				$('.wish-link').toggleClass('fa-solid'); //아이콘 반영
				wishCountChange(result); //관심 수 증가/감소
			},
			error: function(err){
				console.log(err);
			}
		});//ajax
	}
});// end click(관심상품)

// 관심상품 여부(flag)에 따라 관심 수 +- 
function wishCountChange(result){
	let likeCount = $('#like-count').text();
		likeCount *= 1; //text를 숫자로 변환
	let resultCount;
	if(result == "on") resultCount = likeCount+1;
	else if(result == "off") resultCount = likeCount-1;

	$('.like-count').text(resultCount);
}


$(document).on('click', '#sellNow', function(){
	resetButton();
	$('#sellNow').addClass('active');
	$('.modal-content-input-select').show();
});
$(document).on('click', '#sellBid', function(){
	resetButton();
	$('#sellBid').addClass('active');
	$('.modal-content-input-price').show();
	$('.modal-content-input-select').show();
});

$(document).on('click', '#buyNow', function(){
	resetButton();
	$('#buyNow').addClass('active');
	$('.modal-content-input-select').show();
});
$(document).on('click', '#buyBid', function(){
	resetButton();
	$('#buyBid').addClass('active');
	$('.modal-content-input-price').show();
	$('.modal-content-input-select').show();
});


function resetButton() {
	$('#modal-content-warning-div').empty();
	$('#modal-content-warning-div').hide();
	$('#sellBid').removeClass('active');
	$('#sellNow').removeClass('active');
	$('#buyBid').removeClass('active');
	$('#buyNow').removeClass('active');
	$('.modal-content-input-price').hide();
	$('.modal-content-input-select').hide();
};

// 모달 클로즈 (x버튼 클릭)
$(".close-area").click(function() {
	$(".modal").css("display", "none");
	$("body").css("overflow", "auto");
	$('.modal-content').empty();
	$('.modal-content-form').removeAttr("action");
});

/* 판매하기 버튼 */
$(document).on("click", "#sellBtn", function(){

	if($('#sellBid').hasClass('active')){
		if($('.modal-content-input-select').val() == -1 || $('.modal-content-input-price').val() == '') {
			$('#modal-content-warning-div').text('잘못된 값 입니다.');
			$('#modal-content-warning-div').show();
		} else if(isNaN($('.modal-content-input-price').val())) {
			$('#modal-content-warning-div').text('숫자만 입력 해주세요.');
			$('#modal-content-warning-div').show();
		} else {
			$('form[name="modalForm"]').serialize();
			$('.modal-content-form').attr("action", "/shoeCream/shop/shopSalesBidView/").submit();	
		}
		
	} else if($('#sellNow').hasClass('active')) {
		if($('.modal-content-input-select').val() == -1) {
			$('#modal-content-warning-div').text('잘못된 값 입니다.');
			$('#modal-content-warning-div').show();
		} else {
			$('<input>', {type:'hidden', name:'todaysPriceHidden', value:todaysPrice}).appendTo($('.style_suggest_item'));
			$('form[name="modalForm"]').serialize();
			$('.modal-content-form').attr("action", "/shoeCream/shop/shopSalesNowView/").submit();
		}
	} 
	
});

/* 구매하기 버튼 */
$(document).on("click", "#purchaseBtn", function(){

	if($('.modal-content-input-select').val() == -1) {
		$('#modal-content-warning-div').text('잘못된 값 입니다.');
		$('#modal-content-warning-div').show();
	} else {
		$('form[name="modalForm"]').serialize();
		
		if($('#buyBid').hasClass('active')){
			
			$.ajax({
				type: 'POST',
				url: '/shoeCream/get/sales/getSalesListBySize',
				data: {
					productId: pId,
					productSize: $('.modal-content-input-select').val()
				},
				success: function(data){
					if(data.length != 0) {
						$('input[name="salesIdHidden"]').empty();
						$('input[name="priceHidden"]').empty();
						$('<input>', {type:'hidden', name:'salesIdHidden', value:data[0].salesId}).appendTo($('.style_suggest_item'));
						$('<input>', {type:'hidden', name:'priceHidden', value:data[0].price}).appendTo($('.style_suggest_item'));
						$('.modal-content-form').attr("action", "/shoeCream/shop/shopPurchaseBidView/").submit();
					} else {
						swal('판매 등록된 사이즈가 없습니다.', ' ' , 'error');
					}
				},
				error: function(err){
					alert('입찰판매 사이즈 측정 에러남');
					console.log(err);
				}
			});//end ajax
				
		} else if($('#buyNow').hasClass('active')) {
			$.ajax({
				type: 'POST',
				url: '/shoeCream/get/stock/getStockListBySize',
				data: {
					productId: pId,
					userSize: $('.modal-content-input-select').val()
				},
				success: function(data){
					if(data.length != 0) {
						$('<input>', {type:'hidden', name:'stockIdHidden', value:data[0].stockId}).appendTo($('.style_suggest_item'));
						$('form[name="modalForm"]').serialize();
						$('.modal-content-form').attr("action", "/shoeCream/shop/shopPurchaseNowView/").submit();
					} else {
						swal('재고 사이즈가 없습니다.', ' ' , 'error');
					}
				},
				error: function(err){
					alert('재고 사이즈 측정 에러남');
					console.log(err);
				}
			});//end ajax
		}
	}
	
});

$(document).on('input', '.modal-content-input-select', function(){
	if($('.modal-title-text').text() == '구매하기'){
		let tempDTO;
		
		if($('#buyNow').hasClass('active')){
			
			$.ajax({
				type: 'POST',
				url: '/shoeCream/get/stock/getStockListBySize',
				data: {
					productId: pId,
					userSize: $('.modal-content-input-select').val()
				},
				success: function(data){
					console.log('data123123', data);
					
					if(data.length != 0){
						$('.low_price_div p').eq(0).text('선택된 사이즈 즉시 구매 가격');
						$('.low_price_div p').eq(0).css("color","black");
						$('.low_price_div p').eq(1).text(data[0].price.toLocaleString()+'원');
					} else {
						$('.low_price_div p').eq(0).text('선택된 사이즈의 재고가 없습니다.');
						$('.low_price_div p').eq(0).css("color","red");
						//$('.low_price_div p').eq(0).css("font-size","11px");
						$('.low_price_div p').eq(1).text('');
					}
				},
				error: function(err){
					alert('재고 사이즈 측정 에러남');
					console.log(err);
				}
			});//end ajax
			
			
		} else {
			$('.low_price_div p').eq(0).text('가장 낮은 입찰가격');
			$('.low_price_div p').eq(0).css("color","black");
			$('.low_price_div p').eq(1).text(+lowestPriceSalesDTO.productSize 
											 +' / '
											 +lowestPriceSalesDTO.price.toLocaleString()+'원');
		}
		
	}//end if
});//end input

$(document).on("input", ".modal-content-input-price", function(){
	if(isNaN($('.modal-content-input-price').val())) {
		$('#modal-content-warning-div').text('숫자만 입력 해주세요.');
		$('#modal-content-warning-div').show();
	} else {
		$('#modal-content-warning-div').hide();
	}
});//end input

$(document).on("input", ".modal-content-input-select", function(){
	$('#modal-content-warning-div').empty();
});//end input


function makeChart(xAxisForChart, dataForChart){
	
	let option = 
		 {type: 'line', 									//차트의 형태
		  options: {
				scales: {  y: {
	                suggestedMin: 0,
	                suggestedMax: 500000
	            } },
    			responsive: false
		  },
		  data: { 											//차트에 들어갈 데이터
				labels: xAxisForChart,  					//x축 => (이번달-5)
				datasets: [{ 
						label: '시세', 						//차트 제목
						fill: false,  						//line 형태일 때, 선 밑으로 색칠할껀지 선택
						data: dataForChart,					//x축 label에 대응되는 데이터 값
						backgroundColor: [  				//색상
							'rgba(255, 99, 132, 0.2)',
							'rgba(54, 162, 235, 0.2)',
							'rgba(255, 206, 86, 0.2)',
							'rgba(75, 192, 192, 0.2)',
							'rgba(153, 102, 255, 0.2)',
							'rgba(255, 159, 64, 0.2)'
						],
						borderColor: [ 						//경계선 색상
							'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
							'rgba(153, 102, 255, 1)',	
							'rgba(255, 159, 64, 1)'
						],
						borderWidth: 1 //경계선 굵기
					}]
			},//end data
		};//end let option
	
	const myChart = new Chart($('#myChart'), option);	//차트생성   document.getElementById('myChart')
	//myChart.destroy();
}
