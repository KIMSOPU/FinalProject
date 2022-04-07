<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/shoeCream/resources/css/styleView.css">
<div class="modal-bg modal-hidden"></div>

<jsp:include page="styleModifyModal.jsp"></jsp:include>
<jsp:include page="styleLikeModal.jsp"></jsp:include>

<div class="styleViewBox">

	









</div>

<div class="big-reply-box modal-hidden">


  <div class="show-reply">

    <div class="reply-title">
      <i class="fa-solid fa-x xbutton"></i> <h3 class="reply-title_title">댓글</h3>
    </div>

    <div class="reply-user_box">
        <div class="reply-userimg"><img src="img/1.png"class="reply-uresimg_real"></div>

        <div class="reply-content_box">

        <div class="reply-content">
          <span class="reply-writer_id"></span><span class="reply-writer_content"> </span>
        </div>
        <div class="reply-sub"><span class="reply-update_time"></span><span class="dot"> • </span><span class="reply-like_count">공감 <strong class="reply-like_count"></strong>개</span></div>
     
      </div><!--reply-content_box-->

      
      
    </div>
    


  </div><!--show-reply-->

  <div class="add-reply">
  <div class="add-reply_img_box"><img src="img/3.png" class="add-reply_img"></div> </img> 
  <div class="add-reply_div"><input placeholder="댓글을 남기세요.." class="add-reply_input" name ="contents" onkeypress="onPress(event)"><span onclick="addReplyBox()" class="add-reply_submit hidden">등록</span>
  <input name ="styleId" hidden id="styleIdInput">
  </div>

  </div><!--add-reply-->




  <div class="comment-statebox" id ="right-comment-box">
   
    <!-- <div class="comment-statebox_info">
      <div class="comment-userimg">
        <img src="img/1.png" class="comment-userimg-real"/>
      </div>

      <div class="comment-state_info">
        <div class="comment-idntext"><span class="comment-user_id">tj</span> <span class="comment-text">댓스트</span></div>
        <span class="comment-uspanload_time">2월 20일</span><span class="dot"> • </span><span class="comment-like">공감 <strong class="comment-like_count">224</strong>개</span>
      </div>
    </div>
 
  <div class="comment-like_button">
    <i class="fa-solid fa-face-smile" class="comment-like"></i>
  </div> -->
  
</div><!--comment-statebox-->






</div><!--big-reply-box-->
  
<input type="hidden" id="sessionId" value='${ssUserId}'>
<input type="hidden" id="sessionUsername" value='${ssUsername}'>
<input type="hidden" id="sessionUserImg" value='${ssUserImg}'>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="/shoeCream/resources/js/styleView.js"></script>