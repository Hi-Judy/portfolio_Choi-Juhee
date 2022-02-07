<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />

<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
   
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>

<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>

<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
	<div id="help" align="right" style="width : 1500px ;"><button type="button" id="helpBtn" style="border : none; background-color : #f2f7ff; color : #007b88; float : right ;"><i class="bi bi-question-circle"></i></button></div>
	<br>
	<div id="title" style="margin-left : 10px;"><h3 style="color : #054148; font-weight : bold">불량 조회</h3></div>
	
	<div id="top" style="height : 130px; padding : 10px;">
		<div class = "manDate">
			<p style="display:inline-block; margin : 20px;">작업일자</p>
			<input id = "txtFromDate" type="date" name="from" style="display:inline-block;">
			<p style="display:inline-block;"> ~ </p>
			<input id = "txtToDate" type="date" name="to" style="display:inline-block;">&nbsp;<button type="button" id="btnFind" class="btn">검색</button>
			<br>
			<button type="button" id="btnClear" class="btn" style="float : right; margin : 5px;">초기화</button>	
			<button type="button" id="btnFacDate" class="btn" style="float : right; margin : 5px;">월별 불량</button>
			<button type="button" id="btnFacProc" class="btn" style="float : right; margin : 5px;">공정별 불량</button>
		</div>
	</div>

	<div id="OverallSize" style="margin-left : 10px;">
	<br>
		<div id = "gridMain" style="border-top: 3px solid #168;"></div>
		<br>
		<div><h5 style="color : #007b88;">공정목록</h5></div>
		<div id = "process" style="border-top: 3px solid #168;"></div>
	</div>

	<div>
		<!-- 제품코드 모달 -->
		<div id = "dialog-form-defective" title="작업일자별 조회">
			<div align="center"><h5 style="color : #007b88;">작업일자별 불량발생 제품코드</h5></div>
			<div id="gridProductResult"></div>
		</div>
	</div>	
	
	<div id="defChart" title="불량 수량 그래프" style="text-align: center;">
		<div align="center"><h5 id="defTitle" style="color : #007b88;">불량 수량 그래프 조회</h5></div>
		<div id="chart"></div>
	</div>
	
	<div id="helpDialog" title="도움말">
		<br>
		검색 : 작업일자를 조건으로 발생한 불량정보를 조회합니다.<br><br>
		공정별불량 : 공정별로 누적 불량정보 그래프를 조회합니다.<br><br>
		월별불량 : 월별로 누적 불량정보 그래프를 조회합니다.<br><br>
		초기화 : 입력한 조회 조건을 초기화합니다.<br><br>
		공정목록 : 선택한 제품의 공정을 조회합니다.
	</div>

