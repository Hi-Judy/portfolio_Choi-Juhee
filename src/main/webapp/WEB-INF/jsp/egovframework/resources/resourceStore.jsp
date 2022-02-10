<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 입고 관리</title>
</head>
<body>
	<h4 style="margin-left: 10px">자재 입고 관리</h4>
	<div id="top">
		<div>
			<span style="margin-top: 13px; float: left;"></span>
			<span style="float: right; margin-top: 4.5px;">
				<button id="findResourcesStore" class="btn">미입고 조회</button> &nbsp;&nbsp;
				<button id="deleteRscStore" class="btn">삭제</button> &nbsp;&nbsp;
				<button id="saveResourcesStore" class="btn">저장</button> &nbsp;&nbsp;
			</span>
		</div>
	</div>
	<div id="dialog-form-store" title="미입고 검색"></div>
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
	
	//-------- 미입고조회 모달 ----------
	let dialogIn = $( "#dialog-form-store" ).dialog({
		autoOpen: false,
		modal: true,
		heigth : 500,
		width : 900,
		buttons: {
			"확인" : function (){
				for(i=0; i <gridIn.getCheckedRows().length; i++ ){
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

	//미입고조회 모달 오픈
	$("#findResourcesStore").on("click", function(){
		dialogIn.dialog("open");
		$("#dialog-form-store").load("searchResourceStore",
				function(){
					console.log("미입고조회 모달 로드됨")
				})
		});

	//-------- 메인그리드 ----------
	var Grid = tui.Grid;
	Grid.applyTheme('default');
	
	var columns = [
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
	
		//메인 그리드 api
		let dataSource = {
				  api: {
				    readData: { 
				    	url: 'resourcesStore', 
				    	method: 'GET'
				    	},
				    modifyData: { 
				    	url: 'resourcesStoreModify', 
				    	method: 'POST' 
				    	}
				  },
				  contentType: 'application/json'
				};
		
		//메인 그리드 설정
		var grid = new Grid({
			  el: document.getElementById('grid'),
			  data: dataSource,
			  rowHeaders: ['checkbox'],
			  columns
			});
		
		
	//저장버튼 클릭 -> 유효성 검사
	//LOT 번호 미입력 -> alert 창으로 경고
	saveResourcesStore.addEventListener("click", function(){
		for(let i=0; i<grid.getRowCount(); i++){
			if(grid.getValue(i, "rscLot") != null && grid.getValue(i, "rscLot") != 0){
				 grid.request('modifyData');
			}else {
				 alert("자재 LOT를 입력해주세요")
				 break;
			}
		}
	});
		
	//저장시 데이터 다시 읽어서 수정한 품목(입고 완료한) 사라지게
	grid.on("response",function(){
		grid.clear();
	})
	
	//삭제 버튼 클릭
	deleteRscStore.addEventListener("click", function(){
		grid.removeCheckedRows(true);
	}) 	
</script>
</body>
</html>