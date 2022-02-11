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
	<div id="title" style="margin-left : 10px;"><h3 style="color : #054148; font-weight : bold">미생산 출하 조회</h3></div>
	
	<div id="top" style="height : 160px; padding : 10px;">
		<span style="margin : 20px;">납기일자</span><input id="dueDateStart" type="date" style="margin-top : 10px;"><span> ~ </span><input id="dueDateEnd" type="date">
		<br><br>
		<span style="margin : 20px;">고객명</span><input id="txtCusName" style="margin-left : 15px; background-color: #d2e5eb;" readonly>
		<span style="margin : 20px;">고객코드</span><input id="txtCusCode">&nbsp;<button type="button" id="btnSearch" style="border : none; background-color : #f8f8ff; color : #007b88;"><i class="bi bi-search"></i></button>
		<br>
		<button type="button" id="clearBtn" class="btn" style="float : right; margin : 5px;">초기화</button>
		<button type="button" id="listBtn" class="btn" style="float : right; margin : 5px;">조회</button>
	</div>
	
	<div id="OverallSize" style="margin-left : 10px;">
	<br>
		<div id="info" style="border-top: 3px solid #168;"></div>
	</div>
	
	<div id="findCustomer" title="업체검색"">
		<input id="cusName">&nbsp;<button id="btnCusSearch" class="btn">검색</button>
		<div id="cusResult"></div>
	</div>
	
	<div id="helpDialog" title="도움말">
		<br>
		고객명 : 고객코드를 검색해서 검색결과를 선택하면 자동으로 입력됩니다.<br><br>
		고객코드검색 : 검색어를 포함한 고객명으로 고객코드를 검색합니다.<br><br>
		조회 : 조건 없이 조회하면 전체목록을 조회합니다.<br><br>
		초기화 : 입력한 조회 조건을 초기화합니다.	<br><br>
	</div>
<script>
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
	
	//---------- ↓페이지 ----------
	const columns = [
		{
			header : '주문코드' ,
			name : 'ordCode' ,
			align: 'center'
		} ,
		{
			header : '고객코드' ,
			name : 'cusCode' ,
			align: 'center'
		} ,
		{
			header : '고객명' ,
			name : 'codeName' ,
			align: 'center'
		} ,
		{
			header : '접수일' ,
			name : 'ordDate' ,
			align: 'center',
		    sortable: true,
		    sortingType: 'desc'
		} ,
		{
			header : '납기일' ,
			name : 'ordDuedate' , 
			align: 'center',
		    sortable: true,
		    sortingType: 'desc'
		} , 
		{
			header : '총주문량' ,
			name : 'ordQnt' ,
			align : 'center',
			formatter(value) {
				if(value.value != null && value.value != '' ){
					  return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
				}else{
					return value.value ;
				}
            }
		}
	] ;
	
	let data ;
	
	$("#listBtn").on("click" , function() {
		let cusCode = $("#txtCusCode").val() ;
		let ordDuedatestart = $("#dueDateStart").val() ;
		let ordDuedateend = $("#dueDateEnd").val() ;
		
		if (cusCode == '') {
			cusCode = 'null' ;
		}
		
		if (ordDuedatestart == '') {
			ordDuedatestart = '1910-12-25';
		}
		
		if (ordDuedateend == '') {
			ordDuedateend = '1910-12-25';
		}
		
		$.ajax({
			url : 'noManSelect' ,
			dataType : 'json' ,
			data : {
				cusCode : cusCode ,
				ordDuedatestart : ordDuedatestart ,
				ordDuedateend : ordDuedateend
			} ,
			async : false ,
			success : function(datas) {
				data = datas.nomanlist ;
				grid.resetData(data) ;
				grid.resetOriginData() ;
				
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	
	const grid = new Grid ({
		el : document.getElementById('info') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		data : data ,
		columns : columns ,
		bodyHeight : 430 ,
 		pageOptions: {
		    useClient: true,
		    perPage: 10
		} 
	}) ;
	
	$("#clearBtn").on("click" , function() {
		$("#txtCusCode").val("") ;
		$("#dueDateStart").val("") ;
		$("#dueDateEnd").val("") ;
		$("#txtCusName").val("") ;
	})
	//---------- ↑페이지 ----------
	//---------- ↓업체찾기 ----------
	let dialog2 = $("#findCustomer").dialog({
		autoOpen : false ,
		modal : true ,
		width : 600 ,
		height : 600 ,
		buttons: {
			"닫기" : function() {
				dialog2.dialog("close") ;
				grid3.clear() ;
				$("#cusName").val("") ;
			}
		}
	})
	
	$("#btnSearch2").on("click" , function() {
		dialog2.dialog("open") ;
		$.ajax({
			url : 'findCustomerAll' ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data3 = datas.customerall ;
				grid3.resetData(data3) ;
				grid3.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
		grid3.refreshLayout() ;
	})
	
	const columns3 = [
		{
			header: '업체코드' ,
			name: 'cusCode' , 
			align: 'center'
		} ,
		{
			header: '업체명' ,
			name: 'codeName' ,
			align: 'center'
		}
	] ;
	
	let data3 ;
	
	$("#btnCusSearch").on("click" , function() {
		var codeName = $("#cusName").val() ;
		
		if (codeName == '') {
			alert('고객명을 입력하세요') ;
			return ;
		}
		
		$.ajax({
			url : 'findCustomer/' + codeName ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data3 = datas.customer ;
				grid3.resetData(data3) ;
				grid3.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	
	const grid3 = new Grid({
		el : document.getElementById('cusResult') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		bodyHeight : 300 ,
		data : data3 ,
		columns : columns3 ,
 		pageOptions: {
		    useClient: true,
		    perPage: 10
		} 
	})
	
	grid3.on('click',(ev) => {
		let cusCode = data3[ev.rowKey].cusCode ;
		let cusName = data3[ev.rowKey].codeName ;
		$("#txtCusCode").val(cusCode) ;
		$("#txtCusName").val(cusName) ;
		grid3.clear() ;
		dialog2.dialog("close") ;
		$("#cusName").val("") ;
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
	//---------- ↑업체찾기 ----------
	
	tui.Grid.applyTheme('default', themesOptions);
</script>
</body>
</html>