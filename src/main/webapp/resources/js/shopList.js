const IMG_SRC = '/shoeCream/images/productImg/';
let brand = new Array();
let size = new Array();
let price = '';
let sort = $('.sorting_list .item_on').attr('id');

$(function(){
	//getShopList
	movePage();
	
});//end onload

/* 필터 */
$(function(){
	$.ajax({
		type:'get',
		url:'/shoeCream/shop/getBrandList',
		success:function(data){
			// 브랜드
			for(let i = 0; i < data.brandList.length; i++){
				$('<div/>',{class:'checkbox_item'})
				.append($('<label/>',{class:'check_label', for:'check_'+data.brandList[i].replace(/(\s*)/g, "")})
				.append($('<input/>',{type:'checkbox', class:'checkbox', id:'check_'+data.brandList[i].replace(/(\s*)/g, "")}))
				.append($('<span/>',{class:'link_txt', id:data.brandList[i].replace(/(\s*)/g, ""), text:data.brandList[i]})))
				.appendTo($('#brand_menu'));	
			}
			
			$('.filter_title').click(function(){
				$(this).find('.placeholder').toggleClass('close');
				$(this).siblings('.filter_menu').toggleClass('open');
				$(this).find('i').toggleClass('fa-plus fa-minus');
			});
			
			$('#brand_menu .checkbox').click(function(){
				const item = $(this).siblings('.link_txt').text();
				const id = $(this).parents('.filter_menu').attr('id').replace('_menu','');
				
				$(this).next('span').toggleClass('menu_on');
				
				if($(this).prop('checked')){
					makeList(true, id, item);
					setFilterTag(true, id, item);
				}else{
					makeList(false, id, item);
					setFilterTag(false, id, item);
				}
				setSelected(id);
				setPlaceholder(id);
				setStatusNum();
				movePage();
			});
			
			$(document).on('click', '.delete_filter_tag', function(){
				const target = $(this).siblings().text().replace(/(\s*)/g, "");
				const id = $(this).parent().attr('class').replace('tag_item tag_item_','');
				
				// 초기화
				$(this).parent().remove();
				$('#'+target).removeClass('menu_on');
				$('#'+target).siblings('.checkbox').prop('checked', false);
				if(id=='price'){
					price = '';
				}
				
				makeList(false, id, $(this).siblings().text());
				setSelected(id);
				setPlaceholder(id);
				setStatusNum();
				movePage();
			});
			
			$('.delete_status_num').click(function(){
				// 초기화
				brand=[];
				size=[];
				price='';
				sort='popular';
				
				$('.delete_filter_tag').trigger('click');
				$('.status_num, .delete_status_num').css('display', 'none');
				movePage();
			});
			
		}, // end success
		error:function(){
			alert('Error: 필터 브랜드');
		}
	});	// end ajax
	
	// 사이즈
	const sizeList = [225, 230, 235, 240, 245, 250, 255, 260, 265, 270, 275, 280, 285, 290];
	
	$('<div/>',{class:'menu_column'})
	.append($('<div/>',{class:'column_list'}))
	.appendTo($('#size_menu'));
	
	for(let i = 0; i < sizeList.length; i++){
		$('<a/>',{class:'column_menu', id:sizeList[i], href:'javascript:;', text:sizeList[i]})
		.appendTo($('.column_list'));
	}
	
	$('.column_menu').click(function(){
		const item = $(this).attr('id');
		const id = $(this).parents('.filter_menu').attr('id').replace('_menu','');
		
		$(this).toggleClass('menu_on');
		
		if($(this).hasClass('menu_on')){
			makeList(true, id, item);
			setFilterTag(true, id, item);
		}else{
			makeList(false, id, item);
			setFilterTag(false, id, item);
		}
		setSelected(id);
		setPlaceholder(id);
		setStatusNum();
		movePage();
	});
	
	// 가격
	const priceList = ['10만원 이하', '10만원 - 30만원 이하', '30만원 - 50만원 이하', '50만원 이상'];
	
	for(let i = 0; i < priceList.length; i++){
		$('<div/>',{class:'checkbox_item'})
		.append($('<label/>',{class:'check_label', for:'check_'+priceList[i].replace(/(\s*)/g, "")})
		.append($('<input/>',{type:'checkbox', class:'checkbox', id:'check_'+priceList[i].replace(/(\s*)/g, "")}))
		.append($('<span/>',{class:'link_txt', id:priceList[i].replace(/(\s*)/g, ""), text:priceList[i]})))
		.appendTo($('#price_menu'));
	}
	
	$('#price_menu .checkbox').click(function(){
		const item = $(this).siblings('.link_txt').text();
		const id = $(this).parents('.filter_menu').attr('id').replace('_menu','');
		
		// 단일 선택
		$('#price_menu .checkbox').not($(this)).prop('checked', false);
		$('#price_menu .link_txt').removeClass('menu_on');
		$('.tag_item_price').remove();
		price = '';
		
		if($(this).prop('checked')){
			$(this).next('span').addClass('menu_on');
			setFilterTag(true, id, item);
			price = $('#price_menu .menu_on').text();
			
		}else{
			$(this).next('span').removeClass('menu_on');
		}
		setSelected(id);
		setPlaceholder(id);
		setStatusNum();
		movePage();
	});
	
	/* 정렬 */
	$('.sorting_item').click(function(){
		$('.sorting_title').text($(this).find('.main_desc').text());
		$('.sorting_item').removeClass('item_on');
		$(this).toggleClass('item_on');
		$('.sorting_list').toggle();
		
		sort = $('.sorting_list .item_on').attr('id');
		console.log(sort);
		movePage();
	});
	
	$('.sorting_title').click(function(){
		$('.sorting_list').toggle();
		
		$('body').click(function(e) {
        	if(!$(e.target).hasClass('sorting')) $('.sorting_list').css('display', 'none');
     	});
	});
	
}); // end onload

