<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<meta charset="utf-8">
<title>사원정보관리</title>
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

div.Gridleft {
   float: left;
   width: 45%;
 /*  padding: 5px; */
 /*  box-sizing: border-box; */
}

div.Gridright {
   float: right;
   width: 45%;
 /*  padding: 5px; */
 /*  box-sizing: border-box; */
}


.btn {
   border-radius: 5px;
   background-color: cornflowerblue;
   padding: 2px 15px;
}

</style>

</head>
<body>


   <div id="top">
      <div>
      		<span style="margin-top: 13px; float: left;"> &nbsp;&nbsp;사원정보관리</span>
            <span style="float: right; margin-top: 3.5px;">
            <button id="AddData" type="button" class="btn"
               style="padding: 5px 30px;">추가</button> &nbsp;&nbsp;
            <button id="btnDelete" type="button" class="btn"
               style="padding: 5px 30px;">삭제</button> &nbsp;&nbsp;
            <button id="btnSave" type="button" class="btn"
               style="padding: 5px 30px;">저장</button> &nbsp;&nbsp;
         </span>

      </div>
   </div>
   
  
   <br>
   <div id="AA">

      <div class="right">
         <span> 등록된사원수 : 3579 </span>
         <br>
         <br>
         <div id="Grid" style="border-top: 3px solid #168; height: 600px;"></div>
      </div>
	
	
	</div>
     
      
   
</body>

<script>
//-------- toastr 옵션설정 ----------
toastr.options = {
        "closeButton": false,  //닫기버튼(X 표시)
        "debug": false,       //디버그
        "newestOnTop": false,
        "progressBar": false,  //진행률 표시
        "positionClass": "toast-top-center",
        "preventDuplicates": false,    //중복 방지(같은거 여러개 안뜸)
        "onclick": null,             //알림창 클릭시 alert 창 활성화 (다른것도 되는지는 연구해봐야함)
        "showDuration": "3",
        "hideDuration": "100",
        "timeOut": "2000",   //사라지는데 걸리는 시간
        "extendedTimeOut": "1000",  //마우스 올리고 연장된 시간
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut",
        "tapToDismiss": false
      }
      
//------사원조회(반장 직급만) 그리드 헤드 --------
const EmpGrid = new tui.Grid({
   el : document.getElementById('EmpGrid'),
   data : EmpDatas ,
   columns : [
      { header : 'ID'	, name : 'empId'   	, align : 'center' },
      { header : '이름'	, name : 'empName'	, align : 'center' },
      { header : 'ETC'	, name : 'etc'   	, align : 'center' }
   ]
});

</script>
</html>