<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" /> -->
<!-- <link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" /> -->
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css"> -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"> -->
<!-- <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" /> -->

<!-- <script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script> -->
<!-- <script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script> -->
<!-- <script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script> -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->
<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script> -->
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
		<h4 style="margin-left: 10px; margin-bottom: 25px;">자재 입/출고 조회</h4>
	</div>


<div id="tabs" style="margin-left: 10px; width : 1500px ; height: 600px;">
  <ul>
    <li><a href="#tabs-1">입고</a></li>
    <li><a href="#tabs-2">출고</a></li>
  </ul>
  
  <div id="tabs-1" style="margin-left:10px; padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">
	<div id="top" style="width: 1450px; height:170px;">
		<div style="margin-top : 5px;  margin-left: 8px;">
	입고일자  <input id="txtStoreIn1" type="date" data-role="datebox" data-options='{"mode": "calbox"}'>
	~ 		<input id="txtStoreIn2" type="date" data-role="datebox" data-options='{"mode": "calbox"}'><br>
	업체명 <input id="txtStoreInSuc2" class="inpBC" readonly>		업체코드  <input id="txtStoreInSuc1">  <button id="btnStoreInSuc"  style="border : none; background-color :#f8f8ff; color : #007b88;" ><i class="bi bi-search"></i></button>&nbsp;&nbsp;&nbsp; <br>
	자재명 <input id="txtStoreInRsc2" class="inpBC" readonly>		자재코드  <input id="txtStoreInRsc1">  <button id="btnStoreInRsc" style="border : none; background-color :#f8f8ff; color : #007b88;" ><i class="bi bi-search"></i></button>&nbsp;&nbsp;&nbsp;
	<div id="dialog-form-in-rsc" title="자재 검색"></div>
	<div id="dialog-form-in-suc" title="업체 검색"></div>
	</div>	
	<div  style="float:right;margin-bottom: 0px;margin-top: 7px;margin-right: 10px;">
	<button id="btnStoreInSelect"  class="btn">조회</button>
	<button id="btnStoreInreset" type="reset" class="btn">초기화</button>
	<button  class="btn">엑셀</button>
		</div>
		</div>
		<br>
	<div id="gridStoreIn" style="border-top: 3px solid #168; height: 600px; width: 1450px; margin-left: 10px;"></div>
  
  </div>
  
	<div id="tabs-2" style="margin-left:10px; padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">
		<div id="top" style="width: 1450px; height:170px;">
			<div style="margin-top : 5px;  margin-left: 8px;">
	출고일자  <input id="txtStoreOut1" type="date" data-role="datebox" data-options='{"mode": "calbox"}'>
	~ 		<input id="txtStoreOut2" type="date" data-role="datebox" data-options='{"mode": "calbox"}'><br>
	업체명 <input id="txtStoreOutSuc2" class="inpBC" readonly>	업체코드  <input id="txtStoreOutSuc1">  <button id="btnStoreOutSuc" style="border : none; background-color :#f8f8ff; color : #007b88;" ><i class="bi bi-search"></i></button>&nbsp;&nbsp;&nbsp; <br>
	자재명 <input id="txtStoreOutRsc2" class="inpBC" readonly>	자재코드  <input id="txtStoreOutRsc1">  <button id="btnStoreOutRsc" style="border : none; background-color :#f8f8ff; color : #007b88;" ><i class="bi bi-search"></i></button>&nbsp;&nbsp;&nbsp;
	<div id="dialog-form-Out-rsc" title="자재 검색"></div>
	<div id="dialog-form-Out-suc" title="업체 검색"></div>
	</div>
	<div  style="float:right;margin-bottom: 0px;margin-top: 7px;margin-right: 10px;">
	<button id="btnStoreOutSelect" class="btn">조회</button>
	<button id="btnStoreOutreset" type="reset" class="btn">초기화</button>
	<button class="btn">엑셀</button>
		</div>
		</div>
		<br>	
	<div id="gridStoreOut" style="border-top: 3px solid #168; height: 600px; width: 1450px; margin-left: 10px;"></div>
	</div>
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

$(function() {
    $( "#tabs" ).tabs();
  });


