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
	<h3 style="color : #054148; font-weight : bold">자재 발주 관리</h3>

	<div id="top">
		<div>
		<button id="btnSelectOrder" class="btn">미검사 조회</button>
		<button id="btnSaveOrder" class="btn">저장</button>
		<button id="btnAdd" class="btn">추가</button>
		<button id="btnDel" class="btn">삭제</button>
		</div>
	</div>
	
	<div id="dialog-form-rsc" title="자재 검색"></div>
	<div id="dialog-form-order" title="미입고 검색"></div>
	
	<div id="OverallSize">
	<div id="grid" ></div>
	</div>

	<script type="text/javascript">
	let rscRowKey;
	
	//모달창 설정(자재 조회)
	let dialog3 = $( "#dialog-form-rsc" ).dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
			buttons: {
				"닫기" : function() {
					dialog3.dialog("close") ;
				}
			},
		});
	var poNoList=[];
	//모달창 설정(조회 클릭시 미입고 품목 조회)
	let dialog4 = $( "#dialog-form-order" ).dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
			buttons: {
				"확인" : function (){
					$.ajax({
						url: 'resourcesCheckList',
						method :'GET',
						dataType : 'JSON',
						success : function(datas){
							for(let a = 0; a < datas.data.contents.length; a++){
								for(let b = 0; b<ordrNo.length; b++) {
									if(datas.data.contents[a].ordrNo == ordrNo[b]){
										poNoList.push(datas.data.contents[a]);
									}
								}
							}
							grid.resetData(poNoList);
						}
					})
					dialog4.dialog("close");
				},
				"닫기" : function() {
					dialog4.dialog("close");
				}
			},
		});
	
	//모달창 오픈
	$("#btnSelectOrder").on("click", function(){
			dialog4.dialog("open");
		$("#dialog-form-order").load("searchOrderList",
				function(){
					console.log("로드됨")
			})
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
		editor: 'text',
		 formatter(value) {
            return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
        }
	   },
	   {
		header: '단가',
		name: 'rscPrc',
		 formatter(value) {
            return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
        }
		},
	   {
		 header: '합계',
		 name: 'rscTotal',
		 formatter(value) {
             return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
         }
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
		if(ev["columnName"]=="rscCode" && grid.getValue(ev["rowKey"], ev["columnName"])!=null){
			rscRowKey=ev["rowKey"];
		dialog3.dialog("open");
		
	$("#dialog-form-rsc").load("recList",
			function(){console.log("로드됨")})}
		
	});
	
	

	btnAdd.addEventListener("click", function(){
		grid.appendRow({});
	})

	btnDel.addEventListener("click", function(){
		grid.removeCheckedRows(true);
	}) 
	
	
	btnSaveOrder.addEventListener("click", function(){
		for(let i=0; i<grid.getRowCount(); i++){
			console.log(grid.getValue(i, "rscCnt"));
			if(grid.getValue(i, "rscCnt")) == ""){
				alert("발주량을 입력해주세요")
			}else if(grid.getValue(i, "rscCnt")) != null){
			  grid.request('modifyData');
			}	
		}
	}) 
	
	grid.on("response",function(){
		grid.clear();
	})
	
	</script>
</body>
</html>