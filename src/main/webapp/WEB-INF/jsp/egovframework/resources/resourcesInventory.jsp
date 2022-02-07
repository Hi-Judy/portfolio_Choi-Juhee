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

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
	<h4 style="margin-left: 10px">재고 조정 관리</h4>
	<div id="top">
		<div>
		<span style="margin-top: 13px; float: left;">
			</span>
			<span style="float: right; margin-top: 4.5px;">
		<button id="btnSelectInventory" class="btn">조회</button> &nbsp;&nbsp;
		<button id="btnDel" class="btn">삭제</button> &nbsp;&nbsp;
		<button id="btnSaveInventory" class="btn">저장</button> &nbsp;&nbsp;
		</span>
		</div>
	</div>
	<div id="dialog-form-inventory" title="자재 LOT 검색"></div>
	<div id="OverallSize" style="margin-left: 10px;">
			<br>
	<div id="grid" style="border-top: 3px solid #168; width: 1500px;"></div>
	</div>

<script type="text/javascript">

	//모달창(조회 클릭시 LOT별 입고)
	let dialoginventory = $( "#dialog-form-inventory" ).dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
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