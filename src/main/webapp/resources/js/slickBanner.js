$(function() {
	$.noConflict();
	
	$('.banner_item-slide').append(
		$('<div/>', {class:'banner_item-content'}).append(
			$('<img>', {class:'responsive', src:'/shoeCream/images/logo/Untitled-1.jpg'})
		),
		$('<div/>', {class:'banner_item-content'}).append(
			$('<img>', {class:'responsive', src:'/shoeCream/images/logo/Untitled-2.jpg'})
		),
		$('<div/>', {class:'banner_item-content'}).append(
			$('<img>', {class:'responsive', src:'/shoeCream/images/logo/Untitled-3.jpg'})
		),
		$('<div/>', {class:'banner_item-content'}).append(
			$('<img>', {class:'responsive', src:'/shoeCream/images/logo/Untitled-4.jpg'})
		)
	)//end append '.banner_item-slide'
	
	$('.banner_item-slide').slick({
		/* prevArrow : ".prev", // 이전 화살표 모양 설정
		nextArrow : ".next", */
		slidesToShow: 1,
		autoplay: true,
		autoplaySpeed: 6000,
		arrows: true,
		dots: true
	});

})