//////////////////////////////////////////////입고////////////////////////////////////////////////		

	//입고일자 초기값 
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('txtStoreIn1').value = nd.toISOString().slice(0, 10);
	document.getElementById('txtStoreIn2').value = d.toISOString().slice(0, 10);
	
	//초기화 버튼
	$("#btnStoreInreset").on("click", function(){
		document.getElementById('txtStoreIn1').value = nd.toISOString().slice(0, 10);
		document.getElementById('txtStoreIn2').value = d.toISOString().slice(0, 10);
		$("#txtStoreInSuc1").val('');
		$("#txtStoreInSuc2").val('');
		$("#txtStoreInRsc1").val('');
		$("#txtStoreInRsc2").val('');
	})
	
	
	//모달창(자재조회)
	function clickRsc(rscCode, rscName){
		$("#txtStoreInRsc1").val(rscCode);
		$("#txtStoreInRsc2").val(rscName);
		dialogInRsc.dialog("close");
	};

	let dialogInRsc = $("#dialog-form-in-rsc").dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
		});
	
	$("#btnStoreInRsc").on("click", function(){
		dialogInRsc.dialog("open");
		$("#dialog-form-in-rsc").load("recList2",
				function(){console.log("로드됨")})
		});

	//모달창(업체조회)
	function clickSuc(sucCode, sucName){
		console.log(sucCode);
		console.log(sucName);
		$("#txtStoreInSuc1").val(sucCode);
		$("#txtStoreInSuc2").val(sucName);
		dialogInSuc.dialog("close");
	};

	let dialogInSuc = $("#dialog-form-in-rsc").dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
		});
	
	$("#btnStoreInSuc").on("click", function(){
		dialogInSuc.dialog("open");
		$("#dialog-form-in-rsc").load("sucList",
				function(){console.log("로드됨")})
		});
	
	//그리드 
	var Grid = tui.Grid;
	
	const columnsStoreIn = [
		  		{
			    header: '입고일자',
			    name: 'storeDate',
			    sortable: true,
			    sortingType: 'desc'
			  },
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
				header: '단가',
				name: 'rscPrc',
				 formatter(value) {
	                return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	            }
				},
			   {
				 header: '업체',
				 name: 'sucName'
				},
			   {
				 header: '입고량',
				 name: 'istCnt'
				},
				{
				  header: '자재 LOT NO',
				  name: 'rscLot',
				  sortable: true,
				  sortingType: 'desc'
				}
			];
			
	//ajax(api)로 값 받아오는 거 
	let dataSourceStoreIn = {
		  api: {
		    readData: { 
		    	url: 'resourceStoreInList', 
		    	method: 'GET'
		    	}
		  },
		  contentType: 'application/json'
		};
	
	const gridStoreIn = new Grid({
		  el: document.getElementById('gridStoreIn'),
		  data: null,
		  columns: columnsStoreIn,
		  summary: {
			    position: 'bottom',
			    height: 40, 
			    columnContent: {
			    	istCnt: {
			        template(summary) {
			        	console.log(summary);
			        	return '입고량: ' + (summary.sum*1).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			        }
			      }
			    }
			  },
		 		pageOptions: {
				    useClient: true,
				    perPage: 15
				} 
		});
	
	//조회버튼 클릭시 값 가지고 오는 거
	$("#btnStoreInSelect").on("click", function(){
			var rscCode = $("#txtStoreInRsc1").val();
			var sucCode = $("#txtStoreInSuc1").val();
			var storeDate = $("#txtStoreIn1").val();
			var storeDate2 = $("#txtStoreIn2").val();

			
			$.ajax({
				url :'resourceStoreInList',
				data: {'rscCode' : rscCode, 'sucCode': sucCode, 'storeDate':storeDate, 'storeDate2':storeDate2 },
				contentType: 'application/json; charset=UTF-8'
			}).done(function(da){
				var datalist = JSON.parse(da);
				gridStoreIn.resetData(datalist["data"]["contents"]);
			})
					
		})
		
