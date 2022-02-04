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
	<div id="title" align="center"><h2>설비 관리</h2></div>
	<br>
	<div id="info">
		<span>설비명 :  </span><input id="txtFacName" readonly>
		<span>설비코드 : </span><input id="txtfacCode">&nbsp;<button type="button" id="btnSearch">설비코드검색</button>
		<br><br>
		<span>설비상태 : </span>
		<select id="selectStatus">
			<option value="" selected>선택</option>
			<option value="가동">가동</option>
			<option value="비가동">비가동</option>
		</select>
		<span>점검일자 : </span><input id="checkDateStart" type="date"><span> ~ </span><input id="checkDateEnd" type="date">
		<br>
		<div align="right">
			<button type="button" id="listBtn">조회</button>
			<button type="button" id="addBtn">추가</button>
			<button type="button" id="deleteBtn">삭제</button>
			<button type="button" id="btnInsert">저장</button>
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
	
	<div id="helpDialog" title="도움말">
		<br>
		설비명 : 설비코드를 검색해서 검색결과를 선택하면 자동으로 입력됩니다.<br><br>
		설비코드검색 : 검색어를 포함한 설비명으로 설비코드를 검색합니다.<br><br>
		조회 : 조건 없이 조회하면 전체목록을 조회합니다.<br><br>
		추가 : <br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;설비번호 : 설비명을 선택하면 저장시 자동으로 입력됩니다.<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;설비코드 : 설비명을 선택 시 자동으로 입력됩니다.<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공정명 : 설비명을 선택 시 자동으로 입력됩니다.<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;모든 값을 다 입력해야 저장이 가능합니다.<br><br>
		초기화 : 입력한 조회 조건을 초기화합니다.
	</div>
