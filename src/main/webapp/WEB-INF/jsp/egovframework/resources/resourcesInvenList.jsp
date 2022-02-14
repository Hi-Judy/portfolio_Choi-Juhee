<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재재고 조회</title>

<style type="text/css">
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active,
	a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover
	{
	border: 1px solid #007b88;
	background: #007b88;
	font-weight: normal;
	color: #ffffff;
}
.ab
	{
		color: #ff1004;
		font-weight: bold;
}

</style>
</head>
<body>
	<div style="width: 1500px;">
		<span style="float: right;">
			<button type="button" id="helpBtn"
				style="border: none; background-color: #f2f7ff; color: #007b88; float: right;">
				<i class="bi bi-question-circle"></i>
			</button>
		</span>
		<h4 style="margin-left: 10px; margin-bottom: 25px;">자재재고 조회</h4>
	</div>
	<div id="tabs" style="margin-left: 10px; width: 1500px; height: 810px;">
		<ul>
			<li><a href="#tabs-1">자재별 재고</a></li>
			<li><a href="#tabs-2">LOT별 재고</a></li>
		</ul>

		<!-- 안전재고 -->
		<div id="tabs-1"
			style="margin-left: 10px; padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">
			<div id="top" style="width: 1450px; height: 90px;">
				<div style="margin-top: 5px; margin-left: 8px;">
					자재명 <input id="txtRsc2" class="inpBC" readonly>
					자재코드 <input id="txtRsc1">
					<button id="btnFindRsc"
						style="border: none; background-color: #f8f8ff; color: #007b88;">
						<i class="bi bi-search"></i>
					</button>
					&nbsp;&nbsp;&nbsp; <br>
				</div>
				<div id="dialog-form-rsc" title="자재 검색"></div>
				<div
					style="float: right; margin-bottom: 0px; margin-top: 7px; margin-right: 10px;">
					<button id="btnSelect" class="btn">조회</button>
					<button id="btn_reset" type="reset" class="btn">초기화</button>
				</div>
			</div>
			<br>
			<div id="gridRsc1"
				style="border-top: 3px solid #168; height: 800px; width: 1450px; margin-left: 10px;"></div>
		</div>

		<!-- LOT별 재고 -->
		<div id="tabs-2"
			style="margin-left: 10px; padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">
			<div id="top" style="width: 1450px; height: 90px;">
				<div style="margin-top: 5px; margin-left: 8px;">
					자재명 <input id="txtRscLot2" class="inpBC" readonly>
					자재코드 <input id="txtRscLot1">
					<button id="btnFindRscLot"
						style="border: none; background-color: #f8f8ff; color: #007b88;">
						<i class="bi bi-search"></i>
					</button>
					&nbsp;&nbsp;&nbsp; <br>
				</div>
				<div id="dialog-form-rsc-Lot" title="자재 검색"></div>
				<div
					style="float: right; margin-bottom: 0px; margin-top: 7px; margin-right: 10px;">
					<button id="btnSelectLot" class="btn">조회</button>
					<button id="btn_reset_Lot" type="reset" class="btn">초기화</button>
				</div>
			</div>
			<br>
			<div id="gridRscLot"
				style="border-top: 3px solid #168; height: 600px; width: 1450px; margin-left: 10px;"></div>
		</div>
	</div>

	<!-- 도움말 모달입니다. -->
	<div id="helpModal" title="도움말">
		<hr>
		새자료 : 화면에 보여지고있는 자재정보를 없에고 등록모드 로 바뀝니다.<br>
		<br> 자재재고조회 : 선택된 자재의 전년도 이월량 밑 올해 내역들을 볼수있습니다.<br>
		<br> 저장 : "담당관리자" , "입고업체" , "입고단가" 들을 <br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 새롭게 수정해서
		저장할수있습니다.<br>
		<br> LOT정보가 없는 자재들은 자재재고조회 밑 LOT정보 조회가 불가능합니다.<br>
		<br> LOT추가 밑 더 자세한 자재관리는 자재관리 탭에서 진행해주세요.
	</div>

	<script type="text/javascript">
	//그리드 한글로 변환
	tui.Grid.setLanguage('ko');

	//옵션세팅
	themesOptions = { 
	            selection: {    background: '#007b88',     border: '#004082'  },//  <- 클릭한 셀 색상변경 border(테두리색) , background (백그라운드)
	            scrollbar: {    background: '#f5f5f5',  thumb: '#d9d9d9',  active: '#c1c1c1'    }, //<- 그리드 스크롤바 옵션
	            row: {    
	                hover: {    background: '#ccc'  }// <-마우스 올라갔을떄 한row 에 색상넣기
	            },
	            cell: {   // <- 셀클릭했을떄 조건들 주는것이다.
	                normal: {   background: '#fbfbfb',  border: '#e0e0e0',  showVerticalBorder: true    },// <- showVerticalBorder : 세로(아래,위) 테두리가 보이는지 여부
	                header: {   background: '#eee',     border: '#ccc',     showVerticalBorder: true    },// <- showVerticalBorder : 가로(양옆) 테두리가 보이는지 여부
	                rowHeader: {    border: '#eee',     showVerticalBorder: true    },// <- 행의헤더 색상영역
	                editable: { background: '#fbfbfb' },//  <-편집가능한 셀들의 색상을 주는영역
	                selectedHeader: { background: '#eee' },//  <- 선택한 셀의 백그라룬드	
	                disabled: { text: '#b0b0b0' }// <- 편집할수없는(비활성화된) 셀들에 대한 스타일 조절
	            }
	};
	
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

	$( function() {
	    $( "#tabs" ).tabs();
	  } );
  

	
