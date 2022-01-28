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
	<div id="help" align="right"><button type="button" id="helpBtn">도움말</button></div>
	<br>
	<div id="title" align="center"><h2>주문 관리</h2></div>
	<br>
	<div id="info">
		<span>진행상태 : </span>
		<select id="selectStatus">
			<option value="" selected>선택</option>
			<option value="미진행">미진행</option>
			<option value="진행중">진행중</option>
			<option value="완료">완료</option>
			<option value="미생산완료">미생산완료</option>
		</select>
		<span>고객명 :  </span><input id="txtCusName" readonly>
		<span>고객코드 : </span><input id="txtCusCode"><button type="button" id="btnSearch">고객코드검색</button>
		<br><br>
		<span>접수일자 : </span><input id="ordDateStart" type="date"><span> ~ </span><input id="ordDateEnd" type="date">
		<span>납기일자 : </span><input id="dueDateStart" type="date"><span> ~ </span><input id="dueDateEnd" type="date">
		<br>
		<div align="right">
			<button type="button" id="listBtn">조회</button>
			<button type="button" id="releaseBtn">미생산출하</button>
			<button type="button" id="clearBtn">초기화</button>
		</div>
	</div>
	
	<div id="findCustomer" title="고객검색"">
		<input id="cusName"><button id="btnCusSearch">검색</button>
		<div id="cusResult"></div>
	</div>
	<br>
	<div align="center"><h5>거래상세정보</h5></div>
	<div id="tradeDetail" title="주문상세정보" align="center">
		<div id="selectInfo"></div>
	</div>
	
	<div id="helpDialog" title="도움말" style="text-align: center;">
		
	</div>
<script>

	var Grid = tui.Grid ;
	
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
			align: 'center'
		} ,
		{
			header : '납기일' ,
			name : 'ordDuedate' , 
			align: 'center'
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
		console.log(rowCodes) ;
		console.log(rowStatus) ;
		
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
			align: 'center'
		} ,
		{
			header : '재고량' ,
			name : 'podtQnt' , 
			align: 'center'
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
						return ' 총 주문량 : ' + summary.sum + ' 개'
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
</script>
</body>
</html>