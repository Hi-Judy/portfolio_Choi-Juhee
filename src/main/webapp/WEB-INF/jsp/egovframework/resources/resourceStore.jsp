<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>자재 입/출고 관리</h2>
	<hr>
	<button id="findResourcesStore">조회</button>
	<button id="saveResourcesStore">저장</button>
	<hr>
	<div id="grid"></div>
	
<script type="text/javascript">

	var Grid = tui.Grid;
	Grid.applyTheme('default');
	
	const columns = [
		  		{
			    header: '자재코드',
			    name: 'rscCode'
			  },
			  {
			    header: '자재명',
			    name: 'rscName',
			  },
			  {
			    header: '단위',
			    name: 'rscUnit'
			  },
			  {
				header: '입고량',
				name: 'rscIstCnt'
			  },
			  {
				header: '단가',
				name: 'rscPrc'
			   },
			   {
				 header: '자재LOTNO',
				 name: 'rscLot'
				},
				{
				 header: '입고유무',
				 name: 'rscTstCnt'
				}
			];
			
		let dataSource = {
				  api: {
				    readData: { 
				    	url: 'resourcesStoreList', 
				    	method: 'GET'
				    	},
				    	modifyData: { url: 'resourcesStoreModify', method: 'POST' }
				  },
				  contentType: 'application/json'
				};
	
		const grid = new Grid({
			  el: document.getElementById('grid'),
			  data: dataSource,
			  rowHeaders: ['checkbox'],
			  columns
			});
		
	
	
	
</script>
</body>
</html>