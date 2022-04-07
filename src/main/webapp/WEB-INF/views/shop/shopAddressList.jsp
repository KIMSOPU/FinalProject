<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<link rel='stylesheet' type='text/css' media='screen'
	href='/shoeCream/resources/css/shopSalesBidView.css'>

<link rel='stylesheet' type='text/css' media='screen'
	href='/shoeCream/resources/css/shopAddressList.css'>


<!-- 모달 -->
<div class="layer_address_list layer">
	<div class="layer_container">
		<div class="layer_header">
			<h2 class="title">주소록</h2>
		</div>
		<div class="layer_content">
		
			<div class="myAddress">
				 <div class="myAddress_info">
					<c:forEach var="item" items='${addressList}'>
					
						<c:if test="${item.defaultAddr=='Y'}">
							<div class="basic">
								<div class="basic_item" default-mark="기본 배송지">
									<div class="info_bind">
										<div class="name_box">
											<span class="name">${item.recipient}</span>
											<div class="btn_bind">
												<span class="mark">기본 배송지</span>
											</div>
										</div>
										<div class="address_box">
											<span class="zipcode">${item.zipcode}</span>
											<span class="address">${item.addr1} ${item.addr2}</span>
										</div>
									</div>
										<input type="hidden" id="addressId" value="${item.addressId}">
										<input type="hidden" id="defaultAddr" value="${item.defaultAddr}">
										<input type="hidden" id="recipient" value="${item.recipient}">
										<input type="hidden" id="zipcode" value="${item.zipcode}">
										<input type="hidden" id="addr1" value="${item.addr1}">
										<input type="hidden" id="addr2" value="${item.addr2}">
								</div>
							</div>
						</c:if>
						
						<c:if test="${item.defaultAddr=='N'}">
							<div class="other">
								<div class="other_list">
									<div class="info_bind">
										<div class="name_box">
											<span class="name">${item.recipient}</span>
											<div class="btn_bind">
												<button type="button" class="btn default_btn"> 기본 배송지 </button>
											</div>
										</div>
										<div class="address_box">
											<span class="zipcode">${item.zipcode}</span>
											<span class="address">${item.addr1} ${item.addr2}</span>
										</div>
									</div>
										<input type="hidden" id="addressId" value="${item.addressId}">
										<input type="hidden" id="defaultAddr" value="${item.defaultAddr}">
										<input type="hidden" id="recipient" value="${item.recipient}">
										<input type="hidden" id="zipcode" value="${item.zipcode}">
										<input type="hidden" id="addr1" value="${item.addr1}">
										<input type="hidden" id="addr2" value="${item.addr2}">
								</div>
							</div>
						</c:if>
						
					</c:forEach>
				</div> 
			</div>
			
			<div class="layer_btn">
				<a href=javascript:; class="btn cancel_btn"> 닫기 </a>
				<input type="hidden" id="target">
			</div>
		</div>
		<div>
			<a href=javascript:; class="layer_close_btn"><i class="fa-solid fa-xmark"></i></a>
		</div>
	</div>
</div>


<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).on('click', '.address-btn', function(){
		$('.layer_address_list').css('display', 'flex');
		$('body').css('overflow', 'auto');
		
	});
	
	$('.default_btn').click(function(){
		//console.log(this.parentNode.parentNode.parentNode.nextElementSibling.value);
		
		const addressId = this.parentNode.parentNode.parentNode.nextElementSibling.value;

		$.ajax({
			type:'GET',
			url:'/shoeCream/my/setDefaultAddr',
			data:'addressId='+addressId,
			success:function(){
				swal('주소 변경 성공', '', 'success').then(function(){
					location.reload();
				});
				 
			},
			error:function(){
				alert('Error: 기본 배송지 설정')
			}
		}); // end ajax
		 
	});
</script>
