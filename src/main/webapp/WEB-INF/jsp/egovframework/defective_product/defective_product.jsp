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
	<h2>불량 상태 입력</h2><br>
	
	<div class = "manDate">
		<p style="display:inline-block;">작업일자</p>
		<input id = "txtFromDate" type="date" name="from" style="display:inline-block;">
		
		<p style="display:inline-block;"> ~ </p>
		<input id = "txtToDate" type="date" name="to" style="display:inline-block;">
	</div>

	<div>
		<p style="display:inline-block;">제품코드</p>
		<input id = "txtPodtCode" style="display:inline-block;">
	</div>
	<br>
	
	<div>
		<p style="display:inline-block;">제품공정현황</p>
		<input id = "txtPodtCode" style="display:inline-block;">
	</div>
	<br>

	<div> 		
		<!-- 공정현황 모달 -->
		<div id = "dialog-form-plan" title="미계획 내역 조회" > 
			<div id="gridPlan"></div>
			<button type="button" id="btnClose1">확인</button><br>
		</div>
		
		<!-- 제품코드 모달 -->
		<div id = "dialog-form-resource" title="자재 조회">
			<div id="gridResource"></div>
			<button type="button" id="btnClose2">확인</button><br>
		</div>
	</div>
	<br>
	
	<!-- 메인화면 그리드 -->
	<div id = "gridMain"></div>
	<br>
	
	<div style="float:right;">
		<button type="button" id="btnSave">저장</button>
		<button type="button" id="btnClear">초기화</button>
	</div>
</body>
</html>