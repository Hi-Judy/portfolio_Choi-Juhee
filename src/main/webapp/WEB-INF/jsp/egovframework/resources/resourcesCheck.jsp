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

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
	<h4 style="margin-left: 10px">자재입고검사관리</h4>

	<div id="top">
		<div>
		<span style="margin-top: 13px; float: left;">
			</span>
		<span style="float: right; margin-top: 4.5px;">
		<button id="findResourcesCheck" class="btn">미검사 조회</button> &nbsp;&nbsp;
		<button id="delRscCheck" class="btn">삭제</button> &nbsp;&nbsp;
		<button id="saveResourcesCheck" class="btn">저장</button> &nbsp;&nbsp;
		</span>
		</div>
	</div>
	<div id="dialog-form-def" title="자재 불량 검사 관리"></div>
	<div id="dialog-form-check" title="미입고 검색"></div>
	<div id="OverallSize" style="margin-left: 10px;">
		<br>
	<div id="grid" style="border-top: 3px solid #168; width: 1500px;"></div>
	</div>
	
<script type="text/javascript">
	let defRowKey;
	
	var poNoList=[];
	//모달창 설정(조회 클릭시 미입고 품목 조회)
	let dialog5 = $( "#dialog-form-check" ).dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
			buttons: {
				"확인" : function (){
						//여기서는 getCheckedRows에 있는 값을 
						for(i=0; i <gridOrder.getCheckedRows().length; i++ ){
							//중복체크하고 값이 없는 경우에만 appendRow 해주는 거 
							if(grid.findRows({ordrNo : gridOrder.getValue(i,'ordrNo')}).length == 0) {
								grid.appendRow({'ordeDate':gridOrder.getValue(i,'ordeDate'),
												'ordrNo':gridOrder.getValue(i,'ordrNo'),
												'rscCode':gridOrder.getValue(i,'rscCode'),
												'rscName':gridOrder.getValue(i,'rscName'),
												'rscUnit':gridOrder.getValue(i,'rscUnit'),
												'rscCnt':gridOrder.getValue(i,'rscCnt'),
												'rscPrc':gridOrder.getValue(i,'rscPrc'),
												'sucName':gridOrder.getValue(i,'sucName'),
												'istReqDate':gridOrder.getValue(i,'istReqDate')
								});
								
							}
						}

					dialog5.dialog("close");
				},
				"닫기" : function() {
					dialog5.dialog("close");
				}
			},
		});
	
	//모달창 오픈
	$("#findResourcesCheck").on("click", function(){
			dialog5.dialog("open");
		$("#dialog-form-check").load("searchOrderList",
				function(){console.log("로드됨")})
		});

	
	//그리드 
	var Grid = tui.Grid;
	Grid.applyTheme('default');
	
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
				  header: '불량코드',
				  name: 'defCode'
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
		    	url: '', 
		    	method: 'GET'
		    	},
		    	modifyData: { url: 'resourcesCheckModify', method: 'POST' }
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
	
	grid.readData();
	
	//모달창(불량코드 조회)
	let dialogRtn = $( "#dialog-form-def" ).dialog({
		autoOpen: false,
		modal: true,
		heigth : 500,
		width : 900,
	});
	
	//모달창(불량코드 조회)-> 불량코드 셀 선택시 코드 값 그리드에 넣어주기
	grid.on("click", function(ev){
		console.log(grid.getValue(ev["rowKey"], "defCode"));
		if(ev["columnName"]=="defCode"){
			defRowKey=ev["rowKey"];
		dialogRtn.dialog("open");
		
	$("#dialog-form-def").load("rtnList",
			function(){console.log("로드됨")})}
	});
	
	//테이블에서 셀 편집을 종료했을때 검사량, 합격량이 null이 아니면 검사량 - 합격량 = 불량량 구해준다
	grid.on("editingFinish", function(ev){
		if(grid.getValue(ev["rowKey"], "rscTstCnt")!=null && grid.getValue(ev["rowKey"], "rscPassCnt")!=null){
			grid.setValue(ev["rowKey"],"rscDefCnt",grid.getValue(ev["rowKey"], "rscTstCnt")-grid.getValue(ev["rowKey"], "rscPassCnt"));
		}
	})
	
	//저장버튼 클릭시 modify rscIstCnt
	saveResourcesCheck.addEventListener("click", function(){
		if((grid.getValue(grid.getRowCount()-1, "rscCnt")) != (grid.getValue(grid.getRowCount()-1, "rscIstCnt"))){
			alert("발주량과 입고량이 일치하지 않습니다")
		}else if((grid.getValue(grid.getRowCount()-1, "rscCnt")) == (grid.getValue(grid.getRowCount()-1, "rscIstCnt"))){
		  grid.request('modifyData');
		}
	}) 

	//저장시 데이터 다시 읽어서 수정한 품목(입고 완료한) 사라지게
// 	grid.on("response",function(ev){
// 		let a =JSON.parse(ev.xhr.response)
// 		 if(a.mod=="upd"){
// 			grid.readData();
// 		} 
// 	})
	
	delRscCheck.addEventListener("click", function(){
		grid.removeCheckedRows(true);
	}) 
</script>
</body>
</html>