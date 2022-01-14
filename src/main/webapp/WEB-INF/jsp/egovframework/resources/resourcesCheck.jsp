<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>resourcesCheck</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
	<h2>자재입고검사관리</h2>
	<hr>
		<button id="">조회</button>
		<button id="saveResourcesCheck">저장</button>
	<hr>
	<div id="grid"></div>
<script type="text/javascript">
	//그리드 
	var Grid = tui.Grid;
	Grid.applyTheme('striped', {
		  cell: {
		    header: {
		      background: '#ebedef'
		    }
	
		  },
		  frozenBorder: {
			    border: '#ff0000'
			  }
		});
	
	const columns = [
		  		{
			    header: '발주일',
			    name: 'ordeDate'
			  },
			  {
			    header: '발주번호',
			    name: 'ordrNo',
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
				name: 'rscCnt'
			   },
			   {
				 header: '입고량',
				 name: 'rscIstCnt',
				 editor: 'text'
				},
				{
				 header: '검사량',
				 name: 'rscTstCnt',
				 editor: 'text'
				},
				{
				 header: '합격량',
				 name: 'rscPassCnt',
				 editor: 'text'
				},
				{
				  header: '불량량',
				  name: 'rscDefCnt'
				},
				{
				  header: '입고요청일',
				  name: 'istReqDate'
				}
			];
			
	//ajax(api)로 값 받아오는 거 
	let dataSource = {
		  api: {
		    readData: { 
		    	url: 'resourcesCheckList', 
		    	method: 'GET'
		    	},
		    	modifyData: { url: 'resourcesCheckModify', method: 'POST' }
		  },
		  contentType: 'application/json'
		};
	
	const grid = new Grid({
		  el: document.getElementById('grid'),
		  data: dataSource,
		  rowHeaders: ['checkbox'],
		  columns
		});
	
	saveResourcesCheck.addEventListener("click", function(){
		grid.request('modifyData'); 
}) 
	
	
</script>
</body>
</html>