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
			<span style="margin-top: 13px; float: left;"> &nbsp;&nbsp;그룹코드
				&nbsp; <select>
					<option value="">공통관리</option>
					<option value="">불량관리</option>
			</select>
			</span> <span style="float: right; margin-top: 3.5px;">
				<button id="btnAdd" type="button" class="btn"
					style="padding: 5px 30px;">자료추가</button> &nbsp;&nbsp;
				<button id="btnSave" type="button" class="btn"
					style="padding: 5px 30px;">저장</button> &nbsp;&nbsp;
			</span>

		</div>
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
  	
   
    var Grid = tui.Grid; //그리드 선언
    
    Grid.applyTheme('clean' ,{
    	cell : {
    		header : {
    			background: '#f0f6f9'
    		}
    	},row: { 
    		    hover: { 
    		      background: '#dfeff7' 
    		    }
    		  }
    });
    
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
			editor : 'text',
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
    /* 	console.log("콘솔로그 성공");
    	console.log(datas); */
		data = datas.data
		
		
	});
    
    const grid = new Grid({
		el : document.getElementById('grid'),
		data : data ,
		columns 
	 
    });
    
    grid.on('click' , (ev) => {
    	
    	
    	//내가선언해준 전역변수 data 에서 로우키(몇번쨰 열 인지) 잡아서 VO에 있는 칼럼명 찾기
    	var rst = data[ev.rowKey].groupCode ;
    	
    	findSelect(rst);
			
		
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
		columns : columns2 
	 
    });
    
    // toastr 옵션 옵션설정이 위에 먼저 와있어야 설정이 먹는다. (전역변수로 선언)
	toastr.options = {
			  "closeButton": true,  //닫기버튼(X 표시)
			  "debug": false, 		//디버그
			  "newestOnTop": false,
			  "progressBar": true,  //진행률 표시
			  "positionClass": "toast-top-center",
			  "preventDuplicates": false, 	//중복 방지(같은거 여러개 안뜸)
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
  
   
    
    </script>
</html>