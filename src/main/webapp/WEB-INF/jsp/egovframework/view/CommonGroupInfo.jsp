<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<meta charset="utf-8">
<title>HTML CSS Left Right Split</title>

<style>



div.left {
	float: left;
	box-sizing: border-box;
}

div.right {
	float: right;
	width: 53%;
	margin-right: 5px;
	box-sizing: border-box;
}



.btn-secondary {
    color: white;
    border-radius: 5px;
    background-color:#007b88;
    
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
		<h4 style="margin-left: 10px">공통자료 관리</h4>
	</div>
	
	<div id="top">
		<div>
			</span> <span style="float: right; margin-top: 4.5px;">
				<button id="btnAdd" type="button" class="btn"
					style="padding: 5px 30px;">자료추가</button> &nbsp;&nbsp;
				<button id="btnSave" type="button" class="btn"
					style="padding: 5px 30px;">저장</button> &nbsp;&nbsp;
			</span>

		</div>
	</div>

	<div id="OverallSize" style="margin-left: 13px;">
		<div class="left">
			<span style="font-size: 1.5em; color: blue"> 코드 </span>
			<br>
			<br>

			<div id="grid" style="border-top: 3px solid #168; width: 504px; "></div>
		</div>

		<div class="right">
			<span style="font-size: 1.5em; color: blue"> 상세보기 </span> <br>
			<br>

			<div id="grid2" style="border-top: 3px solid #168;"></div>

		</div>
	</div>
	
	<div id="helpModal" title="도움말">
		<hr>
		그룹코드 추가 와 삭제를 원하신다면 담당자를 호출해 주세요.<br><br>
		
		자료추가 버튼을 누른후 반드시 "코드ID" , "코드명" 들을기입후<br>
		저장버튼을 눌려주셔야 합니다.
	</div>
	
</body>

<script>
//옵션세팅
themesOptions = { 
            selection: {    background: '#007b88',     border: '#004082'  },//  <- 클릭한 셀 색상변경 border(테두리색) , background (백그라운드)
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

tui.Grid.applyTheme('default', themesOptions);



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
  	
   
    var Grid = tui.Grid; //그리드 선언
    
    /* Grid.applyTheme('clean' ,{
    	cell : {
    		header : {
    			background: '#f0f6f9'
    		}
    	},row: { 
    		    hover: { 
    		      background: '#dfeff7' 
    		    }
    		  }
    }); */
    
	//공통그룹tr 영역
    const columns = [
		{
			header: '그룹코드',
			name : 'groupCode',
			align : 'center',
			cssClass : 'aaa'
			
		},
		{
			header: '그룹명',
			name : 'groupName',
			align : 'center',
			cssClass : 'aaa'
		}
	]
	
  //공통코드 -> 코드구분상세보기 tr 영역
    const columns2 = [
		{
			header: '코드ID',
			name : 'code',
			editor : 'text',
			align : 'center',
			className : 'code',
			sortable: true, //얘를 기준으로 코드 정렬 가능
			//유효성 검사 (반드시 입력해야하는 칸)
			validation : {
				required : true
			}
			
		},
		{
			header: '코드명',
			name : 'codeName',
			editor : 'text',
			align : 'center',
			validation : {
				required : true
			}
		},
		{
			header: '코드 설명',
			name : 'codeDesct',
			editor : 'text',
			align : 'center'
		},
		{
			header: '사용여부',
			name : 'codeFlag',
		    formatter: 'listItemText',
		    editor: {
		      type: 'select',
		      options: {
		        listItems: [
			        { text: '사용', value: 'Y' },
			        { text: '미사용', value: 'N' }
			    ]
		      }
		    },
			align : 'center'
			
		},
		{
			header: '비 고',
			name : 'codeEtc',
			editor : 'text',
			align : 'center'
		},
		{
			header: 'DB',
			name: 'crud',
			width : 100,
			align: 'center',
			hidden : true
		},
		{
			header: '그룹코드',
			name: 'groupCode',
			hidden : true
		}
		
	]
	
	let data;
 
    //전체조회
     $.ajax({
    	url : './findIn',
    	dataType : 'json',
    	async : false
    }).done(function (datas) {
     	console.log("콘솔로그 성공");
    	console.log(datas); 
		data = datas.data
		
	});
    
    const grid = new Grid({
		el : document.getElementById('grid'),
		data : data ,
		columns ,
		bodyHeight: 379
	 
    });
    
    grid.on('click' , (ev) => {
    	
    	
    	//내가선언해준 전역변수 data 에서 로우키(몇번쨰 열 인지) 잡아서 VO에 있는 칼럼명 찾기
    	var rst = data[ev.rowKey].groupCode ;
    	
    	findSelect(rst);
    	
    	//선택한값 색상 넣고 뺴기
    	grid.setSelectionRange({
        	start: [ev.rowKey, 0],
        	end: [ev.rowKey, grid.getColumns().length-1]
        });
			
		
    });
    
    
    var data2
    //단건조회
    function findSelect(rst) {
    	let aaa = rst.toLowerCase();
    	
		$.ajax({
			url : './findSelect/'+aaa,
			dataType : 'json',
	    	async : false
		}).done(function (datas) {
			data2 = datas.data
			grid2.resetData(data2);
			grid2.resetOriginData();
			
			  
		})
	}
    
    const grid2 = new Grid({
		el : document.getElementById('grid2'),
		data : data2 ,
//		rowHeaders : ['checkbox'], //난중에 다시 해보는걸로~ 천마 정답이있긴함
		columns : columns2 ,
		bodyHeight: 379
	 
    });
    
    
    // toastr 옵션 옵션설정이 위에 먼저 와있어야 설정이 먹는다. (전역변수로 선언)
	toastr.options = {
			  "closeButton": true,  //닫기버튼(X 표시)
			  "debug": false, 		//디버그
			  "newestOnTop": false,
			  "progressBar": true,  //진행률 표시
			  "positionClass": "toast-top-center",
			  "preventDuplicates": true, 	//중복 방지(같은거 여러개 안뜸)
			  "onclick": null, 				//알림창 클릭시 alert 창 활성화 (다른것도 되는지는 연구해봐야함)
			  "showDuration": "3",
			  "hideDuration": "100",
			  "timeOut": "1500",   //사라지는데 걸리는 시간
			  "extendedTimeOut": "1000",  //마우스 올리고 연장된 시간
			  "showEasing": "swing",
			  "hideEasing": "linear",
			  "showMethod": "fadeIn",
			  "hideMethod": "fadeOut",
			  "tapToDismiss": false
			}
    
    
    //저장된 ID , NAME 값 수정안되게 처리 해주기
    grid2.on('editingStart' , (ev) => {
    	try{
    		if (ev.columnName == "code" ||  ev.columnName == "codeName"){
    			//VO 에서 임의 CRUD 값을 받아와서 이미 입력된 값으면 R 이란느 값이
    			var CRUD = grid2.getValue(ev.rowKey ,'crud'); //crud 라는 얘의 값을 가져온다
    			if ( CRUD != null && CRUD != ''){ //crud
    			
    				//success: 성공(초록) , info:정보(하늘색) , warning:경고(주황) , error:에러(빨강)
    				toastr["warning"]("변경할수없는 코드 입니다.", "경고합니다.")
    				
    				//현재 펑션을 멈춤
                    ev.stop();
    			}
    		}
    	}catch (err)
        {
            alert('예외에러 발생<위치: 338줄>' + err);
        }
    });
    
    //이미 저장된 코드 중복방지
    grid2.on('editingFinish' , (ev) => {
    	try{
    		if(ev.columnName === 'code') //타입까지 완전히 같은놈이면~?
    		{ 
    			datas = grid2.getData();
    			var i = 0;
    			var chkCodeId = true;
    			
    			datas.forEach(function (rst)
    			{
					if ( chkCodeId == true ){
						if(i != ev.rowKey ) //새로입력한 값은 맨밑으로 가니깐 무조건 0이 아니게된다.
						{
						    if(grid2.getValue(ev.rowKey ,'code' ) == rst.code)
							{
								toastr["warning"]("이미 입력한 코드입니다.", rst.code);
								chkCodeId = false;
								grid2.setValue(ev.rowKey,'code','' );
								return false;
							}
						}
					}
					i++;
				})
    		}
    		grid2.check(ev.rowKey);
    	}catch(err)
    	  {
    		alert('상세코드입력시 예외발생<위치:코드중복체크>'+err);
    	  }
    })
    
    //새자료 인썰트
    btnAdd.addEventListener("click",function(){
    	grid2.appendRow({})
    })
    
    //저장 눌렀을때 처리
    btnSave.addEventListener("click",function(ev){
    	
    	var dataCheck = grid2.getData(); //그리드2 데이터 를 변수에 담고
    	var dataSet = grid2.getModifiedRows(); // 변경된 데이터들 목록을 변수에 담고 //원본 데이터와 비교하여 변경된 데이터 목록이 포함된 개체를 반환합니다. 개체에는 'createdRows', 'updatedRows', 'deletedRows' 속성이 있습니다.
    	var dataInput = dataSet.createdRows; //데이터 목록에서 새로입력된 목록만 가지고 와서 변수에 담았다(0번 부터 들어오고, length +1 씩 증가된다)
    	var dataInputArray = new Array(); //Array() 형식으로 변수선언 Array 형식으로 배열을 담아줘야 옮기기 좋다.
  		
    	var groupCode = dataCheck[0].groupCode; //그룹코드값 가져오기
    	
    	var i = 0; //저장 할꼐 없을떄는 안되게 하기 위해
    	
    	//새로운 데이터 캐치 입력부분
    	try{
    		if(dataInput.length > 0) { //입력된값이 있으면 length 가 +1 될태니깐 무조건 체크가를 할수있다
    			dataInput.forEach(function (rst) { //입력된 목록을 forEach 로 하나하나 rst 에 넣어준다
    				if( rst.code == null || rst.code == '' ||rst.codeName == null || rst.codeName == ''){ //code 가 빈값일 경우
						toastr["error"]("필수입력코드 미입력");  //토스터 알림 호출
						return false;
					}
    				else
    					{
    					dataInput = {   //칼럼명 대로 값을 담아줘야 한다.
    								code : rst.code ,
    								codeName : rst.codeName,
    								codeDesct : rst.codeDesct,
    								codeFlag : rst.codeFlag,
    								codeEtc : rst.codeEtc,
    								groupCode : groupCode
    							}
    					
    					dataInputArray.push(dataInput); //Array 형식 변수에 data배열 값 을 담았다.
    					i++ ; //저장예외처리
    					}
				});
    			
    		}
    	}catch (err) {
			alert('저장오류'+err);
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    	
    	var dataUpdate = dataSet.updatedRows;
    	var dataUpdateArray = new Array();
    	
    	//이미있던 데이터 수정 부분
    	try{
    		if(dataUpdate.length > 0) { //입력된값이 있으면 length 가 +1 될태니깐 무조건 체크가를 할수있다
    			dataUpdate.forEach(function (rst) //입력된 목록을 forEach 로 하나하나 rst 에 넣어준다
    			{ 
    				dataUpdate = {
    						code : rst.code ,
							codeName : rst.codeName,
							codeDesct : rst.codeDesct,
							codeFlag : rst.codeFlag,
							codeEtc : rst.codeEtc,
							groupCode : groupCode
    						}
    				dataUpdateArray.push(dataUpdate);
    				i++ ;
    			})
    		}
    	
    	}
    	catch (err) 
    	{
			alert('저장오류'+err);
		}
    	
    	
    	
    	if(i > 0)
    	{
			(function () {	
		    	//인설트 (추가)
				 $.ajax({
					url : './Insert',
					type : 'post',
					data : JSON.stringify(dataInputArray), //배열로 보내줬기 떄문에 컨트롤러 에서도 배열로 받아야한다.
					contentType : 'application/json;'
					}).done(function() {
						i = 1;
						console.log("추가성공")
					});
		    	
		    	console.log(dataInputArray); //인썰트
		    	console.log(dataUpdateArray); //업데이트
		    	
		    	 //업데이트
		    	$.ajax({
		    		url : './dataUpdate',
		    		type : 'post',
		    		data : JSON.stringify(dataUpdateArray),
		    		contentType : 'application/json;'
		    	}).done(function() {
		    		i = 1;
					console.log("수정성공")
				}); 
		    	
		    	toastr["success"]("저장완료"); 
		    	
		    })();
	    	
    	}
        else
        	{
        	console.log("저장예외완료")
 //       	toastr["info"]("저장할 정보가 없습니다");  //error 에러랑 같이꺼서 일단 주석처리
        	return false;
        	}
	    
	    });
    
    helpBtn.addEventListener('mouseover' , () => {
    	helpModal.dialog("open") ;
    })
  
   
    
    </script>
</html>