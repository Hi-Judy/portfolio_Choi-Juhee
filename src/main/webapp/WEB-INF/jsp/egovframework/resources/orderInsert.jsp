<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 발주 관리</title>
<style type="text/css">
.ab
	{
		color: #ff1004;
		font-weight: bold;
}
</style>
</head>
<body>
	<div style="width : 1500px ;">
		<span style="float: right;">
			<button type="button" id="helpBtn" style="border : none; background-color : #f2f7ff; color : #007b88; float : right ;">
				<i class="bi bi-question-circle"></i>
			</button>
		</span>
		<h4 style="margin-left: 10px">자재 발주 관리</h4>
	</div>
	<div id="top">
		<div>
			<span style="margin-top: 13px; float: left;"></span>
			<span style="float: right; margin-top: 4.5px;">
				<button id="btnSelectOrder" class="btn">미검사 조회</button> &nbsp;&nbsp;
				<button id="btnAdd" class="btn">추가</button>	 &nbsp;&nbsp;
				<button id="btnDel" class="btn">삭제</button> &nbsp;&nbsp;
				<button id="btnSaveOrder" class="btn">저장</button> &nbsp;&nbsp;
			</span>
		</div>
	</div>
	
		<!-- 메인화면 그리드(insert) -->
		<div id="OverallSize" style="margin-left: 10px;"><br>
			<div id="grid" style="border-top: 3px solid #168; width: 1500px;"></div>
			<br>
			<br>
			<!-- 메인화면 그리드(생산계획조회) -->
			<h5 style="color: #25396f; style="margin-left: 10px;">생산필요자재</h5>		
			<div id="gridPlan" style="border-top: 3px solid #168; width: 1500px;"></div>
		</div>	
	
		<!-- 모달 -->
		<div id="dialog-form-rsc" title="자재 검색"></div>
		<div id="dialog-form-order" title="미입고 검색"></div>
		
	<!-- 도움말 모달입니다. -->
	<div id="helpModal" title="도움말">
		<hr>
		미검사 조회 : 미검사 품목을 선택하여 수정, 삭제가 가능합니다<br><br>
		추가 : 발주 가능한 자재를 선택하여 발주가 가능합니다<br><br>
		저장 : 발주수량, 입고요청일 기입 후 저장하면 발주가 가능합니다<br><br>
		생산필요자재 목록을 조회하여 부족한 자재를 발주하는 페이지입니다
		<br><br>
		<hr>
	</div>

