<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<meta charset="utf-8">
<title>공정관리</title>
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

<!-- 모달창 만들떄 필요한 ui 라이브러리 -->
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet"
   href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

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


div#AA {
   width: 1500px;
   height: 600px;
   margin-left: 10px;
 /*  margin-top: 5px; /*위에서 부터 벌어질 크기*/
}



div.right {
   float: right;
   width: 1500px;
  /* padding: 5px; */
   box-sizing: border-box;
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
            <span style="float: right; margin-top: 3.5px;">
            <button id="" type="button" class="btn btn btn-new"
               style="padding: 5px 30px;">리셋</button> &nbsp;&nbsp;
            <button id="BomSave" type="button" class="btn"
               style="padding: 5px 30px;">저장</button> &nbsp;&nbsp;
            <button id="BomDataAllDelete" type="button" class="btn"
               style="padding: 5px 30px;">BOM 삭제</button> &nbsp;&nbsp;
         </span>

      </div>
   </div>
   
  
   <br>
   <div id="AA">

      <div class="right">
         <span> 등록된 공정수 : 12509 </span>
         <br>
         <br>
         <div id="Grid" style="border-top: 3px solid #168;"></div>

      </div>

     
      
   </div>
</body>

<script>
var ProcAllData

//------공정전체조회 ajax --------
$.ajax({
   url : './AllFind',
   dataType : 'json',
   async : false,
}).done( (rsts) => {
	console.log(rsts);
	ProcAllData = rsts.datas
	
})

const Grid = new tui.Grid({
	el : document.getElementById('Grid'),
	data : ProcAllData ,
	columns : [
		{ header : '공정코드'		, name : 'procCode' 	, align : 'center'},
		{ header : '공정명'		, name : 'codeName' 	, align : 'center'	, editor : 'text'},
		{ header : '공정구분'		, name : 'procFlag' 	, align : 'center'},
		{ header : '공정관리자ID'	, name : 'procEmpId' 	, align : 'center'	, editor : 'text'}
	]
})


</script>
</html>