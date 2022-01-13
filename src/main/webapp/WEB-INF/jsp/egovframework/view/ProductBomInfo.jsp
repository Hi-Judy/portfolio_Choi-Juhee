<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<meta charset="utf-8">
<title>제품BOM</title>
<!-- 토스트그리드 cdn -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />

<!-- 토스트 그리드 위에 데이트피커 가 선언되어야 작동이 된다 (순서가중요) -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

<!-- 토스트그리드 cdn -->
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<!-- toastr css라이브러리 -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
<!-- toastr cdn 라이브러리 둘다 제이쿼리 밑에 있어야함 -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>


<style>
div#top {
	margin-left: 10px;
	width: 1500px;
	height: 50px;
	margin-top: 30px;
	border-top: 1px solid black;
	border-bottom: 1px solid black;
	background-color: ghostwhite;
}

div#productView{
	width: 1500px;
	margin-left: 10px;
	margin-top: 10px;
	border-top: 2px solid black;
	height: 50px;
	border-bottom: 2px solid black;
}


div#AA {
	width: 1500px;
	height: 600px;
	margin-top: 10px; /*위에서 부터 벌어질 크기*/
}

div.left {
	margin-left: 8px;
	float: left;
	box-sizing: border-box;
	/* border-top: 1px solid black; */
	/* border-bottom: 1px solid black; */
	padding: 5px;
}

div.right {
	float: right;
	width: 53%;
	padding: 5px;
	box-sizing: border-box;
	/* background: #ece6cc; */
}

/*그리드 사용으로 사용 안하게됨*/
tr:hover {
	background-color: bisque;
}

.table {
	width: 100%;
	border-collapse: collapse;
	border-top: 3px solid #168;
}

.table th {
	color: #168;
	background: #f0f6f9;
	text-align: center;
}

.table th, .table td {
	padding: 10px;
	border: 1px solid #ddd;
}

.table th:first-child, .table td:first-child {
	border-left: 0;
}

.table th:last-child, .table td:last-child {
	border-right: 0;
}

.table tr td:first-child {
	text-align: center;
}

.table caption {
	caption-side: bottom;
	display: none;
}

.btn {
	border-radius: 5px;
	background-color: white;
	padding: 2px 15px;
}
</style>

</head>
<body>


	<div id="top">
		<div>
			<!-- 탑바 왼쪽 드롭바 -->
			<!-- <span style="margin-top: 13px; float: left;"> &nbsp;&nbsp;그룹코드
				&nbsp; <select>
					<option value="">공통관리</option>
					<option value="">불량관리</option>
			</select> -->
			
			</span> <span style="float: right; margin-top: 3.5px;">
				<button id="btnAdd" type="button" class="btn"
					style="padding: 5px 30px;">리셋</button> &nbsp;&nbsp;
				<button id="btnSave" type="button" class="btn"
					style="padding: 5px 30px;">저장</button> &nbsp;&nbsp;
				<button id="btnSave" type="button" class="btn"
					style="padding: 5px 30px;">BOM 삭제</button> &nbsp;&nbsp;
			</span>

		</div>
	</div>
	
	<div id="productView">
	
	</div>
	

	<div id="AA">
		<div class="left">
			<span style="font-size: 1.5em; color: blue"> 코드 </span>
			 <span style="float: right; margin-top: 5px; color: rgb(158, 158, 158);">그룹코드
				&nbsp; <input type="text" size="10">
				<button id="btnS" type="button" class="btn">검색</button>
			</span> <br>
			<br>

			<!-- style="overflow:scroll; width:504px; height:500px; " -->
			<div id="grid"
				style="border-top: 3px solid #168; width: 504px; height: 500px;"></div>
		</div>

		<div class="right">
			<span style="font-size: 1.5em; color: blue"> 상세보기 </span> <br>
			<br>

			<div id="grid2" style="border-top: 3px solid #168;"></div>

		</div>
	</div>
</body>

<script>
   
    
    </script>
</html>