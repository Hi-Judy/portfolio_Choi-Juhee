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
	<h2>불량조회</h2><br>
	
	<div class = "manDate">
		<p style="display:inline-block;">작업일자</p>
		<input id = "txtFromDate" type="date" name="from" style="display:inline-block;">
		
		<p style="display:inline-block;"> ~ </p>
		<input id = "txtToDate" type="date" name="to" style="display:inline-block;">
		<button type="button" id="btnFind">검색</button><br>
	</div>

	<div>
		<!-- 제품코드 모달 -->
		<div id = "dialog-form-defective" title="작업일자별 제품조회">
			<div id="gridProduct"></div>
		</div>
	</div>
	
	<div style="float:right;">
		<button type="button" id="btnClear">초기화</button>		
	</div>
	<br>
	
	<!-- 메인화면 그리드 -->
	<div id = "gridMain">
	</div>
	<br>
	
	
	
	<script>
		var Grid = tui.Grid; //그리드 객체 생성
		
		//제품코드찾기 모달 설정해주기
		let dialogProduct = $("#dialog-form-defective").dialog({
			autoOpen: false, 
			modal: true,
			height: 500,
		    width: 900,
			buttons: {
				"확인" : function(){
					dialogProduct.dialog("close");
				}, 
				"취소" : function(){
					dialogProduct.dialog("close");
				}
			}		    
		});
		
		//제품코드찾기 모달 컬럼
		const columnsProduct = [
			{
				header: '작업일자',
				name: 'manDate'
			},
			{
				header: '제품코드',
				name: 'podtCode'
			},
			{
				header: '제품명',
				name: 'podtName'
			}
		]

		//메인화면 컬럼
		let columnsMain = [
			{
				header:'불량번호',
				name: 'defNo',
				hidden: true
			},
			{
				header:'불량코드',
				name:'defCode'
			},
			{
				header:'불량명',
				name: 'codeName'
			},
			{
				header:'제품코드',
				name: 'podtCode'
			},
			{
				header:'제품명',
				name: 'codeName'
			},
			{
				header:'공정코드',
				name: 'procCode'
			},
			{
				header: '공정명',
				name: 'codeName'
			},
			{
				header:'작업일',
				name: 'manDate'
			},
			{
				header:'불량량',
				name: 'defQnt'
			}
		]
		
 		//제품코드찾기 조회 그리드
		const dataSourceProduct = {
				api: {
					readData: {url: '.', 
							   method: 'GET'}
				},
				contentType: 'application/json'
		}; 
		
		//메인그리드
		const dataSourceMain = {
				api : {
					readData : {url: '.', 
							   method: 'GET'},
					/* modifyData : { url: '${pageContext.request.contextPath}/manufacture/main', 
								  method: 'POST' }, */
				},
				contentType : 'application/json;charset=UTF-8'
		}; 
		
 		//제품코드찾기 그리드 내용. 
		let gridProduct = new Grid({
			el: document.getElementById('gridProduct'),
			data: dataSourceProduct,
			columns: columnsProduct
		}) 
		
		//메인 그리드
		var gridMain = new Grid({
			el : document.getElementById('gridMain'),
			data : dataSourceMain,
			columns : columnsMain,
			rowHeaders : ['rowNum']
		});
		
		$("#btnFind").on("click" , function() {
			dialogProduct.dialog("open") ;
			
			let from = $("#txtFromDate").val() ;
			let to = $("#txtToDate").val() ;
			
			gridProduct.readData() ;
			gridProduct.refreshLayout() ;
		})
		
	</script>
</body>
</html>