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
			<button type="button" id="addBtn">추가</button>
			<button type="button" id="btnInsert">저장</button>
			<button type="button" id="deleteBtn">삭제</button>
			<button type="button" id="clearBtn">초기화</button>
		</div>
	</div>
	
	<div id="findFacility" title="설비검색">
		<input id="facName"><button id="btnfacSearch">검색</button>
		<div id="facResult"></div>
	</div>
	
	<div id="selectFacility" title="비가동내역" align="center">
		<div id="selectInfo"></div>
	</div>	
<script>

	var Grid = tui.Grid ;
	
	//---------- ↓페이지 ----------
	let facList = [] ;
	
	const columns = [
		{
			header : '설비번호' ,
			name : 'facNo' ,
			align: 'center'
		} ,
		{
			header : '설비코드' ,
			name : 'facCode' ,
			editor : {
				type: 'select' ,
				options: {
					listItems : facList
				}
			} ,
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
			editor: {
				type : 'datePicker' ,
				options : {
					format : 'yyyy-MM-dd'
				}
			} ,
			align: 'center'
		} ,
		{
			header : 'UPH' ,
			name : 'facOutput' , 
			editor : 'text' ,
			align: 'center'
		} ,
		{
			header : '가동시간' ,
			name : 'facRuntime' ,
			editor : 'text' ,
			align : 'center'
		}
	] ;
	
	let data ;
	
	$.ajax({
		url : 'selectFacOptions' ,
		dataType : 'json' ,
		async : false ,
		success : function(datas) {
			for (let i = 0 ; i < datas.selectfacoptions.length ; i++) {
				let option = { text : datas.selectfacoptions[i].code , value : datas.selectfacoptions[i].code } ;
				facList.push(option) ;
			}
		} , 
		error : function(reject) {
			console.log(reject) ;
		}
	})
	
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
			{ type : 'rowNum' } ,
			{ type : 'checkbox' }
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
	
	grid.on('editingStart' , (ev) => {
		let value = grid.getValue(ev.rowKey , ev.columnName) ;
		
		if ( ( ev.columnName == 'facCode' || ev.columnName == 'facOutput' || ev.columnName == 'facRuntime' ) && value != '' && value != null ){
			return ev.stop() ;
		}
	})
	
	$("#addBtn").on("click" , function() {
		let data = { facStatus : 'Y' }
		grid.appendRow(data) ;
	})
	
	$("#btnInsert").on("click" , function() {
		let modified = grid.getModifiedRows() ;
		let updated = modified.updatedRows ;
		
		let modified2 = grid.getModifiedRows() ;
		let inserted = modified2.createdRows ;
		
		if ( updated != '' ){
			let ok = 1 ;
			for (let i = 0 ; i < updated.length ; i++) {
				
				let no = updated[i].facNo ;
				let status = updated[i].facStatus ;
				let cause = updated[i].facCause ;
				let checkdate = updated[i].facCheckdate ;
				
	 			$.ajax({
					url : 'facilityStatusUpdate' ,
					async : false ,
					data : {
						facNo : no ,
						facStatus : status ,
						facCause : cause ,
						facCheckdate : checkdate
					} ,
					success : function(datas) {
						ok = 2 ;
						
						let facCode = 'null' ;
						let facStatus = 'null' ;
						let checkDatestart = '1910-12-25' ;
						let checkDateend = '1910-12-25' ;
						
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
					} ,
					error : function(reject) {
						console.log(reject) ;
					}
				}) 
			}  
			if (ok == 2) {
				alert('수정완료되었습니다') ;
			}
		}
		
		if ( inserted != '' ) {
			let ok = 1 ;
			for (let i = 0 ; i < inserted.length ; i++) {
				
				let facStatus = inserted[i].facStatus ;				
				let facCode = inserted[i].facCode ;
				let facOutput = inserted[i].facOutput ;
				let facRuntime = inserted[i].facRuntime ;
				
	 			$.ajax({
					url : 'insertFacility' ,
					async : false ,
					data : {
						facCode : facCode ,
						facStatus : facStatus ,
						facOutput : facOutput ,
						facRuntime : facRuntime
					} ,
					success : function(datas) {
						ok = 2 ;
						
						let facCode = 'null' ;
						let facStatus = 'null' ;
						let checkDatestart = '1910-12-25' ;
						let checkDateend = '1910-12-25' ;
						
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
					} ,
					error : function(reject) {
						console.log(reject) ;
					}
				}) 
			}  
			if (ok == 2) {
				alert('등록완료되었습니다') ;
			}
		}
	})
	
	var rowNo = new Array() ;
	
	grid.on('check' , (ev) => {
		rowNo[ev.rowKey] = grid.getValue([ev.rowKey],"facNo") ;
	})
	
	grid.on('uncheck' , (ev) => {
		delete rowNo[ev.rowKey] ;
	})
	
	$("#deleteBtn").on("click" , function() {
		let ok = 1 ;
		for (let i = 0 ; i < rowNo.length ; i++) {
			if(rowNo[i] != null) {
				let facNo = rowNo[i] ;
				
				$.ajax({
					url : 'deleteFacility/' + facNo ,
					async : false ,
					success : function(datas) {
						ok = 2 ;
						
						let facCode = 'null' ;
						let facStatus = 'null' ;
						let checkDatestart = '1910-12-25' ;
						let checkDateend = '1910-12-25' ;
						
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
					} ,
					error : function(reject) {
						console.log(reject) ;
					}
				})
				delete rowNo[i] ;
			}
		}
		if (ok == 2) {
			alert('삭제완료되었습니다') ;
		}
	})
	
	//---------- ↑페이지 ----------
	//---------- ↓설비찾기 ----------
	let dialog = $("#findFacility").dialog({
		autoOpen : false ,
		modal : true ,
		width : 600 ,
		height : 400 ,
		buttons : {
			"닫기" : function() {
				dialog.dialog("close") ;
				grid2.clear() ;
				$("#facName").val("") ;
			}
		}
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
	//---------- ↑설비찾기 ----------
	//---------- ↓상세정보 ----------	
	let dialog2 = $("#selectFacility").dialog({
		autoOpen : false ,
		modal : true ,
		width : 600 ,
		height : 400 ,
		buttons : {
			"닫기" : function() {
				dialog2.dialog("close") ;
			}
		}
	}) ;
	
	const columns3 = [
		{
			header: '번호' ,
			name: 'facInfono' , 
			hidden : true
		} ,
		{
			header: '설비번호' ,
			name: 'facNo' ,
			align: 'center'
		} ,
		{
			header: '비가동사유' ,
			name: 'facCause' ,
			align: 'center'
		} ,
		{
			header: '고장발생일자' ,
			name: 'facCausedate' ,
			align: 'center'
		}
	] ;
	
	let data3 ;
	
	const grid3 = new Grid({
		el : document.getElementById('selectInfo') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		height : 300 ,
		data : data3 ,
		columns : columns3
	})
	
	grid.on('click' , (ev) => {
		
		let value = grid.getValue(ev.rowKey,ev.columnName) ;
		
		if ( ev.columnName === 'facCode' || ev.columnName === 'facStatus' || ev.columnName === 'facCause' || ev.columnName === 'facCheckdate' || ev.columnName === 'facOutput' || ev.columnName === 'facRuntime' || value == null) {
			return ev.stop() ;
		}
		
		dialog2.dialog("open") ;
		grid3.refreshLayout() ;
		
		let facNo = data[ev.rowKey].facNo ;
		
		$.ajax({
			url : 'facilityBreakInfo/' + facNo ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				console.log(data3) ;
				data3 = datas.facilitybreakinfo ;
				grid3.resetData(data3) ;
				grid3.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		}) ;
	})
	//---------- ↑상세정보 ----------
</script>
</body>
</html>