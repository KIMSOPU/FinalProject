function makeStyleFeed(){
	$.ajax({
		type: 'post',
		url: '/shoeCream/style/getProductsFeedFour', 
		data: 'productId='+pId,
		success: function(data){
			//console.log(JSON.stringify(data));
			
			// 게시물이 없을 경우
			if(data.length === 0) {
				let noContentDiv = '';
					noContentDiv += "<div class='no-feed'>";
					noContentDiv += "<i class='product-icon fa-solid fa-indent fa-3x'></i>";
					noContentDiv += "<p>상품 태그를 등록하여 게시글을 작성해주세요</p>";
					noContentDiv += "</div>"; 
				$('.content-null-div').append(noContentDiv);
				
			} else {
				// 게시물이 있을 경우 
				
				// 유저 프로필 이미지 설정
				const img = $('#userImg').val();
				let src = '';
				if(chkUrl(img)){
					src = img;
				} else {
					src = "/shoeCream/images/userProfile/"+img;
				}
				
				//$.each(data, function(index, item){
				for(var i=0 ; i < data.length; i++){   
					//card 부분 데이터
					$('<div/>', {class: 'card-box_'+i}).append(
						$('<img/>', {
							class:'style-img_real',
							src: '/shoeCream/images/style_board/'+data[i].img1
							}),
						$('<div/>', {class: 'style-feed_detail'}).append(
							$('<a/>', {class: 'style-detail-link'}).append(
								$('<div/>', {class:'style_user-box'}).append(
									$('<img/>', {
										class: 'userProfile-img profile-img-sm',
										src: "/shoeCream/images/userProfile/"+data[i].img
										}),
									$('<span/>', {
										class: 'userFeed-username',
										text: data[i].username
										})),
								$('<span/>', {
									class: 'style_contents-box',
									text: data[i].contents
									})),
							$('<input/>', {type: 'hidden', value: data[i].styleId}), //url용 id
							$('<div/>', {class: 'style_btn-box'}).append(
								$('<a/>', {class: 'style_smile-link', href:'javascript:;'}).append(
									$('<i/>', {
										class: 'likeBtn likeBtn_'+data[i].styleId+' fa-solid fa-face-smile'}),
									$('<span/>', {
										class: 'style_like-count likeCount_'+data[i].styleId,
										text: data[i].likeCount
										})),
								$('<a/>', {class:'style_comment-link'}).append(
									$('<i/>', {class: 'fa-solid fa-message'}),
									$('<span/>', {
										class: 'style_comment-count', 
										text: data[i].replyCount
										})))),
						$('<input/>', {type: 'hidden', value: data.productId}) //url용 id
					).appendTo($('.styleboard-content'));		
											
					//게시글 당 좋아요 여부 체크하고 아이콘 반영
					likeOnOff(data[i].styleId, data[i].likeOnOff);
					
				};//each

                if(data.length == 4){
                    $('.add_btn_div').css('display','block');
                }
				
				/* 공감버튼 클릭 */
				$('.style_smile-link').click(function(){
					if(uDTO == null) location.href = "/shoeCream/user/login";
					else {
						var styleId = $(this).parent().prev().val();
						//console.log('styleId: ' + styleId);
						$.ajax({
							type: 'post',
							url: '/shoeCream/style/switchLike', 
							data: 'styleId=' + styleId,
							success: function(result){
								//console.log(JSON.stringify(result));
								likeOnOff(styleId, result); //아이콘 변경
								likeCountChange(styleId, result); //개수 변경
							},
							error: function(err){
								console.log(err);
							}
						});//ajax
					}
				});//공감버튼
				
				/* 게시글 사진 클릭(상세보기 페이지) */
				$('.style-img_real').click(function(){
					var styleId = $(this).next().children().next().val();
					//console.log(styleId);
					location.href = "/shoeCream/style/details?styleId="+styleId;
				});
				
				/* 게시글 내용 클릭(상세보기 페이지) */
				$('.style-detail-link').click(function(){
					var styleId = $(this).next().val();
					location.href = "/shoeCream/style/details?styleId="+styleId;
				});

                // 더보기 버튼 클릭
                $('.add_btn_div').click(function(){
                    location.href='/shoeCream/style/products?productId='+pId;
                });
				
			} //else
		},
		error: function(err){
			console.log(err);
		}
	});//ajax
}

/* 카카오 로그인 시 url 형식 체크 */
function chkUrl(url){
	const reg = /^http[s]?\:\/\//i;
	return reg.test(url);
}

/* 좋아요 여부 on/off에 따라 아이콘 클래스 변경 */
function likeOnOff(styleId, result){
	if(result == 'on'){
		$('.likeBtn_'+styleId).removeClass('fa-face-smile');
		$('.likeBtn_'+styleId).addClass('fa-heart');
	} else if(result == 'off'){
		$('.likeBtn_'+styleId).removeClass('fa-heart');
		$('.likeBtn_'+styleId).addClass('fa-face-smile');
	}
}

/* 좋아요 여부 on/off에 따라 공감 수 +- */
function likeCountChange(styleId, result){
	var likeCount = $('.likeCount_'+styleId).text();
		likeCount *= 1; //text를 숫자로 변환
	var resultCount;
	if(result == 'on'){
		resultCount = likeCount+1;
	} else if(result == 'off'){
		resultCount = likeCount-1;
	}
	$('.likeCount_'+styleId).text(resultCount);
}