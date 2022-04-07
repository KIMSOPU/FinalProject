<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"
	integrity="sha512-QSkVNOCYLtj73J4hbmVoOV6KVZuMluZlioC+trLpewV8qMjsWqlIQvkn1KGX2StWvPMdWGBqim1xlC8krl1EKQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"
	integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg=="
	crossorigin="anonymous" type="text/javascript"></script>


<div class="row">
	<div class="col-md-8">
		<div class="card ">
			<div class="card-header ">
				<h5 class="card-title">월별 판매량</h5>
			</div>

			<div class="card-body ">
				<div class="chartjs-size-monitor"
					style="position: absolute; inset: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;">
					<div class="chartjs-size-monitor-expand"
						style="position: absolute; left: 0; top: 0; right: 0; bottom: 0; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;">
						<div
							style="position: absolute; width: 1000000px; height: 1000000px; left: 0; top: 0"></div>
					</div>
					<div class="chartjs-size-monitor-shrink"
						style="position: absolute; left: 0; top: 0; right: 0; bottom: 0; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;">
						<div
							style="position: absolute; width: 200%; height: 200%; left: 0; top: 0"></div>
					</div>
				</div>

				<canvas id="pursellCht" width="397" height="140"></canvas>
			</div>
		</div>
	</div>



<!-- <div class="row"> -->
	<div class="col-md-4">
		<div class="card ">
			<div class="card-header ">
				<h5 class="card-title">브랜드별 선호도</h5>
			</div>


			<div class="card-body ">

				<canvas id="pie-chart" width="250" height="250">
       </canvas>
			</div>

		</div>
	</div>
</div>


<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

$(function(){
	$('.nav').children().removeClass('active');
	$('.nav li:nth-child(1)').addClass('active');
	
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/sales/getSalesHis',
		dataType: 'JSON',
		success: function(data){
			console.log('salesData', data);
			
			let dataForChart = [];
			let xAxis = [];	
			let salesData = [];
			
			$.each(data, function(index, items){
				dataForChart.push(items.sellCount);
				xAxis.push(items.regDate);
			});//end each
			
			salesData.push(dataForChart);
			salesData.push(xAxis);
			console.log('salesData', salesData)								
			makeChart(salesData);
			/*
			$.ajax({
				type: 'POST',
				url: '/shoeCream/adminViews/sales/getPurchaseHis',
				success: function(data){
					console.log('purchaseData', data);
					
					
				},
				error: function(err){
					
				}
				
			})
			*/
		}//end success
	});//end ajax
	
	$.ajax({
		type: 'POST',
		url: '/shoeCream/adminViews/sales/getBrandHis',
		dataType: 'JSON',
		success: function(data){
			console.log('brandData', data);
			
			let dataForDonutChart = [];
			let brandXAxis = [];	
			
			$.each(data, function(index, items){
				dataForDonutChart.push(items.sellCount);
				brandXAxis.push(items.brandName);
			});
											
			makeDounutChart(brandXAxis, dataForDonutChart);
		}
	});
	
});
	
		

function makeChart(data){
	
	var context = document.getElementById('pursellCht').getContext('2d');
	   let option = 
       {type: 'line',                            //차트의 형태
        options: {
            scales: { yAxes: [ {ticks: {beginAtZero: true}} ] },
             responsive: true
        },
        data: {                                  //차트에 들어갈 데이터
            labels: data[1], //['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], //x축 => (이번달-5)
            datasets: [
            	{ 
                  label: '판매량',                   //차트 제목
                  fill: true,                    //line 형태일 때, 선 밑으로 색칠할껀지 선택
                  data: data[0], //[1, 2, 3, 4, 5],               //x축 label에 대응되는 데이터 값
		                  backgroundColor: [              //색상
		                     'rgba(255, 99, 132, 0.2)',
		                     'rgba(54, 162, 235, 0.2)',
		                     'rgba(255, 206, 86, 0.2)',
		                     'rgba(75, 192, 192, 0.2)',
		                     'rgba(153, 102, 255, 0.2)',
		                     'rgba(255, 159, 64, 0.2)'
		                  ],
		                  borderColor: [                   //경계선 색상
		                     'rgba(255, 99, 132, 1)',
		                     'rgba(54, 162, 235, 1)',
		                     'rgba(255, 206, 86, 1)',
		                     'rgba(75, 192, 192, 1)',
		                     'rgba(153, 102, 255, 1)',
		                     'rgba(255, 159, 64, 1)'
		                  ],
		                  borderWidth: 2 //경계선 굵기
                }
            	/*
            	,{ 
                  label: '구매량',                  //차트 제목
                  fill: false,                    //line 형태일 때, 선 밑으로 색칠할껀지 선택
                  data: [10, 20, 30, 40],         //x축 label에 대응되는 데이터 값
                  backgroundColor: [              //색상
                     'rgba(20, 201, 150, 1)',
                     'rgba(54, 162, 235, 0.2)',
                     'rgba(255, 206, 86, 0.2)',
                     'rgba(75, 192, 192, 0.2)',
                     'rgba(153, 102, 255, 0.2)',
                     'rgba(255, 159, 64, 0.2)'
                  ],
                  borderColor: [                   //경계선 색상
                     'rgba(20, 201, 150, 1)',
                     'rgba(54, 162, 235, 1)',
                     'rgba(255, 206, 86, 1)',
                     'rgba(75, 192, 192, 1)',
                     'rgba(153, 102, 255, 1)',
                     'rgba(255, 159, 64, 1)'
                  ],
                  borderWidth: 3 //경계선 굵기			                  
	            }
            	*/
            	]
         },//end data
      };//end let option
   
	var myChart = new Chart(context, option);
};//end function



function makeDounutChart(brandXAxis, dataForDonutChart){

	new Chart(document.getElementById("pie-chart"), {
		type : 'pie',
		data : {
			labels : brandXAxis, // 브랜드네임이 들어가야 함
			datasets : [ {
				label : "qweqweqwe",
				backgroundColor : [ "#3e95cd", "#8e5ea2", "#3cba9f",
						"#e8c3b9", "#c45850" ],
				data : dataForDonutChart,
			} ]
		},
		options : {
			title : {
				display : true
				
			}
		}
	});
};
</script>
  
   