// 페이지 로드 시 관심상품 여부에 따라 아이콘 반영
function wishOnOff(productId, result){
	if(result == 'on'){
		$('.wishBtn_'+productId).removeClass('fa-regular');
		$('.wishBtn_'+productId).addClass('fa-solid');
	}else if(result == 'off'){
		$('.wishBtn_'+productId).removeClass('fa-solid');
		$('.wishBtn_'+productId).addClass('fa-regular');
	}
}

// 관심상품 여부(flag)에 따라 관심 수 +- 
function wishCountChange(productId, result){
	let wishCount = $('.wishCount_'+productId).text();
		wishCount *= 1; //text를 숫자로 변환
	let resultCount;
	if(result == "on") resultCount = wishCount+1;
	else if(result == "off") resultCount = wishCount-1;

	$('.wishCount_'+productId).text(resultCount);
}

function urlFunction(url, id){
	location.href = url+id;
}

function makeParams(){
	let params = '';
	
	if(brand!=''){
		params += 'brand='+brand+'&';
	}
	
	if(size!=''){
		params += 'size='+size+'&';
	}
	
	if(price!=''){
		params += 'price='+price+'&';
	}
	
	params += 'sort='+sort;
	console.log(params);
	return params;
}

function movePage(){
	$.ajax({
		type: 'GET',
		url: '/shoeCream/shop/search',
		tranditional: true,
		data: {
			'brand':brand,
			'size':size,
			'price':price,
			'sort':sort
		},
		success: function(data){
			// 초기화
			$('.product_wrap').empty();
			$('.product-conent-box .result_nodata').css('display', 'none');
			
			if(data.productList=='') $('.product-conent-box .result_nodata').css('display', 'block');
			else{
				$.each(data.productList, function(index, item){
					$('<div/>',{class: 'product_list'}).append( 
					$('<input/>',{
						type: 'hidden',	id: 'productId', value: item.productId}),
					$('<div/>', {class: 'product_list-img'}).append(
						$('<img>', {
						src: IMG_SRC + item.img1 })), 
					$('<div/>', {class: 'product_list-infobox'}).append( 
						$('<div/>', {
							class: 'brand-text',
							text: item.brandName
							}), 
						$('<p/>', {
							class: 'product_name',
							text: item.productName }), 
						$('<p/>', {
							class: 'product_name_translate',
							text: item.productNameKor }), 
						
						$('<div/>', {class: 'amount-lg'}).append(
							$('<span/>', {
								class: 'num num_'+item.productId,
								text: item.lowest.toLocaleString() + '원' }))), 
					$('<div/>', {class: 'product-icon-box'}).append(
						$('<i/>', {class: 'product-icon wish-link wishBtn_'+item.productId+' fa-regular fa-bookmark'}), 
						$('<span/>', {
							class: 'product-icon wishCount_'+item.productId,
							text: '0'
								//SELECT COUNT(*) AS wishListCount FROM wish_list WHERE productId = #{productId}
							}), 
						$('<i/>', {class: 'product-icon fa-solid fa-indent'}), 
						$('<span/>', {
							class: 'product-icon styleCount_'+item.productId,
							text: '0'
								//style_table에서 product count
								//SELECT COUNT(*) AS styleCount FROM style_board WHERE productId = #{productId}
							})
						) 
						
					).appendTo($('.product_wrap'));
				
					$.each(data.wishStyleCountList, function(index2, item2){
						if(item2.productId === item.productId) {
							$('.wishCount_'+item.productId).text(item2.wishListCount);
							$('.styleCount_'+item.productId).text(item2.styleCount);
						}
					}); //end 2nd each
					
					// 즉시판매가 정렬일 경우,상품가격 즉시구매가->즉시판매가로 바꿔주기
					if(sort == 'highest') $('.num_'+item.productId).text(item.highest.toLocaleString() + '원');
		
					//관심상품 등록 여부에 따라 아이콘 반영
					wishOnOff(item.productId, item.wishOnOff);
		
				});//end 1st each
				
				
				$(document).on("click", ".product_list-infobox", function(){
					urlFunction('/shoeCream/shop/shopView?productId=', $(this).siblings().get(0).value)
				});
				$(document).on("click", ".product_list-img", function(){
					urlFunction('/shoeCream/shop/shopView?productId=', $(this).siblings().get(0).value)
				});
	
				// 관심상품 버튼 클릭
				$('.wish-link').click(function(){
					if($('#ssUserId').val() == '') location.href = "/shoeCream/user/login";
					else{
						const productId = $(this).parent().prev().prev().prev().val();
						$.ajax({
							type: 'post',
							url: '/shoeCream/my/addWish', 
							data: 'productId=' + productId,
							success: function(result){
								wishOnOff(productId, result);
								wishCountChange(productId, result);
							},
							error: function(err){
								console.log(err);
							}
						});//end ajax
					}
				});// end click(관심상품)
	
				// 스타일 버튼 클릭
				$('.fa-indent').click(function(){
					const productId = $(this).parent().prev().prev().prev().val();
					location.href='/shoeCream/style/products?productId='+productId;
				});
			}
		},
		error: function(err){
			alert('샵페이지 에러났습니다');
			console.log(err);
		}
	});//end ajax
}

