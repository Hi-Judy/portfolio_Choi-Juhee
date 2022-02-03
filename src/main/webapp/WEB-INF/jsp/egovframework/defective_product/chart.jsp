<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
	<div id="chart"></div>
	<button type="button" onclick="test()">테스트</button>
	<script>
		const Chart = toastui.Chart;
		
		const el = document.getElementById('chart');
		
		var data = {
		  categories: [],
		  series: [
		    {
		      name: '불량수',
		      data: []
		    }
		  ]
		};
		
		var options = {
		  chart: { width: 700, height: 400 },
		  series : {
			  stack : true
		  }
		};
		
		const chart = Chart.barChart({ el, data, options });
		
		function test() {
			$.ajax({
				url : 'chartData' ,
				dataType : "json" ,
				success : function(datas) {
					chart.destroy() ;
					
					let str = 0 ;
					let dataList = [] ;
					
					for (let i = 0 ; i < datas.chartData.length ; i++) {
						data.categories.push(datas.chartData[i].procCode) ;
						data.series[0].data.push(Number(datas.chartData[i].defQnt)) ;
					} ;									
					
					console.log(data.categories) ;
					console.log(data.series) ;
					
					const chart2 = Chart.barChart({ el , data , options }) ;
									
				} ,
				error : function(reject) {
					console.log(reject) ;
				}
				
			})
		}
	</script>
</body>
</html>