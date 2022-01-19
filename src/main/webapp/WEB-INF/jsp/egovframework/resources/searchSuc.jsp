<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="gridSuc">
</div>
<script type="text/javascript">

	//그리드
	var columnsSuc = [
			{
			 header:'업체코드',
			 name: 'code'
			},
			{
			 header: '업체명',
			 name: 'codeName'
			 }
			];
				
	//ajax(api)로 값 받아오는 거 
	var dataSourceSuc = {
		  api: {
		    readData: { 
		    	url: 'searchSuc', 
		    	method: 'GET'
		    	}
		  },
		  contentType: 'application/json'
		};
	
	var gridSuc = new Grid({
		  el: document.getElementById('gridSuc'),
		  data: dataSourceSuc,
		  columns: columnsSuc
		});
	
	//리스트에서 선택한 값 가지고 오기...$(여기 어떻게 쓰지? )
	gridSuc.on("dblclick", (ev) => {
		console.log(gridSuc.getFocusedCell());
		console.log(gridSuc.getData());
		var suc = gridSuc.getValue(ev["rowKey"],ev["columnName"]);
		clickSuc(suc)
	});

</script>
</body>
</html>