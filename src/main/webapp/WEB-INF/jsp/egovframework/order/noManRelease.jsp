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
	<div id="title" align="center"><h2>미생산 출하 조회</h2></div>
	<br>
	<div id="info">
		<span>납기일자 : </span><input id="dueDateStart" type="date"><span> ~ </span><input id="dueDateEnd" type="date">
		<br><br>
		<span>업체명 :  </span><input id="txtCusName" readonly>
		<span>고객코드 : </span><input id="txtCusCode"><button type="button" id="btnSearch2">고객코드검색</button>
		<br>
		<div align="right">
			<button type="button" id="listBtn">조회</button>
			<button type="button" id="clearBtn">초기화</button>
		</div>
	</div>
	
	<div id="findCustomer" title="업체검색"">
		<input id="cusName"><button id="btnCusSearch">검색</button>
		<div id="cusResult"></div>
	</div>
	
	<div id="helpDialog" title="도움말" style="text-align: center;">
		
	</div>
<script>
	var Grid = tui.Grid ;
	
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
			align: 'center'
		} ,
		{
			header : '납기일' ,
			name : 'ordDuedate' , 
			align: 'center'
		} , 
		{
			header : '총주문량' ,
			name : 'ordQnt' ,
			align : 'center'
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
		height : 400 ,
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
		height : 300 ,
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
</script>
</body>
</html>