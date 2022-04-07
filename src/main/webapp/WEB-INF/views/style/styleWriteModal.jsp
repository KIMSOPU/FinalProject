<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="/shoeCream/resources/css/modal.css">
<link rel="stylesheet" href="/shoeCream/resources/css/styleWrite.css">
<link rel="stylesheet" type='text/css'
	href="https://fengyuanchen.github.io/cropperjs/css/cropper.css">
</head>
<body>

	<div id="writeModal" class="modal">
		<div class="modal-window modal-window-styleWrite">
			<div class="modal-title">
				<h2>스타일 작성</h2>
				<a href="#" class="close-area"><i
					class="fa-solid fa-xmark fa-lg"></i></a>
			</div>
			<div class="modal-content">
				<div class="write-modal-content">
					<form name="styleWriteForm" id="styleWriteForm"
						enctype="multipart/form-data">
						<input type="hidden" name="userId" value="${ssUserId}">

						<div class="product-tag-div">
							<h4>상품 태그하기</h4>
							<p>태그할 상품을 검색하세요</p>
							<div class="inputDiv">
								<input type="text" class="searchProudct" name="searchProudct"
									autocomplete="off"> <i
									class="fa-solid fa-magnifying-glass"></i>
							</div>
						</div>

						<div class="style_suggest_list">
							<div class="style_suggest_item">
								<input type="hidden" value="3"><a class="suggest_link"><div
										class="suggest_thumb">
										<img class="thumb_img"
											src="/shoeCream/images/productImg/Nike x Supreme Air Force 1 Low Flax.png">
									</div>
									<div class="style_suggest_info">
										<p class="style_model_title">Nike x Supreme Air Force 1 Low Flax</p>
										<p class="style_model_sub_info">나이키 x 슈프림 에어포스 1 로우 플랙스</p>
									</div></a>
							</div>
							<div class="style_suggest_item">
								<input type="hidden" value="4"><a class="suggest_link"><div
										class="style_suggest_thumb">
										<img class="style_thumb_img"
											src="/shoeCream/images/productImg/Nike x NBA Dunk Low Retro EMB Chicago.png">
									</div>
									<div class="style_suggest_info">
										<p class="style_model_title">Nike x NBA Dunk Low Retro EMB
											Chicago</p>
										<p class="style_model_sub_info">나이키 x NBA 덩크 로우 레트로 EMB 시카고</p>
									</div></a>
							</div>
						</div>
						
						<div class="selected_item"></div>

						<div class="img-upload-div">
							<div class="img_upload" id="img_upload">
								<input type="file" name="uploadBtn"
									accept="image/jpeg, image/png" capture="camera" id="uploadBtn">
								<label for="uploadBtn">사진 첨부하기</label>
							</div>
							<div class="imgDiv" id="imgDiv">
								<img id="image" src="">
							</div>
							<div class="img-option-div">
								<a id="changeSize" href="#"><i
									class="fa-solid fa-table-cells"></i>비율변경</a>
								<div class="description-delete-div">
									<p>스크롤: 확대/축소 드래그: 위치이동</p>
									<a id="deleteImg" href="#"><i class="fa-solid fa-trash-can"></i>삭제</a>
								</div>
							</div>
						</div>
						<div class="styleContent-div">
							<div class="styleContents">
								<textarea class="contentsTextArea" name="contents"
									placeholder="공유하고 싶은 정보를 작성하세요"></textarea>
							</div>
						</div>



						<div class="register-btn-div btn_center_div">
							<a href="#" class="styleWrite_btn black_btn" id="register_btn">등록</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="https://fengyuanchen.github.io/cropperjs/js/cropper.js"></script>
	<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
	let productListForStyle = [];
	let keywordForStyle;
	const img_src = "/shoeCream/images/productImg/";
	
		$(function() {
			// 작성모달 오픈
			$('#writeModalBtn').click(function() {
				if ($('#sessionId').val() == '') {
					location.href = '/shoeCream/user/login';
				} else {
					$('#writeModal').css('display', 'flex');
					$('body').css('overflow', 'hidden');
				}
			});

			// 모달 클로즈 (x버튼 클릭)
			$('.close-area').click(function() {
				$('.modal').css('display', 'none');
				$('body').css('overflow', 'auto');
				closeSearchList();
			});

			//사진 비율 변경 클릭
			$('#changeSize').click(function() {
				$('#imgDiv').toggleClass('imgSize_long')
			});

			var cropper; //온로드 되자마자 선언해주어야 각각 다른 메소드에서 cropper를 인식함
			//사진 업로드 버튼
			$('#uploadBtn').on('change', function() {
				$('.imgDiv').empty().append('<img id="image" src="">');
				var image = $('#image');
				var imgFile = $('#uploadBtn').val(); //file버튼의 value 값
				var fileForm = /(.*?)\.(jpg|jpeg|png)$/;

				//이미지 확장자 검사 후 미리보기 출력
				if (imgFile.match(fileForm)) {
					var reader = new FileReader(); //미리보기 이미지  
					reader.onload = function(event) {
						image.attr("src", event.target.result);
						//사진 삭제 버튼 활성화, 사이즈 변경 버튼 비활성화
						$('.description-delete-div').css('display', 'flex');
						$('#changeSize').css('display', 'none');

						if ($('.imgDiv').css('height') == '279px')
							image.addClass('imageSize_default');
						else
							image.addClass('imgSize_long');

						cropper = new Cropper(image[0], {
							viewMode : 3,
							dragMode : 'move',
							autoCropArea : 1,
							restore : false,
							modal : false,
							guides : false,
							highlight : false,
							cropBoxMovable : false,
							cropBoxResizable : false,
							toggleDragModeOnDblclick : false,
						});
					}
					reader.readAsDataURL(event.target.files[0]);
				} else {
					swal('이미지 파일(jpg, png형식의 파일)만 올려주세요', '' , 'warning').then(function(){
						$('#photoBtn').focus();
						return;
						
					});//end swal
				}
			});//업로드 끝

			//사진 삭제
			$('#deleteImg').click(function() {
				if ($('input[type="file"]').val() != "") {
					$('#uploadBtn').val('');
					$('.imgDiv img').attr('src', '').remove();
					$('.cropper-container').remove();
					$('#changeSize').css('display', 'flex');
					$('.description-delete-div').css('display', 'none');
				} else
					swal('업로드된 사진이 없습니다', '' , 'warning');//end swal

			}); //삭제 끝

			//글 작성 버튼 클릭
			$('#register_btn').click(function() {
				if ($('input[type="file"]').val() == '') {
					swal('사진을 첨부하세요.', '' , 'warning');
				} else if ($('.contentsTextArea').val() == '') {
					swal('내용을 작성하세요.', '' , 'warning').then(function(){
						$('.contentsTextArea').addClass(
							"input_empty");
					});//end swal
				} else {
					$('.imgDiv')
							.append(
									'<div class="result_box"><img id="result" src=""><div>');
					var image = $('#image');
					var result = $('#result');
					var canvas;
					if (cropper) {
						if ($('.imgDiv').css('height') == '279px') {
							canvas = cropper.getCroppedCanvas({
								width : 720,
								height : 720
							});
						} else {
							canvas = cropper.getCroppedCanvas({
								width : 720,
								height : 962
							});
						}
					}
					result.attr("src", canvas
							.toDataURL("image/jpg"));

					canvas
							.toBlob(function(blob) {
								var formData = new FormData(
										$('#styleWriteForm')[0]); //$('#styleWriteForm')[0]
								formData.append('croppedImg',
										blob, '.jpg'); //formData.append('name', value, filename); 
								console.log(blob);

								console.log(formData);
								$.ajax({
									method : 'post',
									url : '/shoeCream/style/styleWrite',
									data : formData,
									enctype : 'multipart/form-data',
									processData : false,
									contentType : false,
									success : function() {
										swal('업로드 성공', '' , 'success').then(function(){
											location.href = "/shoeCream/style/newest";
											
										});//end swal

									},
									error : function(
											err) {
										alert('업로드 실패');
										$('#result')
												.remove();
									}
								});//ajax
							})
				}
			}); //글 작성 끝

			// 유효성 검사 후 커서가 밖으로 나가면 강조표시 해제
			$('.contentsTextArea').focusout(function() {
				if ($(this).val() != '') {
					$(this).removeClass("input_empty");
				}
			});
							
			getProductListForSearch()
		});//end onload

		
		
		
		
		
		
		$('.searchProudct').on('input', function(){
			keywordForStyle = $('.searchProudct').val().toLowerCase();
			
			if(keywordForStyle!='') {
				checkOutKeywordStyle(keywordForStyle);
			} else { // keywordForStyle==''
				$('.style_suggest_list').empty();
				//$('.style_recent_area').show();
			}
		});
		
		$(document).on('click', '.style_suggest_item', function(){
			console.log(this.children[0].value); //상품Id 반환
			
			$.ajax({
				type: 'POST',
				url: '/shoeCream/shop/getShop',
				data: 'productId='+this.children[0].value,
				success: function(data){
					console.log('getShopData', data);
					
					$('.selected_item').empty();
					$('.selected_item').append(
						$('<input>', {name:'productId', type:'hidden', value: data.shopDTO.productId}), 
						$('<a/>',{class:'style_suggest_link'}).append(
								$('<div/>',{class:'style_suggest_thumb'}).append(
										$('<img/>',{class:'style_thumb_img', src: img_src + data.shopDTO.img1}))).append(
												$('<div/>',{class:'style_suggest_info'}).append(
														$('<p/>',{class:'style_model_title', text:data.shopDTO.productName})).append(
																$('<p/>',{class:'style_model_sub_info', text:data.shopDTO.productNameKor})
														)
										)
					);
				},
				error: function(err){
					alert('에러낫삼');
					console.log(err);
				}
				
			});//end ajax
			
			closeSearchList();
		});//end click
			
		
	/* 상품 태그 검색 함수 */
		function getProductListForSearch() {
			$.ajax({
				type:'POST',
				url:'/shoeCream/search/product/getProductListForSearch',
				success: function(data){
					productListForStyle.splice(0, productListForStyle.length);
					console.log('productListForStyle', productListForStyle);
					$.each(data, function(index, item) {
						productListForStyle.push(item);
					});
				},
				error:function(){
					alert('Error: 검색');
				}
			}); //end ajax 
		};
		
		function checkOutKeywordStyle(keywordForStyle){
			$('.style_suggest_list').empty();
			
			$('.style_suggest_list').show();
			//$('.suggest_title').text($('.searchProudct').val());  
			
				
			for(let i = 0; i < productListForStyle[0].length; i++) {
				if(productListForStyle[0][i].productName.includes(keywordForStyle) 
					|| productListForStyle[0][i].productNameKor.includes(keywordForStyle)
					|| productListForStyle[0][i].brandName.includes(keywordForStyle)) {
					
					// 10개만 보여주기
					
					$('<div/>', {class:'style_suggest_item'}).append(
						$('<input>', {type:'hidden', value: productListForStyle[0][i].productId}), 
						$('<a/>',{class:'style_suggest_link'}).append(
								$('<div/>',{class:'style_suggest_thumb'}).append(
										$('<img/>',{class:'style_thumb_img', src:img_src+productListForStyle[0][i].img1}))).append(
												$('<div/>',{class:'style_suggest_info'}).append(
														$('<p/>',{class:'style_model_title', text:productListForStyle[1][i].productName})).append(
																$('<p/>',{class:'style_model_sub_info', text:productListForStyle[1][i].productNameKor})
														)
										)
					)
					.appendTo($('.style_suggest_list'));
				}
				
			}; // end for
		};
		
		function closeSearchList(){
			$('.style_suggest_list').hide();
			$('.style_suggest_list').empty();
			$('.searchProudct').val('');
			$('.selected_item').empty();
		};
		
	/* 상품 태그 검색 함수 끝*/
	</script>
</body>
