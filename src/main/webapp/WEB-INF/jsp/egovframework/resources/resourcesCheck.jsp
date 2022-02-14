<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재입고검사 관리</title>
</head>
<body>
	<h4 style="margin-left: 10px">자재입고검사 관리</h4>
	<div id="top">
		<div>
			<span style="margin-top: 13px; float: left;"></span>
			<span style="float: right; margin-top: 4.5px;">
				<button id="findResourcesCheck" class="btn">미검사 조회</button> &nbsp;&nbsp;
				<button id="delRscCheck" class="btn">삭제</button> &nbsp;&nbsp;
				<button id="saveResourcesCheck" class="btn">저장</button> &nbsp;&nbsp;
			</span>
		</div>
	</div>
	
	<!-- 모달 -->
	<div id="dialog-form-def" title="자재 불량 검사 관리"></div>
	
	<!-- 미입고 모달 -->
	<div id="dialog-form-check" title="미입고 검색"></div>
	
	<div id="OverallSize" style="margin-left: 10px;"><br>
		<div id="grid" style="border-top: 3px solid #168; width: 1500px;"></div>
	</div>
	
	<!-- 도움말 모달입니다. -->
	<div id="helpModal" title="도움말">
		<hr>
		새자료 : 화면에 보여지고있는 자재정보를 없에고 등록모드 로 바뀝니다.<br><br>
		자재재고조회 : 선택된 자재의 전년도 이월량 밑 올해 내역들을 볼수있습니다.<br><br>
		저장 : "담당관리자" , "입고업체" , "입고단가" 들을 <br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		새롭게 수정해서 저장할수있습니다.<br><br>
		LOT정보가 없는 자재들은 자재재고조회 밑 LOT정보 조회가 불가능합니다.<br><br>
		LOT추가 밑 더 자세한 자재관리는 자재관리 탭에서 진행해주세요.
	</div>
	
