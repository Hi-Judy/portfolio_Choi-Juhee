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

div#productView {
   width: 1500px;
   margin-left: 10px;
   margin-top: 15px;
   border-top: 3px solid black;
   height: 94.5px;
   border-bottom: 1px solid black;
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
   padding: 5px;
}

div.right {
   float: right;
   width: 30%;
   padding: 5px;
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
         <!-- 탑바 왼쪽 드롭바 -->
         <!-- <span style="margin-top: 13px; float: left;"> &nbsp;&nbsp;그룹코드
            &nbsp; <select>
               <option value="">공통관리</option>
               <option value="">불량관리</option>
         </select> 
            </span>-->
            
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
   
   <!-- 제품정보 보여주는 div 공간 -->
   <div id="productView">
      <div
         style="height: 40px; border-bottom: 1px solid black; margin-top: 5px; margin-bottom: 5px;">
         <span>제품코드 <input id="proId" type="text" readonly>
         </span> &nbsp;&nbsp; <span> 제품명 <input id="proName" type="text"
            readonly>
         </span>
      </div>
      <div style="height: 40px; margin-top: 7px; margin-bottom: 5px;">
         <span>제품분류 <input id="proFlag" type="text" readonly>
         </span> &nbsp;&nbsp; <span>생산구분 <input id="manFlag" type="text"	
            readonly>&nbsp;
         </span> <span>관리단위 <input id="proUnit" type="text" readonly>
         </span>
      </div>

   </div>

   <br>
   <div id="AA">
      <div class="left">
         <span style="font-size: 1.5em; color: blue"> 사용자재 관리 </span>
          <span style="float: right; margin-top: 5px; color: rgb(158, 158, 158);">
            <button id="btnLeftAdd" type="button" class="btn">추가</button> &nbsp;
            <button id="btnLeftDel" type="button" class="btn">삭제</button>
         </span> <br> <br>

         <!-- style="overflow:scroll; width:504px; height:500px; " -->
         <div id="MatGrid"
            style="border-top: 3px solid #168; width: 800px; height: 500px;"></div>
      </div>

      <div class="right">
         <span style="font-size: 1.5em; color: blue"> 공정흐름 관리 </span>
         <span style="float: right; margin-top: 5px; color: rgb(158, 158, 158);">
            <button id="btnRightAdd" type="button" class="btn">추가</button> &nbsp;
            <button id="btnRightDel" type="button" class="btn">삭제</button>
         </span>
         <br>
         <br>

         <div id="ProcGrid" style="border-top: 3px solid #168;"></div>

      </div>

      <div id="dialog-form" title="모달">
         <div id="ProGrid"></div>
      </div>
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

      //-------- 모달 설정 ----------
      var dialog = $( "#dialog-form" ).dialog({
         autoOpen : false ,
         modal : true ,
         width:600, //너비
         height:400 //높이
      });
      
      //------제품선택 모달 --------
         $("#proId").on('click' , () => {
            dialog.dialog( "open" ) ;
            ProGrid.refreshLayout() ; //그리드는 새로고침해서 빠르게 다시 가져오는 함수
      });
      
      var Grid = tui.Grid;
      
      var ProDatas;
      
      //------제품조회 ajax --------
      $.ajax({
         url : './ProFind',
         dataType : 'json',
         async : false,
      }).done( (rsts) => {
         ProDatas = rsts.data
      })
      
      //------제품 모달 그리드 헤드 --------
      const ProGrid = new Grid({
         el : document.getElementById('ProGrid'),
         data : ProDatas ,
         columns : [
            { header : '제품코드'   , name : 'podtCode'   , align : 'center' },
            { header : '제품명'   , name : 'codeName'   , align : 'center' },
            { header : '제품분류'   , name : 'podtFlag'   , align : 'center' }
         ]
      });
      
      //------클릭한 제품 코드 선택 --------
      ProGrid.on('click' , (ev) =>{
         var proCode = ProDatas[ev.rowKey].podtCode;
         BomFindAll(proCode);
      })
      
      
      var proData ;
      var rscData ;
      var pData ;
      var ProcData ;
      var MatDatas ; 
      
      //------BOM 전체 조회 --------
      function BomFindAll(proCode) {
         
         //------제품코드를 기준으로 제품상세 , BOM자재 , 공정흐흐름 들의정보불러오기 --------
         $.ajax({
            url : './DetailAll/'+proCode,
            dataType : 'json',
            async : false
         }).done( (rsts) =>{
            proData = rsts.ProDetail;
            document.getElementById("proId").setAttribute("value",proCode);         //제품코드
            document.getElementById("proName").setAttribute("value",proData[0].codeName);   //제품명
            document.getElementById("proFlag").setAttribute("value",proData[0].podtFlag);   //제품구분
            document.getElementById("manFlag").setAttribute("value",proData[0].manFlag);   //제품구분
            document.getElementById("proUnit").setAttribute("value",proData[0].podtUnit);   //제품 관리단위
            rscData = rsts.rscDetail;   //BOM 자재
     		console.log(rscData);
            pData = rsts.ProcDetail;   //공정흐름
         })      
         
         MatDatas = rscData;          //제품코드 기준 등록된 자재소모량 정보 조회
         MatGrid.resetData(MatDatas); //모달에서 새로 데이터를 입력할것이기 때문에 리셋하고 MatDatas 데이터로 변경하고
         MatGrid.resetOriginData();   //모달을 새로고침 해서 띄운다. / 이미있던 그리드에 값을 뒤늦게 입력해줄려면 이 두줄이 필수
         
         ProcData = pData ;           //제품코드 기준 등록된 공정흐름 정보 조회
         ProcGrid.resetData(ProcData);
         ProcGrid.resetOriginData();
         
 //        MatGrid.appendRow({})  
         dialog.dialog( "close" ) ;
         
      }
      
      var aaa ;
      var dataA ;
      var dataArray = new Array();
      
      //------자재코드 조회--------
      $.ajax({
         url : './rscFind',
         dataType : 'json',
         async : false,
      }).done( (rsts) => {
         //grud 에 있는 listItems 형식대로 배열을 만들어서 헤드에 넣어줘야 한다.
         aaa = rsts.data
         aaa.forEach( (rsts) => {
            //그리드 형식에 맞춰서 Array 타입 에 데이트 추가
             dataA = { text : rsts.rscCode , value : rsts.rscCode }
             dataArray.push(dataA);
            
         })
      })
      
       var bbb ;
      var dataB ;
      var ProcDataArray = new Array();
       //------공정코드 조회--------
      $.ajax({
         url : './ProcFind',
         dataType : 'json',
         async : false,
      }).done( (rsts) => {
         //grud 에 있는 listItems 형식대로 배열을 만들어서 헤드에 넣어줘야 한다.
         bbb = rsts.data
         bbb.forEach( (rsts) => {
            //그리드 형식에 맞춰서 Array 타입 에 데이트 추가
             dataB = {
                     text : rsts.code , value : rsts.code
                  }
             ProcDataArray.push(dataB);
            
         })
      })
      
                 
      //------자재 그리드 헤드 --------
      const MatGrid = new Grid({
         el : document.getElementById('MatGrid'),
         data : MatDatas ,
         columns : [ 
            { 
               header : '자재코드'   , name : 'resCode'   , align : 'center' , validation : { required : true } , 
                   formatter: 'listItemText',
                   editor: {
                        type: 'select',
                        options: {
                           //dataArray -> ajax 에서 값을받아서 Array 타입 과 그리드 형식을 갖춰서 만든 변수이다
                          listItems: dataArray
                        }
                      }
           	 },
            { header : '자재명'   	, name : 'codeName'   	, align : 'center'},
            { header : '단위'   		, name : 'rscUnit'   	, align : 'center'},
            { header : '자재소모량'   	, name : 'resUsage'   	, align : 'center' , editor : 'text' 	, validation : { required : true }  },
            { header : '공정코드'     	, name : 'procCode'   	, align : 'center' , editor : 'text'	, validation : { required : true }, 
                formatter: 'listItemText',
                editor: {
                     type: 'select',
                     options: {
                        //dataArray -> ajax 에서 값을받아서 Array 타입 과 그리드 형식을 갖춰서 만든 변수이다
                       listItems: ProcDataArray
                     }
                   }
            },
            { header : '비고'      	, name : 'resEtc'   	, align : 'center' , editor : 'text'	},
            { header : 'DB'			, name: 'crud'		  	, hidden : true }
         ],
         rowHeaders: ['checkbox']
      });
      
      
      //제품코드로 조회해서 가져온 코드는 변경 안되도록 해주기
      MatGrid.on('editingStart' , (ev) => {
      	try{
      		if (ev.columnName == "resCode"){
      			var CRUD = MatGrid.getValue(ev.rowKey ,'crud'); 
      			if ( CRUD != null && CRUD != ''){ 
      				//success: 성공(초록) , info:정보(하늘색) , warning:경고(주황) , error:에러(빨강)
      				toastr["warning"]("저장된 자재코드는 수정이 불가능합니다.")
      				ev.stop();
      			}
      		}
      	}catch (err)
          {
              alert('코드수정 방지 에러 ' + err);
          }
      });
      
    	
       //----------자재코드로 자재명 출력 부분 -------------
       MatGrid.on('editingFinish' , (ev) => {
          var resCode  ;
          var jsonData ;
          if(ev.columnName == "resCode"){
          resCode = ev.value ;
          jsonData = { resCode : resCode } //앞에가 키값 , 뒤에서 벨류값으로 보여진다.
          var Metadata = getCodeNm(jsonData)  //ajax 호출해서 리턴값을 돌려받는다.
            if ( Metadata != '' || Metadata != null || Metadata != undefined ) {
               MatGrid.setValue(ev.rowKey , 'codeName' , Metadata);
            }
          

          var MaterialUnit = getUnitFn(jsonData) //자재단위 호출
          if ( MaterialUnit != '' || MaterialUnit != null || MaterialUnit != undefined ) {
              MatGrid.setValue(ev.rowKey , 'rscUnit' , MaterialUnit);
           }
          }
          
          
          //----------자재코드 중복체크 -------------
          var i = 0 ;
          var Datas ;
             if(ev.columnName === 'resCode' )
                {
                 Datas = MatGrid.getData();
                var chkCodeId = true;
                Datas.forEach( (rst) => {
                   if (chkCodeId == true )
                      {
                      if(i !=ev.rowKey)
                         {
                         if(MatGrid.getValue(ev.rowKey , 'resCode') == rst.resCode)
                            {
                               toastr["warning"]("이미 입력한 코드입니다.", rst.code);
                               chkCodeId = false;
                               MatGrid.setValue(ev.rowKey , 'resCode'  , '');
                                MatGrid.setValue(ev.rowKey , 'codeName' , '');
                                return false;
                            }
                         }
                      }
                      i++;
                   });
                }     
       });
       
          

          //----------자재코드로 자재명 처리 -------------
          function getCodeNm(jsonData) {
            
          var Metadata ; 
          var CodeName ;
          $.ajax({
             url: './proNameFind' ,
             type: "post",
             dataType: 'json',
             data: JSON.stringify(jsonData),
             contentType: "application/json",
             async : false, //  동기식으로 처리하여 결과를 되돌린다.
             success: function(datas) {
                CodeName = datas.data
                if(CodeName != null ){
                   Metadata = CodeName.codeName;
                }else{
                   toastr["warning"]("자재명이 없는 코드입니다.")
                }
             },
             error: function(err) {
                alert("코드명호출 에러 " + err);
             }
          });
          
          return Metadata;
          
          
       };
       
     //----------자재코드로 자재단위 호출 -------------
       function getUnitFn(jsonData) {
         
       var Unitdata ; 
       var MatUnit ;
       $.ajax({
          url: './proNameFind' ,
          type: "post",
          dataType: 'json',
          data: JSON.stringify(jsonData),
          contentType: "application/json",
          async : false, //  동기식으로 처리하여 결과를 되돌린다.
          success: function(datas) {
        	  MatUnit = datas.rscUnit
              if(MatUnit != null ){
            	  Unitdata = MatUnit.rscUnit;
              }else{
                 toastr["warning"]("자재단위가 없는 코드입니다.")
              }
           },
          error: function(err) {
             alert("코드단위 호출 에러 " + err);
          }
       });
       
       return Unitdata;
       
       
    };
       
 ///////// ↑↑↑ 자재코드 //////////////// ↓↓↓ 공정 관련코드 //////////////////      
       
       
     
       
       //------공정흐름 그리드 헤드 --------
      const ProcGrid = new Grid({
         el : document.getElementById('ProcGrid'),
         data : ProcData ,
         columns : [ 
            { header : '공정순서'   , name : 'procIndex'   , align : 'center', sortable : true },
            { header : '공정코드'   , name : 'procCode'   , align : 'center' , validation : { required : true } ,
               	   formatter: 'listItemText',
                editor: {
                     type: 'select',
                     options: {
                       listItems: ProcDataArray
                     }
                   } 
            
            },
            { header : '공정명'   , name : 'codeName'   , align : 'center' },
            { header: 'DB'		, name: 'crud'		  , hidden : true }
         ]
      });
       
       
      //제품코드로 조회해서 가져온 코드는 변경 안되도록 해주기
      ProcGrid.on('editingStart' , (ev) => {
      	try{
      		if (ev.columnName == "procCode"){
      			var CRUD = ProcGrid.getValue(ev.rowKey ,'crud'); 
      			if ( CRUD != null && CRUD != ''){ 
      				//success: 성공(초록) , info:정보(하늘색) , warning:경고(주황) , error:에러(빨강)
      				toastr["warning"]("저장된 공정코드는 수정이 불가능합니다.")
      				ev.stop();
      			}
      		}
      	}catch (err)
          {
              alert('코드수정 방지 에러 ' + err);
          }
      });
       
       
       
   	   //----------공정코드로 공정명 불러오는기능 -------------
       ProcGrid.on('editingFinish' , (ev) => {
    	   
    	   var procCode  ;
           var JsonData ;
           if(ev.columnName == "procCode"){
        	   procCode = ev.value ;
        	   JsonData = { procCode : procCode } //앞에가 키값 , 뒤에서 벨류값으로 보여진다.
            var PrNmData = getCoNm(JsonData)  //ajax 호출해서 리턴값을 돌려받는다.
             if ( PrNmData != '' || PrNmData != null || PrNmData != undefined ) {
            	 ProcGrid.setValue(ev.rowKey , 'codeName' , PrNmData);
             } 
           }
           
           
         //----------공정코드 중복체크 -------------
           var i = 0 ;
           var Datas ;
              if(ev.columnName === 'procCode' )
                 {
                  Datas = ProcGrid.getData();
                 var chkCodeId = true;
                 Datas.forEach( (rst) => {
                    if (chkCodeId == true )
                       {
                       if(i !=ev.rowKey)
                          {
                          if(ProcGrid.getValue(ev.rowKey , 'procCode') == rst.procCode)
                             {
                                toastr["warning"]("이미 선택된 공정입니다");
                                chkCodeId = false;
                                ProcGrid.setValue(ev.rowKey , 'procCode'  , '');
                                ProcGrid.setValue(ev.rowKey , 'codeName' , '');
                                 return false;
                             }
                          }
                       }
                       i++;
                    });
                 }
       });
       
       
       //----------공정코드로 공정명 호출 함수 -------------
       function getCoNm(JsonData) {
         
       var PrNmData ; 
       var CoNm ;
       $.ajax({
          url: './ProcNmFind' ,
          type: "post",
          dataType: 'json',
          data: JSON.stringify(JsonData),
          contentType: "application/json",
          async : false, //  동기식으로 처리하여 결과를 되돌린다.
          success: function(datas) {
        	  CoNm = datas.data
             if(CoNm != null ){
            	 PrNmData = CoNm.codeName;
             }else{
                toastr["warning"]("공정명이 없는 코드입니다")
             }
          },
          error: function(err) {
             alert("공정명 호출 에러 " + err);
          }
       });
       
       return PrNmData;
       
       
    };
    
     //----------BOM 저장버튼 ---------------
     BomSave.addEventListener("click" , () => {
    	var Check = 0 ;
    	//공정흐름 영역
    	var ProcModiRow = ProcGrid.getModifiedRows();
    	
    	var ProcInput = ProcModiRow.createdRows ;
	    	if(ProcInput.length > 0) {
	    		let attr = Pinpt(ProcInput);
	    		if(attr){
	    			Check++;
	    			console.log("공정 데이터 추가완료")
	    		}
	    	}
	    	
    	
    	//자재 영역
    	var MatModiRow = MatGrid.getModifiedRows();
    	
    	var MatInput = MatModiRow.createdRows ;
	    	if(MatInput.length > 0) {
	    		let attr = Minpt(MatInput);
	    		if(attr){
	    			Check++;
	    			console.log("자재 데이터 추가완료")
	    		}
	    	}
	 
	    var MatUpdate = MatModiRow.updatedRows;
	    	if(MatUpdate.length>0){
	    		let attr = MUpdate(MatUpdate);
	    		if(attr){
	    			Check++;
	    			console.log("자재 업데이트")
	    		}
	    	}
	    	
	    	
    	var MatDelete = MatModiRow.deletedRows ;
	    	if(MatDelete.length > 0) {
	    		MDelt(MatDelete);
	    	}
	    	
	    	
	    	
	    if(Check > 0){
      		toastr["success"]("데이터 저장완료",Check+" 건"); 
	    }
    	
     })
     
     //---------- BOM 삭제버튼 이벤트 ---------------
     BomDataAllDelete.addEventListener("click" , () => {
    	var proIdValue = document.getElementById("proId").value;
  	   
 	  	if(proIdValue == '' || proIdValue == null)
 	   		{
 		   		toastr["warning"]("조회된 BOM정보가 없습니다")
 	   		}
 	   		else
 	   		{
 		 		if(confirm(proIdValue + '의 BOM을 삭제 하시겠습니까?'))
 		 		{
	    		  		Pdelete(proIdValue);
	    		  		Mdelete(proIdValue);
	    		  		ProcGrid.clear();
	    		  		MatGrid.clear();
	    	   		}
 	   		}	    
    	 
     })
    	
      
             
      //----------자재 그리드 행추가 ---------------
       btnLeftAdd.addEventListener("click", () => {
          MatGrid.appendRow({})      
          
          
       })
       
       btnLeftDel.addEventListener("click", () => {
          MatGrid.removeCheckedRows(true);
          
       })
       
       //----------공정흐름 그리드 행추가 ---------------
       btnRightAdd.addEventListener("click", () => {
           
           //index 숫자 증가 부분
           var indexData ;
           var ProcGridData = ProcGrid.getData();
           ProcGridData.forEach( (datas) => {
              indexData = datas.procIndex ; 
              RowKey = datas.rowKey;
           })
           if(indexData == undefined || indexData == null){
              indexData = 1; //첫번째 행에선 undefined 이 뜨기떄문에 +1
           }else{

              indexData++; //2번째 행부턴 이미 있는값에 +1씩
           }
           
           ProcGrid.appendRow({}) //여기서 미리 행을 추가해줘야 rowKey 가 밑에서 잡힌다
           
           //rowKey 찾는 영역(위에선 못찾음)
           var Pdata = ProcGrid.getData();
           var RowKey ;
           Pdata.forEach( (datas) => {
              RowKey = datas.rowKey
           })

           ProcGrid.setValue(RowKey , 'procIndex' , indexData);

       })
       
       btnRightDel.addEventListener('click' , (ev) => {
    	   var proIdValue = document.getElementById("proId").value;
    	   
    	  	if(proIdValue == '' || proIdValue == null)
    	   		{
    		   		toastr["info"]("조회된 BOM정보가 없습니다")
    	   		}
    	   		else
    	   		{
    		 		if(confirm('공정흐름을 초기화 하시겠습니까?'))
    		 		{
	    		  		Pdelete(proIdValue); 	//DB랑 먼저 연결해서 삭제를 해줘야 알림창이 정상적으로 뜬다
	    		  		ProcGrid.clear();		//View 에서 삭제를 해줘야한다.
	    	   		}
    	   		}	    
       })
       	
       
       
    	
       //공정 데이터 추가(인설트)
       function Pinpt(ProcInput) {
    	 var proIdValue = document.getElementById("proId").value ;
    	 var num = 0 ;	
    	 var PI ;
    	 var ProcInpData = new Array();
    	 var Check = false ;
	     	 try{
	    		 ProcInput.forEach( (rst) => {
	    			 if(rst.procCode == null || rst.procCode == '' || rst.procCode == undefined)
	    			 {
	    				toastr["error"]("공정코드 미입력");  
						return false; 
	    			 }
	    			 else
	    				 {
	    				 PI = {
		    					procCode  : rst.procCode,
		    					podtCode  : proIdValue,
		    					procIndex : rst.procIndex
		    				 }
		    			   ProcInpData.push(PI);
		    			   num++ ;
	    				 }
	    		 });
	    		 
	    	 }catch (err) {
	 			alert('공정추가 오류 '+ err);
	 		} 
	    if(num>0){ 
	    	 $.ajax({
	    		 url : './ProcInsert',
	    		 type : 'post',
	    		 data : JSON.stringify(ProcInpData),
	    		 contentType : 'application/json;',
	             async : false, 
	             success: (datas) => {
	            	 Check = true ;

	             },
	             error: (err) => {
	                alert("공정데이터 추가 ajax 오류 " + err);
	             }
	          });
	    	}
    	 return Check;
		}
    
	  //공정흐름 삭제 이벤트처리
   	  function Pdelete(proIdValue) {
			var param = {podtCode : proIdValue}
			var PgridDt = ProcGrid.getData() ;
			
			if(PgridDt.length > 0) {
				
			
				$.ajax({
	 	    		 url : './ProcDelete',
	 	    		 type : 'post',
	 	    		 data : JSON.stringify(param),
	 	    		 contentType : 'application/json;',
	 	             async : false, 
	 	             success: (datas) => {
	 	            	 console.log(datas);
	 	            	 toastr["success"]("공정흐름 데이터 삭제완료"); 
	 	             },
	 	             error: (err) => {
	 	                alert("공정흐름 삭제 오류 " + err);
	 	             }
	 	          });  
			}else{
				toastr["info"]("삭제할 데이터가 없습니다"); 
			}
	    	
		}
	  
	  
   	//자재 데이터 추가(인설트)
    function Minpt(MatInput) {
   	 var proIdValue = document.getElementById("proId").value ;
   	 var num = 0 ;	
   	 var MI ;
   	 var Check = false ;
   	 var MatInpData = new Array();
	     	 try{
	     		MatInput.forEach( (rst) => {
	    			 if(rst.resCode == null || rst.resCode == '' || rst.resCode == undefined || rst.procCode == null || rst.procCode == '')
	    			 {
	    				toastr["error"]("필수입력코드 미입력");  
						return false; 
	    			 }
	    			 else
	    				 {
	    				 MI = {
	    						 podtCode 	: proIdValue,
	    						 resCode  	: rst.resCode,
	    						 resUsage 	: rst.resUsage,
	    						 procCode	: rst.procCode,
	    						 resEtc 	: rst.resEtc
		    				 }
	    				 MatInpData.push(MI);
		    			   num++ ;
	    				 }
	    		 });
	    		 
	    	 }catch (err) {
	 			alert('자재 데이터 오류 '+ err);
	 		} 
	    	 
	    	 if(num > 0){ 
		    	 $.ajax({
		    		 url : './ResInsert',
		    		 type : 'post',
		    		 data : JSON.stringify(MatInpData),
		    		 contentType : 'application/json;',
		             async : false, 
		             success: (datas) => {
		            	 Check = true ;
		             },
		             error: (err) => {
		                alert("자재데이터 추가 ajax 오류 " + err);
		             }
		          });
	    	 }
	    	 return Check ;
		}
   	
   	
    //---------- 자재 업데이트 ---------------
   	function MUpdate(MatUpdate) {
   		var proIdValue = document.getElementById("proId").value ;
      	 var num = 0 ;	
      	 var MU ;
      	 var Check = false ;
      	 var MatUpdtData = new Array();
   	     	 try{
   	     		MatUpdate.forEach( (rst) => {
	   	     		 if(rst.resCode == null || rst.resCode == '' || rst.resCode == undefined || rst.procCode == null || rst.procCode == '')
	    			 {
	    				toastr["error"]("필수입력코드 미입력");  
						return false; 
	    			 }
	    			 else
	    				 {
	    				 MU = {
	    						 podtCode 	: proIdValue,
	    						 resCode  	: rst.resCode,
	    						 resUsage 	: rst.resUsage,
	    						 procCode	: rst.procCode,
	    						 resEtc 	: rst.resEtc
		    				 }
   	    				MatUpdtData.push(MU);
   		    			   num++ ;
   	    				 }
   	    		 });
   	    		 
   	    	 }catch (err) {
   	 			alert('자재 데이터 오류 '+ err);
   	 		} 
   	    	 
   	    	 if(num > 0){ 
   		    	 $.ajax({
   		    		 url : './ResUpdate',
   		    		 type : 'post',
   		    		 data : JSON.stringify(MatUpdtData),
   		    		 contentType : 'application/json;',
   		             async : false, 
   		             success: (datas) => {
   		            	 Check = true ;
   		             },
   		             error: (err) => {
   		                alert("자재 업데이트 ajax 오류 " + err);
   		             }
   		          });
   	    	 }
   	    	 return Check ;
		
	}
   	
   	
    //---------- 자재 체크된 데이터 삭제 ---------------
   	function MDelt(MatDelete) {
      	 var num = 0 ;	
      	 var MU ;
      	 var MatDeltData = new Array();
   	     	 try{
   	     		MatDelete.forEach( (rst) => {
   	    			 if(rst.resCode == null || rst.resCode == '' || rst.resCode == undefined)
   	    			 {
   	    				toastr["error"]("삭제할 코드가 없습니다");  
   						return false; 
   	    			 }
   	    			 else
   	    				 {
   	    				MU = { resCode : rst.resCode }
	   	    				 
	   	    				MatDeltData.push(MU);
	   		    			   num++ ;
   	    				 }
   	    		 });
   	    		 
   	    	 }catch (err) {
   	 			alert('자재 삭제 오류 '+ err);
   	 		} 
   	    	 
   	    	if(num > 0){ 
   	    	 $.ajax({
   	    		 url : './ResDelete',
   	    		 type : 'post',
   	    		 data : JSON.stringify(MatDeltData),
   	    		 contentType : 'application/json;',
   	             async : false, 
   	             success: (datas) => {
   	            	 console.log(datas);
   	            	 toastr["success"]("자재 삭제 완료"); 
   	             },
   	             error: (err) => {
   	                alert("자재 삭제 ajax 오류 " + err);
   	             }
   	          });
   	    	}
      	 	
	}
    
    
  	  //자재 BOM 전체 삭제
 	  function Mdelete(proIdValue) {
			var param = {podtCode : proIdValue}
			var MgridDt = MatGrid.getData() ;
			
			if(MgridDt.length > 0) {
				
			
				$.ajax({
	 	    		 url : './ResAllDelete',
	 	    		 type : 'post',
	 	    		 data : JSON.stringify(param),
	 	    		 contentType : 'application/json;',
	 	             async : false, 
	 	             success: (datas) => {
	 	            	 console.log(datas);
	 	            	 toastr["success"]("자재 데이터 삭제 완료"); 
	 	             },
	 	             error: (err) => {
	 	                alert("자재BOM 삭제 오류 " + err);
	 	             }
	 	          });  
			}else{
				toastr["info"]("삭제할 데이터가 없습니다"); 
			}
	    	
		}
      
      
    
    </script>
</html>