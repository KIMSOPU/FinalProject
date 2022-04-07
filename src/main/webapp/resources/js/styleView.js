var script = document.createElement("script");
script.src = "https://code.jquery.com/jquery-3.6.0.min.js";
script.type = "text/javascript";
document.getElementsByTagName("head")[0].appendChild(script);

/////////////로그인///////////////////
let url = new URLSearchParams(location.search);
let styleUrl = url.get("styleId");
const id = document.getElementById("sessionId").value;
const username = document.getElementById("sessionUsername").value;

console.log("1");
/////////////url모음집///////////////////
const myPageUrl = "/shoeCream/style/user?username=";
const ImgUrl = "/shoeCream/resources/images/";
//////////// 오른쪽 댓글창 jsp가져오기///////////////////
const Content = document.querySelector(".reply-writer_content");
const writerId = document.querySelector(".reply-writer_id");
const updatetime = document.querySelector(".reply-update_time");
const likeCount = document.querySelector(".reply-like_count");

const replyBox = document.querySelector("#right-comment-box");
const replyContent = document.querySelector(".reply-writer_content");
const replywriterId = document.querySelector(".comment-user_id");
const replyupdatetime = document.querySelector(".comment-uspanload_time");
const replylikeCount = document.querySelector(".reply-like_count");
/////////////jsp에서 댓글창 가져오기///////////////////
const styleBox = document.querySelector(".styleViewBox");

////////////(오른쪽)2번 댓글창///////////////////
const modal = document.querySelector(".big-reply-box"); //댓전체박스
const reply = document.querySelector(".modal-hidden"); //숨겨요
const xButton = document.querySelector(".xbutton"); //바튼
const blackBox = document.querySelector(".modal-bg"); //모달

const submit = document.querySelector(".add-reply_submit"); //댓글등록
const replyInput = document.querySelector(".add-reply_input"); //댓그래용..왜두개있냐
const styleIdInput = document.getElementById("styleIdInput"); // styleId 숨기기
const inputValue = document.querySelector(".add-reply_input"); // 댓글 내용
const userImg = document.querySelector(".reply-uresimg_real");
const realImg = document.querySelector(".add-reply_img");

let windowData;
///////////////////////////////////////////////////////////////////////////////////

function deleteContent(styleId) {
  if (confirm("정말로 삭제하시겠습니까?")) {
    fetch(`/shoeCream/style/styleDelete?styleId=${styleId}`).then((res) => {
      //console.log(res);
      alert("삭제되었습니다.");
      location.href = `/shoeCream/style/user`;
    });
  }
}

function goToCorDel(styleId) {
  const buttonBox = document.querySelector(`#clickBox${styleId}`);
  buttonBox.classList.toggle("hidden");
}

function reportContent(styleId) {
  if(!id) alert('게시글 신고는 로그인 후 가능합니다.');
  else {
    if(confirm('정말로 신고하시겠습니까? 취소는 불가능합니다😢')) {
      $.ajax({
        method: "get",
        url: "/shoeCream/style/styleReport?styleId=" + styleId,
        success: function (result) {
          console.log(result);
          if(result == 'success') alert('🚩신고 완료! 해당 게시글은 운영자 검토 후 처리될 예정입니다.');
          else if (result == 'fail') alert('이미 신고한 게시글입니다. 운영자 검토까지 조금만 기다려주세요😊');
        },
        error: function (err) {
          console.log(err);
        },
      }); //ajax
    }
    
  }
}

function modifyStyle(styleId) {
  $("#modifyModal").css("display", "flex");
  $("body").css("overflow", "hidden");

  //파라미터로 styleId 전달하고 데이터 받아서 넣어주기
  $.ajax({
    method: "post",
    url: "/shoeCream/style/getDeatilsReplyList?styleId=" + styleId, //파라미터에 styleId 넣어주기
    success: function (data) {
      console.log(data);
      $("#styleId").val(data.styleId);
      $("#contentsTextArea-md").text(data.contents);
      $("#productId").val(data.productId);
      //$('') //상품태그쪽 정보
    },
    error: function (err) {
      console.log(err);
    },
  }); //ajax
}

function removeAddButton(ele) {
  styleContentText = ele.parentNode.firstElementChild;
  console.log(styleContentText);
  ele.remove();
  styleContentText.classList.remove("text-content");
}

