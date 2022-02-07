<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js">
	
</script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

</head>
<body>
	<h2>생산실적관리_주희</h2>
	<br>
	
	<!-- 월별 생산 실적 그리드 -->
	<div id="gridPerformance"  class="col-sm-9" style="float: left;"></div>
	
	
	<script>
		var Grid = tui.Grid; //그리드 객체 생성
		
		Grid.applyTheme('striped', { //그리드 객체에 전체 옵션 주기
			cell : {
				header : {
					background : '#eef'
				},
				evenRow : {
					background : '#fee'
				}
			},
			frozenBorder : {
				border : 'red'
			}
		});
		
		
		//******************************월별 생산 실적 그리드******************************
		//월별 생산 실적 그리드 컬럼
		const columnsPerformance = [
			
			{
				header : '제품코드',
				name : 'podtCode'
			},
			{
				header : '제품명',
				name : 'podtName'
			},
			{
				header : '작업일',
				name : 'manStartdate'
			},
			{
				header : '지시수량',
				name : 'manGoalperday'
			},
			{
				header : '작업완료량',
				name : 'manQnt'
			},
			{
				header : '불량량',
				name : 'defQnt'
			},
			{
				header : '불량율',
				name : 'defPercentage'
			}
			
		]
		
		//월별 생산 실적 그리드 내용
		let gridPerformance = new Grid({
			el: document.getElementById('gridPerformance'),
			data: null,
			columns: columnsPerformance,
			rowHeaders : [ 'rowNum' ]
		})
		
		
	</script>
</body>
</html>