<script type="text/javascript">

	//그리드 한글로 변환
	tui.Grid.setLanguage('ko');
	
	let defRowKey;
	
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
	
	//-------- 미검사조회 모달 ----------
	let dialogOrder = $( "#dialog-form-check" ).dialog({
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
		
							grid.setValue(i, "rscIstCnt", a.rscCnt);
							grid.setValue(i, "rscTstCnt", a.rscCnt);
							grid.setValue(i, "rscPassCnt", "");
							grid.setValue(i, "defCode", "");
							grid.setValue(i, "rscDefCnt", "0");
							//grid.setValue(i, "rscPassCnt", grid.getValue(i,"rscCnt"));
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
	$("#findResourcesCheck").on("click", function(){
		grid.clear();
		dialogOrder.dialog("open");
		$("#dialog-form-check").load("searchOrderList",
				function(){
					console.log("미검사조회 모달 로드됨")
				})
		});
	
	//-------- 메인그리드 ----------
	var Grid = tui.Grid;
	Grid.applyTheme('default');
	
	var columns = [
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
						name: 'rscCnt',
						formatter(value) {
							if(value.value != null && value.value != '' ){
								return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
							}else{
								return value.value ;
							}
						}
					},
					{
						header: '입고량',
						name: 'rscIstCnt',
						formatter(value) {
							if(value.value != null && value.value != '' ){
								return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
							}else{
								return value.value ;
								}
							}
					},
					{
						header: '검사량',
						name: 'rscTstCnt',
						formatter(value) {
							if(value.value != null && value.value != '' ){
								return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
							}else{
								return value.value ;
							}
						}
					},
					{
						header: '합격량',
						name: 'rscPassCnt',
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
						header: '불량량',
						name: 'rscDefCnt',
						formatter(value) {
							if(value.value != null && value.value != '' ){
								return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
							}else{
								return value.value ;
								}
							}
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
			
	//메인 그리드 api
	let dataSource = {
		  api: {
		    readData: { 
		    	url: 'resourcesOrder', 
		    	method: 'GET'
		    	},
		    modifyData: { 
		    	url: 'resourcesCheckModify',
		    	method: 'POST'
		    	}
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
	
	//-------- 불량코드조회 모달 ----------
	let dialogRtn = $( "#dialog-form-def" ).dialog({
		autoOpen: false,
		modal: true,
		heigth : 500,
		width : 900,
	});
	
	//모달창(불량코드 조회)-> 불량코드 셀 선택시 코드 값 그리드에 넣어주기
	grid.on("click", function(ev){
		if(ev["columnName"]=="defCode"){
			defRowKey=ev["rowKey"];
				dialogRtn.dialog("open");
		
		$("#dialog-form-def").load("rtnList",
				function(){
					console.log("불량코드 조회 모달 로드됨")
			}
		)}
	});
	
	
	//
	
	//테이블에서 셀 편집을 종료했을때 검사량, 합격량이 null이 아니면 검사량 - 합격량 = 불량량 구해준다
	grid.on("editingFinish", function(ev){
		if(grid.getValue(ev["rowKey"], "rscTstCnt")!=null && grid.getValue(ev["rowKey"], "rscPassCnt")!=null){
			grid.setValue(ev["rowKey"],"rscDefCnt",grid.getValue(ev["rowKey"], "rscTstCnt")-grid.getValue(ev["rowKey"], "rscPassCnt"));
		}
	});
	
	
	//저장버튼 클릭시 -> 유효성 검사
	//값 미입력(발주량,입고량,검사량,합격량) -> alert 창으로 경고
	//발주량 != 입고량 != 검사량  -> alert 창으로 경고
	//발주량보다 입고량,검사량,합격량이 크면 -> alert 창으로 경고
	//불량량 != 0인데 불량코드가 null이면 -> alert 창으로 경고 getRowAt(rowIdx)
	saveResourcesCheck.addEventListener("click", function(){
		var j = 0;
		for(let i=0; i<grid.getRowCount(); i++){
			if(grid.getValue(i,'rscPassCnt') == ''){
				console.log("합격량 입력")
				alert("합격량을 입력해주세요.");
				 j=0
				 break;
			}else if(grid.getValue(i,'rscTstCnt') != grid.getValue(i,'rscPassCnt')){
				console.log("검사량이랑 합격량이랑 같지 않으면 들어온다")
				if(grid.getValue(i,'defCode') == ''){
					console.log("불량량이랑 합격량이랑 같지 않으면 들어온다===코드가 null")
					alert("불량코드를 입력해주세요.");
					j=0 
					break;
				}else{
					j=1
					break;
				}
			}else{
				j=1;
			}
		}
		if(j==1){
			grid.request('modifyData');
		}
	});
	
	
		
// 		var j = 0;
// 		for(let i=0; i<grid.getRowCount(); i++){
// 			if((grid.getValue(i, "rscCnt")) != (grid.getValue(i, "rscTstCnt"))){
// 				console.log(grid.getValue(i, "rscCnt"));
// 				alert("발주량과 검사량이 일치하지 않습니다");
// 				j=0;
// 				break;
// 			}else if( (grid.getValue(i, "rscDefCnt")) != 0 ){
// 				if(grid.getValue(i, "defCode") == null){
// 					alert("불량코드를 입력해주세요");
// 					j=0;
// 					break;
// 				}else{
// 					j=1;
// 					break;
// 				}
// 			}else{
// 				j=1;
// 			}
// 		}
// 		console.log(j);
// 		if(j==1){
// 			grid.request('modifyData');
// 		}
// 	}) 

	//저장시 데이터 다시 읽어서 수정한 품목(입고 완료한) 사라지게
// 	grid.on("response",function(){
// 		grid.clear();
// 	})
	
	//삭제 버튼 클릭
	delRscCheck.addEventListener("click", function(){
		grid.removeCheckedRows(true);
	}) 
</script>
</body>
</html>