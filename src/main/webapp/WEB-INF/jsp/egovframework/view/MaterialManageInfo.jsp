<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<meta charset="utf-8">
<title>HTML CSS Left Right Split</title>
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
	width: 1500px;
	height: 50px;
	margin-left: 10px;
	margin-top: 30px;
	border-top: 1px solid black;
	border-bottom: 1px solid black;
	background-color: ghostwhite;
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
	width: 67%;
	padding: 5px;
	box-sizing: border-box;
	/* background: #ece6cc; */
}

.btn {
   color: white;
   border-radius: 5px;
   background-color: cornflowerblue;
   padding: 2px 15px;
}

.inpBC{

	background-color: #d2e5eb; 
}

</style>

</head>
<body>


	<div id="top">
		<div>
			<span style="margin-top: 13px; float: left;"> &nbsp;&nbsp;자재정보관리
			</span> <span style="float: right; margin-top: 3.5px;">
				<button id="ResetBtn" type="button" class="btn"
					style="padding: 5px 30px;">새자료</button> &nbsp;&nbsp;
				<button id="" type="button" class="btn"
					style="padding: 5px 30px;">삭제</button> &nbsp;&nbsp;
				<button id="SaveBtn" type="button" class="btn"
					style="padding: 5px 30px;">저장</button> &nbsp;&nbsp;
			</span>

		</div>
	</div>

	<div id="AA">
		<div class="left">
			<span color="blue"> 코드 </span>
			<br>
			
			<div id="grid" style="border-top: 3px solid #168; width: 450px; height: 500px;"></div>
		</div>

		<div class="right">
			<br>
			

			<div style="border-top: 2px solid black;">
				<div style="height: 40px; border-bottom: 1px solid black; margin-top: 5px; margin-bottom: 5px;">
			        <span> 자재코드 <input id="rscCode" type="text" > </span> &nbsp;&nbsp; 
			        <span> 자재명 &nbsp;&nbsp; <input id="rscName" type="text" > </span>
			    </div>
			      
			    <div style="height: 40px; border-bottom: 1px solid black; margin-top: 5px; margin-bottom: 5px;">
			         <span>관리단위 <input id="rscUnit" type="text" > </span> &nbsp;&nbsp; 
			         <span>담당관리자 <input id="rscManCode" type="text" readonly> </span> &nbsp;&nbsp;
					 <span>안전재고량 <input id="" type="text" > </span> 
			    </div>
			    
			    <div style="height: 40px; border-bottom: 1px solid black; margin-top: 5px; margin-bottom: 5px;">
			         <span>입고업체 <input id="suplcomCode" type="text" readonly> </span> &nbsp;&nbsp; 
			         <span>업체명 &nbsp;&nbsp; <input id="suplcomName" class="inpBC" type="text" readonly> </span> &nbsp;&nbsp; 
			    	 <span>입고단가 <input id="rscPrc"  type="text" > </span> 
			    </div>
			    
			    <div style="width: 100%;">
				    <div style=" float: right;" >
						<input class="btn" type="button" value="자재재고 조회">
					</div>	
					<div id="grid2" style="border-top: 3px solid #168; width: 550px; height: 500px; float: left;"></div>
				</div>
			
			</div>

		</div>
	</div>
	
	<div id="dialog-form" title="관리자 조회">
		<div id="EmpGrid"></div>
		<hr>
		<input id="ModalCheck" style=" float: right;" class="btn" type="button" value="확인">
	</div>
	
	<div id="ClientModal" tite="거래처 목록">
		<div id="ClientGrid"></div>
		<hr>
		<input id="ClientGridCheck" style=" float: right;" class="btn" type="button" value="확인">
	</div>
</body>

<script>
//-------- toastr 옵션설정 ----------
toastr.options = {
        "closeButton": true,  //닫기버튼(X 표시)
        "debug": false,       //디버그
        "newestOnTop": false,
        "progressBar": true,  //진행률 표시
        "positionClass": "toast-top-center",
        "preventDuplicates": true,    //중복 방지(같은거 여러개 안뜸)
        "onclick": null,             //알림창 클릭시 alert 창 활성화 (다른것도 되는지는 연구해봐야함)
        "showDuration": "3",
        "hideDuration": "100",
        "timeOut": "2500",   //사라지는데 걸리는 시간
        "extendedTimeOut": "1000",  //마우스 올리고 연장된 시간
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut",
        "tapToDismiss": false
      }