replyInput.addEventListener("keyup", () => {
  //타자를 치면,등록버튼이 생긴다
  submit.classList.remove("hidden");

  replyInput.value
    ? submit.classList.remove("hidden")
    : submit.classList.add("hidden"); //벨류값 없으면 등록 버튼이 사라진다
});

function deleteComment(id) {
  Swal.fire({
    title: "글을 삭제하시겠습니까???",
    text: "삭제하시면 다시 복구시킬 수 없습니다.",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "삭제",
    cancelButtonText: "취소",
  }).then((result) => {
    if (result.value) {
      console.log(",bb");

      const styleId = styleIdInput.value; //숨긴 아이디 인풋에거 꺼내고

      fetch(
        `/shoeCream/style/replyDelete?styleId=${styleId}&styleReplyId=${id}`
      )
        .then((res) => {
          const commentBox = document.getElementById(`mainComment${styleId}`);
          const mainComments = document.querySelectorAll(".mainComments");
          const leftComments = document.querySelectorAll(".left-comment-div");
          //디비에 넘겨줘서 정보들을 받아요

          //idx 를 구하는 이유 = 내가 '몇변째' 댓글을 선택했는지 알수있어야 모든 정보 출력,정보 빼와서 활용 가능
          //밑에서 확인

          let arrIdx;
          let replyIdx;
          console.log(replyBox);
          console.log(replyBox.childNodes);
          mainComments.forEach((elem, idx) => {
            if (commentBox.id == elem.id) arrIdx = idx;
          });

          console.log(windowData[arrIdx].replyList);

          leftComments.forEach((elem, idx) => {
            if (elem.id == `box${id}`) {
              //찾아와야 할 박스에 이미 아이디를 부여, 디비에서 아이디를 받았으니 포이치 돌려서 찾아옴
              console.log(elem);
              replyIdx = idx; //idx까지 구해버림 (넘김) -> 여기서 57번째 줄로 idx변환 let때문에
            }
          });
          console.log(replyIdx, "리플라이 idx");
          windowData[arrIdx].replyList.splice(replyIdx, 1); //배열안의 댓글 요소를 아예 바꿔버림.db에 반영가능, 삭제 후 화면 단에 그 전 댓글이 올라올 것.

          console.log(windowData[arrIdx].replyList); //n번째 데이터의 댓글 리스트 확인
          const idBox = document.querySelector(`#box${id}`);
          const leftBox = document.querySelector(`#left-box${id}`);

          if (leftBox) leftBox.remove(); //댓글이 없으면 지우지 말고 있으면 선택한거 지워버려
          idBox.remove(); //오른쪽 댓글도 마찬가지임
          const secondReplyData = windowData[arrIdx].replyList[1];
          //삭제가 되면 배열에서 없어진 후 그 다음 요소를 뷰단에 보여주기 위해

          if (
            commentBox.childElementCount < 2 && //삭제가 된 후, 댓글의 갯수가 2개보다 적을때
            windowData[arrIdx].replyList.length >= 2 //찐 댓글 배열 자체가 2개보다 적을수 있으니 댓글 배열 길이도 검사를
          )
            //if 문으로 검증을 하고

            console.log(secondReplyData);

          commentBox.innerHTML += ` <div class="comment-statebox_info" id="left-box${secondReplyData.styleReplyId}">
              <div class="comment-userimg" onclick="myView('${secondReplyData.username}')">
              <img src="/shoeCream/images/userProfile/${windowData[arrIdx].img}" class="comment-userimg-real"/>
              </div>
              
              <div class="comment-state_info">
              <div class="comment-idntext"><span class="comment-user_id">${username}</span> <span class="comment-text">${secondReplyData.contents}</span></div>
              <span class="comment-uspanload_time">${secondReplyData.regDate}</span>
              </div>
              </div>`;

          document.querySelector(`#commentCount${styleId}`).innerText =
            windowData[arrIdx].replyList.length; // ??

          const showReplyButton = document.querySelector(`.btn${styleId}`);
          console.log(showReplyButton);

          if (commentBox.childElementCount < 2) {
            showReplyButton.classList.add("hidden");
            console.log("숨김");
          }

          if (result.isConfirmed) {
            // 만약 모달창에서 confirm 버튼을 눌렀다면
            Swal.fire("댓글이 삭제됐습니다!");
          }
        })
        .catch((err) => {
          //alert("삭제에 실패했습니다.");
          console.log(err);
        });
    }
  });

  //replyId를 받아옴
  // if (confirm("정말로 삭제하시겠습니까?")) {

  // }
}

