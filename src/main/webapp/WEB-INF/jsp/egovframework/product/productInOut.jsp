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
	<div id="title" align="center"><h2>제품 입/출고 관리</h2></div>
	<br>
	<div id="info">
		<span>제품코드 : </span><input id="txtPodtCode"><button type="button" id="btnSearch">제품코드검색</button>
		<br>
		<br>
		<span>작업일자 : </span><input id="manDatestart" type="date"><span> ~ </span><input id="manDateend" type="date">
		<br>
		<div align="right">
<!-- 테스트 -->
			<button type="button" id="test">테스트버튼</button>
			<button type="button" id="test2">테스트버튼2</button>
<!-- 테스트 -->
			<button type="button" id="listBtn">조회</button>
			<button type="button" id="btnAdd">추가</button>
			<button type="button" id="btnInsert">저장</button>
			<button type="button" id="btnDelete">삭제</button>
			<button type="button" id="clearBtn">초기화</button>
		</div>
	</div>
	
	<div id="findProduct" title="제품코드검색">
		<input id="podtName"><button id="btnPodtSearch">검색</button>
		<button type="button" id="btnClose">닫기</button>
		<div id="podtResult"></div>
	</div>
<script>
	var Grid = tui.Grid ;
	
	//---------- ↓페이지 ----------
	const columns = [
		{
			header: '번호' ,
			name: 'qntInfono' ,
			hidden : true
		} ,
		{
			header: '제품코드' ,
			name: 'podtCode' ,
			editor: {
				type: 'select' ,
				options: {
					listItems: [
						{ text: '하드콘택트 브라운' , value: 'PODT001' } ,
						{ text: '하드콘택트 그레이' , value: 'PODT002' } ,
						{ text: '소프트콘택트 브라운' , value: 'PODT003' } ,
						{ text: '소프트콘택트 그레이' , value: 'PODT004' } ,
						{ text: '하드콘택트 무색' , value: 'PODT005' } ,
						{ text: '소프트콘택트 무색' , value: 'PODT006' } ,
						{ text: '소프트콘택트 도수 1.0' , value: 'PODT007' } ,
						{ text: '하드콘택트 도수 1.0' , value: 'PODT008' } ,
						{ text: '소프트콘택트 도수 0.5' , value: 'PODT009' } ,
						{ text: '하드콘택트 도수 0.5' , value: 'PODT010' } 
					]
				}
			} ,
			align: 'center'
		} ,
		{
			header: '제품명' ,
			name: 'codeName' ,
			align: 'center'
		} ,
		{
			header: '작업일자' ,
			name : 'manDate' ,
			editor: 'datePicker' ,
			align: 'center'
		} ,
		{
			header: '입고량' ,
			name : 'podtInput' ,
			editor: 'text' ,
			align: 'center'
		} ,
		{
			header: '출고량' ,
			name : 'podtOutput' ,
			editor: 'text' ,
			align: 'center'
		} ,
// ----- 테스트 -----
		{
			header: '비고	' ,
			name : 'podtEtc' ,
			align: 'center' ,
			formatter : 'listItemText' ,
			editor: {
				type : 'select' ,
				options: {
					listItems: [
						{ text : '선택' , value: ''} ,
						{ text : '생산완료' , value: '생산완료'} ,
						{ text : '출하' , value: '출하'} ,
						{ text : '미생산출하' , value: '미생산출하'} ,
						{ text : '기타' , value: '기타'}
					]
				}
			} ,
			relations: [
				{
					targetNames: ['podtLot'] ,
					listItems({ value }) {
						return second[value] ;
					} ,
					disabled({ value }) {
						return !value ;
					}
				}
			]
		} ,
		{
			header: '완제품 Lot' ,
			name : 'podtLot' ,
			align: 'center' ,
			formatter: 'listItemText' ,
			editor: {
				type : 'select' ,
				options : {
					listItems : []
				}
			}
		}
// ----- 테스트 -----
	] ;
	
	let data ;
	
	$("#listBtn").click(function () {
		let podtCode = $("#txtPodtCode").val() ;
		let manDatestart = $("#manDatestart").val() ;
		let manDateend = $("#manDateend").val() ;
		
		if (podtCode == '') {
			podtCode = 'null' ;
		}
		
		if (manDatestart == '') {
			manDatestart = '1910-12-25' ;
		}
		
		if (manDateend == '') {
			manDateend = '1910-12-25' ;
		}
		
		$.ajax({
			url : 'productList' ,
			dataType : 'json' ,
			data : {
				podtCode : podtCode ,
				manDatestart : manDatestart ,
				manDateend : manDateend
			} ,
			async : false ,
			success : function(datas) {
				data = datas.productlist ;
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
	
	// ----- 테스트 -----
	const second = {
		'생산완료' : [
			{ text : '선택' , value : ''} ,
			{ text : '생산완료용Lot' , value : '1-1'}
		] ,
		'출하' : [
			{ text : '선택' , value : ''} ,
			{ text : '출하용Lot' , value : '2-1'}
		] ,
		'미생산출하' : [
			{ text : '선택' , value : ''} ,
			{ text : '출하용Lot' , value : '3-1'}
		] ,
		'기타' : [
			{ text : '선택' , value : ''} ,
			{ text : '생산완료Lot' , value : '4-1'} , 
			{ text : '출하용Lot' , value : '4-2'} 
		]
	} ;	
	 
	$("#test").on("click" , function() {
		second.출하[1].text = 'C220117001_001' ;
		second.출하[1].value = 'C220117001_001' ;
	})	
	
	$("#test2").on("click" , function() {
		$.ajax({
			url : 'selectOptions' ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				console.log(datas.selectoptions) ;
				for (let i = 0 ; i < datas.selectoptions.length ; i++) {
					second.미생산완료.push(datas.selectoptions.podtLot) ;
					second.생산완료.push(datas.selectoptions.podtLot) ;
					second.출하.push(datas.selectoptions.podtLot) ;
				}
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	// ----- 테스트 -----
	
	// 입력된 데이터 수정못하게 하기
	grid.on('editingStart' , (ev) => {
		let value = grid.getValue(ev.rowKey , ev.columnName) ;
		let lot = ev.columnName ;
		
		console.log(lot) ;
		console.log(value) ;
		
		if (value != '' && value != null) {
			if (lot != 'podtLot' || value != null) {
				ev.stop() ;	
			}
		} 
	})
	
	$("#btnAdd").on("click" , function() {
		grid.appendRow({}) ;
	})
	
	$("#btnInsert").on("click" , function() {
		let insertDatas = grid.getModifiedRows() ;
		let insertData = insertDatas.createdRows ;
		
		let datas = grid.getModifiedRows() ;
		let data = datas.updatedRows ;
		
		 if (data != '') {
			
	  		let ok = 1 ;
			for (let i = 0 ; i < data.length ; i++) {
				
				let no = data[i].qntInfono ;
				let lot = data[i].podtLot ;
				let podtCode = data[i].podtCode ;
				let input = data[i].podtInput ;
				let output = data[i].podtOutput ;
				
	 			$.ajax({
					url : 'updateLotno' ,
					async : false ,
					data : {
						qntInfono : no ,
						podtLot : lot ,
						podtCode : podtCode ,
						podtInput : input ,
						podtOutput : output
					} ,
					success : function(datas) {
						ok = 2 ;
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
		if (insertData != '') {
			
			let ok = 1 ;
			for (let i = 0 ; i < insertData.length ; i++) {
				let insertCode = insertData[0].podtCode ;
				let insertDate = insertData[0].manDate ;
				let insertInput = insertData[0].podtInput ;
				let insertOutput = insertData[0].podtOutput ;
				let insertEtc = insertData[0].podtEtc ;
				let insertLot = insertData[0].podtLot ;
				
				if (insertCode == '' || insertDate == '' || insertInput == '' || insertOutput == '' || insertCode == '') {
					alert('입력값을 확인하세요') ;
					return ;
				}
				
				if (insertEtc == '') {
					insertEtc = 'null'
				}
				
				$.ajax({
					url : 'productInOut' ,
					data : {
						podtCode : insertCode ,
						manDate : insertDate ,
						podtInput : insertInput ,
						podtOutput : insertOutput ,
						podtEtc : insertEtc ,
						podtLot : insertLot
					} ,
					async : false ,
					success : function(datas) {
						
						ok = 2 ;						
						let podtCode = 'null' ;
						let manDatestart = '1910-12-25';
						let manDateend = '1910-12-25';
						
						$.ajax({
							url : 'productList' ,
							dataType : 'json' ,
							data : {
								podtCode : podtCode ,
								manDatestart : manDatestart ,
								manDateend : manDateend
							} ,
							async : false ,
							success : function(datas) {
								data = datas.productlist ;
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
				alert('저장완료되었습니다') ;
			}
		} 
		
	})
	
	var rowNo = new Array() ;
	
	grid.on('check' , (ev) => {
		rowNo[ev.rowKey] = data[ev.rowKey].qntInfono ;
	})
	
	grid.on('uncheck' , (ev) => {
		delete rowNo[ev.rowKey] ;
	})
	
	$("#btnDelete").on("click" , function() {
		let ok = 1 ;
		for (let i = 0 ; i < rowNo.length ; i++) {
			if(rowNo[i] != null) {
				let qntInfono = rowNo[i] ;
				
				$.ajax({
					url : 'deleteInOut/' + qntInfono ,
					async : false ,
					success : function(datas) {
						ok = 2 ;
						
						let podtCode = 'null' ;
						let manDatestart = '1910-12-25';
						let manDateend = '1910-12-25';
						
						$.ajax({
							url : 'productList' ,
							dataType : 'json' ,
							data : {
								podtCode : podtCode ,
								manDatestart : manDatestart ,
								manDateend : manDateend
							} ,
							async : false ,
							success : function(datas) {
								data = datas.productlist ;
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
	
	$("#clearBtn").on("click" , function() {
		$("#txtPodtCode").val("") ;
		$("#manDatestart").val("") ;
		$("#manDateend").val("") ;
		grid.clear() ;
	})
	//---------- ↑페이지 ----------
	//---------- ↓제품코드찾기 ----------
	let dialog = $("#findProduct").dialog({
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
			header: '제품코드' ,
			name: 'podtCode' , 
			align: 'center'
		} ,
		{
			header: '제품명' ,
			name: 'codeName' ,
			align: 'center'
		}
	] ;
	
	let data2 ;
	
	$("#btnPodtSearch").on("click" , function() {
		var podtName = $("#podtName").val() ;
		
		if (podtName == '') {
			alert('제품명을 입력하세요') ;
			return ;
		}
		
		$.ajax({
			url : 'findProduct/' + podtName ,
			dataType : 'json' ,
			async : false ,
			success : function(datas) {
				data2 = datas.findproduct ;
				grid2.resetData(data2) ;
				grid2.resetOriginData() ;
			} ,
			error : function(reject) {
				console.log(reject) ;
			}
		})
	})
	
	const grid2 = new Grid({
		el : document.getElementById('podtResult') ,
		rowHeaders: [
			{ type : 'rowNum' }
		] ,
		height : 300 ,
		data : data2 ,
		columns : columns2
	})
	
	grid2.on('click',(ev) => {
		let cusCode = data2[ev.rowKey].podtCode ;
		$("#txtPodtCode").val(cusCode) ;
		grid2.clear() ;
		dialog.dialog("close") ;
		$("#podtName").val("") ;
	})
	
	$("#btnClose").on("click" , function() {
		dialog.dialog("close") ;
		grid2.clear() ;
		$("#podtName").val("") ;
	})
	//---------- ↑제품코드찾기 ----------
</script>
</body>
</html>