//옵션세팅
themesOptions = { 
            selection: {    background: 'blue',     border: '#004082'  },//  <- 클릭한 셀 색상변경 border(테두리색) , background (백그라운드)
            scrollbar: {    background: '#f5f5f5',  thumb: '#d9d9d9',  active: '#c1c1c1'    }, //<- 그리드 스크롤바 옵션
            row: {    
                hover: {    background: '#ccc'  }// <-마우스 올라갔을떄 한row 에 색상넣기
            },
            cell: {   // <- 셀클릭했을떄 조건들 주는것이다.
                normal: {   background: '#fbfbfb',  border: '#e0e0e0',  showVerticalBorder: true    },// <- showVerticalBorder : 세로(아래,위) 테두리가 보이는지 여부
                header: {   background: '#eee',     border: '#ccc',     showVerticalBorder: true    },// <- showVerticalBorder : 가로(양옆) 테두리가 보이는지 여부
                rowHeader: {    border: '#eee',     showVerticalBorder: true    },// <- 행의헤더 색상영역
                editable: { background: '#fbfbfb' },//  <-편집가능한 셀들의 색상을 주는영역
                selectedHeader: { background: '#eee' },//  <- 선택한 셀의 백그라룬드	
                disabled: { text: '#b0b0b0' }// <- 편집할수없는(비활성화된) 셀들에 대한 스타일 조절
            }
};


//-------- 관리자선택 모달 설정 ----------
var dialog = $( "#dialog-form" ).dialog({
   autoOpen : false ,
   modal : true ,
   width:600, //너비
   height:530 //높이
});

//-------- 관리자선택 모달 설정 ----------
var ClientModal = $( "#ClientModal" ).dialog({
   autoOpen : false ,
   modal : true ,
   width:600, //너비
   height:530 //높이
});


//------ 자재 간략정보 조회 --------
var MaterialList
$.ajax({
   url : './MaterialListAllFind',
   dataType : 'json',
   async : false,
}).done( (rsts) => {
   	MaterialList = rsts.datas
})


	  //------자재정보 그리드헤드 --------
      const Grid = new tui.Grid({
         el : document.getElementById('grid'),
         data : MaterialList ,
         columns : [
            { header : '자재코드'	, name : 'rscCode'   , align : 'center' },
            { header : '자재명'	, name : 'rscName'   , align : 'center'  ,	width: 230 },
            { header : '사용상태'	, name : 'rscFlag'   , align : 'center' ,
          	  	formatter: 'listItemText',
        	    editor: {
        		      type: 'select',
        		      options: {
        		        listItems: [
        			        { text: '사용중', value: 'Y' },
        			        { text: '미사용', value: 'N' }
        			    ]
        		      }
        		    } 
            }
         ],
         bodyHeight: 500
      })
      
	  //------자재 단건검색 --------
      	var FindData ;
		var rcCode 		= document.getElementById("rscCode")	 //자재코드
		var	rcName	 	= document.getElementById("rscName") 	 //자재명
		var rcUnit		= document.getElementById("rscUnit") 	 //관리단위
		var rcPrc		= document.getElementById("rscPrc")		 //자재 입고단가
		var rcManCode	= document.getElementById("rscManCode")  //담당 관리자 코드
		var spcCode 	= document.getElementById("suplcomCode") //입고업체코드
		var spcName		= document.getElementById("suplcomName") //입고업체명
      Grid.on('click' , (ev) => {
		
    	 var RscCode = MaterialList[ev.rowKey].rscCode
    	 $.ajax({
    		   url : './Details/'+ RscCode ,
    		   dataType : 'json',
    		   async : false,
    		}).done( (rsts) => {
    			console.log(rsts.OneData)
    			//인풋태그에 값넣어주기
    			rcCode.value = "" ;	
    			rcCode.value = rsts.OneData.rscCode ;
    			document.getElementById("rscCode").setAttribute("readonly","");
    			document.getElementById("rscCode").setAttribute("class","inpBC");
    			
    			rcName.value = "" ;
    			rcName.value = rsts.OneData.rscName ;
    			document.getElementById("rscName").setAttribute("readonly","");	
    			document.getElementById("rscName").setAttribute("class","inpBC");
    			
    			rcUnit.value = "";
    			rcUnit.value = rsts.OneData.rscUnit ;
    			document.getElementById("rscUnit").setAttribute("readonly","");	
    			document.getElementById("rscUnit").setAttribute("class","inpBC");
    			
    			rcPrc.value = "";
    			rcPrc.value = rsts.OneData.rscPrc ;  		
    			
    			rcManCode.value = "";
    			rcManCode.value = rsts.OneData.rscManCode;
    			
    			spcCode.value = "";
    			spcCode.value = rsts.OneData.suplcomCode;
    				
    			spcName.value = "";
    			spcName.value = rsts.OneData.suplcomName;
    			
    			FindData = rsts.Datas
    			Grid2.resetData(FindData);
    			Grid2.resetOriginData();
    			
    			if(FindData.length == 0){
    				toastr["warning"]("LOT 미할당 자재입니다"); 
    			}
    		})
      })
      
      
	  //------자재정보 그리드헤드 --------
	  const Grid2 = new tui.Grid({
		  el : document.getElementById('grid2'),
		  data : FindData ,
		  columns : [
		     { header : '자재LOT'			, name : 'rscLot'   , align : 'center' },
		     { header : '자재 입고/출고 번호'	, name : 'storeNo'   , align : 'center' },
		     { header : '재고량'			, name : 'istCnt'   , align : 'center' },
		     { header : '비고'			, name : 'storeEtc'   , align : 'center' } 
		  ],
		  bodyHeight: 360
	  })
      
    var EmpDatas;
    //------사원조회(반장만) ajax --------
    $.ajax({
       url : './MatPresFind',
       dataType : 'json',
       async : false,
    }).done( (rsts) => {
    	EmpDatas = rsts.datas;
    	
    })
      
      
    //------사원조회(반장 직급만) 그리드 헤드 --------
      const EmpGrid = new tui.Grid({
         el : document.getElementById('EmpGrid'),
         data : EmpDatas ,
         columns : [
            { header : 'ID'		, name : 'empId'   	, align : 'center' },
            { header : '이름'		, name : 'empName'	, align : 'center' },
            { header : '비고'	, name : 'etc'   	, align : 'center' }
         ],
         bodyHeight: 350
      });
    
    
    var clientList;
    //------사원조회(반장만) ajax --------
    $.ajax({
       url : './ClientFind',
       dataType : 'json',
       async : false,
    }).done( (rsts) => {
    	clientList = rsts.datas;
    	
    })
      
      
    //------사원조회(반장 직급만) 그리드 헤드 --------
      const ClientGrid = new tui.Grid({
         el : document.getElementById('ClientGrid'),
         data : clientList ,
         columns : [
            { header : '업체코드'	, name : 'code'   		, align : 'center' },
            { header : '업체명'	, name : 'codeName'		, align : 'center' },
            { header : '비고'		, name : 'codeEtc'   	, align : 'center' }
         ],
         bodyHeight: 350
      });


