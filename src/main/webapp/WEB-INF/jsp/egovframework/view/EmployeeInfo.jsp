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


.Test{
	background-color: darksalmon;
}

</style>

</head>
<body>

	<div style="width : 1500px ;">
		<span style="float: right;">
			<button type="button" id="helpBtn" style="border : none; background-color : #f2f7ff; color : #007b88; float : right ;">
			<i class="bi bi-question-circle"></i>
			</button>
		</span>
		<h4 style="margin-left: 10px">사원정보 관리</h4>
	</div>


   <div id="top">
      <div>
            <span style="float: right; margin-top: 3.5px;">
            <button id="AddData" type="button" class="btn"
               style="padding: 5px 30px;">추가</button> &nbsp;&nbsp;
            <button id="btnSave" type="button" class="btn"
               style="padding: 5px 30px;">저장</button> &nbsp;&nbsp;
         </span>

      </div>
   </div>
   
  
   <div id="OverallSize">

      <div style="margin-left: 10px; width: 1500px;">
         <span> 등록된사원수 : <input id="NUM"style="border:none;margin-left:5px; background-color:#f2f7ff; width:30px" disabled="true" > </span>
         <br><br>
         <div id="EmpGrid" style="border-top: 3px solid #168; height: 600px;"></div>
      </div>
	
	
	</div>
     
     <div id="dialog-form" title="사원 데이터 입력">
     	<div style="height: 200px;">
	     	<span style="color: red; font-size:12px;">* 초기비밀번호는 사번 입니다</span> 
	     	<br>
	     	<div style=" width:100%; ">
		     	이름 : <input id="empName" type="text" font-size=10px; placeholder="필수입력입니다"> <!-- <span>* 비밀번호는 생년월일 입니다.</span> -->
		     	<hr>
		     	<div style=" width:50%; float:left ">
			     	부서선택 : 
			     	<select id="dept" style="width: 100px; text-align: center;">
			     		<option value="D001">영업</option>
			     		<option value="D002">자재</option>
			     		<option value="D003">생산</option>
			     		<option value="D004">품질</option>
			     	</select>
			     	<hr>
			     	직책선택 : 
			     	<select id="position" style="width: 100px; text-align: center;">
			     		<option value="W004">사원</option>
			     		<option value="W003">반장</option>
			     		<option value="W002">공장장</option>
			     	</select>
			     	<hr>
		     	</div>
		     	<div style=" width:49%; float:right ">
		     		비고: <br>
		     		<input id="empEtc" type="text" placeholder="비고 입력 공간" style="width:300px; height: 75px; font-size:15px;">
		     	</div>
	     	</div>
     	</div>
     	<br>
     	<hr>
     	
     	<button id="ModalSave" type="button" style=" float:right" class="btn">저장</button> 
      </div> 
      
     <div id="helpModal" title="도움말">
		<hr>
		추가 : 신규 사원을 입력할수있는 모달창이 뜨면서 데이터추가가 가능하다.<br><br>
		저장 : 변경된 정보가 있다면 DB데이터 수정 이 되면서 저장이된다.<br><br>
		저장 : "담당관리자" , "입고업체" , "입고단가" 들을 <br>
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
tui.Grid.setLanguage('ko');      
//옵션세팅
themesOptions = { 
           	row: {    
                hover: {    background: '#ccc'  }// <-마우스 올라갔을떄 한row 에 색상넣기
            }
           
};


//-------- 도움말 모달 ----------
var helpModal = $( "#helpModal" ).dialog({
 autoOpen : false ,
 modal : true ,
 width:600, //너비
 height:400, //높이
 buttons: {
		"닫기" : function() {
			helpModal.dialog("close") ;
		}
	}
});
      
      
//-------- 사원입력 설정 ----------
var dialog = $( "#dialog-form" ).dialog({
   autoOpen : false ,
   modal : true ,
   width:700, //너비
   height:400 //높이
});      
      
      

