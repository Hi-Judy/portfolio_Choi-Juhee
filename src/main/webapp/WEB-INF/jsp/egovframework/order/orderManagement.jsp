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
	<div id="title" style="margin-left : 10px;"><h3 style="color : #054148; font-weight : bold">주문 관리</h3></div>
	<div id="top" style="height : 160px; padding : 10px;">
		<span style="margin : 20px;">진행상태</span>
		<select id="selectStatus" style="margin : 19px;">
			<option value="" selected>선택</option>
			<option value="미진행">미진행</option>
			<option value="진행중">진행중</option>
			<option value="완료">완료</option>
			<option value="미생산출하">미생산출하</option>
		</select>
		<span style="margin : 20px;">업체명</span><input id="txtCusName" style="background-color: #d2e5eb;" readonly>
		<span style="margin : 20px;">업체코드</span><input id="txtCusCode" style="margin-left : 20px;">&nbsp;<button type="button" id="btnSearch" style="border : none; background-color : #f8f8ff; color : #007b88;"><i class="bi bi-search"></i></button>
		<br>	
		<span style="margin : 20px;">접수일자</span>&nbsp;&nbsp;&nbsp;&nbsp;<input id="ordDateStart" type="date"><span> ~ </span><input id="ordDateEnd" type="date" style="margin-right : 60px;">
		<span style="margin : 20px;">납기일자</span>&nbsp;&nbsp;&nbsp;<input id="dueDateStart" type="date"><span> ~ </span><input id="dueDateEnd" type="date">
		<br>
		<button type="button" id="clearBtn" class="btn" style="float : right; margin : 5px;">초기화</button>
		<button type="button" id="releaseBtn" class="btn" style="float : right; margin : 5px;">미생산출하</button>
		<button type="button" id="listBtn" class="btn" style="float : right; margin : 5px;">조회</button>
	</div>
	
	<div id="OverallSize" style="margin-left : 10px;">
	<br>
		<div id="info" style="border-top: 3px solid #168;"></div>
		<br>
		<div><h5 style="color : #007b88;">거래상세정보</h5></div>
		<div id="tradeDetail" title="주문상세정보" align="center">
			<div id="selectInfo" style="border-top: 3px solid #168;"></div>
		</div>
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
		미생산출하 : 체크한 주문에 대해 생산계획 작성없이 바로 출하처리합니다.<br><br>
		초기화 : 입력한 조회 조건을 초기화합니다.	<br><br>
		거래상세정보 : 주문 클릭 시 주문에 대한 상세 정보를 조회합니다.
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
	
	//---------- ↓업체찾기 ----------
	let dialog = $("#findCustomer").dialog({
		autoOpen : false ,
		modal : true ,
		width : 600 ,
		height : 600 ,
		buttons: {
			"닫기" : function() {
				dialog.dialog("close") ;
				grid.clear() ;
				$("#cusName").val("") ;
			}
		}
	})
	
	$("#btnSearch").on("click" , function() {
		dialog.dialog("open") ;
		$.ajax({
			url : 'findCustomerAll' ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data = datas.customerall ;
				grid.resetData(data) ;
				grid.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
		grid.refreshLayout() ;
	})
	
	const columns = [
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
	
	let data ;
	
	$("#btnCusSearch").on("click" , function() {
		var codeName = $("#cusName").val() ;
		
		if (codeName == '') {
			alert('업체명을 입력하세요') ;
			return ;
		}
		
		$.ajax({
			url : 'findCustomer/' + codeName ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data = datas.customer ;
				grid.resetData(data) ;
				grid.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	
	const grid = new Grid({
		el : document.getElementById('cusResult') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		bodyHeight : 300 ,
		data : data ,
		columns : columns ,
 		pageOptions: {
		    useClient: true,
		    perPage: 10
		} 
	})
	
	grid.on('click',(ev) => {
		let cusCode = data[ev.rowKey].cusCode ;
		let cusName = data[ev.rowKey].codeName ;
		$("#txtCusCode").val(cusCode) ;
		$("#txtCusName").val(cusName) ;
		grid.clear() ;
		dialog.dialog("close") ;
		$("#cusName").val("") ;
	})
	//---------- ↑업체찾기 ----------
	//---------- ↓페이지 ----------
	const columns2 = [
		{
			header : '진행상태' ,
			name : 'ordStatus' ,
			align: 'center'
		} ,
		{
			header : '주문코드' ,
			name : 'ordCode' ,
			align: 'center'
		} ,
		{
			header : '업체코드' ,
			name : 'cusCode' ,
			align: 'center'
		} ,
		{
			header : '업체명' ,
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
		}
	] ;
	
	let data2 ;
	
	$('#listBtn').click(function () {
		let cusCode = $("#txtCusCode").val() ;
		let ordStatus = $("#selectStatus").val() ;
		let ordDatestart = $("#ordDateStart").val() ;
		let ordDateend = $("#ordDateEnd").val() ;
		let ordDuedatestart = $("#dueDateStart").val() ;
		let ordDuedateend = $("#dueDateEnd").val() ;
		 
		if (cusCode == '') {
			cusCode = 'null' ;
		}
		
		if (ordStatus == '') {
			ordStatus = 'null' ;
		}
		
		if (ordDatestart == '') {
			ordDatestart='1910-12-25' ;
		}
		
		if (ordDateend == '') {
			ordDateend ='1910-12-25';
		}
		
		if (ordDuedatestart == '') {
			ordDuedatestart = '1910-12-25';
		}
		
		if (ordDuedateend == '') {
			ordDuedateend = '1910-12-25';
		}
		
		$.ajax({
			url : 'orderList' ,
			dataType : 'json' ,
			data : {
				cusCode : cusCode ,
				ordStatus : ordStatus ,
				ordDatestart : ordDatestart ,
				ordDateend : ordDateend ,
				ordDuedatestart : ordDuedatestart ,
				ordDuedateend : ordDuedateend
			} ,
			async : false ,
			success : function(datas) {
				data2 = datas.orderlist ;
				grid2.resetData(data2) ;
				grid2.resetOriginData() ;
				
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		}) 
	})
	
	const grid2 = new Grid ({
		el : document.getElementById('info') ,
		rowHeaders: [
			{ type : 'rowNum' } ,
			{ type : 'checkbox'}
		] ,
		data : data2 ,
		columns : columns2 ,
		bodyHeight : 250 ,
 		pageOptions: {
		    useClient: true,
		    perPage: 10
		} 
	}) ;
	
	$("#clearBtn").on("click" , function() {
		$("#selectStatus").val("") ;
		$("#txtCusCode").val("") ;
		$("#ordDateStart").val("") ;
		$("#ordDateEnd").val("") ;
		$("#dueDateStart").val("") ;
		$("#dueDateEnd").val("") ;
		$("#txtCusName").val("") ;
	})
	
	grid2.on('check' , (ev) => {
		rowCodes[ev.rowKey] = data2[ev.rowKey].ordCode ;
		rowStatus[ev.rowKey] = data2[ev.rowKey].ordStatus ;
	})
	
	grid2.on('uncheck' , (ev) => {
		delete rowCodes[ev.rowKey] ;
		delete rowStatus[ev.rowKey] ;
	})
	
	var rowCodes = new Array() ;
	var rowStatus = new Array() ;
	
	$("#releaseBtn").on("click" , function() {		
		grid2.uncheckAll() ;
		
		let no = 1 ;
		for (let i = 0 ; i < rowStatus.length ; i++) {
			if(rowStatus[i] != null) {
				let ordStatus = rowStatus[i] ;
				if(ordStatus == '완료' || ordStatus == '미생산출하' || ordStatus == ''){
					no = 2 ;
				} else if (ordStatus == '진행중') {
					no = 3 ;
				} 
			} 
		}
		if (no == 2) {
			alert('이미 완료된 주문입니다') ;
			rowCodes = [] ;
			rowStatus = [] ;
			return ;
		}
		if (no == 3) {
			alert('이미 진행중인 주문입니다') ;
			rowCodes = [] ;
			rowStatus = [] ;
			return ;
		}
		
		let ok = 1 ;
		for (let i = 0 ; i < rowCodes.length ; i++) {
			if(rowCodes[i] != null) {
				let ordCode = rowCodes[i] ;
				
				$.ajax({
					url : 'noManRelease' ,
					data : {
						ordCode : ordCode 
					} ,
					dataType : 'json' ,
					async : false ,
					contentType : 'application/json ; charset=utf-8;' ,
					success : function(datas) {
						ok = 2 ;
						
						let cusCode = 'null' ;
						let ordStatus = 'null' ;
						let ordDatestart = '1910-12-25' ;
						let ordDateend = '1910-12-25' ;
						let ordDuedatestart = '1910-12-25' ;
						let ordDuedateend = '1910-12-25' ;
						
						$.ajax({
							url : 'orderList' ,
							dataType : 'json' ,
							data : {
								cusCode : cusCode ,
								ordStatus : ordStatus ,
								ordDatestart : ordDatestart ,
								ordDateend : ordDateend ,
								ordDuedatestart : ordDuedatestart ,
								ordDuedateend : ordDuedateend
							} ,
							async : false ,
							success : function(datas) {
								data2 = datas.orderlist ;
								grid2.resetData(data2) ;
								grid2.resetOriginData() ;
								
							} ,
							error : function(reject) {
								console.log(reject) ;
							}
						})
					} ,
					error : function(reject) {
						console.log(reject) ;
					}
				})
				delete rowCodes[i] ;
				delete rowStatus[i] ;
			}
		}
		if (ok == 2) {
			alert('출하완료되었습니다') ;
		}
	})
	
	//---------- ↑페이지 ----------
	//---------- ↓상세조회 ----------
	const columns3 = [
		{
			header : '번호' ,
			name : 'ordNo' ,
			hidden: true ,
			align: 'center'
		} ,
		{
			header : '주문코드' ,
			name : 'ordCode' ,
			width: 100 ,
			align: 'center'
		} ,
		{
			header : '제품코드' ,
			name : 'podtCode' ,
			align: 'center'
		} ,
		{
			header : '제품명' ,
			name : 'codeName' ,
			width: 200 ,
			align: 'center'
		} ,
		{
			header : '주문량' ,
			name : 'ordQnt' ,
			align: 'center',
			formatter(value) {
				if(value.value != null && value.value != '' ){
					  return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
				}else{
					return value.value ;
				}
            },
		    sortable: true,
		    sortingType: 'desc'
		} ,
		{
			header : '재고량' ,
			name : 'podtQnt' , 
			align: 'center',
			formatter(value) {
				if(value.value != null && value.value != '' ){
					  return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
				}else{
					return value.value ;
				}
            },
		    sortable: true,
		    sortingType: 'desc'
		}
	] ;
	
	let data3 ;

	grid2.on('click' , (ev) => {
		
		if (ev.columnName === '_checked'){
			return ev.stop() ;
		}
		
		let ordCode = data2[ev.rowKey].ordCode ;
		
		$.ajax({
			url : 'orderSelect/' + ordCode ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data3 = datas.orderSelect ;
				grid3.resetData(data3) ;
				grid3.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
		
		//dialog2.dialog("open") ;
		grid3.refreshLayout() ;
	})
	
	const grid3 = new Grid ({
		el : document.getElementById('selectInfo') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		data : data3 ,
		columns : columns3 ,
		bodyHeight : 250 ,
		summary : {
			height : 30 ,
			columnContent : {
				ordQnt: {
					template(summary) {
						return ' 총 주문량 : ' + summary.sum.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + ' 개'
					}
				}
			}
		} ,
 		pageOptions: {
		    useClient: true,
		    perPage: 10
		} 
	}) ;
	
/* 	let dialog2 = $("#tradeDetail").dialog({
		autoOpen : false ,
		modal : true ,
		width : 800 ,
		height : 400 ,
		buttons : {
			"닫기" : function() {
				dialog2.dialog("close") ;
				grid.clear() ;
			}
		}
	}) */
	
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
	//---------- ↑상세조회 ----------
	
	tui.Grid.applyTheme('default', themesOptions);
</script>
</body>
</html>