//-----------------------------------안전재고조회-----------------------------------

	//input 태그 초기화 버튼
	$("#btn_reset").on("click", function(){
		$("#txtRsc1").val('');
		$("#txtRsc2").val('');
	})

	//-------- 자재조회 모달 ----------
	let dialogRsc = $( "#dialog-form-rsc" ).dialog({
		autoOpen: false,
		modal: true,
		width : 600,
		heigth : 600,
		buttons: {
			"닫기" : function() {
				dialogRsc.dialog("close") ;
			}
		},
	});
	
	//자재조회 모달창 오픈 
	$("#btnFindRsc").on("click", function(){
		dialogRsc.dialog("open");
		$("#dialog-form-rsc").load("recList2",
			function(){
				console.log("자재조회 모달창 로드됨")
			})
	});

	//모달창(자재조회)에서 클릭한 값 가지고 와서 input 태그에 넣고 모달 닫기
	function clickRsc(rscCode, rscName){
		$("#txtRsc1").val(rscCode);
		$("#txtRsc2").val(rscName);
		dialogRsc.dialog("close");
	};
	
	//-------- 메인그리드 ----------
	var Grid = tui.Grid;
	
	var columns = [
					  {
					    header: '자재코드',
					    name: 'rscCode',
					    sortable: true,
					    sortingType: 'desc'
					  },
					  {
						header: '자재명',
						name: 'rscName',
					    sortable: true,
					    sortingType: 'desc'
					  },
					  {
						header: '단위',
						name: 'rscUnit'
					   },
						{
						  header: '재고',
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
						  header: '미달량',
						  name: 'shortage'
						}
					];
	
	//메인 그리드 api
	var dataSource = {
		  api: {
		    readData: { 
		    	url: 'rscStoreInv', 
		    	method: 'GET'
		    	}
		  },

		  contentType: 'application/json'
		};
	
	//메인 그리드 설정
	var grid = new Grid({
		  el: document.getElementById('gridRsc1'),
		  data: null,
		  columns,
		  pageOptions: {
				useClient: true,
				perPage: 15
			},
			  bodyHeight: 490
		});
	
	//조회버튼 클릭시 input 태그의 값을 넘겨서 원하는 데이터를 가지고 온다
	$("#btnSelect").on("click", function(){
			var rscCode = $("#txtRsc1").val();
			$.ajax({
				url :'rscStoreInv',
				data: {'rscCode' : rscCode },
				contentType: 'application/json; charset=UTF-8'
			}).done(function(da){
				var datalist = JSON.parse(da);
				grid.resetData(datalist["data"]["contents"]);
			})
					
		});
		
	//그리드 재고 - 안전재고  = 미달량 
	grid.on("onGridUpdated", function(ev){
		for(i=0; i<grid.getRowCount(); i++){
			let gr1 = grid.getValue(i, "rscCnt")-grid.getValue(i, "rscSfinvc")
			let gr = Math.round(gr1);
			console.log(gr)
			if(gr < 0){
				let a =(gr*-1)
				grid.setValue(i, "shortage", a.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
				//grid.addRowClassName(i, 'ab')
				grid.addCellClassName(i, 'shortage', 'ab')
			}else{
				grid.setValue(i, "shortage", 0);
			}
			
		}
	});
		

//-----------------------------------자재 LOT별 재고-----------------------------------
	
	//input 태그 초기화 버튼
	$("#btn_reset_Lot").on("click", function(){
		$("#txtRscLot1").val('');
		$("#txtRscLot2").val('');
	})
	
	
	//-------- 자재조회 모달 ----------
	let dialogLot = $( "#dialog-form-rsc-Lot" ).dialog({
		autoOpen: false,
		modal: true,
		heigth : 500,
		width : 900,
	});
	
	//자재조회 모달창 오픈 
	$("#btnFindRscLot").on("click", function(){
		dialogLot.dialog("open");
		$("#dialog-form-rsc-Lot").load("recList2",
			function(){
				console.log("자재조회 모달창 로드됨")
			})
	});
	
	//모달창(자재조회)에서 클릭한 값 가지고 와서 input 태그에 넣고 모달 닫기
	function clickRsc2(rscCode, rscName){
		$("#txtRscLot1").val(rscCode);
		$("#txtRscLot2").val(rscName);
		dialogLot.dialog("close");
	};
	
	//-------- 메인그리드 ----------
	var Grid = tui.Grid;
	
	var columnsLot = [
						{
							header: '자재코드',
							name: 'rscCode',
						    sortable: true,
						    sortingType: 'desc'
						},
						{
							header: '자재명',
							name: 'rscName',
						    sortable: true,
						    sortingType: 'desc'
						},
						{
						    header: '자재 LOT',
							name: 'rscLot',
							sortable: true,
							sortingType: 'desc'
						},
						{
							header: '단위',
							name: 'rscUnit'
						},
						{
							header: '입고량',
							name: 'istCnt'
						},
						{
							header: '출고량',
							name: 'ostCnt'
						},
						{
							header: '재고',
							name: 'rscCnt'
						},
					];
	
	//메인 그리드 api
	var dataSourceLot = {
		  api: {
		    readData: { 
		    	url: 'resourceStoreInventory', 
		    	method: 'GET'
		    	}
		  },
		  contentType: 'application/json'
		};
	
	//메인 그리드 설정
	var gridRscLot = new Grid({
		  el: document.getElementById('gridRscLot'),
		  data: null,
		  columns : columnsLot,
		  pageOptions: {
				useClient: true,
				perPage: 15
			},
		  bodyHeight: 490
		});
	
	//조회버튼 클릭시 input 태그의 값을 넘겨서 원하는 데이터를 가지고 온다
	$("#btnSelectLot").on("click", function(){
			var rscCode = $("#txtRscLot1").val();
			$.ajax({
				url :'resourceStoreInventory',
				data: {'rscCode' : rscCode },
				contentType: 'application/json; charset=UTF-8'
			}).done(function(da){
				var datalist = JSON.parse(da);
				gridRscLot.resetData(datalist["data"]["contents"]);
			})			
		});
	
	//------------------ 도움말 버튼 이벤트 -----------------------
	helpBtn.addEventListener('mouseover' , () => {
		helpModal.dialog("open") ;
	})		
	
	tui.Grid.applyTheme('default', themesOptions);
</script>
</body>
</html>