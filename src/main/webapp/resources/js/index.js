
let count = 1;

const productWrap = document.querySelector(".product_wrap");
const addBtn = document.querySelector(".add_btn");
const wrap = document.querySelector(".product_wrap");
const IMG_SRC = '/shoeCream/images/productImg/';

window.onload = function() {
  //event 데이터 불러오기
  $.ajax({
    type: "POST",
    url: "/shoeCream/get/event/getEventList",
    data: {
      pg: "1",
      option: "going",
    },
    success: function (data) {
      // console.log(data);
    },
    error: function (err) {
      alert("이벤트 에러났습니다");
      console.log(err);
    },
  }); //end ajax
	
  
  
  //product 데이터 불러오기
  fetch(`/shoeCream/get/product/getProductListForIndex?pg=${count}`, {
    method: "POST",
  })
    .then((response) => response.json())
    .then((productData) => {
      console.log(count);
      console.log(productData);

      makeProduct(productData);
      count++;
    }); //패치는 서림이 코드
    
	
};//end onload

	
addBtn.addEventListener("click", () => 
	fetch(`/shoeCream/get/product/getProductListForIndex?pg=${count}`, {
    	method: "POST",
  	})
    .then( (response) => response.json() )
    .then( (productData) => {
      console.log(count);
      console.log(productData);

      makeProduct(productData);
      count++;
	})
);//end click

function makeProduct(data) {
  data.forEach((datas) => {
	$('.product_wrap').append(
		$('<div/>', {class: 'product_list'}).append(
			$('<input>', {type:'hidden', value:datas.productId}),
			$('<div/>', {class: 'product_list-img'}).append(
				$('<img>', {src: IMG_SRC + datas.img1})  
			),
			$('<div/>', {class: 'product_list-infobox'}).append(
				$('<div/>', {class: 'brand-text', text: datas.brandName}),
				$('<p/>', {class: 'product_name', text: datas.productName}),
				$('<div/>', {class: 'amount-lg'}).append(
					$('<em/>', {class:'num', text: datas.todaysPrice.toLocaleString()}),
					$('<span/>', {class:'won', text:'원'})
				)
			)
		)
	)//end append .product_wrap
	
    if (wrap.childElementCount == 16) {
      console.log("인제끝..");
      addBtn.style.display = "none";
    }
  });//end forEach
};//end makeProduct()

const styleWrap = document.querySelectorAll(".style_wrap-imgbox");
const styleUserImg = document.querySelectorAll(".style-uesr-img");
const styleUserId = document.querySelectorAll(".style-user-id");

function makeStyleList(data) {
  styleUserId.forEach((datas, idx) => {
    datas.innerText = `@${data[idx].username}`;
  });
}

$(document).on("click", ".product_list-img", function(){
	//console.log($(this).siblings().get(0).value);
	location.href = '/shoeCream/shop/shopView?productId='+$(this).siblings().get(0).value;
});//end click

$(document).on('click', '.item_list-img', function(){
	console.log(this.nextElementSibling.innerText);
	
});
