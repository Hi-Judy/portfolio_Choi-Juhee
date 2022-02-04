<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 미입고 검색 그리드 -->
<div id="gridOrder"></div>

<script type="text/javascript">
	
	//그리드
	var columnsOrder = [
			{
			 header: '발주번호',
			 name: 'ordrNo'
			},
			{
			 header: '자재코드',
			 name: 'rscCode'
			 },
			{
			 header: '자재명',
			 name: 'rscName'
			},
			{
			 header: '단위',
			 name: 'rscUnit'
			},

			 {
			  header: '발주량',
			  name: 'rscCnt',
				formatter(value) {
	                return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	            }
			},
			{
			 header: '합계',
			 name: 'rscTotal',
				formatter(value) {
	                return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	            }
			},
			{
			 header: '발주일',
			 name: 'ordeDate'
			},
			{
			 header: '입고요청일',
			 name: 'istReqDate'
			}
		];
				
	//ajax(api)로 값 받아오는 거 
	var dataSourceOrder = {
		  api: {
		    readData: { 
		    	url: 'resourcesCheckList', 
		    	method: 'GET'
		    	}
		  },
		  contentType: 'application/json'
		};
	
	//그리드 속성
	var gridOrder = new Grid({
		  el: document.getElementById('gridOrder'),
		  data: dataSourceOrder,
		  columns: columnsOrder,
		  rowHeaders: ['checkbox'],
		});
	
	
	//리스트에서 선택한 값 가지고 오기
	//var ordrNo = [];
	
	gridOrder.on("check", (ev) => {
		//grid.appendRow({'rscCode':gridOrder.getValue(ev["rowKey"],'rscCode'),
						//'rscName':gridOrder.getValue(ev["rowKey"],'rscName'),
						//'rscUnit':gridOrder.getValue(ev["rowKey"],'rscUnit'),
						//'rscCnt':gridOrder.getValue(ev["rowKey"],'rscCnt'),
						//'rscPrc':gridOrder.getValue(ev["rowKey"],'rscPrc'),
						//'sucName':gridOrder.getValue(ev["rowKey"],'sucName'),
						//'istReqDate':gridOrder.getValue(ev["rowKey"],'istReqDate')
						//});
		
		//ordrNo[ev.rowKey] = gridOrder.getValue(ev["rowKey"],'ordrNo');
		
	});
</script>
</body>
</html>