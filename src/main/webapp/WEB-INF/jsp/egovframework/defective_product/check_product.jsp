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
	<div id="title" style="margin-left : 10px;"><h3 style="color : #054148; font-weight : bold">불량 검사</h3></div>
	
	<div id="top" style="height : 130px; padding : 10px;">
		<p style="display:inline-block; margin : 20px;">작업일자</p>
		<input id = "txtFromDate" type="date" name="from" style="display:inline-block;">
		<p style="display:inline-block;"> ~ </p>
		<input id = "txtToDate" type="date" name="to" style="display:inline-block;">
		<br>
		<button type="button" id="btnClear" class="btn" style="float : right; margin : 5px;">초기화</button>	
		<button type="button" id="btnList" class="btn" style="float : right; margin : 5px;">조회</button>
	</div>

	<div id="OverallSize" style="margin-left : 10px;">
	<br>
		<div id="info" style="border-top: 3px solid #168;"></div>
		<br>
		<div><h5 style="color : #007b88;">불량내역</h5></div>
		<div id = "defD" style="border-top: 3px solid #168;"></div>
	</div>	
	
	<div id="helpDialog" title="도움말">
		<br>
		조회 : 작업일자를 조건으로 발생한 불량정보를 조회합니다.<br><br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작업일자 미 입력시 검사를 진행하지 않은 모든 생산을 조회합니다.<br><br>
		불량내역 : 발생한 불량에 대한 정보를 조회합니다.<br><br>
		초기화 : 입력한 조회 조건을 초기화합니다.<br><br>
	</div>

	<script>
		// 메인그리드
		var Grid = tui.Grid ;
		
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
		
		const columns = [
			{
				header : '지시코드' ,
				name : 'comCode' ,
				align : 'center'
			} ,
			{
				header : '작업일' ,
				name : 'manDate' ,
				align : 'center'
			} ,
			{
				header : '작업완료량' ,
				name : 'manQnt' ,
				align : 'center'
			} ,
			{
				header : '불량량' ,
				name : 'defQnt' ,
				align : 'center'
			} ,
			{
				header : '입고량' ,
				name : 'podtInput' ,
				align : 'center'				
			}
		]
		
		let data ;
		
		$("#btnList").on('click' , function() {
			let fromDate = $("#txtFromDate").val() ;
			let toDate = $("#txtToDate").val() ;
			
			if (fromDate == '') {
				fromDate = '1910-12-25' ;
			}
			
			if (toDate == '') {
				toDate = '1910-12-25' ;
			}
			
			$.ajax({
				url : 'checkProductList' ,
				dataType : 'json' ,
				data : {
					fromDate : fromDate ,
					toDate : toDate
				} ,
				async : false ,
				success : function(datas) {
					data = datas.checklist ;
					grid.resetData(data) ;
					grid.resetOriginData ;
				} ,
				error : function(reject) {
					console.log(reject) ;
				}
			})
		})
		
		const grid = new Grid ({
			el : document.getElementById('info') ,
			rowHeaders : [
				{ type : 'rowNum' }
			] ,
			data : data ,
			columns : columns ,
			bodyHeight : 250 ,
	 		pageOptions: {
			    useClient: true,
			    perPage: 10
			}
		})
		
		// 불량내역
		const columns2 = [
			{
				header : '공정코드' ,
				name : 'procCode' ,
				align : 'center'
			} ,
			{
				header : '공정명' ,
				name : 'procName' ,
				align : 'center'
			} ,
			{
				header : '불량코드' ,
				name : 'defCode' ,
				align : 'center'
			} ,
			{
				header : '불량명' ,
				name : 'defName' ,
				align : 'center'
			} ,
			{
				header : '불량량' ,
				name : 'defQnt' ,
				align : 'center'				
			}
		]
		
		let data2 ;
		
		// 메인그리드 누르면 불량내역 나오게
		grid.on('click' , (ev) => {
			let comCode = data[ev.rowKey].comCode ;
			
			$.ajax({
				url : 'defList' ,
				dataType : 'json' ,
				data : {
					comCode : comCode
				} ,
				async : false ,
				success : function(datas) {
					data2 = datas.deflist ;
					grid2.resetData(data2) ;
					grid2.resetOriginData ;
				} ,
				error : function(reject) {
					console.log(reject) ;
				}
			})
		})
		
		const grid2 = new Grid ({
			el : document.getElementById('defD') ,
			rowHeaders : [
				{ type : 'rowNum' }
			] ,
			data : data2 ,
			columns : columns2 ,
			bodyHeight : 250 ,
	 		pageOptions: {
			    useClient: true,
			    perPage: 10
			}
		})
		
		// 초기화
		$("#btnClear").click(function() {
			$("#txtFromDate").val('') ;
			$("#txtToDate").val('') ;
		})
		
		// 도움말
		let dialog = $("#helpDialog").dialog({
			autoOpen : false ,
			modal : true ,
			width : 600 ,
			height : 400 ,
			buttons: {
				"닫기" : function() {
					dialog.dialog("close") ;
				}
			},
		})
	
		$("#helpBtn").on("mouseover" , function() {
			dialog.dialog("open") ;
		}) ;
		
		tui.Grid.applyTheme('default', themesOptions);
	</script>
</body>
</html>