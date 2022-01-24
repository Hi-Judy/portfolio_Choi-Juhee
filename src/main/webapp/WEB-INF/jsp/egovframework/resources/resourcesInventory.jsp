<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<h2>재고조정 관리</h2>
	<div>
		<hr>
		<button id="btnSelectInventory">조회</button>
		<button id="btnSaveInventory">저장</button>
		<button id="btnDel">삭제</button>
		<hr>
	</div>
	<div id="dialog-form-inventory" title="자재 LOT 검색"></div>
	<div id="grid" ></div>

<script type="text/javascript">

	//모달창(조회 클릭시 LOT별 입고)
	let dialoginventory = $( "#dialog-form-inventory" ).dialog({
			autoOpen: false,
			modal: true
		});
	
	$("#btnSelectInventory").on("click", function(){
		dialoginventory.dialog("open");
	$("#dialog-form-inventory").load("resourcesInventoryIn",
			function(){console.log("로드됨")})
	});
	
	
	
	//발주 insert 그리드 
	var Grid = tui.Grid;
	Grid.applyTheme('default');
	
	const columns = [
		
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
		 header: '입고량',
		 name: 'istCnt',
		editor: 'text'
		},
		{
		 header: '출고량',
		 name: 'ostCnt',
		editor: 'text'
		},
		{
		 header: '자재LOT',
		 name: 'rscLot'
		},
		{
		 header: '입출고 구분',
		 name: 'storeFlag',
			editor: {
				type:'select',
				options: {
					 listItems: [
					     { text: '정산입고', value: '정산입고' },
				         { text: '정산출고', value: '정산출고' },
					 ]
				}
			}
		}, 
	];
	
	//ajax(api)로 값 받아오는 거 
	const dataSource = {
		  api: {
			  readData: { 
			    	url: 'resourcesInventory', 
			    	method: 'GET'
			    	//initParams: { ordrNo: 'param' }
			    	},
		    	modifyData: { url: 'resourcesStoreModify', method: 'POST' }
		  },
		  initialRequest : false,
		  contentType: 'application/json'
		};
	
	const grid = new Grid({
		  el: document.getElementById('grid'),
		  data: dataSource,
		  rowHeaders: ['checkbox'],
		  columns
		});
	
	
	btnDel.addEventListener("click", function(){
		grid.removeCheckedRows(true);
	}) 
	
	btnSaveInventory.addEventListener("click", function(){
		grid.request('modifyData');
	}) 
	
	grid.on("response",function(){
		grid.clear();
	})	
	
</script>	
	
	
</body>
</html>