<script>

	var Grid = tui.Grid ;
	
	//---------- ↓페이지 ----------
	let facList = [] ;
	let procList = [] ;
	
	const columns = [
		{
			header : '설비번호' ,
			name : 'facNo' ,
			align: 'center' ,
			width : 80,
		    sortable: true,
		    sortingType: 'desc'
		} ,
		{
			header : '설비코드' ,
			name : 'facCode' ,
			align: 'center' ,
			width : 70
		} ,
		{
			header : '설비명' ,
			name : 'codeName' ,
			editor : {
				type: 'select' ,
				options: {
					listItems : facList
				}
			} ,
			align: 'center'
		} ,
		{
			header : '가동상태' ,
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
			align: 'center' ,
			width : 70
		} ,
		{
			header : '비가동사유' ,
			name : 'facCause' ,
			editor : 'text' ,
			align: 'center' ,
			width : 90
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
			align: 'center' ,
			width : 90,
		    sortable: true,
		    sortingType: 'desc'
		} ,
		{
			header : '공정코드' ,
			name : 'procCode' , 
			editor : {
				type: 'select' ,
				options: {
					listItems : procList
				}
			},
			align: 'center' ,
			width : 70
		} ,
		{
			header : '공정명' ,
			name : 'procName' , 
			align: 'center' ,
			width : 70
		} ,
		{
			header : 'UPH' ,
			name : 'facOutput' , 
			editor : 'text' ,
			align: 'center' ,
			formatter(value) {
				return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") ;
			} ,
			width : 50
		} ,
		{
			header : '가동시간' ,
			name : 'facRuntime' ,
			editor : 'text' ,
			align : 'center' ,
			width : 90
		}
	] ;
	
	let data ;
	
	$.ajax({
		url : 'selectFacOptions' ,
		dataType : 'json' ,
		async : false ,
		success : function(datas) {
			for (let i = 0 ; i < datas.selectfacoptions.length ; i++) {
				let option = { text : datas.selectfacoptions[i].codeName , value : datas.selectfacoptions[i].codeName } ;
				facList.push(option) ;
			}
		} , 
		error : function(reject) {
			console.log(reject) ;
		}
	})
	
	$.ajax({
		url : 'selectProcOptions' ,
		dataType : 'json' ,
		async : false ,
		success : function(datas) {
			for (let i = 0 ; i < datas.selectprocoptions.length ; i++) {
				let option = { text : datas.selectprocoptions[i].code , value : datas.selectprocoptions[i].code } ;
				procList.push(option) ;
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
		bodyHeight : 430 ,
		data : data ,
		columns : columns ,
 		pageOptions: {
		    useClient: true,
		    perPage: 10
		} 
	})
	
	$("#clearBtn").on("click" , function() {
		$("#txtfacCode").val("") ;
		$("#selectStatus").val("") ;
		$("#checkDateStart").val("") ;
		$("#checkDateEnd").val("") ;
		$("#txtFacName").val("") ;
	})
	
	grid.on('editingStart' , (ev) => {
		let value = grid.getValue(ev.rowKey , ev.columnName) ;
		
		if ( ( ev.columnName == 'codeName' || ev.columnName == 'facOutput' || ev.columnName == 'facRuntime' ) && value != '' && value != null ){
			return ev.stop() ;
		}		
	})
	
	grid.on('editingFinish' , (ev) => {		
		let code = ev.value ;
		
		if(ev.columnName == 'codeName') {
			if(code == '교반기') {
				grid.setValue(ev.rowKey , 'facCode' , 'F001') ;
			} else if(code == '정삭기') {
				grid.setValue(ev.rowKey , 'facCode' , 'F002') ;
			} else if(code == '패드기') {
				grid.setValue(ev.rowKey , 'facCode' , 'F003') ;
			} else if(code == '재료성형기') {
				grid.setValue(ev.rowKey , 'facCode' , 'F004') ;
			} else if(code == '안마기') {
				grid.setValue(ev.rowKey , 'facCode' , 'F005') ;
			} else if(code == '렌즈분리기') {
				grid.setValue(ev.rowKey , 'facCode' , 'F006') ;
			} else if(code == '열탕기') {
				grid.setValue(ev.rowKey , 'facCode' , 'F007') ;
			} else if(code == '렌즈메타') {
				grid.setValue(ev.rowKey , 'facCode' , 'F008') ;
			} else if(code == '멸균기') {
				grid.setValue(ev.rowKey , 'facCode' , 'F009') ;
			} else if(code == '포장기') {
				grid.setValue(ev.rowKey , 'facCode' , 'F010') ;
			}
		}
		
		if(ev.columnName == 'procCode') {
			if(code == 'PROC001') {
				grid.setValue(ev.rowKey , 'procName' , '원자재혼합') ;
			} else if(code == 'PROC002') {
				grid.setValue(ev.rowKey , 'procName' , '1차 절삭') ;
			} else if(code == 'PROC003') {
				grid.setValue(ev.rowKey , 'procName' , '색소착색') ;
			} else if(code == 'PROC004') {
				grid.setValue(ev.rowKey , 'procName' , '렌즈중합') ;
			} else if(code == 'PROC005') {
				grid.setValue(ev.rowKey , 'procName' , '2차 절삭') ;
			} else if(code == 'PROC006') {
				grid.setValue(ev.rowKey , 'procName' , '연마') ;
			} else if(code == 'PROC007') {
				grid.setValue(ev.rowKey , 'procName' , '분리') ;
			} else if(code == 'PROC008') {
				grid.setValue(ev.rowKey , 'procName' , '열처리') ;
			} else if(code == 'PROC009') {
				grid.setValue(ev.rowKey , 'procName' , '검사') ;
			} else if(code == 'PROC010') {
				grid.setValue(ev.rowKey , 'procName' , '멸균') ;
			} else if(code == 'PROC011') {
				grid.setValue(ev.rowKey , 'procName' , '포장') ;
			}
		}
	})
	
	$("#addBtn").on("click" , function() {
		let data = { facStatus : 'Y' }
		grid.appendRow(data) ;
	})
	
	$("#btnInsert").on("click" , function() {
		grid.blur() ;
		
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
				let procCode = inserted[i].procCode ;
				
				if (facStatus == null || facCode == null || facOutput == null || facRuntime == null || procCode == null) {
					alert('입력값을 확인하세요') ;
					return ;
				}
				
	 			$.ajax({
					url : 'insertFacility' ,
					async : false ,
					data : {
						facCode : facCode ,
						facStatus : facStatus ,
						facOutput : facOutput ,
						facRuntime : facRuntime ,
						procCode : procCode
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
		height : 600 ,
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
		$.ajax({
			url : 'findFacilityAll' ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data2 = datas.findfacilityall ;
				grid2.resetData(data2) ;
				grid2.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
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
			alert('설비명을 입력하세요') ;
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
		bodyHeight : 300 ,
		data : data2 ,
		columns : columns2 ,
 		pageOptions: {
		    useClient: true,
		    perPage: 10
		} 
	})
	
	grid2.on('click',(ev) => {
		let facCode = data2[ev.rowKey].facCode ;
		let facName = data2[ev.rowKey].codeName ;
		$("#txtfacCode").val(facCode) ;
		$("#txtFacName").val(facName) ;
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
		height : 600 ,
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
			header: '설비명' ,
			name: 'codeName' ,
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
		columns : columns3 ,
 		pageOptions: {
		    useClient: true,
		    perPage: 10
		} 
	})
	
	grid.on('click' , (ev) => {
		
		let value = grid.getValue(ev.rowKey,ev.columnName) ;
		
		if ( ev.columnName === 'codeName' || ev.columnName === 'facStatus' || ev.columnName === 'facCause' || ev.columnName === 'facCheckdate' || ev.columnName === 'facOutput' || ev.columnName === 'facRuntime' || value == null) {
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
	//---------- ↑상세정보 ----------
</script>
</body>
</html>