//////////////////////////////////////////////출고////////////////////////////////////////////////
	
	//출고일자 초기값 
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('txtStoreOut1').value = nd.toISOString().slice(0, 10);
	document.getElementById('txtStoreOut2').value = d.toISOString().slice(0, 10);
	
	//초기화 버튼
	$("#btnStoreOutreset").on("click", function(){
		document.getElementById('txtStoreOut1').value = nd.toISOString().slice(0, 10);
		document.getElementById('txtStoreOut2').value = d.toISOString().slice(0, 10);
		$("#txtStoreOutSuc1").val('');
		$("#txtStoreOutSuc2").val('');
		$("#txtStoreOutRsc1").val('');
		$("#txtStoreOutRsc2").val('');
	})
	
	
	//모달창(자재조회)
	function clickRsc(rscCode, rscName){
		$("#txtStoreOutRsc1").val(rscCode);
		$("#txtStoreOutRsc2").val(rscName);
		dialogOutRsc.dialog("close");
	};

	let dialogOutRsc = $("#dialog-form-Out-rsc").dialog({
			autoOpen: false,
			modal: true
		});
	
	$("#btnStoreOutRsc").on("click", function(){
		dialogOutRsc.dialog("open");
		$("#dialog-form-Out-rsc").load("recList2",
				function(){
					console.log("로드됨")
				})
		});

	//모달창(업체조회)
	function clickSuc(sucCode, sucName){
		$("#txtStoreOutSuc1").val(sucCode);
		$("#txtStoreOutSuc2").val(sucName);
		dialogOutSuc.dialog("close");
	};

	let dialogOutSuc = $("#dialog-form-Out-rsc").dialog({
			autoOpen: false,
			modal: true
		});
	
	$("#btnStoreOutSuc").on("click", function(){
		dialogOutSuc.dialog("open");
		$("#dialog-form-Out-suc").load("sucList",
				function(){
					console.log("로드됨")
				})
		});
	
	//그리드 
	var Grid = tui.Grid;
	
	const columnsStoreOut = [
		  		{
			    header: '출고일자',
			    name: 'storeDate',
			    sortable: true,
			    sortingType: 'desc'
			  },
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
				header: '단가',
				name: 'rscPrc'
				},
			   {
				 header: '업체',
				 name: 'sucName'
				},
			   {
				 header: '출고량',
				 name: 'ostCnt'
				},
				{
				  header: '자재 LOT NO',
				  name: 'rscLot',
				  sortable: true,
				  sortingType: 'desc'
				},
				{
				  header: '생산지시번호',
				  name: 'storeEtc',
				  sortable: true,
				  sortingType: 'desc'
				}
			];
			
	//ajax(api)로 값 받아오는 거 
	let dataSourceStoreOut = {
		  api: {
		    readData: { 
		    	url: 'resourceStoreOutList', 
		    	method: 'GET'
		    	}
		  },
		  contentType: 'application/json'
		};
	
	const gridStoreOut = new Grid({
		  el: document.getElementById('gridStoreOut'),
		  data: null,
		  columns: columnsStoreOut,
		  summary: {
			    position: 'bottom',
			    height: 40, 
			    columnContent: {
			    	ostCnt: {
			        template(summary) {
			        	console.log(summary);
			        	return '출고량: ' + (summary.sum*1).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			        }
			      }
			    }
			  },
	 		pageOptions: {
			    useClient: true,
			    perPage: 15
			} 
		});
	
	//조회버튼 클릭시 값 가지고 오는 거
	$("#btnStoreOutSelect").on("click", function(){
			var rscCode = $("#txtStoreOutRsc1").val();
			var sucCode = $("#txtStoreOutSuc1").val();
			var storeDate = $("#txtStoreOut1").val();
			var storeDate2 = $("#txtStoreOut2").val();

			
			$.ajax({
				url :'resourceStoreOutList',
				data: {'rscCode' : rscCode, 'sucCode': sucCode, 'storeDate':storeDate, 'storeDate2':storeDate2 },
				contentType: 'application/json; charset=UTF-8'
			}).done(function(da){
				var datalist = JSON.parse(da);
				console.log(datalist["data"]["contents"])
				gridStoreOut.resetData(datalist["data"]["contents"]);
			})
					
		})
		
//------------------ 도움말 버튼 이벤트 -----------------------
helpBtn.addEventListener('mouseover' , () => {
	helpModal.dialog("open") ;
})		
	
tui.Grid.applyTheme('default', themesOptions);	
	
</script>
</body>
</html>