console.log("바낌");
////////////////////////////////////////////////////////////////////////////////////////

xButton.addEventListener("click", removeClass); //x버튼 댓글창 나가기
blackBox.addEventListener("click", removeClass); //검은창 눌렀을때 댓글창 나가기

function makeContent(styleData) {
  //더보기버튼 클릭-> 정보를 받아와서 띄워주는 코드 //windowData[idx] 데이터의 n번째 배열
  replyBox.innerHTML = "";
  console.log(styleData);

  realImg.src = `/shoeCream/images/userProfile/${document.getElementById("sessionUserImg").value}`;
  userImg.src = `/shoeCream/images/userProfile/${styleData.img}`;

  userImg.addEventListener("click", () => {
    location.href = `/shoeCream/style/user?username=${styleData.username}`;
  });

  Content.innerText = styleData.contents;
  writerId.innerText = styleData.username;
  updatetime.innerText = styleData.regDate;
  styleData.regDate ? styleData.regDate : "";
  likeCount.innerText = styleData.likeCount + "개";

  const replyArr = styleData.replyList;
  console.log(replyArr);
  if (replyArr)
    replyArr.forEach((replys) => {
      replyBox.innerHTML += ` <div class="comment-statebox_info left-comment-div"  id="box${
        replys.styleReplyId
      }">
    <div class="comment-userimg" onclick="myView('${replys.username}')">
      <img src="/shoeCream/images/userProfile/${
        replys.img
      }" class="comment-userimg-real"/>
    </div>

    <div class="comment-state_info">
      <div class="comment-idntext"><span class="comment-user_id">${
        replys.username
      }</span> <span class="comment-text">${replys.contents}</span></div>
      <span class="comment-uspanload_time">${replys.regDate}</span>${
        replys.username == username
          ? `<span class="delete" onclick="deleteComment(${replys.styleReplyId})">삭제<span>`
          : ``
      }
    </div>
  </div>

 `;
    });
}
////////////기능//////////////////
function showComment(idx) {
  if (!id) location.href = "/shoeCream/user/login";
  else {
    modal.classList.remove("modal-hidden");
    reply.classList.remove("modal-hidden");

    inputValue.focus();
    const styleNumber = windowData[idx].styleId;
    makeContent(windowData[idx]); //클릭한 것의 인덱스,스타일 넘버를 구했음
    //여기다가 함수를 만들어준다
    styleIdInput.value = styleNumber;
  }
}

function removeClass() {
  modal.classList.add("modal-hidden");
  reply.classList.add("modal-hidden");
  blackBox.classList.add("modal-hidden");
}

function urlFunction() {}

function myView(username) {
  //상세페이지로 이동합시다
  location.href = myPageUrl + username;
}

function onPress(event) {
  if (event.keyCode == 13) addReplyBox();
}

function goToShop(productId) {
  //프로덕트 사진 클릭하면 이동
  console.log("넘어갔다!");
  location.href = `/shoeCream/shop/shopView?productId=${productId}`;
  // /shoeCream/shop/shopView?=
}

