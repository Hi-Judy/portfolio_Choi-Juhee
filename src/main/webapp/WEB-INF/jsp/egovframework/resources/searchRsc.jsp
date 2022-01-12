<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="gridRsc">
</div>
<script type="text/javascript">

	//그리드
	var columnsRsc = [
			{
			 header: '자재코드',
			 name: 'code'
			},
			{
			 header: '자재명',
			 name: 'codeName'
			 }
			];
				
	//ajax(api)로 값 받아오는 거 
	var dataSourceRsc = {
		  api: {
		    readData: { 
		    	url: 'search', 
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
	gridRsc.on("click", (ev) => {
		console.log(gridRsc.getValue(ev["rowKey"],ev["columnName"]));
		var rsc = gridRsc.getValue(ev["rowKey"],ev["columnName"]);
		selectRsc(rsc)
		
	});

</script>
</body>
</html>