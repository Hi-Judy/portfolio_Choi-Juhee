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
			<!-- 탑바 왼쪽 드롭바 -->
			<!-- <span style="margin-top: 13px; float: left;"> &nbsp;&nbsp;그룹코드
				&nbsp; <select>
					<option value="">공통관리</option>
					<option value="">불량관리</option>
			</select> -->

			</span> <span style="float: right; margin-top: 3.5px;">
				<button id="" type="button" class="btn btn btn-new"
					style="padding: 5px 30px;">리셋</button> &nbsp;&nbsp;
				<button id="btnSave" type="button" class="btn"
					style="padding: 5px 30px;">저장</button> &nbsp;&nbsp;
				<button id="btnSave" type="button" class="btn"
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
			<span style="font-size: 1.5em; color: blue"> 사용자재 관리 </span> <span
				style="float: right; margin-top: 5px; color: rgb(158, 158, 158);">
				<button id="btnAdd" type="button" class="btn">추가</button> &nbsp;
				<button id="btnS" type="button" class="btn">삭제</button>
			</span> <br> <br>

			<!-- style="overflow:scroll; width:504px; height:500px; " -->
			<div id="MatGrid"
				style="border-top: 3px solid #168; width: 504px; height: 500px;"></div>
		</div>

		<div class="right">
			<span style="font-size: 1.5em; color: blue"> 공정흐름 관리 </span> <br>
			<br>

			<div id="ProcGrid" style="border-top: 3px solid #168;"></div>

		</div>

		<div id="dialog-form" title="모달">
			<div id="ProGrid"></div>
		</div>
	</div>
</body>

<script>
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
				{ header : '제품코드'	, name : 'podtCode'	, align : 'center' },
				{ header : '제품명'	, name : 'codeName'	, align : 'center' },
				{ headet : '제품분류'	, name : 'podtFlag'	, align : 'center' }
			]
		});
		
		//------클릭한 제품 코드 선택 --------
		ProGrid.on('click' , (ev) =>{
			var proCode = ProDatas[ev.rowKey].podtCode;
			BomFindAll(proCode);
		})
		
		
		var proData ;
		var rscData ;
		var procData ;
		var MatDatas ; //자재 그리드
		
		//------BOM 전체 조회 --------
		function BomFindAll(proCode) {
			
			//------제품코드를 기준으로 제품상세 , BOM자재 , 공정흐흐름 들의정보불러오기 --------
			$.ajax({
				url : './DetailAll/'+proCode,
				dataType : 'json',
				async : false
			}).done( (rsts) =>{
				proData = rsts.ProDetail;
				document.getElementById("proId").setAttribute("value",proCode);			//제품코드
				document.getElementById("proName").setAttribute("value",proData[0].codeName);	//제품명
				document.getElementById("proFlag").setAttribute("value",proData[0].podtFlag);	//제품구분
				document.getElementById("manFlag").setAttribute("value",proData[0].manFlag);	//제품구분
				document.getElementById("proUnit").setAttribute("value",proData[0].podtUnit);	//제품 관리단위
				rscData = rsts.rscDetail;	//BOM 자재
				procData = rsts.ProcDetail;	//공정흐름
			})		
			
			MatDatas = rscData;
			MatGrid.resetData(MatDatas); //모달에서 새로 데이터를 입력할것이기 때문에 리셋하고 MatDatas 데이터로 변경하고
			MatGrid.resetOriginData();   //모달을 새로고침 해서 띄운다. / 이미있던 그리드에 값을 뒤늦게 입력해줄려면 이 두줄이 필수
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
			console.log("자재코드 조회결과")
			//grud 에 있는 listItems 형식대로 배열을 만들어서 헤드에 넣어줘야 한다.
			aaa = rsts.data
			aaa.forEach( (rsts) => {
				//그리드 형식에 맞춰서 Array 타입 에 데이트 추가
		 		dataA = {
						   text : rsts.rscCode , value : rsts.rscCode
						}
		 		dataArray.push(dataA);
				
			})
		})
		
		
						
		//------자재 그리드 헤드 --------
		const MatGrid = new Grid({
			el : document.getElementById('MatGrid'),
			data : MatDatas ,
			columns : [ 
				{ 
					header : '자재코드'	, name : 'resCode'	, align : 'center'// , editor : 'text' 
			 		  , formatter: 'listItemText',
					    editor: {
						      type: 'select',
						      options: {
						    	  //dataArray -> ajax 에서 값을받아서 Array 타입 과 그리드 형식을 갖춰서 만든 변수이다
						        listItems: dataArray
						      }
						    }
					
				},
				{ header : '자재명'	, name : 'codeName'	, align : 'center' , editor : 'text' },
				{ header : '자재소모량'	, name : 'resUsage'	, align : 'center' , editor : 'text' },
				{ header : '비고'		, name : 'resEtc'	, align : 'center' , editor : 'text' }
			]
		});
		
		
		
		//----------자재 그리드 행추가 ---------------
	    btnAdd.addEventListener("click", () => {
	    	MatGrid.appendRow({})   	
	    })
	    
	    
	    //----------자재코드로 자재명 출력 -------------
	    MatGrid.on('editingFinish' , (ev) => {
	    	var resCode  ;
	    	var jsonData ;
	    	if(ev.columnName == "resCode"){
	    	resCode = ev.value ;
	    	jsonData = { resCode : resCode } //앞에가 키값 , 뒤에서 벨류값으로 보여진다.


	    	}
	    	
	    	$.ajax({
	    		url: '' ,
	    		type: "post",
	    		data: JSON.stringify(jsonData),
	    		contentType: "application/json",
	    		async : false, //  동기식으로 처리하여 결과를 되돌린다.
	    		success: function(data) {
	    			console.log(data);
	    		/* 	result = JSON.parse( data );
	    			if ( result.res == 'success') {
	    				matrDta = result.resultData;
	    			} else {
	    				toastr.warning('해당하는 자재코드가 없습니다.');
	    			} */
	    		},
	    		error: function(err) {
	    			alert("코드명호출 에러"+err);
	    		}
	    	});
	    	

	    	
	    	
	    })
			
		
		
    
    </script>
</html>