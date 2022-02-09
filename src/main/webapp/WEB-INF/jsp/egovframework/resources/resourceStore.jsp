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
	<h4 style="margin-left: 10px">자재 입고 관리</h4>
	<div id="top">
		<div>
			<span style="margin-top: 13px; float: left;">
			</span>
			<span style="float: right; margin-top: 4.5px;">
				<button id="findResourcesStore" class="btn">미입고 조회</button> &nbsp;&nbsp;
				<button id="DeleteRscStore" class="btn">삭제</button> &nbsp;&nbsp;
				<button id="saveResourcesStore" class="btn">저장</button> &nbsp;&nbsp;
			</span>
		</div>
	</div>
	<div id="dialog-form-store" title="미입고 검색"></div>
	<div id="OverallSize" style="margin-left: 10px;">
	<br>
	<div id="grid" style="border-top: 3px solid #168; width: 1500px;"></div>
	</div>
<script type="text/javascript">
tui.Grid.setLanguage('ko');
	let dialogIn = $( "#dialog-form-store" ).dialog({
		autoOpen: false,
		modal: true,
		heigth : 500,
		width : 900,
		buttons: {
			"확인" : function (){
				//여기서는 getCheckedRows에 있는 값을 
				for(i=0; i <gridIn.getCheckedRows().length; i++ ){
					//중복체크하고 값이 없는 경우에만 appendRow 해주는 거 
					if(grid.findRows({ordrNo : gridIn.getCheckedRows()[i].ordrNo}).length == 0) {
						grid.appendRow(gridIn.getCheckedRows()[i]);
					}
				}
				dialogIn.dialog("close");
			},
			"닫기" : function() {
				dialogIn.dialog("close");
			}
		},
	});

	//모달창 오픈
	$("#findResourcesStore").on("click", function(){
		dialogIn.dialog("open");
		$("#dialog-form-store").load("searchResourceStore",
				function(){
					console.log("로드됨")
					})
			});

	var Grid = tui.Grid;
	Grid.applyTheme('default');
	
	const columns = [
				{
			    header: '발주번호',
			    name: 'ordrNo'
			  	},
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
				name: 'rscPassCnt',
				formatter(value) {
					if(value.value != null && value.value != '' ){
						  return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
					}else{
						return value.value ;
					}
	            }
			  },
			  {
				header: '단가',
				name: 'rscPrc',
				formatter(value) {
					if(value.value != null && value.value != '' ){
						  return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
					}else{
						return value.value ;
					}
	            }
			   },
			   {
				 header: '자재LOTNO',
				 name: 'rscLot',
				 editor: 'text'
				},
				 {
				  header: '비고',
				  name: 'field',
				  editor: 'text'
				},
			];
			
		let dataSource = {
				  api: {
				    readData: { 
				    	url: 'resourcesStore', 
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
		
		//저장버튼 클릭시 modify
		saveResourcesStore.addEventListener("click", function(){
			grid.request('modifyData'); 
	}) 
		
	//저장시 데이터 다시 읽어서 수정한 품목(입고 완료한) 사라지게
		grid.on("response",function(){
		grid.clear();
	})
	
	
	DeleteRscStore.addEventListener("click", function(){
		grid.removeCheckedRows(true);
	}) 	
</script>
</body>
</html>