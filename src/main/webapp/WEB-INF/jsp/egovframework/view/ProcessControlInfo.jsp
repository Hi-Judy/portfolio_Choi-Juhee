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

.test {
	background-color: darksalmon;
}

.FacYes{
	background-color: #59d959;
}
.FacNo{
	background-color: rgb(204, 70, 70);
}
</style>

</head>
<body>


   <div id="top">
      <div>
      		<span style="margin-top: 13px; float: left;"> &nbsp;&nbsp;공정관리</span>
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
         <span> 등록된 공정수 : 12509 </span>
         <br>
         <br>
         <div id="Grid" style="border-top: 3px solid #168; height: 600px;"></div>
      </div>
	
	<div id="dialog-form" title="작업반장 조회">
		<span>10111~ 영업팀  10211~ 자재팀  10311~ 생상팀 <br>
			  10411~ QC팀   10511~ 포장팀</span>
		<div id="EmpGrid"></div>
	</div>
	
	<div id="ModalDal" title="설비등록">
		<div>선택된 공정코드: &nbsp;<input id="ProcSelected" readonly> </div>
		 <button id="FacSave" type="button" class="btn" style="float: right; ">설비저장</button>
		<br><br>
           
		<div id="FacGrid" style="border-top: 3px solid #168;"></div>
	</div>
	
	<div id="ChangeModal" title="등록된 설비 변경">
		<div> 선택된 공정코드: &nbsp;<input id="ProcSelected2" readonly>
			  <button id="" type="button" class="btn" style="float: right; ">변경저장</button>
		</div>
		<br><br>
		
		<div class="Gridleft">
			<div> <span> 가동중인 설비 </span>
	        	<button id="" type="button" class="btn" style="float: right; margin-bottom: 5px;">삭제</button>
	        </div> 
			<div id="FacGrid3" ></div> <!-- style="border-top: 3px solid #168;" -->
		</div>
		
		<div class="Gridright" >
			
	        <div> <span> 비가동(가동준비) 설비 </span>
	        	<button id="dataflowBtn" type="button" class="btn" style="float: right; margin-bottom: 5px;">추가</button>
	        </div> 
			<div id="FacGrid2"></div> <!-- style="border-top: 3px solid #168;" -->
		</div>
	</div>
     
      
   </div>
   
   <div id="chart"></div>
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

      //-------- 관리자선택 모달 설정 ----------
      var dialog = $( "#dialog-form" ).dialog({
         autoOpen : false ,
         modal : true ,
         width:600, //너비
         height:400 //높이
      });
      
	  //-------- 설비등록 모달 설정 ----------
	  var ModalDal = $( "#ModalDal" ).dialog({
	     autoOpen : false ,
	     modal : true ,
	     width:1000, //너비
	     height:700 ,//높이
	     buttons : {"취소" : function() {
	     		ModalDal.dialog( "close" ) ;
			}
	    }
	  });
	  
	//-------- 설비등록 모달 설정 ----------
	  var ChangeModal = $( "#ChangeModal" ).dialog({
	     autoOpen : false ,
	     modal : true ,
	     width:900, //너비
	     height:705 ,//높이
	     buttons : {"취소" : function() {
	     		ModalDal.dialog( "close" ) ;
			}
	    }
	  });
      


var EmpDatas;
//------사원조회(반장만) ajax --------
$.ajax({
   url : './EmpFind',
   dataType : 'json',
   async : false,
}).done( (rsts) => {
	console.log(rsts);
	EmpDatas = rsts.datas;
	
})
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


