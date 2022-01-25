<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
	<div id="info"></div>
	<div class="container">
		<div id="title" align="center"><h2>LOT 정보조회</h2></div>  
		<div class="table-responsive">
		  <table class="table">
		      <tr>
				<th style="background-color: skyblue;">제품코드</th>
				<td>${qr[0].podtCode}</td>
		      </tr>
		      <tr>
				<th style="background-color: skyblue;">제품명</th>
				<td>${qr[0].podtName}</td>
		      </tr>
		      <tr>
		      	<th style="background-color: skyblue;">생산완료일</th>
		      	<td>${qr[0].manDate2}</td>
		      </tr>
		      <tr>
		      	<th style="background-color: skyblue;">생산지시코드</th>
				<td>${qr[0].comCode}</td>
		      </tr>
		      <tr>
				<th style="background-color: skyblue;">생산계획코드</th>
				<td>${qr[0].manPlanNo}</td>
		      </tr>
		      <tr>
		      	<th style="background-color: skyblue;">주문코드</th>
				<td>${qr[0].ordCode}</td>
		      </tr>
		  </table>
		</div>
	</div>
	<div id="buttonArea" align="center">
		<button type="button" onclick="javascript:window.close()">닫기</button>
	</div>
</body>
</html>