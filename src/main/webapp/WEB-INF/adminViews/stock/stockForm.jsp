<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
.dropbtn {
	background-color: #04AA6D;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: #ddd;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown:hover .dropbtn {
	background-color: #3e8e41;
}
</style>
</head>
<body>


	
	
	<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
  재고 현황</button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <a class="dropdown-item" href="/shoeCream/adminViews/stock/inspectionView">검수 현황</a>
   
  </div>
</div>
	
	
	
	

	<div class="card-body">
		<div class="table-responsive">
			<table class="table">
				<thead class=" text-primary">
					<th>상품번호</th>
					<th>기존재고</th>
					<th>입고량</th>
					<th>출고량</th>
					<th>현재고</th>
					<th>입고날짜</th>
					<th>출고날짜</th>
					<th>출고량</th>
				</thead>
				<tbody>
					<tr>
						<td>Dakota Rice</td>
						<td>Niger</td>
						<td>Oud-Turnhout</td>
						<td class="text-right">$36,738</td>
					</tr>
					<tr>
						<td>Minerva Hooper</td>
						<td>Curaçao</td>
						<td>Sinaai-Waas</td>
						<td class="text-right">$23,789</td>
					</tr>
					<tr>
						<td>Sage Rodriguez</td>
						<td>Netherlands</td>
						<td>Baileux</td>
						<td class="text-right">$56,142</td>
					</tr>
					<tr>
						<td>Philip Chaney</td>
						<td>Korea, South</td>
						<td>Overland Park</td>
						<td class="text-right">$38,735</td>
					</tr>
					<tr>
						<td>Doris Greene</td>
						<td>Malawi</td>
						<td>Feldkirchen in Kärnten</td>
						<td class="text-right">$63,542</td>
					</tr>
					<tr>
						<td>Mason Porter</td>
						<td>Chile</td>
						<td>Gloucester</td>
						<td class="text-right">$78,615</td>
					</tr>
					<tr>
						<td>Jon Porter</td>
						<td>Portugal</td>
						<td>Gloucester</td>
						<td class="text-right">$98,615</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>



</body>

</html>


<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">


$(function(){
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/stock/getStockForm',
		//data: 'pg=' + $('#pg').val(),	
		//dataType: 'JSON',
		success: function(data){
			console.log('data', data);
			
			$.each(data, function(index, items){
				$('<tr/>')			
					.append($('<td/>', {    // 유저아이디
						text: items.stockId
					})).append($('<td/>', {
						text: items.exportDate
					})).append($('<td/>', {
						text: items.productSize				
					})).append($('<td/>', {								
					}).append($('<a/>',{
						href: '/shoeCream/adminViews/user/userView?userId='+items.userId ,
						text: items.modelId, 
						class:'subjectA		subject_' + items.seq			
					}))
					).appendTo($('#stockListTable'));	
				
			});//end each
			
		},
		error: function(err){
			alert('에러났습니다');
			console.log(err);
		}
	});//end ajax
});//end onload

</script>