function makeList(selected, id, item){
	let list = '';
	
	if(id=='brand'){
		list=brand;
	}else if(id=='size'){
		list=size;
	}else if(id=='price'){
		list=price;
	}
	
	if(selected){
		list.push(item);
		console.log(list);
		
	}else{
		for(let i = 0; i < list.length; i++){
			if(list[i] == item){
				list.splice(i, 1);
			    i--;
				console.log(list);
			}
		}
	}
}

function setFilterTag(selected, id, item){
	if(selected){
		$('<div/>',{class:'tag_item tag_item_'+id})
		.append($('<span/>',{class:'tag tag_'+item.replace(/(\s*)/g, ""), text:item}))
		.append($('<button/>',{type:'button', class:'delete_filter_tag'})
		.append($('<i/>',{class:'fa-solid fa-x'})))
		.appendTo($('.filter_tag'));
	}else{
		$('.tag_'+item.replace(/(\s*)/g, "")).parent().remove();
	}
}

function setStatusNum(){
	if($('.tag_item').length!=0){
		$('.status_num, .delete_status_num').css('display', 'inline-flex');
		$('.status_num').text($('.tag_item').length);
					
	}else{
		$('.status_num, .delete_status_num').css('display', 'none');
	}
}

function setPlaceholder(id){
	const target = $('#'+id+'_list').find('.placeholder');
	let list = '';

	target.text(''); // 초기화		
	
	if(id=='brand'){
		list=brand;
	}else if(id=='size'){
		list=size;
	}else if(id=='price'){
		list=price;
	}
	
	if(list==''){
		target.text('모든 '+target.parent().text());
		return;
	}else{
		target.text(list);
	}
}

function setSelected(id){
	const menuOn = $('#'+id+'_menu .menu_on');
	
	if(menuOn.length!=0){
		$('#'+id+'_list').addClass('selected');
	}else{
		$('#'+id+'_list').removeClass('selected');
	}
}