<script type="text/javascript">

	//그리드 한글로 변환
	tui.Grid.setLanguage('ko');
	
	let rscRowKey;

	//-------- 도움말 모달 ----------
	var helpModal = $( "#helpModal" ).dialog({
	 autoOpen : false ,
	 modal : true ,
	 width:600, //너비
	 height:400, //높이
	 buttons: {
			"닫기" : function() {
				helpModal.dialog("close") ;
			}
		}
	});	
	
	//-------- 자재조회 모달 ----------
	let dialogRsc = $( "#dialog-form-rsc" ).dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
			buttons: {
				"확인" : function (){
					for(i=0; i <gridRsc.getCheckedRows().length; i++ ){
						let a = gridRsc.getCheckedRows()[i]
						a.rowKey = i;
						grid.appendRow(a);
						grid.setValue(i, "rscCnt", "");
					}
					dialogRsc.dialog("close");
				},
				"닫기" : function() {
					dialogRsc.dialog("close");
				}
			},
		});
	
	//-------- 미검사조회 모달 ----------
	let dialogOrder = $( "#dialog-form-order" ).dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
			buttons: {
				"확인" : function (){
					for(i=0; i <gridOrder.getCheckedRows().length; i++ ){
						if(grid.findRows({ordrNo : gridOrder.getCheckedRows()[i].ordrNo}).length == 0) {
							let a = gridOrder.getCheckedRows()[i]
							a.rowKey = i;
							grid.appendRow(a);
						}
					}
					dialogOrder.dialog("close");
				},
				"닫기" : function() {
					dialogOrder.dialog("close");
				}
			},
		});
	
	//미검사조회 모달 오픈
	$("#btnSelectOrder").on("click", function(){
		grid.clear();
		dialogOrder.dialog("open");
		$("#dialog-form-order").load("searchOrderList",
				function(){
					console.log("미검사조회 모달 로드됨")
				})
		});

	
	//-------- 메인그리드(발주 insert) ----------
	var Grid = tui.Grid;
	Grid.applyTheme('default');
	
	var columns = [
					 {
					    header: '발주번호',
					    name: 'ordrNo',
					    //hidden : true
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
						name: 'rscCnt',
						editor: 'text',
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
						 header: '합계',
						 name: 'rscTotal',
							formatter(value) {
								if(value.value != null && value.value != '' ){
									  return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
								}else{
									return value.value ;
								}
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
	
	//메인 그리드 api
	var dataSource = {
		  api: {
			  readData: { 
			    	url: 'resourcesOrder', 
			    	method: 'GET'
			    	},
		    	modifyData: { url: 'resourcesOrderModify', method: 'POST' }
		  },
		  initialRequest : false,
		  contentType: 'application/json'
		};
	
	//메인 그리드 설정
	var grid = new Grid({
		  el: document.getElementById('grid'),
		  data: dataSource,
		  rowHeaders: ['checkbox'],
		  columns
		});
	
	//발주량 입력 -> 발주량 * 단가 = 합계 구해준다
	grid.on("editingFinish",function(ev){
		if(grid.getValue(ev["rowKey"], "rscPrc")!=null && grid.getValue(ev["rowKey"], "rscCnt")!=null){
			grid.setValue(ev["rowKey"],"rscTotal",grid.getValue(ev["rowKey"], "rscPrc")*grid.getValue(ev["rowKey"], "rscCnt"));
		}
	});
	
	grid.on("successResponse", function(){
		alert('저장완료되었습니다');
	})
	
	//그리드 columnName = rscCode 클릭시 자재조회 모달 오픈
// 	grid.on("click", function(ev){
// 		if(ev["columnName"]=="rscCode"){
// 			rscRowKey=ev["rowKey"];
// 				dialogRsc.dialog("open");
		
// 		$("#dialog-form-rsc").load("recList",
// 				function(){
// 					console.log("자재 조회 모달 로드됨")
// 			}
// 		)}	
// 	});

	//추가 버튼 클릭
	btnAdd.addEventListener("click", function(){
		grid.clear();
		dialogRsc.dialog("open");
		$("#dialog-form-rsc").load("recList",
				function(){
					console.log("자재 조회 모달 로드됨")
			})
	});

	//삭제 버튼 클릭
	btnDel.addEventListener("click", function(){
		grid.request('modifyData',{checkedOnly:true,modifiedOnly:false});
		grid.removeCheckedRows(true);
	});
	
	//저장 버튼 클릭 -> 유효성 검사 
	//발주량,입고요청일 미입력 -> alert 창으로 경고
	//발주량 입력 -> 저장
	btnSaveOrder.addEventListener("click", function(){
		var j =0;
		for(let i=0; i<grid.getRowCount(); i++){	
			if(grid.getValue(i, "rscCnt") == ""){
 				 alert("발주량을 입력해주세요.")
 				 j=0
				 break;
 			}else if(grid.getValue(i, "istReqDate") == null ){
 				alert("입고요청일을 입력해주세요.")
 				j=0;
 				break;
 			}else {
 				j=1;
 			}
 		}
		if (j==1){
			grid.request('modifyData');
		}
	});
	
	//저장시 데이터 다시 읽어서 수정한 품목(입고 완료한) 사라지게
// 	grid.on("response",function(){
// 		grid.clear();
// 	});
	
	
	//-------- 메인그리드(계획완료 select) ----------
	var columnsPlan= [
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
							  header: '계획수량',
							  name: 'sumofPlan',
							  formatter(value) {
									if(value.value != null && value.value != '' ){
										return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
									}else{
										return value.value ;
									}
								}
							},
							{
								header: '안전재고',
								name: 'rscSfinvc',
								formatter(value) {
									if(value.value != null && value.value != '' ){
										return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
									}else{
										return value.value ;
									}
								}
							},
							{
							  header: '재고량',
							  name: 'rscCnt',
								formatter(value) {
									if(value.value != null && value.value != '' ){
										return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
									}else{
										return value.value ;
									}
								}
							},

					];
	
	//메인 그리드 api
	var dataSourcePlan = {
		  api: {
			  readData: { 
			    	url: 'rscOrderPlan', 
			    	method: 'GET'
			    	}
		  	},
		  //initialRequest : false,
		  contentType: 'application/json'
		};
	
	//메인 그리드 설정
	var gridPlan = new Grid({
		  el: document.getElementById('gridPlan'),
		  data: dataSourcePlan,
		  columns: columnsPlan
		});
	
	gridPlan.on("onGridUpdated", function(ev){
		for(i=0; i<gridPlan.getRowCount(); i++){
			if(gridPlan.getValue(i, "sumofPlan")*1 > gridPlan.getValue(i, "rscCnt")*1){
				gridPlan.addCellClassName(i, 'rscCnt', 'ab')
			}else if(gridPlan.getValue(i, "rscSfinvc")*1 > gridPlan.getValue(i, "rscCnt")*1){
				gridPlan.addCellClassName(i, 'rscCnt', 'ab')
			}
		}
	})
	
	//------------------ 도움말 버튼 이벤트 -----------------------
	helpBtn.addEventListener('mouseover' , () => {
		helpModal.dialog("open") ;
	});
	
	gridPlan.readData();
</script>
</body>
</html>