//----------공정 그리드 헤드 ---------------
const Grid = new tui.Grid({
	el : document.getElementById('Grid'),
	data : ProcAllData ,
	columns : [
		{ header : '공정코드'		, name : 'procCode' 	, align : 'center'	, sortable : true },
		{ header : '공정명'		, name : 'codeName' 	, align : 'center'	, editor : 'text' },
		{ header : '공정구분'		, name : 'procFlag' 	, align : 'center'	,
			formatter: 'listItemText',
            editor: {
                 type: 'select',
                 options: {
                    listItems: [
                    	{ text : "재료혼합공정" , value : "재료혼합공정"},
                    	{ text : "가공공정" 	, value : "가공공정"	},
                    	{ text : "색소착색공정" , value : "색소착색공정"},
                    	{ text : "렌즈중합공정" , value : "렌즈중합공정"},
                    	{ text : "연마공정" 	, value : "연마공정"	},
                    	{ text : "분리공정" 	, value : "분리공정"	},
                    	{ text : "열처리공정" 	, value : "열처리공정"	},
                    	{ text : "제품검사공정" , value : "제품검사공정"},
                    	{ text : "제품멸균공정" , value : "제품멸균공정"},
                    	{ text : "포장공정" 	, value : "포장공정"	}
                    ]
                 }
               }
        },
        { header : '기준생산량(개)'		, name : 'facOutput' 	, align : 'center'	},
        { header : '기준시간'			, name : 'facRuntime' 	, align : 'center'	},
		{ header : '공정관리자ID'		, name : 'procEmpId' 	, align : 'center'	, editor : 'text' },
        { header : '설비등록여부'		, name : 'FacCheck' 	, align : 'center'	, editor : 'text' }
	],
	rowHeaders: ['checkbox'],
	bodyHeight : 500  //그리드 높이 조절해서 스크트롤 생성
})
FacilityCheck(ProcAllData);


	//추가버튼 누르면 그리드 행 추가해주면서 자동으로 코드입력 처리
	AddData.addEventListener('click' , (ev) => {
		let GridData = Grid.getData() ;
		let ArrNum = GridData.length ; //그리드 배열의 갯수는 렝쓰값-1 의 숫자이다
		ArrNum-- ;
		let CodeData = GridData[ArrNum].procCode; //배열마지막 값의 코드를 담고
		let CodeNum = CodeData.substring(4); //숫자만 뺴고 다 자른다
		CodeNum++ //011 이면 ++ 되고나면 12 가 되어서 0을 붙일방법을 못찾아서 하드코딩으로 붙임 미래에 100개넘어가면 문제생김
		
		Grid.appendRow({})
		Grid.setValue(GridData.length , "procCode" , "PROC0"+CodeNum);
		
	});
	
	var GridrowKey;
	var ChoiceFac
	//관리자ID칼럼 라인 클릭시 모달생성
	Grid.on('click' , (ev) => {
		GridrowKey = ev.rowKey;
		if(ev.columnName == 'procEmpId'){
			dialog.dialog( "open" ) ;
			EmpGrid.refreshLayout() ;
		}
		
		//설비 미등록 된 얘만 모달 띄워주기
		if(ev.columnName == 'FacCheck'){
			let FacCheck = Grid.getValue(GridrowKey , 'FacCheck')
			if(FacCheck == '미등록'){
				document.getElementById("ProcSelected").setAttribute("value", Grid.getValue(GridrowKey , 'procCode'));
				ModalDal.dialog("open");
				FacGrid.refreshLayout() ;
			}
			//등록완료 데이터 클릭시 모달생성 및 데이터 생성
			if(FacCheck == '등록완료'){
				document.getElementById("ProcSelected2").setAttribute("value", Grid.getValue(GridrowKey , 'procCode'));
				let ProcCodeDT = document.getElementById("ProcSelected2").value
				ChoiceFac = SelectedFacFn(ProcCodeDT)
				FacGrid3.resetData(ChoiceFac);
				FacGrid3.resetOriginData();
				
				ChangeModal.dialog("open");
				FacGrid2.refreshLayout() ;
				FacGrid3.refreshLayout() ;
				
				
			}
		}
		
	})
	// <설비변경용> 등록된 설비 그리드 헤드 위로 올려야만 작동이 되서 위로올림
	const FacGrid3 = new tui.Grid({
	   el : document.getElementById('FacGrid3'),
	   data : ChoiceFac ,
	   columns : [
	      { header : '설비번호'	, name : 'facNo'	, align : 'center' }
	   ],
	   rowHeaders: ['checkbox'],
	   bodyHeight : 400 
	});
	
	//Grid 그리드 데이터 변경처리
	EmpGrid.on('click' , (ev) => {
		Grid.setValue(GridrowKey , 'procEmpId' , EmpDatas[ev.rowKey].empId);
		 dialog.dialog( "close" ) ;
	})
	
	//데이터가 변경된다면 실행
	Grid.on('afterChange' , (ev) => {
		var rowKey ;
		ev.changes.forEach( (rst) => {
			rowKey = rst.rowKey
		})
		Grid.addRowClassName(rowKey , 'test'); //클래스 추가
	})
	
	
	
	//체크된 행 삭제처리
	btnDelete.addEventListener('click' , (ev) => {
		Grid.removeCheckedRows(true);
		
		var GridModiRow = Grid.getModifiedRows() 	;
		//삭제처리
		var DelectData	 = GridModiRow.deletedRows 	;
    	if(DelectData.length > 0) {
    		Delt(DelectData);
    	}
	});
	
	//---------- 저장버튼 이벤트 -------------
	btnSave.addEventListener('click' , (ev) => {
		var GridModiRow = Grid.getModifiedRows() 	;
		//데이터 추가
		var InputData 	= GridModiRow.createdRows  	;
		if(InputData.length > 0){
			InpData(InputData)
		}
		
		//업데이트
		var UpdateData 	= GridModiRow.updatedRows 	;
		if(UpdateData.length > 0){
			ChangeData(UpdateData)
		}
    	

	});
	
	
	//---------- 공정건별삭제 처리 -------------
	function Delt(DelectData) {
		var num = 0 ;
		var DT ;
		var DetDataArr = new Array();
			try
			{
				DelectData.forEach( (rst) => {
					if(rst.procCode == null || rst.procCode == '')
					{
						toastr["error"]("삭제할 코드가 없습니다");  
   						return false; 
					}
					else
						{
						DT = {procCode : rst.procCode}
						DetDataArr.push(DT);
						num++
						}
				});
			}catch(err){
				alert('삭제오류발생 '+ err);
			}
			if(num > 0)
			{
				$.ajax({
	   	    		 url : './Delete',
	   	    		 type : 'post',
	   	    		 data : JSON.stringify(DetDataArr),
	   	    		 contentType : 'application/json;',
	   	             async : false, 
	   	             success: (datas) => {
	   	            	 toastr["success"]("삭제 완료"); 
	   	             },
	   	             error: (err) => {
	   	                alert("삭제 ajax 오류 " + err);
	   	             }
	   	          });
			}
	}
	//---------- 공정데이터추가 처리 -------------
	function InpData(InputData) {
		var num = 0 ;
		var DI ;
		var InpDataArr = new Array();
			try
			{
				InputData.forEach( (rst) => {
					if(rst.procCode == null || rst.procCode == '')
					{
						toastr["error"]("삭제할 코드가 없습니다");  
   						return false; 
					}
					else
						{
						DI = {
								procCode  : rst.procCode  ,
								codeName  : rst.codeName  ,
								procFlag  : rst.procFlag  ,
								procEmpId : rst.procEmpId
								
							 }
						InpDataArr.push(DI);
						num++
						}
				});
			}catch(err){
				alert('데이터추가 예외 '+ err);
			}
			if(num > 0)
			{
				console.log("인설트 시작");
				$.ajax({
	   	    		 url : './AddData',
	   	    		 type : 'post',
	   	    		 data : JSON.stringify(InpDataArr),
	   	    		 contentType : 'application/json;',
	   	             async : false, 
	   	             success: (datas) => {
	   	            	 toastr["success"]("데이터 추가 완료"); 
	   	             },
	   	             error: (err) => {
	   	                alert("데이터추가 ajax에러 " + err);
	   	             }
	   	          });
			}
	}
	//---------- 공정건별 업데이트 -------------
	function ChangeData(UpdateData) {
		var num = 0 ;
		var DU ;
		var UpDataArr = new Array();
			try
			{
				UpdateData.forEach( (rst) => {
					if(rst.procCode == null || rst.procCode == '')
					{
						toastr["error"]("수정할 코드가 없습니다");  
   						return false; 
					}
					else
						{
						DU = {
								procCode  : rst.procCode  ,
								codeName  : rst.codeName  ,
								procFlag  : rst.procFlag  ,
								procEmpId : rst.procEmpId
								
							 }
						UpDataArr.push(DU);
						num++
						}
				});
			}catch(err){
				alert('데이터수정 예외 '+ err);
			}
			if(num > 0)
			{
				$.ajax({
	   	    		 url : './ChangeData',
	   	    		 type : 'post',
	   	    		 data : JSON.stringify(UpDataArr),
	   	    		 contentType : 'application/json;',
	   	             async : false, 
	   	             success: (datas) => {
	   	            	 toastr["success"]("데이터 수정 완료"); 
	   	             },
	   	             error: (err) => {
	   	                alert("데이터수정 ajax에러 " + err);
	   	             }
	   	          });
			}
	}
	
	
	
