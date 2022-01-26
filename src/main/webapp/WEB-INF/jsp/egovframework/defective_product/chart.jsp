<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
</head>
<body>
	<div id="chart"></div>
	<button type="button" onclick="test()">테스트</button>
	<script>
		const Chart = toastui.Chart;
		const el = document.getElementById('chart');
		var data = {
		  categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  series: [
		    {
		      name: '공정1',
		      data: [10, 4, 5, 7, 6, 4, 10, 8, 2, 10, 5, 3],
		    },
		    {
		      name: '공정2',
		      data: [8, 4, 7, 2, 6, 3, 5, 8, 1, 11, 4, 6],
		    },
		    {
		      name: '공정10',
		      data: [3, 2, 5, 8, 9, 4, 2, 0, 2, 1, 0, 3],
		    },
		  ],
		};
		var options = {
		  chart: { width: 700, height: 400 },
		  series : {
			  stack : true
		  }
		};

		const chart = Chart.barChart({ el, data, options });
		
		function test() {
			console.log(data) ;
			console.log(data.series) ;
		}
	</script>
</body>
</html>