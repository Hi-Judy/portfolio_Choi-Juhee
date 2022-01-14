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

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
	<div id="title" align="center"><h2>주문 관리</h2></div>
	<div id="info">
		<span>진행상태 : </span>
		<select id="selectStatus">
			<option value="" selected>선택</option>
			<option value="미진행">미진행</option>
			<option value="진행중">진행중</option>
			<option value="취소">취소</option>
			<option value="완료">완료</option>
		</select>
		<span>고객코드 : </span><input id="txtCusCode"><button type="button" id="btnSearch">업체검색</button>
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
	
	<div id="find-dialog-form" title="업체검색"">
		<input id="cusName"><button id="btnCusSearch">업체명검색</button>
		<button type="button" id="btnClose1">닫기</button>
		<div id="cusResult"></div>
	</div>
	
	<div id="selectInfo" title="거래상세정보">
		<button type="button" id="btnClose2">닫기</button>
	</div>
<script>

	var Grid = tui.Grid ;
	
	//---------- ↓업체찾기 ----------
	let dialog = $("#find-dialog-form").dialog({
		autoOpen : false ,
		modal : true ,
		width : 600 ,
		height : 400
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
		height : 300 ,
		data : data ,
		columns : columns
	})
	
	grid.on('click',(ev) => {
		let cusCode = data[ev.rowKey].cusCode ;
		$("#txtCusCode").val(cusCode) ;
		grid.clear() ;
		dialog.dialog("close") ;
	})
	
	$("#btnClose1").on("click" , function() {
		dialog.dialog("close") ;
		grid.clear() ;
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
		} else {
			cusCode = $("#txtCusCode").val() ; 
		}
		
		if (ordStatus == '') {
			ordStatus = 'null' ;
		} else {
			ordStatus = $("#selectStatus").val() ; 
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
		columns : columns2
	}) ;
	
	$("#clearBtn").on("click" , function() {
		$("#selectStatus").val("") ;
		$("#txtCusCode").val("") ;
		$("#ordDateStart").val("") ;
		$("#ordDateEnd").val("") ;
		$("#dueDateStart").val("") ;
		$("#dueDateEnd").val("") ;
		grid2.clear() ;
	})
	//---------- ↑페이지 ----------
	//---------- ↓상세조회 ----------
	const columns3 = [
		{
			header : '번호' ,
			name : 'ordNo' ,
			align: 'center'
		} ,
		{
			header : '주문코드' ,
			name : 'ordCode' ,
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

	grid2.on('dblclick' , (ev) => {
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
		
		dialog2.dialog("open") ;
		grid3.refreshLayout() ;
	})
	
	const grid3 = new Grid ({
		el : document.getElementById('selectInfo') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		data : data3 ,
		columns : columns3
	}) ;
	
	let dialog2 = $("#selectInfo").dialog({
		autoOpen : false ,
		modal : true ,
		width : 600 ,
		height : 400
	})
	
	$("#btnClose2").on("click" , function() {
		dialog2.dialog("close") ;
		grid.clear() ;
	})
	//---------- ↑상세조회 ----------
</script>
</body>
</html>