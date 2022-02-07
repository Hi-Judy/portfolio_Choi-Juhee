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
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />

<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
<h3 style="color : #054148; font-weight : bold">재고조회</h3>
<div id="tabs">
  <ul>
    <li><a href="#tabs-1">안전 재고</a></li>
    <li><a href="#tabs-2">LOT별 재고</a></li>
  </ul>
  
  <div id="tabs-1">	
	<div class="card bg-light text-dark">
		<div class="card-body">
	자재명 <input id="txtRsc2" readonly>  자재코드  <input id="txtRsc1">  <button id="btnFindRsc">돋보기</button><br>
	<div id="dialog-form-rsc" title="자재 검색"></div>
	<br>
	<button id="btnSelect">조회</button>
	<button id="btn_reset" type="reset">초기화</button>
	<button>엑셀</button>
		</div>
	</div>	
	<div id="gridRsc1"></div>
	</div>
	
	<div id="tabs-2">
	<div class="card bg-light text-dark">
		<div class="card-body">
	자재명 <input id="txtRscLot2" readonly>	자재코드  <input id="txtRscLot1">  <button id="btnFindRscLot">돋보기</button><br>
	<div id="dialog-form-rsc-Lot" title="자재 검색"></div>
	<br>
	<button id="btnSelectLot">조회</button>
	<button id="btn_reset_Lot" type="reset">초기화</button>
	<button>엑셀</button>
		</div>
	</div>
	<div id="gridRscLot"></div>
	</div>
</div>	

<script type="text/javascript">

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
	Grid.applyTheme('default');
	
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
			}
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
	Grid.applyTheme('default');
	
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
			}
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

</script>
</body>
</html>