var	EmpAllDatas;
//------제품조회 ajax --------
$.ajax({
   url : './EmpAllFind',
   dataType : 'json',
   async : false,
}).done( (rsts) => {
	console.log(rsts);
	EmpAllDatas = rsts.data
	document.getElementById("NUM").setAttribute("value",EmpAllDatas.length); 
})
      
      
//------사원조회 그리드 헤드 --------
const EmpGrid = new tui.Grid({
   el : document.getElementById('EmpGrid'),
   data : EmpAllDatas ,
   columns : [
      { header : '사원번호 / ID'	, name : 'empId'   		, align : 'center' },
      { header : '이름'			, name : 'empName'		, align : 'center' },
      { header : '부서명'		, name : 'deptCode'   	, align : 'center' ,
    	  	formatter: 'listItemText',
		    editor: {
			      type: 'select',
			      options: {
			        listItems: [
				        { text: '영업', value: 'D001' },
				        { text: '자재', value: 'D002' },
				        { text: '생산', value: 'D003' },
				        { text: '품질', value: 'D004' }
				    ]
			      }
			    } 
      },
      { header : '직책명'			, name : 'positionCode' , align : 'center' ,
  	  	formatter: 'listItemText',
	    editor: {
		      type: 'select',
		      options: {
		        listItems: [
			        { text: '사원', value: 'W004' },
			        { text: '반장', value: 'W003' },
			        { text: '공장장', value: 'W002' },
			        { text: '사장', value: 'W001' }
			        
			    ]
		      }
		    } 
      },
      { header : '비고'			, name : 'etc'   		, align : 'center' , editor : 'text'  }  
   ],
   columnOptions: {
	   frozenCount : 2,
	   forzenBorderWidth: 4
   },
   bodyHeight: 500
});


//데이터수정 되면 색상변경 이벤트
EmpGrid.on('afterChange' , (ev) => {
	var rowKey ;
	ev.changes.forEach( (rst) => {
		rowKey = rst.rowKey
	})
	EmpGrid.addRowClassName(rowKey , "Test")
})


//추가버튼 이벤트
AddData.addEventListener("click" , () => {
	console.log(EmpAllDatas);
	dialog.dialog( "open" ) ;
	
})

var deptData;
var position;
//모달안에 있는 저장버튼 처리
ModalSave.addEventListener("click" , () => {
	deptData = document.getElementById("dept").value
	position = document.getElementById("position").value
	var num = 0 ;
	var InpDatas;
	var empName = document.getElementById("empName").value
	var empEtc = document.getElementById("empEtc").value
	if(empName == '' || empName == null){
		alert("이름을 입력해주세요"); 
		return false; 
	}else{
		InpDatas = {
					deptCode  		: deptData,
					positionCode	: position
			 }
		   num++ ;
   		}
		if(num > 0){
			//부서 와 직급 조건별로 empId 젤큰 사원정보 찾아오는 ajax
			$.ajax({
		          url: './IdFind' ,
		          type: 'post',
		          data: JSON.stringify(InpDatas),
		          contentType: "application/json",
		          async : false, 
		          success: function(datas) {
					let rst = JSON.parse(datas)
					let rstEmpId = rst.data[0].empId ;
					rstEmpId++
					var nm = 0 ;
					var Insert;
					if(rstEmpId == '' || rstEmpId == null){
						toastr["error"]("사원번호 생성오류"); 
						return false; 
					}else{
						console.log(rstEmpId);
						Insert = {
									empId 		: rstEmpId	,
									empName 	: empName 	,
									deptCode	: deptData	,
									positionCode: position ,
									etc		: empEtc
									}
						nm++
					}
					if(nm > 0){
					}
					//사원정보 추가ajax 처리
					$.ajax({
				          url: './EmpAddData' ,
				          type: 'post',
				          data: JSON.stringify(Insert),
				          contentType: "application/json",
				          async : false, 
				          success: (rst) => {
				        	  toastr["success"]("저장되었습니다")
				        	  setTimeout(() => {
				        		 	 dialog.dialog( "close" ) ;
				            		 location.reload();
				            		 },1500 );	
			            },
			            error: (err) => {
			               alert("사원데이터 추가ajax 오류 " + err);
			            }
			         }); 
					
	            },
	            error: (err) => {
	               alert("사원번호 단건조회ajax 오류 " + err);
	            }
	         }); 
		}
})

//그리드 저장버튼 이벤트
btnSave.addEventListener('click' , (ev) => {
	var Modifie = EmpGrid.getModifiedRows();
	var Updatas = new Array();
	var dt = Modifie.updatedRows;
	if(dt.length > 0 ){
		Updatas = dt
		 $.ajax({
	          url: './UpdateDatas' ,
	          type: 'post',
	          data: JSON.stringify(Updatas),
	          contentType: "application/json",
	          async : false, 
	          success: (rst) => {
	        	  toastr["success"]("저장되었습니다")
	        	  setTimeout(() => {
	            		 location.reload();
	            		 },1000 );
          },
          error: (err) => {
             alert("사원데이터 추가ajax 오류 " + err);
          }
       });  
	}else{
		toastr["warning"]("변경된 정보가 없습니다"); 
	}
})

//------------------ 도움말 버튼 이벤트 -----------------------
helpBtn.addEventListener('mouseover' , () => {
	helpModal.dialog("open") ;
})


//그리드 색상 옵션세팅
tui.Grid.applyTheme('default', themesOptions);

</script>
</html>