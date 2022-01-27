<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="gridRsc"></div>
<script type="text/javascript">

	//그리드(자재 발주 페이지에서 사용)
	var columnsRsc = [
			{
			  header: '자재코드',
			  name: 'rscCode'
			},
			{
			  header: '자재명',
			  name: 'rscName'
			 },
			 {
			   header: '자재단위',
			   name: 'rscUnit'
			 },
			 {
			   header: '자재단가',
			   name: 'rscPrc'
			},
			 {
			   header: '업체',
			   name: 'sucName'
			},
			{
			 header: '재고',
			 name: 'rscCnt'
			}
			];
				
	//ajax(api)로 값 받아오는 거 
	var dataSourceRsc = {
		  api: {
		    readData: { 
		    	url: 'searchRsc', 
		    	method: 'GET'
		    	}
		  },
		  contentType: 'application/json'
		};
	

	var gridRsc = new Grid({
		  el: document.getElementById('gridRsc'),
		  data:dataSourceRsc,
		  columns:columnsRsc
		});
	
	
	//리스트에서 선택한 값 가지고 오기...$(여기 어떻게 쓰지? )
	gridRsc.on("dblclick", (ev) => {
		console.log(gridRsc.getValue(ev["rowKey"],'rscCode'))
		grid.setValue(rscRowKey, "rscCode", gridRsc.getValue(ev["rowKey"],'rscCode'), false)
		grid.setValue(rscRowKey, "rscName", gridRsc.getValue(ev["rowKey"],'rscName'), false)
		grid.setValue(rscRowKey, "rscUnit", gridRsc.getValue(ev["rowKey"],'rscUnit'), false)
		grid.setValue(rscRowKey, "rscPrc", gridRsc.getValue(ev["rowKey"],'rscPrc'), false)
		grid.setValue(rscRowKey, "sucName", gridRsc.getValue(ev["rowKey"],'sucName'), false)
		dialog3.dialog("close");
	});


</script>
</body>
</html>