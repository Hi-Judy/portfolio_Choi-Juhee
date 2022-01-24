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
	<h2>자재 발주</h2>
	<div>
		<hr>
		<button id="btnSelectOrder">조회</button>
		<button id="btnSaveOrder">저장</button>
		<hr>
		<button id="btnAdd">추가</button>
		<button id="btnDel">삭제</button>
	</div>
	
	<div id="dialog-form-rsc" title="자재 검색"></div>
	<div id="dialog-form-order" title="미입고 검색"></div>
	<div id="grid" ></div>

	<script type="text/javascript">
	let rscRowKey;
	
	//모달창(자재 조회)
	let dialog3 = $( "#dialog-form-rsc" ).dialog({
			autoOpen: false,
			modal: true
		});
	
	//모달창(조회 클릭시 미입고)
	let dialog4 = $( "#dialog-form-order" ).dialog({
			autoOpen: false,
			modal: true
		});
	
	function clickOrder(ordrNo){
		console.log(ordrNo);
		grid.readData(1, {'ordrNo':ordrNo}, true);
		dialog4.dialog("close");
	};
	
	$("#btnSelectOrder").on("click", function(){
			dialog4.dialog("open");
		$("#dialog-form-order").load("searchOrderList",
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
		header: '발주량',
		name: 'rscCnt',
		editor: 'text'
	   },
	   {
		header: '단가',
		name: 'rscPrc'
		},
	   {
		 header: '합계',
		 name: 'rscTotal'
		},
		{
		  header: '업체',
		  name: 'sucName'
		},
		{
		  header: '입고요청일',
		  name: 'istReqDate',
		  editor: 'datePicker'
		}	
	];
	
	//ajax(api)로 값 받아오는 거 
	const dataSource = {
		  api: {
			  readData: { 
			    	url: 'resourcesOrder', 
			    	method: 'GET'
			    	//initParams: { ordrNo: 'param' }
			    	},
		    	modifyData: { url: 'resourcesOrderModify', method: 'POST' }
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
	
	//발주량 입력-> 발주량 * 단가 = 합계 구해준다
	grid.on("editingFinish",function(ev){
		if(grid.getValue(ev["rowKey"], "rscPrc")!=null && grid.getValue(ev["rowKey"], "rscCnt")!=null){
			grid.setValue(ev["rowKey"],"rscTotal",grid.getValue(ev["rowKey"], "rscPrc")*grid.getValue(ev["rowKey"], "rscCnt"));
		}
	});
	
	//그리드 클릭시 columnName = rscCode 
	grid.on("click", function(ev){
		console.log(grid.getValue(ev["rowKey"], "rscCode"));
		if(ev["columnName"]=="rscCode" && grid.getValue(ev["rowKey"], ev["columnName"])!=null){
			rscRowKey=ev["rowKey"];
		dialog3.dialog("open");
		
	$("#dialog-form-rsc").load("recList",
			function(){console.log("로드됨")})}
		
	});
	
	

	btnAdd.addEventListener("click", function(){
		grid.appendRow({});
	})
	
	//btnUpd.addEventListener("click", function(){
		//grid.updatedRows(true);
	//})
	
	btnDel.addEventListener("click", function(){
		grid.removeCheckedRows(true);
	}) 
	
	
	btnSaveOrder.addEventListener("click", function(){
		console.log((grid.getValue(grid.getRowCount()-1, "rscCnt")));
		if((grid.getValue(grid.getRowCount()-1, "rscCnt")) == ""){
			alert("발주량을 입력해주세요")
		}else if((grid.getValue(grid.getRowCount()-1, "rscCnt")) != null){
		  grid.request('modifyData');
		}
	}) 
	
	grid.on("response",function(){
		grid.clear();
	})
	
	</script>
</body>
</html>