<script>	
		var Grid = tui.Grid; //그리드 객체 생성
		const Chart = toastui.Chart;
		
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
		
		//제품코드찾기 모달 설정해주기
		let dialogProduct = $("#dialog-form-defective").dialog({
			autoOpen: false, 
			modal: true,
			height: 650,
		    width: 900,
			buttons: {
				"닫기" : function(){
					gridProduct.clear() ;
					dialogProduct.dialog("close") ;
				}
			}		    
		});
		
		const el = document.getElementById('chart');
		
		var data = {
		  categories: [],
		  series: [
		    {
		      name: '불량수',
		      data: []
		    }
		  ]
		};
		
		var options = {
		  chart: { width: 600, height: 400 },
		  series : {
			  stack : true ,
		      dataLabels: { visible: true }
		  }
		};
		
		const chart4 = Chart.barChart({ el, data, options });
		
		//공정별 불량 모달
		let dialogDefProc = $("#defChart").dialog({
			autoOpen: false, 
			modal: true,
			height: 600,
		    width: 650,
			buttons: {
				"닫기" : function(){
					dialogDefProc.dialog("close") ;
				}
			}		    
		});
		
		//월별 불량 모달
		let dialogDefDate = $("#defChart").dialog({
			autoOpen: false, 
			modal: true,
			height: 600,
		    width: 650,
			buttons: {
				"닫기" : function(){
					dialogDefDate.dialog("close") ;
				}
			}		    
		});
		
		$("#btnFacProc").on("click" , function() {
			$("#chart").empty() ;
			data.categories = [] ;
			data.series[0].data = [] ;
			dialogDefProc.dialog("open") ;
			$("#defTitle").text('공정별 불량 수량 조회(누적)') ;
			$.ajax({
				url : 'chartData' ,
				dataType : "json" ,
				success : function(datas) {					
					for (let i = 0 ; i < datas.chartData.length ; i++) {
						data.categories.push(datas.chartData[i].procCode) ;
						data.series[0].data.push(Number(datas.chartData[i].defQnt)) ;
					} ;								
					
					const chart2 = Chart.barChart({ el , data , options }) ;
									
				} ,
				error : function(reject) {
					console.log(reject) ;
				}
				
			})
		}) ;
		
		$("#btnFacDate").on("click" , function() {
			$("#chart").empty() ;
			data.categories = [] ;
			data.series[0].data = [] ;
			dialogDefDate.dialog("open") ;
			$("#defTitle").text('월별 불량 수량 조회(현재연도)') ;
			$.ajax({
				url : 'chartData2' ,
				dataType : "json" ,
				success : function(datas) {					
 					for (let i = 0 ; i < datas.chartData2.length ; i++) {
						data.categories.push(datas.chartData2[i].manDate + '월') ;
						data.series[0].data.push(Number(datas.chartData2[i].defQnt)) ;
					} ;	 						
					
					const chart3 = Chart.barChart({ el , data , options }) ;
									
				} ,
				error : function(reject) {
					console.log(reject) ;
				}
				
			})
		}) ;
		
		//제품코드찾기 모달 컬럼
		const columnsProduct = [
			{
				header: '작업일자',
				name: 'manDate',
			    sortable: true,
			    sortingType: 'desc'
			},
			{
				header: '공정코드',
				name : 'procCode'
			} ,
			{
				header : '공정명',
				name : 'procName'
			} ,
			{
				header: '제품코드',
				name: 'podtCode'
			},
			{
				header: '제품명',
				name: 'podtName'
			}
		]

		//메인화면 컬럼
		let columnsMain = [
			{
				header:'불량번호',
				name: 'defNo',
				hidden: true
			},
			{
				header:'불량코드',
				name:'defCode'
			},
			{
				header:'불량명',
				name: 'defName'
			},
			{
				header:'제품코드',
				name: 'podtCode'
			},
			{
				header:'제품명',
				name: 'podtName'
			},
			{
				header:'공정코드',
				name: 'procCode'
			},
			{
				header: '공정명',
				name: 'procName'
			},
			{
				header:'작업일',
				name: 'manDate',
			    sortable: true,
			    sortingType: 'desc'
			},
			{
				header:'불량량',
				name: 'defQnt',
				formatter(value) {
					return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") ;
				},
			    sortable: true,
			    sortingType: 'desc'
			}
		]
		
		//공정 컬럼
		const columnsProcess = [
			{
				header: '공정코드',
				name: 'procCode'
			},
			{
				header: '공정명',
				name : 'procName'
			} 
		]
		
 		//제품코드찾기 조회 그리드
		const dataSourceProduct = {
				api: {
					readData: {url: '.', 
							   method: 'GET'}
				},
				contentType: "application/json"
		}; 
		
		//메인그리드 데이터
		let data4 ; 
		
		//공정그리드 데이터
		let data3 ; 
		
 		//제품코드찾기 그리드 내용. 
		let gridProduct = new Grid({
			el: document.getElementById('gridProductResult'),
			rowHeaders: [
				{ type : 'rowNum' }
			] ,
			bodyHeight : 300 ,
			data: dataSourceProduct,
			columns: columnsProduct ,
	 		pageOptions: {
			    useClient: true,
			    perPage: 5
			} 
		}) 
 		
		//메인 그리드
		var gridMain = new Grid({
			el : document.getElementById('gridMain'),
			data : data4,
			columns : columnsMain,
			bodyHeight : 250 ,
			rowHeaders : ['rowNum'] ,
	 		pageOptions: {
			    useClient: true,
			    perPage: 5
			} 
		});
 		
		//공정 그리드
		var gridProcess = new Grid({
			el : document.getElementById('process'),
			data : data3,
			columns : columnsProcess,
			bodyHeight : 250 ,
			rowHeaders : ['rowNum'] ,
	 		pageOptions: {
			    useClient: true,
			    perPage: 5
			} 
		});
 		
 		let data2 ;
 		
 		//작업일자별 제품조회
		$("#btnFind").on("click" , function() {
			dialogProduct.dialog("open") ;
			
			let from = $("#txtFromDate").val() ;
			let to = $("#txtToDate").val() ;
			
			if (from == '') {
				from = 'null' ;
			}
			if (to == '') {
				to = 'null' ;
			}
			
			$.ajax({
				url : '${pageContext.request.contextPath}/defective/findProduct' ,
				method : 'post' ,
				data : { 'fromDate' : from , 'toDate' : to },
				dataType : "json" ,
				success : function(datas) {
					data2 = datas ;
					
					gridProduct.resetData(data2.result) ;
					gridProduct.resetOriginData() ;
					gridProduct.refreshLayout() ;
				} ,
				error : function(reject) {
					console.log(reject) ;
				}
			})
		})
		
		//작업일자별 제품조회에서 클릭된 정보를 메인그리드로 가지고옴
		gridProduct.on('click' , (ev) => {			
			gridMain.clear() ;
			
			let podtCode = data2.result[ev.rowKey].podtCode ;
			let manDate = data2.result[ev.rowKey].manDate ;
			
			$.ajax({
				url : '${pageContext.request.contextPath}/defective/main' ,
				method : 'post' ,
				data : { 'podtCode' : podtCode , "manDate" : manDate } ,
				dataType : "json" ,
				success : function(datas) {
					data4 = datas ;
					
					gridMain.resetData(data4.result) ;
					gridMain.resetOriginData() ;
					gridMain.refreshLayout() ;
				} ,
				error : function(reject) {
					console.log(reject) ;
				}
			})
			
			$.ajax({
				url : '${pageContext.request.contextPath}/defective/selectProcess' ,
				method : 'post' ,
				data : { 'podtCode' : podtCode } ,
				dataType : "json" ,
				success : function(datas) {
					data3 = datas ;
					
					gridProcess.resetData(data3.result) ;
					gridProcess.resetOriginData() ;
					gridProcess.refreshLayout() ;
				} ,
				error : function(reject) {
					console.log(reject) ;
				}
			})
			
			gridProduct.clear() ;
			dialogProduct.dialog("close") ;			
		})
		
		//초기화 버튼
		$("#btnClear").on("click" , function() {
			$("#txtFromDate").val("") ;
			$("#txtToDate").val("") ;
		})
		
		let dialog3 = $("#helpDialog").dialog({
			autoOpen : false ,
			modal : true ,
			width : 600 ,
			height : 400 ,
			buttons: {
				"닫기" : function() {
					dialog3.dialog("close") ;
				}
			},
		})
		
		$("#helpBtn").on("mouseover" , function() {
			dialog3.dialog("open") ;
		}) ;
 		
		tui.Grid.applyTheme('default', themesOptions);
	</script>
</body>
</html>