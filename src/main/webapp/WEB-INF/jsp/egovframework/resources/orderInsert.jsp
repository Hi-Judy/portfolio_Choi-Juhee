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
		<button id="">조회</button>
		<button id="saveOrder">저장</button>
		<hr>
		<hr>
		자재명<input id="txtRsc">
		<button id="btnFindRsc">돋보기</button>
		<div id="dialog-form-rsc" title="자재 검색"></div>
		<br>
		<hr>
		<button id="btnAdd">추가</button>
		<button id="btnDel">삭제</button>
	</div>
	<div id="grid"></div>

	<script type="text/javascript">
	
	//모달창(자재조회)
	function clickRsc(rsc){
		$("#txtRsc").val(rsc);
		dialog3.dialog("close");
	};

	let dialog3 = $( "#dialog-form-rsc" ).dialog({
			autoOpen: false,
			modal: true
		});
	
	$("#btnFindRsc").on("click", function(){
			dialog3.dialog("open");
		$("#dialog-form-rsc").load("recList",
				function(){console.log("로드됨")})
		});
		
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
	    header: '자재코드',
	    name: 'rscCode',
	    editor: 'text'
	  },
	  {
		header: '자재명',
		name: 'rscName',
		editor: 'text'
	  },
	  {
		header: '단위',
		name: 'rscUnit',
		editor: 'text'
	   },
	  {
		header: '발주량',
		name: 'rscCnt',
		editor: 'text'
	   },
	   {
		header: '단가',
		name: 'rscPrc',
		editor: 'text'
		},
	   {
		 header: '합계',
		 name: 'rscTotal',
		 editor: 'text'
		},
		{
		  header: '업체',
		  name: 'sucName',	
		  editor: 'text'
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
			    	url: 'orderList', 
			    	method: 'GET' 
			    	},
		    	modifyData: { url: 'resourcesOrderModify', method: 'POST' }
		  },
		  contentType: 'application/json'
		};
	
	const grid = new Grid({
		  el: document.getElementById('grid'),
		  data: dataSource,
		  rowHeaders: ['checkbox'],
		  columns
		});
	
	btnAdd.addEventListener("click", function(){
		grid.appendRow({});
	})
	
	btnDel.addEventListener("click", function(){
		grid.removeCheckedRows(true);
	}) 
	
	saveOrder.addEventListener("click", function(){
		grid.request('modifyData'); 
}) 
	
	
	
	</script>
</body>
</html>