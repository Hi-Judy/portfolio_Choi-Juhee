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
	<h3>주문정보</h3>
	<div id="info">
		<span>진행상태 : </span>
		<select id="selectStatus">
			<option value="none" selected>선택</option>
			<option value="before">미진행</option>
			<option value="ing">진행중</option>
			<option value="done">완료</option>
		</select>
		<br>
		<span>고객코드 : </span><input id="txtCusCode"><button type="button" id="btnSearch">업체검색</button>
		<br>
		<span>접수일자 : </span><input id="ordDateStart" type="date"><span> ~ </span><input id="ordDateEnd" type="date">
		<br>
		<span>납기일자 : </span><input id="dueDateStart" type="date"><span> ~ </span><input id="dueDateEnd" type="date">
		<br>
		<button type="button" id="listBtn">조회</button>
		<button type="button" id="selectBtn">상세조회</button>
		<button type="button" id="releaseBtn">미생산출하</button>
		<button type="button" id="clearBtn">초기화</button>
	</div>
	
	<div id="find-dialog-form" title="업체검색"">
		<input id="cusName"><button id="btnCusSearch">업체명검색</button>
		<button type="button" id="btnClose1">닫기</button>
		<div id="cusResult"></div>
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
			name: 'cusCode'
		} ,
		{
			header: '업체명' ,
			name: 'codeName'
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
			name : 'ordStatus'	
		} ,
		{
			header : '주문코드' ,
			name : 'ordCode' 
		} ,
		{
			header : '고객코드' ,
			name : 'cusCode'
		} ,
		{
			header : '고객명' ,
			name : 'codeName' 
		} ,
		{
			header : '접수일' ,
			name : 'ordDate'
		} ,
		{
			header : '납기일' ,
			name : 'ordDuedate'
		}
	] ;
	
	let data2 ;
	
	$('#listBtn').click(function () {
		let cusCode = $("#txtCusCode").val() ;
		
		if (cusCode == '') {
			cusCode = 'null' ;
		} else {
			cusCode = $("#txtCusCode").val() ; 
		}
		
		$.ajax({
			url : 'orderList/' + cusCode ,
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
	//---------- ↑페이지 ----------
</script>
</body>
</html>