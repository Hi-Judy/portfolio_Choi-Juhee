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

<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"> -->

<!-- 부트스트랩 cdn 링크 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css" />
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
  
/* 도움말 버튼 */
.bi-question-circle {
	font-size : 25px ;
	width : 25px ;
	height : 25px ;
}
  
/* 재철이형 돋보기 버튼 스타일 */
.bi-search {
   font-size : 20px ;
   width : 20px ;
   height : 20px ;
}
   
.inpBC{
	text-align:center;
	background-color: #d2e5eb; 
}
</style>
</head>
<body>
<script>
window.addEventListener('load',function(){
	if(sessionStorage.getItem("MenuList") != null){
		makesidebar();
	}else{
		$.ajax({
			url : '${pageContext.request.contextPath}/reqsidebar',
			method : 'GET',
			dataType : 'JSON',
			success : function(sidebardatas) {
				sessionStorage.setItem("MenuList",JSON.stringify(sidebardatas.resultsidebar)) ;
				makesidebar();
			},
			error : function(reject) {
				console.log('reject: ' + reject);
			}
		})
	}
});
function makesidebar(){	
	list = JSON.parse(sessionStorage.getItem("MenuList"));
	var menu = document.querySelector('.menu');
	var ul=$('<ul></ul>');
	var outterli=$('<li class="sidebar-title">Menu</li>');
	for(item of list){
		if(item.upperMenuNo == 0){
			var outterli = $('<li class="sidebar-item  has-sub"></li>');
			var outterlia = $("<a href='#' class='sidebar-link'></a>");
			var outterlii = $("<i class='bi bi-collection-fill'></i> ");
			var outterlispan = $("<span></span>");
			ul = $('<ul class="submenu "></ul>');			
			outterlispan.text(item.menuNm);
			
			outterlia.append(outterlii[0]);
			outterlia.append(outterlispan[0]);
			outterli.append(outterlia[0]);
			outterli.append(ul[0]);
			
		}else{
			var innerli = $('<li class="submenu-item "></li>');
			var innerlia = $('<a href="'+item.chkUrl+'"></a>')
			innerlia.href=item.chkUrl;
			innerlia.text(item.menuNm);
			innerli.append(innerlia[0]);
			ul.append(innerli[0]);
		}
		menu.append(outterli[0]);
		
	}
	function slideToggle(t, e, o) {
		0 === t.clientHeight ? j(t, e, o, !0) : j(t, e, o)
	}
	function slideUp(t, e, o) { j(t, e, o) }
	function slideDown(t, e, o) { j(t, e, o, !0) }
	function j(t, e, o, i) { void 0 === e && (e = 400), void 0 === i && (i = !1), t.style.overflow = "hidden", i && (t.style.display = "block"); var p, l = window.getComputedStyle(t), n = parseFloat(l.getPropertyValue("height")), a = parseFloat(l.getPropertyValue("padding-top")), s = parseFloat(l.getPropertyValue("padding-bottom")), r = parseFloat(l.getPropertyValue("margin-top")), d = parseFloat(l.getPropertyValue("margin-bottom")), g = n / e, y = a / e, m = s / e, u = r / e, h = d / e; window.requestAnimationFrame(function l(x) { void 0 === p && (p = x); var f = x - p; i ? (t.style.height = g * f + "px", t.style.paddingTop = y * f + "px", t.style.paddingBottom = m * f + "px", t.style.marginTop = u * f + "px", t.style.marginBottom = h * f + "px") : (t.style.height = n - g * f + "px", t.style.paddingTop = a - y * f + "px", t.style.paddingBottom = s - m * f + "px", t.style.marginTop = r - u * f + "px", t.style.marginBottom = d - h * f + "px"), f >= e ? (t.style.height = "", t.style.paddingTop = "", t.style.paddingBottom = "", t.style.marginTop = "", t.style.marginBottom = "", t.style.overflow = "", i || (t.style.display = "none"), "function" == typeof o && o()) : window.requestAnimationFrame(l) }) }

		let sidebarItems = document.querySelectorAll('.sidebar-item.has-sub');
		for (var i = 0; i < sidebarItems.length; i++) {
			let sidebarItem = sidebarItems[i];
			sidebarItems[i].querySelector('.sidebar-link').addEventListener('click', function(e) {
				e.preventDefault();

				let submenu = sidebarItem.querySelector('.submenu');
				if (submenu.classList.contains('active')) submenu.style.display = "block"

				if (submenu.style.display == "none") submenu.classList.add('active')
				else submenu.classList.remove('active')
				slideToggle(submenu, 300)
			})
		}
}
</script>
	<tiles:insertAttribute name="tiles_side_bar" />
	<div id="wraper" class="margin3">
		<div id="header">
			<tiles:insertAttribute name="tiles_header" />
			<tiles:insertAttribute name="tiles_nav" />
		</div>
		<div id="contents">
			<tiles:insertAttribute name="tiles_content" />
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