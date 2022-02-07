<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재재고조회</title>
<!-- <link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />

<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script> -->
<style type="text/css">

.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
    border: 1px solid #007b88;
    background: #007b88;
    font-weight: normal;
    color: #ffffff;
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
		<h4 style="margin-left: 10px; margin-bottom: 25px;">자재재고 조회</h4>
	</div>
	
<div id="tabs" style="margin-left: 10px; width : 1500px ; height: 600px;">
  <ul>
    <li><a href="#tabs-1">안전 재고</a></li>
    <li><a href="#tabs-2">LOT별 재고</a></li>
  </ul>
  

  <div id="tabs-1" style="margin-left:10px; padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">	
	<div id="top" style="width: 1450px; height: 90px;">
		<div class="card-body">
		자재명 <input id="txtRsc2" class="inpBC" readonly>
		자재코드 <input id="txtRsc1">
		<button id="btnFindRsc" style="border : none; background-color :#f8f8ff; color : #007b88;" >
		<i class="bi bi-search"></i>
		</button>&nbsp;&nbsp;&nbsp;
		<br>
	</div>

	<div id="dialog-form-rsc" title="자재 검색"></div>
	<div  style="float:right;margin-bottom: 0px;margin-top: 7px;margin-right: 10px;">
		<button id="btnSelect" class="btn">조회</button>
		<button id="btn_reset" type="reset" class="btn">초기화</button>
		<button class="btn">엑셀</button>
	</div>
	</div>	
	<br>
	<div id="gridRsc1" style="border-top: 3px solid #168; height: 600px; width: 1450px; margin-left: 10px;"></div>
	</div>
	

	
	<div id="tabs-2"  style="margin-left:10px; padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">
	<div id="top" style="width: 1450px; height: 90px;">
	<div style="margin-top : 5px;  margin-left: 8px;">
		자재코드 <input id="txtRscLot1">  <button id="btnFindRscLot" style="border : none; background-color :#f8f8ff; color : #007b88;" ><i class="bi bi-search"></i></button>&nbsp;&nbsp;&nbsp; 자재명 <input id="txtRscLot2" class="inpBC" readonly><br>
	</div>

	<div id="dialog-form-rsc-Lot" title="자재 검색"></div>
	<div style="float:right;margin-bottom: 0px;margin-top: 7px;margin-right: 10px;">
		<button id="btnSelectLot" class="btn">조회</button>
		<button id="btn_reset_Lot" type="reset" class="btn">초기화</button>
		<button class="btn">엑셀</button>
	</div>	
	</div>
	<br>
	<div id="gridRscLot" style="border-top: 3px solid #168; height: 600px; width: 1450px; margin-left: 10px;"></div>
	</div>
</div>	

<script type="text/javascript">

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


$( function() {
    $( "#tabs" ).tabs();
  } );
  
  
//////////////////////////////////////////////안전재고조회////////////////////////////////////////////////	

	
	//모달창 설정
	let dialog2 = $( "#dialog-form-rsc" ).dialog({
		autoOpen: false,
		modal: true,
		heigth : 500,
		width : 900,
	});
	
	//모달창 오픈
	$("#btnFindRsc").on("click", function(){
		dialog2.dialog("open");
	$("#dialog-form-rsc").load("recList2",
			function(){console.log("로드됨")})
	});

	//클릭한 값을 input태그에 넣고 모달창 종료
	function clickRsc(rscCode, rscName){
		$("#txtRsc1").val(rscCode);
		$("#txtRsc2").val(rscName);
		dialog2.dialog("close");
	};
	
	//input 태그 초기화 버튼
	$("#btn_reset").on("click", function(){
		$("#txtRsc1").val('');
		$("#txtRsc2").val('');
	})

	//그리드 
	var Grid = tui.Grid;
	
	const columns = [
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
			     header: '안전재고',
				 name: 'rscSfinvc',
				 formatter(value) {
		                return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		            }
				},
				{
				  header: '재고',
				  name: 'rscCnt',
					 formatter(value) {
		                return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		            }
				},
				{
				  header: '미달량',
				  name: 'shortage'
				}
			];
	
	//ajax(api)로 값 받아오는 거 
	let dataSource = {
		  api: {
		    readData: { 
		    	url: 'rscStoreInv', 
		    	method: 'GET'
		    	}
		  },

		  contentType: 'application/json'
		};
	
	const grid = new Grid({
		  el: document.getElementById('gridRsc1'),
		  data: null,
		  columns,
		  pageOptions: {
				useClient: true,
				perPage: 15
			},
			  bodyHeight: 298
		});
	
	//조회버튼 클릭시 값 가지고 오는 거
	$("#btnSelect").on("click", function(){
			var rscCode = $("#txtRsc1").val();
			$.ajax({
				url :'rscStoreInv',
				data: {'rscCode' : rscCode },
				contentType: 'application/json; charset=UTF-8'
			}).done(function(da){
				var datalist = JSON.parse(da);
				console.log(datalist);
				grid.resetData(datalist["data"]["contents"]);
			})
					
		})
		
		grid.on("onGridUpdated", function(ev){
			console.log(ev);
			for(i=0; i<grid.getRowCount(); i++){
				let gr = grid.getValue(i, "rscSfinvc")-grid.getValue(i, "rscCnt")
				console.log(gr);
				grid.setValue(i, "shortage", gr.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
			}
		})
		
//////////////////////////////////////////////자재 LOT별 재고////////////////////////////////////////////////		
	
	//모달창 설정
	let dialogLot = $( "#dialog-form-rsc-Lot" ).dialog({
		autoOpen: false,
		modal: true,
		heigth : 500,
		width : 900,
	});
	
	//모달창 오픈
	$("#btnFindRscLot").on("click", function(){
		dialogLot.dialog("open");
	$("#dialog-form-rsc-Lot").load("recList2",
			function(){console.log("로드됨")})
	});
	
	//클릭한 값을 input태그에 넣고 모달창 종료
	function clickRsc2(rscCode, rscName){
		$("#txtRscLot1").val(rscCode);
		$("#txtRscLot2").val(rscName);
		dialogLot.dialog("close");
	};
	
	//input 태그 초기화 버튼
	$("#btn_reset_Lot").on("click", function(){
		$("#txtRscLot1").val('');
		$("#txtRscLot2").val('');
	})
	
	
	//그리드 
	var Grid = tui.Grid;
	
	const columnsLot = [
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
	
	//ajax(api)로 값 받아오는 거 
	let dataSourceLot = {
		  api: {
		    readData: { 
		    	url: 'resourceStoreInventory', 
		    	method: 'GET'
		    	}
		  },

		  contentType: 'application/json'
		};
	
	const gridRscLot = new Grid({
		  el: document.getElementById('gridRscLot'),
		  data: null,
		  columns : columnsLot,
		  pageOptions: {
				useClient: true,
				perPage: 15
			},
			  bodyHeight: 298
		});
	
	//조회버튼 클릭시 값 가지고 오는 거
	$("#btnSelectLot").on("click", function(){
			var rscCode = $("#txtRscLot1").val();
			
			$.ajax({
				url :'resourceStoreInventory',
				data: {'rscCode' : rscCode },
				contentType: 'application/json; charset=UTF-8'
			}).done(function(da){
				var datalist = JSON.parse(da);
				console.log(datalist);
				gridRscLot.resetData(datalist["data"]["contents"]);
			})
					
		})
		
tui.Grid.applyTheme('default', themesOptions);
</script>
</body>
</html>