function addReplyBox() {
  //등록을 눌렀을때
  const styleId = styleIdInput.value; //스타일 넘버 구하기,스타일넘버 받는 코드 : n번째줄

  fetch(
    //등록버튼을 누름과 동시에 빽에 정보를 보내줍니다
    `/shoeCream/style/replyWrite?styleId=${styleId}&contents=${inputValue.value}`
  )
    .then((res) =>
      res.json().then((data) => {
        console.log(data);
        const commentBox = document.getElementById(`mainComment${styleId}`); //댓글 전체를 감싸는 코멘트박스
        if (commentBox.childElementCount >= 2)
          //왼쪽 댓글은 프론트단에서 2개만 보여줘야 하니
          commentBox.lastElementChild.remove(); //맨 밑에 있는건 삭제해버려

        // const date = new Date(); //프론트에서 받아온 데이터,db로 받아서 갈아끼우기. -> 완료
        // const crrentlyDate =
        //   date.getMonth() +
        //   1 +
        //   "월" +
        //   date.getDate() +
        //   "일" +
        //   date.getHours() +
        //   "시";

        // 왼쪽 댓글창 뷰단 띄워주기
        commentBox.innerHTML =
          ` <div class="comment-statebox_info" id="left-box${data.styleReplyId}">
        <div class="comment-userimg" onclick="myView('${data.username}')">
        <img src="/shoeCream/images/userProfile/${data.img}" class="comment-userimg-real"/>
        </div>
        
        <div class="comment-state_info">
        <div class="comment-idntext"><span class="comment-user_id">${username}</span> <span class="comment-text">${inputValue.value}</span></div>
        <span class="comment-uspanload_time">${data.regDate}</span>
        </div>
        </div>` + commentBox.innerHTML;

        //오른쪽 댓글창 뷰단 띄워주기
        replyBox.innerHTML =
          ` <div class="comment-statebox_info" id="box${data.styleReplyId}">
    <div class="comment-userimg" onclick="myView('${data.username}')">
    <img src="/shoeCream/images/userProfile/${data.img}" class="comment-userimg-real"/>
    </div>
    
    <div class="comment-state_info">
    <div class="comment-idntext"><span class="comment-user_id">${username}</span> <span class="comment-text">${inputValue.value}</span></div>
    <span class="comment-uspanload_time">${data.regDate}</span><span class="delete" onclick="deleteComment(${data.styleReplyId})">삭제<span>
    </div>
    </div>` + replyBox.innerHTML;

        // contents: "ㄴㅇㅎㄴㅇ"
        // img: "default.jpg"
        // intromsg: "로그인,마이페이지 테스트용 계정입니다."
        // regDate: "3월20일22시"
        // styleReplyId: 48
        // username: "jsh229"

        //여기까지 띄워주기 완료, 그 후에

        submit.classList.add("hidden"); //등록 버튼도 숨기기
        replyBox.scrollTo(0, 0); //오른쪽 댓글창 스크롤도 올리기

        //등록은 했고 디비에서 받아온 replyId 정보로 왼쪽 댓글창에 뿌려줘야함

        //여기서부터 헷갈..
        const mainComments = document.querySelectorAll(".mainComments"); //왼쪽 댓글 모든 창
        let arrIdx;
        mainComments.forEach((elem, idx) => {
          //뷰단에서 보여주기는 끝, 새로고침해도(?) 업뎃 되기 위해 유저 정보,댓글 내용등을 배열에 넣어주기
          if (commentBox.id == elem.id) {
            arrIdx = idx;
            const obj = {
              //배열의 뒤에 정보 추가
              contents: inputValue.value,
              img: data.img,
              intromsg: "로그인,마이페이지 테스트용 계정입니다.",
              regDate: data.regDate,
              styleReplyId: data.styleReplyId,
              username: username,
            };

            if (windowData[idx].replyList)
              windowData[idx].replyList.unshift(obj);
            else windowData[idx].replyList = [obj];
          }
        });
        console.log(windowData[arrIdx].replyList);
        inputValue.value = ""; //등록하면 인풋창 비워주기
        document.querySelector(`#commentCount${styleId}`).innerText = //댓글 N개 업데이트
          windowData[arrIdx].replyList.length; //받아온 게시글의,댓글의,길이만큼

        //2개일때 = 더보기 뜬다. 1개일때 = 안뜬다.
        //등록하고 1개 추가 됐을때 = 뜨게 만들어야 한다
        //2개였을때 내 댓글 삭제를 눌렀을때 = 안뜨게 만들어야한다

        const showReplyButton = document.querySelector(`.btn${styleId}`);
        console.log(showReplyButton);

        if (commentBox.childElementCount >= 2) {
          showReplyButton.classList.remove("hidden");
          console.log("드러냄ㅇㅇ");
        }

        // commentBox.childElementCount = 2 ? `<button class="show-comment btn${datas.styleId}" onclick='showComment(${idx})'>댓글 더보기</button>` : ""
      })
    )
    .catch((err) => console.log(err));
}

//=================================================================================================

//상세페이지 띄우기 (모든 유저 게시글,정보 띄우기)

window.onload = function () {
  getData();
}; //시작하자마자 일단 데이터를 받아와줍니다

function getData() {
  //실행시켜줍니다

  const listType = sessionStorage.getItem("listType");
  const url = listType === "newest" ? "getRecentList" : "getPopularList";
  fetch(`/shoeCream/style/${url}`).then((res) =>
    res.json().then((styleData) => {
      console.log(styleData);
      makeTag(styleData); //상세페이지 모든 정보 게시글 촤르륵
    })
  );
} //겟데이터

