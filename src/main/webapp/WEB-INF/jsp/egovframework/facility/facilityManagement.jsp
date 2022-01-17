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
	<div id="title" align="center"><h2>설비 관리</h2></div>
	<br>
	<div id="info">
		<span>설비코드 : </span><input id="txtfacCode"><button type="button" id="btnSearch">설비코드검색</button>
		<br>
		<span>설비상태 : </span>
		<select id="selectStatus">
			<option value="" selected>선택</option>
			<option value="가동">가동</option>
			<option value="비가동">비가동</option>
		</select>
		<br>
		<span>점검일자 : </span><input id="checkDateStart" type="date"><span> ~ </span><input id="checkDateEnd" type="date">
		<br>
		<div align="right">
			<button type="button" id="listBtn">조회</button>
			<button type="button" id="btnInsert">저장</button>
			<button type="button" id="clearBtn">초기화</button>
		</div>
	</div>
	
	<div id="findFacility" title="설비검색">
		<input id="facName"><button id="btnfacSearch">검색</button>
		<button type="button" id="btnClose1">닫기</button>
		<div id="facResult"></div>
	</div>
	
	<div id="selectFacility" title="비가동내역" align="center">
		<div id="selectInfo"></div>
		<button type="button" id="btnClose2">닫기</button>
	</div>	
<script>

	var Grid = tui.Grid ;
	
	//---------- ↓페이지 ----------
	const columns = [
		{
			header : '설비번호' ,
			name : 'facNo' ,
			hidden : true
		} ,
		{
			header : '설비코드' ,
			name : 'facCode' ,
			align: 'center'
		} ,
		{
			header : '설비명' ,
			name : 'codeName' ,
			align: 'center'
		} ,
		{
			header : '상태' ,
			name : 'facStatus' ,
			editor : {
				type : 'select' ,
				options : {
					listItems : [
						{ text : 'Y' , value : 'Y' } ,
						{ text : 'N' , value : 'N' } 	
					]
				}
			} ,
			align: 'center'
		} ,
		{
			header : '비가동사유' ,
			name : 'facCause' ,
			editor : 'text' ,
			align: 'center'
		} ,
		{
			header : '점검일자' ,
			name : 'facCheckdate' ,
			editor: 'datePicker' ,
			align: 'center'
		} ,
		{
			header : 'UPH' ,
			name : 'facOutput' , 
			align: 'center'
		}
	] ;
	
	let data ;
	
	$("#listBtn").click(function () {
		let facCode = $("#txtfacCode").val() ;
		let facStatus = $("#selectStatus").val() ;
		let checkDatestart = $("#checkDateStart").val() ;
		let checkDateend = $("#checkDateEnd").val() ;
		
		if (facCode == '') {
			facCode = 'null' ;
		}
		
		if (facStatus == '') {
			facStatus = 'null' ;
		}
		
		if (checkDatestart == '') {
			checkDatestart = '1910-12-25' ;
		}
		
		if (checkDateend == '') {
			checkDateend = '1910-12-25' ;
		}
		
		$.ajax({
			url : 'facilityList' ,
			dataType : 'json' ,
			data : {
				facCode : facCode ,
				facStatus : facStatus ,
				checkDatestart : checkDatestart ,
				checkDateend : checkDateend
			} ,
			async : false ,
			success : function(datas) {
				data = datas.facilitylist ;
				grid.resetData(data) ;
				grid.resetOriginData() ;
				
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	
	const grid = new Grid({
		el : document.getElementById('info') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		height : 300 ,
		data : data ,
		columns : columns
	})
	
	$("#clearBtn").on("click" , function() {
		$("#txtfacCode").val("") ;
		$("#selectStatus").val("") ;
		$("#checkDateStart").val("") ;
		$("#checkDateEnd").val("") ;
		grid.clear() ;
	})
	//---------- ↑페이지 ----------
	//---------- ↓설비찾기 ----------
	let dialog = $("#findFacility").dialog({
		autoOpen : false ,
		modal : true ,
		width : 600 ,
		height : 400
	})
	
	$("#btnSearch").on("click" , function() {
		dialog.dialog("open") ;
		grid2.refreshLayout() ;
	})
	
	const columns2 = [
		{
			header: '설비코드' ,
			name: 'facCode' , 
			align: 'center'
		} ,
		{
			header: '설비명' ,
			name: 'codeName' ,
			align: 'center'
		}
	] ;
	
	let data2 ;
	
	$("#btnfacSearch").on("click" , function() {
		var codeName = $("#facName").val() ;
		
		if (codeName == '') {
			alert('업체명을 입력하세요') ;
			return ;
		}
		
		$.ajax({
			url : 'findFacility/' + codeName ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data2 = datas.findfacility ;
				grid2.resetData(data2) ;
				grid2.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	
	const grid2 = new Grid({
		el : document.getElementById('facResult') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		height : 300 ,
		data : data2 ,
		columns : columns2
	})
	
	grid2.on('click',(ev) => {
		let facCode = data2[ev.rowKey].facCode ;
		$("#txtfacCode").val(facCode) ;
		grid2.clear() ;
		dialog.dialog("close") ;
		$("#facName").val("") ;
	})
	
	$("#btnClose1").on("click" , function() {
		dialog.dialog("close") ;
		grid2.clear() ;
		$("#facName").val("") ;
	})
	//---------- ↑설비찾기 ----------
	//---------- ↓상세정보 ----------
	grid.on('click' , (ev) => {
		
		if ( ev.columnName === 'facStatus' || ev.columnName === 'facCause' || ev.columnName === 'facCheckdate' ) {
			return ev.stop() ;
		}
		
		let facNo = data[ev.rowKey].facNo ;
		
		$.ajax({
			url : 'facilitybreakinfo/' + facNo ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data3 = datas.facilitybreakinfo ;
				grid3.resetData(data3) ;
				grid3.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		}) ;
		
		let dialog2 = $("#selectFacility").dialog({
			autoOpen : false ,
			modal : true ,
			width : 600 ,
			height : 400
		}) ;
		
		const columns3 = [
			{
				header: '설비코드' ,
				name: 'facCode' , 
				align: 'center'
			} ,
			{
				header: '설비명' ,
				name: 'codeName' ,
				align: 'center'
			}
		] ;
		
		let data3 ;
		
		const grid3 = new Grid({
			el : document.getElementById('facResult') ,
			rowHeaders: [
				{ type : 'rowNum' }
			] ,
			height : 300 ,
			data : data3 ,
			columns : columns3
		})
		
		$("#btnClose1").on("click" , function() {
			dialog2.dialog("close") ;
			grid3.clear() ;
			$("#facName").val("") ;
		}) ;
	})
	//---------- ↑상세정보 ----------
</script>
</body>
</html>