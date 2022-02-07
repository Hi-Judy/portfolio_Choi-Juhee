<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />

<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script> -->
</head>
<body>

	<div style="width : 1500px ;">
		<span style="float: right;">
			<button type="button" id="helpBtn" style="border : none; background-color : #f2f7ff; color : #007b88; float : right ;">
			<i class="bi bi-question-circle"></i>
			</button>
		</span>
		<h4 style="margin-left: 10px">자재반품 조회</h4>
	</div>
	
	<div id="top" style="height: 190px;">
		<div style="margin-top : 15px;  margin-left: 10px;">
			<span> 반품일자  <input id="txtOrde1" type="date" data-role="datebox" data-options='{"mode": "calbox"}'> 
			~ 		<input id="txtOrde2" type="date" data-role="datebox" data-options='{"mode": "calbox"}'><br> </span> 
			<div style="margin-top: 10px;">  업체명 <input id="txtSuc2" class="inpBC" readonly>&nbsp;&nbsp;&nbsp;&nbsp; 업체코드 <input id="txtSuc1">  <button id="btnFindSuc" style="border : none; background-color :#f8f8ff; color : #007b88;"><i class="bi bi-search"></i></button> </div>
			<div style="margin-top: 10px;">  자재명 <input id="txtRsc2" class="inpBC" readonly>&nbsp;&nbsp;&nbsp;&nbsp; 자재코드 <input id="txtRsc1">  <button id="btnFindRsc" style="border : none; background-color :#f8f8ff; color : #007b88;"><i class="bi bi-search"></i></button> </div>
			<div id="dialog-form-rsc" title="자재 검색"></div>
			<div id="dialog-form-suc" title="업체 검색"></div>
			
			<div style="float:right;margin-bottom: 0px;margin-top: 15px;margin-right: 10px;">
				<button id="btnSelect" class="btn">조회</button>
				<button id="btn_reset" type="reset" class="btn">초기화</button>
				<button class="btn">엑셀</button>
			</div>
		</div>
	</div>
	
	<div id="OverallSize" style="margin-left: 10px;">
        <br>
		<div id="grid" style="border-top: 3px solid #168; height: 600px;"></div>
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

	//발주일자 초기값 
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('txtOrde1').value = nd.toISOString().slice(0, 10);
	document.getElementById('txtOrde2').value = d.toISOString().slice(0, 10);
	
	//초기화 버튼
	$("#btn_reset").on("click", function(){
		document.getElementById('txtOrde1').value = nd.toISOString().slice(0, 10);
		document.getElementById('txtOrde2').value = d.toISOString().slice(0, 10);
		$("#txtSuc1").val('');
		$("#txtSuc2").val('');
		$("#txtRsc1").val('');
		$("#txtRsc2").val('');
	})
	
	//모달창(자재조회)
	function clickRsc(rscCode, rscName){
		$("#txtRsc1").val(rscCode);
		$("#txtRsc2").val(rscName);
		dialog1.dialog("close");
	};

	let dialog1 = $( "#dialog-form-rsc" ).dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
		});
	
	$("#btnFindRsc").on("click", function(){
			dialog1.dialog("open");
		$("#dialog-form-rsc").load("recList2",
				function(){console.log("로드됨")})
		});

	//모달창(업체조회)
	function clickSuc(sucCode, sucName){
		
		console.log(sucCode);
		console.log(sucName);
		$("#txtSuc1").val(sucCode);
		$("#txtSuc2").val(sucName);
		dialog2.dialog("close");
	};

	let dialog2 = $("#dialog-form-suc").dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
		});
	
	$("#btnFindSuc").on("click", function(){
			dialog2.dialog("open");
		$("#dialog-form-suc").load("sucList",
				function(){console.log("로드됨")})
		});

	//그리드 
	var Grid = tui.Grid;
	
	const columns = [
				{
		    	header: '반품일자',
		    	name: 'rtngdDate',
		    	sortable: true,
		    	sortingType: 'desc'
		  		},
  				{
		    	header: '반품번호',
		    	name: 'rtngdNo',
		    	sortable: true,
		    	sortingType: 'desc'
		  		},
  				{
			     header: '자재입고검사번호',
			     name: 'rscTstNo',
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
				 header: '반품량',
				 name: 'rtngdCnt',
				 formatter(value) {
		                return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		            }
				},
				{
				 header: '합계',
				 name: 'rscTotal'
				},
				{
				  header: '불량코드',
				  name: 'defCode'
				},
				{
				  header: '불량명',
				  name: 'defName'
				}
			];
			
	//ajax(api)로 값 받아오는 거 
	let dataSource = {
		  api: {
		    readData: { 
		    	url: 'resourcesRtngd', 
		    	method: 'GET'
		    	}
		  },
		  //initialRequest: false,
		  contentType: 'application/json'
		};
	
	const grid = new Grid({
		  el: document.getElementById('grid'),
		  data: null,
		  columns,
		  summary: {
			    position: 'bottom',
			    height: 40, 
			    columnContent: {
			      rtngdCnt: {
			        template(summary) {
			        	console.log(summary);
			        	return '반품량: ' + summary.sum;
			        }
			      }
			    }
			  },
			  pageOptions: {
				    useClient: true,
				    perPage: 15
				}
		});
	
	
	grid.on("onGridUpdated", function(ev){
		for(i=0; i<grid.getRowCount(); i++){
			let gr = grid.getValue(i, "rscPrc")*grid.getValue(i, "rtngdCnt")
			grid.setValue(i, "rscTotal", gr.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
		}
	})
	
	
	grid.on('click' , (ev) => {
		//selection 옵션을 주고 얘들을 세팅해야 클릭했을떄 색상이 바뀌고 색상이 사라지고 한다.
		grid.setSelectionRange({
	    	start: [ev.rowKey, 0],
	    	end: [ev.rowKey, grid.getColumns().length-1]
	    }); 
	    
	})
	
	
	
	
	
	
	//조회버튼 클릭시 값 가지고 오는 거
	$("#btnSelect").on("click", function(){
		console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
			var rscCode = $("#txtRsc1").val();
			var sucCode = $("#txtSuc1").val();
			var ordeDate = $("#txtOrde1").val();
			var ordeDate2 = $("#txtOrde2").val();
			
			$.ajax({
				url :'resourcesRtngd',
				data: {'rscCode' : rscCode, 'sucCode': sucCode, 'ordeDate':ordeDate, 'ordeDate2':ordeDate2 },
				contentType: 'application/json; charset=UTF-8'
			}).done(function(da){
				var datalist = JSON.parse(da);
				console.log(datalist);
				grid.resetData(datalist["data"]["contents"]);
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