function makeTag(data) {
  windowData = data;
  //받아온 전체 데이터를
  data.forEach((datas, idx) => {
    //포문에 넣고 돌려돌려,옵젝트 한개
    const styleId = datas.styleId;
    const proudctId = datas.productId;

    //////////////////////////////////////////////뮨자열을 만드는 코드 //////////////////////nm//////////////////////

    let commentList = ""; //댓글 띄워주기,띄울 댓글을 문자열에 통으로 넣어줄거예요
    //없으면 출력 하지 말고
    if (datas.replyList)
      for (let i = 0; i < 2; i++) {
        //일단 화면단에 보여주는거 실행
        //두개만 출력해.. 왼쪽 댓글은 얄짤없이 두개만 보여줄거임
        // datas.replyList.length
        commentList += `
        <div class="comment-statebox" id="left-box${
          datas.replyList[i].styleReplyId
        }">
        <div class="comment-innerBox">
        <div class="comment-statebox_info">
            <div class="comment-userimg" onclick="myView('${
              datas.replyList[i].username
            }')">
                <img src="/shoeCream/images/userProfile/${
                  datas.replyList[i].img
                }" class="comment-userimg-real" />
            </div>

            <div class="comment-state_info">
                <div class="comment-idntext">
                    <span class="comment-user_id">
                    ${datas.replyList ? datas.replyList[i].username : ""}
                    </span> <span
                        class="comment-text">
                        ${datas.replyList ? datas.replyList[i].contents : ""}
                        </span>

                </div>
                <span class="comment-uspanload_time">
                ${datas.replyList ? datas.replyList[i].regDate : ""}
                </span>
            </div>
        </div>

        <div class="comment-like_button">
      
        </div>

        </div>

    </div>`;

        if (datas.replyList.length < 2) {
          break;
        }
      }

    //////////////////////////////////////////////뮨자열을 만드는 코드 ////////////////////////////////////////////

    styleBox.innerHTML += `<div class="want-margin">

    <div class="user-statebox">

        <div class="user-statebox_info" id=${datas.styleId} onclick="myView('${
      datas.username
    }')">
            <div class="user-img" >
                <img src="/shoeCream/images/userProfile/${
                  datas.img
                }" class="user-img_real" />
            </div>

            <div class="user-state_info">
                <p class="user_id">${datas.username}</p>
                <p class="user-upload_time">${datas.regDate}</p>
            </div>
        </div>

      <div class="user-follow_button">

      <div class="button-group hidden" id="clickBox${styleId}">
      ${
        datas.username === username
          ? `<button class="follow_button correct" onclick="modifyStyle(${styleId})">수정</button>
          <button class="follow_button delete" onclick="deleteContent(${styleId})">삭제</button>`
          : ""
      }
      <button class="follow_button_declaration" onclick="reportContent(${styleId})">신고</button>
      </div>
    
      <i class="fa-solid fa-ellipsis-vertical userCorr" onclick="goToCorDel(${styleId})"></i>

        </div>


      
        

    </div>
    <!--user-statebox-->

    <!--게시글 이미지-->
    <div class="img-box">
        <img src="/shoeCream/images/style_board/${
          datas.img1
        }" class="img-box_img">
    </div>
    <!--게시글 이미지-->

    <div class="product_title">
        <p class="procut_tag producttag_${datas.styleId}">
            상품 태그<strong class="num">1</strong>개
        </p>
    </div>

    <div class="product_title">
        <div class=""></div>
        <a href="#" class="share"></a>
    </div>

    <div class="product-wrap product_${datas.styleId}" onclick="goToShop(${datas.productId})">

        <div class="product">
            <img src="/shoeCream/images/productImg/${
              datas.productImg
            }" class="style_product-img">
        </div>
        <div class="product_desc">
            <p class="product_name">${datas.productName}</p>
            <div class="price-box">
                <sapn class="amount">${datas.price.toLocaleString("en")}</sapn>
                <span class="won">원</span>
            </div>
        </div>

    </div>
    <!--product-wrap-->

    <div class="product-svg_wrap">
        <div class="product-svg">
            <i class="likeButton fa-solid ${
              datas.likeOnOff == "off" ? "fa-face-smile" : "fa-heart"
            } smile-icon"></i><i class="fa-solid fa-message" onclick='showComment(${idx})'></i>
        </div>
        <a href="#" class="share"><i
            class="fa-solid fa-arrow-up-from-bracket"></i></a>
    </div>
    <!--product-svg_wrap-->

    <div class="social-count">
        <p onclick='likeModalOpen(${datas.styleId})'>
            공감 <strong class="like-num" id="likeCount${datas.styleId}">${
      datas.likeCount
    }</strong>개
        </p>
    </div>
    <!--social-count-->

    <div class="social-text long-text">
        <span class="text-content">${datas.contents}</span>
        
        ${
          datas.contents.length > 15
            ? ` <span class="view-more" onclick="removeAddButton(this)">더보기</span>`
            : ""
        }
    </div>

   


    <div class="comment-area">
        <a class="comment_count">댓글 <strong id="commentCount${
          datas.styleId
        }">${datas.replyCount}</strong>개
        </a>

    </div>


    <!--commet-area-->

    
    
  
  


    <div class="mainComments" id="mainComment${datas.styleId}">

    ${commentList}

   

    </div>
    <!--comment-statebox-->


    
    

   ${
     1 < datas.replyCount
       ? `<button class="show-comment btn${datas.styleId}" onclick='showComment(${idx})'>댓글 더보기</button>`
       : `<button class="show-comment btn${datas.styleId} hidden" onclick='showComment(${idx})'>댓글 더보기</button>`
   }    

    </div>
    <!--want-margin-->
    `;

  if(datas.productImg == null) { //상품태그 안달았을 경우 상품태그 영역 삭제
    document.querySelector('.producttag_'+datas.styleId).remove();
    document.querySelector('.product_'+datas.styleId).remove();
  }  
  }); //포이치 돌려돌려 여기 끝나면 끝 다 만들어짐

  const styleIdElements = document.querySelectorAll(".user-statebox_info");
  const smileIcon = document.querySelectorAll(".likeButton");
  const likeElements = document.querySelectorAll(".like-num"); //공감 수 엘리먼트 배열

  // const showComment = document.querySelectorAll(".show-comment");

  // showComment.forEach((buttons, idx) => {
  //   showComment[idx].addEventListener("click", () => {
  //     inputValue.focus();
  //     const styleNumber = styleIdElements[idx].id;
  //     makeContent(data[idx]); //클릭한 것의 인덱스,스타일 넘버를 구했음
  //     //여기다가 함수를 만들어준다
  //     styleIdInput.value = styleNumber;
  //     // addReply(styleNumber);
  //   });
  // });

  //공감 배열을 반복하면서
  likeElements.forEach((likeNum, idx) => {
    //n번째 스마일 버튼부터 천천히 이벤트를 할당한다.
    smileIcon[idx].addEventListener("click", () => {
      //함수에는 n번째 버튼과, n번쨰 공감엘리먼트를 넘긴다

      if (id == "") location.href = "/shoeCream/user/login";
      else {
        console.log(styleIdElements);
        const styleNumber = styleIdElements[idx].id;
        changeIcon(smileIcon[idx], likeNum, styleNumber);
      }
    });
  });

  ////////////////////////////스크롤 효과////////////////////////////////////

  setTimeout(() => {
    const styleBox = document.getElementById(styleUrl);
    styleBox.scrollIntoView();
    window.scrollTo(0, window.scrollY - 150);
  }, 100);

  ////////////////////////////삭제//////////////////////////////////////////

  function changeIcon(icons, likeElements, styleNumber) {
    icons.classList.toggle("fa-face-smile");
    icons.classList.toggle("fa-heart");
    //인자로 n번째 아이콘과 n번째 엘리먼트를 받아서 넘김
    addNumber(icons, likeElements, styleNumber);

    // addNumber(icons, likeNum);
  } //클래스 바꿔주는 함수

  function addNumber(icons, likeElements, styleNumber) {
    //n번째 공감 엘리먼트에서 숫자를 받아서 담음
    const likeNum = likeElements.innerText;

    if (icons.classList.contains("fa-heart")) {
      likeElements.innerText = Number(likeNum) + 1;

      fetch(`/shoeCream/style/switchLike?styleId=${styleNumber}`).then(
        (res) => {
          console.log(res);
          res.text().then((styleData) => {
            console.log(styleData);
          });
        }
      );
    } else {
      likeElements.innerText = Number(likeNum) - 1;

      fetch(`/shoeCream/style/switchLike?styleId=${styleNumber}`).then(
        (res) => {
          console.log(res);
          res.text().then((styleData) => {
            console.log(styleData);
          });
        }
      );
    }
  } //하트수 계산
}