//그리드 편집시작시 이벤트
Grid.on('editingStart' , (ev) =>{
    if( ev.columnName == 'rscFlag' ){
    	ev.stop();
    }  
})


//그리드 클릭 이벤트
var ClickRowKey ;
Grid.on('click' , (ev) => {
//selection 옵션을 주고 얘들을 세팅해야 클릭했을떄 색상이 바뀌고 색상이 사라지고 한다.
	Grid.setSelectionRange({
    	start: [ev.rowKey, 0],
    	end: [ev.rowKey, Grid.getColumns().length-1]
    }); 
	ClickRowKey = ev.rowKey;
    
})	

//-------------- 새자료버튼 이벤트 ------------------
ResetBtn.addEventListener('click' , (ev) => {
	var reDatas = []
	Grid2.resetData(reDatas) ; 	//그리드 재정의(리셋) 빈값넣어서 초기화된것처럼 보이기
	Grid.resetData(MaterialList);	//그리드에 설정되어있는 이벤트들 다 없에고 새로 데이터 정의
	
	rcCode.value = "" ;	
	document.getElementById("rscCode").readOnly = false ;
	document.getElementById("rscCode").classList.remove("inpBC")
	
	rcName.value = "" ;
	document.getElementById("rscName").readOnly = false ;
	document.getElementById("rscName").classList.remove("inpBC")
	
	rcUnit.value = "";
	document.getElementById("rscUnit").readOnly = false ;
	document.getElementById("rscUnit").classList.remove("inpBC")
	
	rcPrc.value = "";
    				
	rcManCode.value = "";
	
	spcCode.value = "";
		
	spcName.value = "";

});

//-------- 담당관리자 조회 모달 이벤트 ----------
rscManCode.addEventListener('click' , (ev) => {
	dialog.dialog( "open" ) ;
	EmpGrid.refreshLayout() ;
})

//---- Emp그리드 클릭시 색변환 하고 칼럼Data 담기 ------
var EmpId ;
EmpGrid.on('click' , (ev) => {
	EmpGrid.setSelectionRange({
    	start: [ev.rowKey, 0],
    	end: [ev.rowKey, EmpGrid.getColumns().length-1]
    });
	EmpId = EmpDatas[ev.rowKey].empId
})	

