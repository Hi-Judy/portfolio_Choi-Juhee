<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="gridRtn"></div>
<script type="text/javascript">

	//자재입고검사 페이지에서 불량 체크 
	var columnsRtn = [
			{
			  header: '불량코드',
			  name: 'defCode'
			},
			{
			  header: '불량명',
			  name: 'defName'
			 }
			];
	
	//ajax(api)로 값 받아오는 거 
	var dataSourceRtn = {
		  api: {
		    readData: { 
		    	url: 'searchRtngd', 
		    	method: 'GET'
		    	}
		  },
		  contentType: 'application/json'
		};
	
	var gridRtn = new Grid({
		  el: document.getElementById('gridRtn'),
		  data:dataSourceRtn,
		  columns:columnsRtn
		});
	
	gridRtn.on("dblclick", (ev) => {
		grid.setValue(defRowKey, "defCode", gridRtn.getValue(ev["rowKey"],'defCode'), false)
		console.log(defRowKey);
		console.log(gridRtn.getValue(ev["rowKey"],'defCode'));
		dialogRtn.dialog("close");
	})
	
</script>
</body>
</html>