<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<link href="<c:url value='/images/egovframework/com/Logo/logo.png' />" rel="shortcut icon" type="image/x-icon">
<link type="text/css" rel="stylesheet"
	href="<c:url value='/css/egovframework/com/app.css' />">
<link type="text/css" rel="stylesheet"
	href="<c:url value='/css/egovframework/com/bootstrap.css' />">
<!-- 토스트그리드 cdn -->
<link rel="stylesheet"
   href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />

<!-- 토스트 그리드 위에 데이트피커 가 선언되어야 작동이 된다 (순서가중요) -->
<link rel="stylesheet"
   href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script
   src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
   
<!-- 토스트 그래프 -->
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>

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

<!-- 모달창 만들떄 필요한 ui 라이브러리 -->
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet"
   href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<!-- 부트스트랩 cdn 링크 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<style>
	.tui-is-selected {
		background : #007b88 !important;
		background-color : #007b88 !important;	
		border : #007b88 !important;
	}
	/* 상단 공간 */
	div#top {
	width: 1500px;
	height: 50px;
	margin-left: 10px;
	margin-top: 30px;
	border-top: 1px solid black;
	border-bottom: 1px solid black;
	border-left: 1px solid black;
	border-right: 1px solid black;
	border-radius: 5px; 
	background-color: ghostwhite;
}
/*탑을 위에 먼저넣고 해야함 */
div#OverallSize {
	width: 1500px;
	height: 600px;	/*전체높이*/
	margin-top: 10px; /*위에서 부터 벌어질 크기*/
}
/* 버튼 클래스 */
.btn {
   color: white;
   border-radius: 5px;
   background-color: #007b88;
   padding: 2px 15px;
   padding: 5px 30px;
}
</style>
</head>
<body>
	<tiles:insertAttribute name="tiles_side_bar" />
	<div id="wraper" class="margin3">
		<div id="header">
			<tiles:insertAttribute name="tiles_header" />
			<tiles:insertAttribute name="tiles_nav" />
		</div>
		<div id="contents">
			<tiles:insertAttribute name="x" />
		</div>
	</div>
</body>
<footer>
	<div id="wrap">
		<div id="footer" class="margin3">
			<tiles:insertAttribute name="tiles_footer" />
		</div>
	</div>
</footer>
<script src="<c:url value='/js/bootstrap.bundle.min.js' />"></script>
<script src="<c:url value='/js/main.js' />"></script>
</html>