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
	<h3>거래처정보</h3>
	<div id="info">
		<input id="txtCusCode">
		<button type="button" id="listBtn">조회</button>
		<button type="button" id="btnSearch">업체검색</button>
		<button type="button" id="btnAdd">추가</button>
		<button type="button" id="btnInsert">저장</button>
		<button type="button" id="btnDelete">삭제</button>
	</div>
	
	<div id="find-dialog-form" title="업체검색"">
		<input id="cusName"><button id="btnCusSearch">업체명검색</button>
		<button type="button" id="btnClose1">닫기</button>
		<div id="cusResult"></div>
	</div>
	
	<div id="tradeInfo-dialog-form" title="거래처정보수정 / 거래내역조회" style="text-align: center;">
		<div id="cusInfo"></div>
		<div style="height: 50px">
			<button type="button" id="btnSave">저장</button>
			<button type="button" id="btnClose2">닫기</button>
		</div>
		<div id="tradeResult" style="height: 200px;"></div>
	</div>
	
<script>
	//---------- ↓페이지 ----------
	var Grid = tui.Grid ;
	
	const columns = [
		{
			header: '업체코드' ,
			name: 'cusCode' ,
			editor: {
				type : 'select' ,
				options: {
					listItems: [
						{ text: '제품 구매 고객' , value: '제품 구매 고객'} ,
						{ text: '자재 판매 고객' , value: '자재 판매 고객'}
					]
				}
			}
		} ,
		{
			header: '업체명' ,
			name: 'codeName' ,
			editor: 'text'
		} ,
		{
			header: '연락처' ,
			name : 'cusPhone' ,
			editor: 'text'
		}
	] ;
	
	let data ;
	
	$('#listBtn').click(function () {
		let cusCode = $("#txtCusCode").val() ;
		
		if (cusCode == '') {
			cusCode = 'null' ;
		} else {
			cusCode = $("#txtCusCode").val() ; 
		}
		
		$.ajax({
			url : 'customerList/' + cusCode ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data = datas.data ;
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
			{ type : 'rowNum' } ,
			{ type : 'checkbox'}
		] ,
		data : data ,
		columns 
	}) ;
	
	$("#btnAdd").on("click" , function() {
		grid.appendRow({}) ;
	})
	
	$("#btnInsert").on("click" , function() {
		let insertDatas = grid.getModifiedRows() ;
		let insertData = insertDatas.createdRows ;
		let insertCode = insertData[0].cusCode ;
		let insertName = insertData[0].codeName ;
		let insertPhone = insertData[0].cusPhone ;
		let codeDesct ;
		
		if (insertCode == '' || insertName == '' || insertPhone == '') {
			alert('입력값을 확인하세요') ;
			return ;
		}
		
		if (insertCode == '제품 구매 고객') {
			insertCode = 'b_' ;
			codeDesct = '판매처' ;
		} else {
			insertCode = 'm_' ;
			codeDesct = '구매처' ;
		}
		
		$.ajax({
			url : 'customerInsert' ,
			data : {
				cusCode : insertCode ,
				codeName : insertName ,
				cusPhone : insertPhone ,
				codeDesct : codeDesct
			} ,
			async : false ,
			success : function(datas) {
				alert('저장완료되었습니다') ;
				
				let cusCode = 'null' ;
				
				$.ajax({
					url : 'customerList/' + cusCode ,
					dataType : 'json' ,
					async : false ,
					success : function(datas) {
						data = datas.data ;
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
	})
	
	var rowCodes = new Array() ;
	
	grid.on('check' , (ev) => {
		rowCodes[ev.rowKey] = data[ev.rowKey].cusCode ;
	})
	
	grid.on('uncheck' , (ev) => {
		console.log(rowCodes.length) ;
	})
	
	$("#btnDelete").on("click" , function() {
		console.log(rowCodes) ;
		
/*		$.ajax({
			url : 'deleteCustomer' + cusCode ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				alert('삭제완료되었습니다') ;
				
				let cusCode = 'null' ;
				
				$.ajax({
					url : 'customerList/' + cusCode ,
					dataType : 'json' ,
					async : false ,
					success : function(datas) {
						data = datas.data ;
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
*/
	})
	//---------- ↑페이지 ----------
	
	//---------- ↓업체찾기 ----------
	let dialog = $("#find-dialog-form").dialog({
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
			header: '업체코드' ,
			name: 'cusCode'
		} ,
		{
			header: '업체명' ,
			name: 'codeName'
		}
	] ;
	
	let data2 ;
	
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
				data2 = datas.customer ;
				grid2.resetData(data2) ;
				grid2.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	
	const grid2 = new Grid({
		el : document.getElementById('cusResult') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		height : 300 ,
		data : data2 ,
		columns : columns2
	})
	
	grid2.on('click',(ev) => {
		let cusCode = data2[ev.rowKey].cusCode ;
		$("#txtCusCode").val(cusCode) ;
		dialog.dialog("close") ;
	})
	
	$("#btnClose1").on("click" , function() {
		dialog.dialog("close") ;
	})	
	//---------- ↑업체찾기 ----------
	
	//---------- ↓상세정보 ----------
	let dialog2 = $("#tradeInfo-dialog-form").dialog({
		autoOpen : false ,
		modal : true ,
		width : 600 ,
		height : 400
	})
	
	const columns3 = [
		{
			header: '주문코드' ,
			name: 'ordCode'
		} ,
		{
			header: '제품코드' ,
			name: 'podtCode'
		} ,
		{
			header: '제품명' ,
			name: 'podtName' ,
			width: 200
		} ,
		{
			header: '주문일' ,
			name: 'ordDate'
		} ,
		{
			header: '주문량' ,
			name: 'ordQnt'
		}
	] ;
	
	let data3 ;

	const columns4 = [
		{
			header: '업체명' ,
			name: 'codeName' ,
			editor: 'text'
		} ,
		{
			header: '연락처' ,
			name: 'cusPhone' ,
			editor: 'text'
		}
	] ;
	
	let data4 ;
	
	grid.on('click',(ev) => {
		
		if (ev.columnName === '_checked'){
			return ev.stop() ;
		}
		
		let cusCode = data[ev.rowKey].cusCode ;
		
		dialog2.dialog("open") ;
		grid3.refreshLayout() ;
		grid4.refreshLayout() ;
		
 		$.ajax({
			url : 'selectTradeInfo/' + cusCode ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data3 = datas.trade ;
				grid3.resetData(data3) ;
				grid3.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		}).done( function() {
 			$.ajax({
 				url : 'customerList/' + cusCode ,
 				dataType : 'json' ,
 				async : false ,
 				success : function(datas) {
 					data4 = datas.data ;
 					grid4.resetData(data4) ;
 					grid4.resetOriginData() ;
 					
 				} ,
 				error : function(reject) {
 					console.log(reject) ;
 				}
 			}) 
 		})
	})
	
	const grid3 = new Grid({
		el : document.getElementById('tradeResult') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		data : data3 ,
		columns : columns3
	})
	
	const grid4 = new Grid({
		el : document.getElementById('cusInfo') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		data : data4 ,
		columns : columns4 ,
		bodyHeight: 60,
		minBodyHeight: 60
	})
	
	$("#btnSave").on("click" , function() {
		let datas = grid4.getModifiedRows() ;
		let data = datas.updatedRows ;
		let cusCode = data[0].cusCode ;
		let codeName = data[0].codeName ;
		let cusPhone = data[0].cusPhone ;
		
		$.ajax({
			url : 'updateCustomer' ,
			data : {
				cusCode : cusCode ,
				codeName : codeName ,
				cusPhone : cusPhone
			} ,
			dataType : 'json' ,
			contentType : 'application/json ; charset=utf-8;' , 
			async : false ,
			success : function(datas) {
				alert('수정완료되었습니다.') ;
				data4 = datas.update ;
				grid4.resetData(data4) ;
				grid4.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	
	$("#btnClose2").on("click" , function() {
		dialog2.dialog("close") ;
		
		let cusCode = $("#txtCusCode").val() ;
		
		if (cusCode == '') {
			cusCode = 'null' ;
		} else {
			cusCode = $("#txtCusCode").val() ; 
		}
		
		$.ajax({
			url : 'customerList/' + cusCode ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data = datas.data ;
				grid.resetData(data) ;
				grid.resetOriginData() ;
				
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	//---------- ↑상세정보 ----------
</script>
</body>
</html>