///////////////////////// 설비관리 공간 시작 //////////////////////////////-----------------------------
	
	//설비등록여부 칼럼에 textValue 넣어주고 색으로 구분지어주기
	function FacilityCheck(datas) {
		for (let i = 0 ; i<datas.length ; i++){
			if(datas[i].facOutput != null && datas[i].facRuntime != null){
				Grid.setValue(datas[i].rowKey , 'FacCheck' , '등록완료')
				Grid.addCellClassName(datas[i].rowKey , 'FacCheck' , 'FacYes')
			}else{
				Grid.setValue(datas[i].rowKey , 'FacCheck' , '미등록')
				Grid.addCellClassName(datas[i].rowKey , 'FacCheck' , 'FacNo')
			}
		} 
		
		console.log(datas[0]);
		
	}


var FacAllData

//------공정전체조회 ajax --------
$.ajax({
   url : './FacFind',
   dataType : 'json',
   async : false,
}).done( (rsts) => {
	FacAllData = rsts.datas
	
})

// 설비 그리드 헤드
const FacGrid = new tui.Grid({
	   el : document.getElementById('FacGrid'),
	   data : FacAllData ,
	   columns : [
	      { header : '설비번호'		, name : 'facNo'   		, align : 'center' },
//	      { header : '사용여부'		, name : 'facStatus'	, align : 'center' },
	      { header : '기준생산량(개)'	, name : 'facOutput'   	, align : 'center' },
	      { header : '기준시간'		, name : 'facRuntime'   , align : 'center' }
	   ],
	   rowHeaders: ['checkbox'],
	   bodyHeight : 400 
	});
	
	//------체크된 데이터 배열에 삽입 --------
	var CheckDatas = new Array() ;
	FacGrid.on('check' , (ev) => {
		CheckDatas[ev.rowKey] = FacGrid.getValue([ev.rowKey] , "facNo")
		
	});
	//------체크해제된 데이터 배열에 삭제 --------
	FacGrid.on('uncheck' , (ev) => {
		delete CheckDatas[ev.rowKey] 
	})
	
	FacSave.addEventListener('click' , (ev) => {
		var FacArray = new Array();
		for(let i = 0 ; i<CheckDatas.length ; i++){
			if(CheckDatas[i] == undefined){
				delete CheckDatas[ev.rowKey] 
			}else{
				console.log(CheckDatas[i]);
				var FacProcData = {
						procCode : document.getElementById("ProcSelected").value ,
						facNo : CheckDatas[i]
						}
				FacArray.push(FacProcData);
			}
		}
		console.log(FacArray);
		$.ajax({
	    		 url : './FacProcInput',
	    		 type : 'post',
	    		 data : JSON.stringify(FacArray),
	    		 contentType : 'application/json;',
	             async : false, 
	             success: (datas) => {
	            	 toastr["success"]("설비등록완료");
	            	 setTimeout(() => {
	            		 ModalDal.dialog( "close" ) ;
	            		 location.reload();
	            		 },1500 );		
	             },
	             error: (err) => {
	                alert("설비등록 ajax에러 " + err);
	             }
	          });
		})
		
		
		// <설비변경용> 등록된 설비 그리드 헤드
		const FacGrid2 = new tui.Grid({
	   el : document.getElementById('FacGrid2'),
	   data : FacAllData ,
	   columns : [
	      { header : '설비번호'		, name : 'facNo'   		, align : 'center' },
//	      { header : '사용여부'		, name : 'facStatus'	, align : 'center' },
	      { header : '기준생산량(개)'	, name : 'facOutput'   	, align : 'center' },
	      { header : '기준시간'		, name : 'facRuntime'   , align : 'center' }
	   ],
	   rowHeaders: ['checkbox'],
	   bodyHeight : 400 
	});
	
		const Chart = toastui.Chart;
		
		const el = document.getElementById('chart');
		const data = {
		  categories: ['Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		  series: [
		    {
		      name: 'Budget',
		      data: [5000, 3000, 5000, 7000, 6000, 4000, 1000],
		    },
		    {
		      name: 'Income',
		      data: [8000, 4000, 7000, 2000, 6000, 3000, 5000],
		    },
		  ],
		};
		const options = {
		  chart: { width: 700, height: 400 },
		};

		const chart = Chart.barChart({ el, data, options });
		// const chart = new BarChart({ el, data, options }); // 두 번째 방법


	
	function SelectedFacFn(ProcCodeDT) {
		var ChoiceFac;
         $.ajax({
             url : './SelectedFac/'+ProcCodeDT,
             dataType : 'json',
             async : false
          }).done( (rsts) =>{
        	  ChoiceFac = rsts.datas;
			  FacGrid3.refreshLayout() ;
          });
		return ChoiceFac;
	}
		
		
	//그리드2 에서 체크된 얘만 값 담기	
	var FacArray = new Array() ;
	FacGrid2.on('check' , (ev) => {
		FacArray[ev.rowKey] = FacGrid2.getValue([ev.rowKey] , "facNo")
	});
	
	
	//------체크해제된 데이터 배열에 삭제 --------
	FacGrid2.on('uncheck' , (ev) => {
		delete FacArray[ev.rowKey] 
	})
	
	
	//등록완료 모달에서 데이터추가버튼
	dataflowBtn.addEventListener('click' , (aaa) => {
		
		var After ;
		var CArray = [];
		FacArray.forEach( (rst) => {
			CArray.push(rst)
		})
		
		for(let a = 0 ; a<CArray.length ; a++){
			FacGrid3.appendRow()
			After = FacGrid3.getData();
			
			for(let b = 0 ; b<After.length ; b++){
				if(After[b].facNo != null){
					continue;
				}else{
						console.log(CArray[a])
						FacGrid3.setValue(b , "facNo" , CArray[a]);
					 }
		}
		
		}
		/* 
		console.log(
			FacGrid2.findRows({
			facNo: 1102
		})
		);
		 */
	});
	
	

</script>
</html>