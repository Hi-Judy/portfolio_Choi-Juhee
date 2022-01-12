<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<meta charset="utf-8">
<title>HTML CSS Left Right Split</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
div#top {
	height: 50px;
	margin-top: 70px;
	border-top: 1px solid black;
	border-bottom: 1px solid black;
	background-color: ghostwhite;
}

div#AA {
	height: 600px;
	margin-top: 10px; /*위에서 부터 벌어질 크기*/
}

div.left {
	float: left;
	box-sizing: border-box;
	/* border-top: 1px solid black; */
	/* border-bottom: 1px solid black; */
	padding: 5px;
}

div.right {
	float: right;
	width:53%;
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
			</span> <span style="float: right; margin-top: 5.5px;">
				<button id="btnAdd" type="button" class="btn"
					style="padding: 7px 30px;">새자료</button> &nbsp;&nbsp;
				<button id="btnSave" type="button" class="btn"
					style="padding: 7px 30px;">저장</button> &nbsp;&nbsp;
			</span>
		</div>
	</div>
	<div id="AA">
		<div class="left">
			<span style="font-size: 1.5em; color: blue"> 코드 </span> <span
				style="float: right; margin-top: 5px; color: rgb(158, 158, 158);">그룹코드
				&nbsp; <input type="text" size="10">
				<button id="btnS" type="button" class="btn">검색</button>
			</span> <br> <br>

			<!-- style="overflow:scroll; width:504px; height:500px; " -->
			<div id="grid"
				style="border-top: 3px solid #168; width: 504px; height: 500px;"></div>
		</div>

		<div class="right">
			<span style="font-size: 1.5em; color: blue"> 상세보기 </span> <br> <br>
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
    	}
    });
    
	//공통그룹tr 영역
    const columns = [
		{
			header: '그룹코드',
			name : 'groupCode'
		},
		{
			header: '그룹명',
			name : 'groupName'
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
			sortable: true,
			//유효성 검사 (반드시 입력해야하는 칸)
			validation : {
				required : true
			}
			
		},
		{
			header: '코드명',
			name : 'codeName',
			editor : 'text',
			align : 'center'
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
		columns 
    });
    
    grid.on('click' , (ev) => {
    	
    	//내가선언해준 전역변수 data 에서 로우키(몇번쨰 열 인지) 잡아서 VO에 있는 칼럼명 찾기
    	var rst = data[ev.rowKey].groupCode ;
    	
    	findSelect(rst);
			
		
    });
    grid.on('mouseover' , (ev) => {
    })
    
    let data2
    //단건조회
    function findSelect(rst) {
    	console.log(rst.toLowerCase());
    	let aaa = rst.toLowerCase();
    	
		$.ajax({
			url : './findSelect/'+aaa,
			dataType : 'json',
	    	async : false
		}).done(function (datas) {
			console.log(datas.data[0])
			 data2 = datas.data
			grid2.resetData(data2);
			grid2.resetOriginData();
		})
	}
    
    const grid2 = new Grid({
		el : document.getElementById('grid2'),
		data : data2 ,
		columns : columns2 
	 
    });
    
    grid2.on('editingStart' , (ev) => {
    	console.log(columnName);
    	try{
    		if (ev.columnName == 'code' ){
    			var data = grid2.getValue( ev.rowKey , 'data');
    			if ( data != null && data != ''){
    				toastr.warning('이미저장된 코드 입니다.');
    				ev.stop();
    			}
    		}
    	}catch (err)
        {
            alert('>>>>에러<<<<' + err);
        }
    });
    
    //새자료 인썰트
    btnAdd.addEventListener("click",function(){
    	grid2.appendRow({})
    })
    
    //저장 눌렀을때 처리
    btnSave.addEventListener("click",function(){
    	grid2.request('SaveData');
    })
   
    
    </script>
</html>