ModalCheck.addEventListener('click' , () => {
	rcManCode.value = "";
	rcManCode.value = EmpId;
	dialog.dialog( "close" ) ;
})


//-------- 입고업체조회 이벤트 (모달) ----------
suplcomCode.addEventListener('click' , () => {
	ClientModal.dialog( "open" ) ;
	ClientGrid.refreshLayout() ;
})
      
//---- 입고업체 그리드 클릭시 색변환 하고 칼럼Data 담기 ------
var ClientCode ;
var ClientName ;
ClientGrid.on('click' , (ev) => {
	ClientGrid.setSelectionRange({
    	start: [ev.rowKey, 0],
    	end: [ev.rowKey, ClientGrid.getColumns().length-1]
    });
	ClientCode = clientList[ev.rowKey].code
	ClientName = clientList[ev.rowKey].codeName
})	

ClientGridCheck.addEventListener('click' , () => {
	suplcomCode.value = "";
	suplcomCode.value = ClientCode;
	suplcomName.value = "";
	suplcomName.value = ClientName
	ClientModal.dialog( "close" ) ;
})      
      
//---- 데이터 입력 & ------
SaveBtn.addEventListener('click' , () => {
	if(rcCode.value == '' || rcCode.value == null){
		toastr["warning"]("자재코드 를 입력해주세요"); 
	}else{
		
		var Check;
		var Getclass = document.getElementById("rscCode").classList.item(0);
		if(Getclass == "inpBC"){ //수정이면 클래스에 inpBC 가 있을것이기 때문에 그걸로 판단한다
			//수정 ajax 넣는곳
			Check = UpdataFn();
		}else{
			//신규등록 ajax 넣는곳
			Check = AddData()
		}
		if(Check){
			toastr["success"]("저장완료");
			
			rcCode.value = "" ;	
			document.getElementById("rscCode").readOnly = false ;
			document.getElementById("rscCode").classList.remove("inpBC")
			rcName.value = "" ;
			document.getElementById("rscName").readOnly = false ;
			document.getElementById("rscName").classList.remove("inpBC")
			rcUnit.value = "";
			document.getElementById("rscUnit").readOnly = false ;
			document.getElementById("rscUnit").classList.remove("inpBC")
			rcPrc.value = "";
			rcManCode.value = "";
			spcCode.value = "";
			spcName.value = "";
			
			var resetdata;
			$.ajax({
			   url : './MaterialListAllFind',
			   dataType : 'json',
			   async : false,
			}).done( (rsts) => {
				resetdata = rsts.datas
			})

			Grid.resetData(resetdata);
			Grid.resetOriginData();
		}
		
	}
})



//---------------- 데이터수정 ajax --------------------
function UpdataFn() {
	var Check;
	var MadeData ; 
	var madeArray = new Array();
	if(rcCode.value != '' || rcCode.value != null){
		MadeData = {
					rscCode		:	rcCode.value,
					rscManCode	:	rcManCode.value,
					suplcomCode	:	spcCode.value,
					rscPrc		:	rcPrc.value
					}
		$.ajax({
   		 url : './UpdateMat',
   		 type : 'post',
   		 data : JSON.stringify(MadeData),
   		 contentType : 'application/json;',
            async : false, 
            success: (datas) => {
           	 Check = true ;
            },
            error: (err) => {
            	Check = false ;
                alert("자재 데이터 수정 ajax 오류 " + err);
            }
         });
	}
	return Check;
}

//----------- 데이터추가 ajax -------------
function AddData() {
	var Check;
	var OK;
	var AddMatData ;
	if(rcCode.value != '' || rcCode.value != null){
		for(let i = 0 ; i<MaterialList.length ; i++ ){
			if(MaterialList[i].rscCode == rcCode.value){
				toastr["warning"]("자재코드가 중복됩니다");
				OK = false ;
				break;
			}else{
				OK = true ;
			}
		} 
	}	
	if(OK){
		AddMatData = {
					rscCode		:	rcCode.value,
					rscName		:	rcName.value,
					rscUnit		:	rcUnit.value,
					rscPrc		:	rcPrc.value,
					rscManCode	:	rcManCode.value,
					suplcomCode	:	spcCode.value,
					suplcomName	:	spcName.value
					}
		 $.ajax({
   		 url : './AddMat',
   		 type : 'post',
   		 data : JSON.stringify(AddMatData),
   		 contentType : 'application/json;',
            async : false, 
            success: (datas) => {
           	 Check = true ;
            },
            error: (err) => {
            	Check = false ;
                alert("자재 신규등록 ajax 오류 " + err);
            }
         }); 
	}
	return Check;
}
      
      
tui.Grid.applyTheme('default', themesOptions);

</script>
</html>