<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/shoeCream/resources/css/modal.css">
<link rel="stylesheet" href="/shoeCream/resources/css/styleLikeModal.css">    

<body>
     <div id="likeUserModal" class="modal">
        <div class="modal-window modal-window-likeUser">
            <div class="modal-title">
                <h2 class="likeUser-modal-h2">공감 <span id="likeCount"></span></h2>
                <a href="#" class="close-area"><i class="fa-solid fa-xmark fa-lg"></i></a>
            </div>
            <div class="modal-content">
                <div class="likeUser-modal-content">
                    <a href=# class="userfeedLink">
                        <div class="style_user-box">
                            <img class="modal_img-profile" src="/shoeCream/resources/images/">
                            <div class="modal_txt-profile">
                                <span class="style_username"></span>
                                <span class="style_intromsg"></span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        
    // 공감모달 오픈
    function likeModalOpen(styleId){
		$('.likeUser-modal-content').empty();
		
		$('#likeUserModal').css('display','flex');
		$("body").css("overflow", "hidden");
		
		$.ajax({
			type: 'get',
			data: {'styleId':styleId}, 
	        url: '/shoeCream/style/getLikeUserList',
	        success: function(data){
	        	console.log(JSON.stringify(data));
	        	$('#likeCount').text(data.likeCount);
	        	
	        	$.each(data.UserList, function(index, items){
		        	let userbox = "<a href='javascript:;' class='userfeedLink'>";
		        		userbox += "<div class='style_user-box'>";
		        		userbox += "<img class='modal_img-profile' src='/shoeCream/images/userProfile/"+items.img+"'>";
		        		userbox += "<div class='modal_txt-profile'>";
		        		userbox += "<span class='style_username'>" + items.username + "</span>";
		        		userbox += "<span class='style_intromsg'>" + items.intromsg + "</span>";
		        		userbox += "</div></div></a>";
	        		$('.likeUser-modal-content').append(userbox);
	        	})//each
	        	
	        	// 유저 프로필 클릭 (유저 피드로 이동)
	            $('.style_user-box').click(function(){
	            	var username = $(this).children().find('.style_username').text();
	            	location.href = '/shoeCream/style/user?username='+username;
	            });
	        },
	        error: function(err){
	        	console.log(err);
	        }
		});
    }
	
	// 공감모달 클로즈 (어두운 배경 클릭) 
	$('#likeUserModal').click(function(){
		$('#likeUserModal').css('display', 'none');
		$('body').css('overflow', 'auto'); //모달 꺼지면 스크롤 가능
	}); 

       // 모달 클로즈 (x버튼 클릭)
	$('.close-area').click(function(e){
		e.preventDefault();
		$('.modal').css('display', 'none');
		$('body').css('overflow', 'auto');
	});


    </script>
</body>