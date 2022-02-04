<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js">
	
</script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

</head>
<body>
	<h2>생산 현황</h2>
	<br>

	<!-- 생산지시서 조회 -->
	<div class="manToday">
		<p style="display: inline-block;">작업일</p>

		<input id="txtManDate" type="date" name="manDate"
			style="display: inline-block;">
		<button type="button" id="btnSearchCommand"
			style="display: inline-block;">조회</button>

		<button type="button" id="btnStart" style="display: inline-block;">시작</button>

		<button type="button" id="btnEnd" style="display: inline-block;">종료</button>

	</div>
	<br>

	<div>
		<p style="display: inline-block;">작업일</p>
		<p id="manDate" style="display: inline-block;"></p>
		<br>

		<p style="display: inline-block;">제품코드</p>
		<p id="podtCode" style="display: inline-block;"></p>
		<br>

		<p style="display: inline-block;">제품명</p>
		<p id="podtName" style="display: inline-block;"></p>
		<br>

	</div>
	
	<div >
		<p style="display: inline-block;">생산지시번호</p>
		<p id="comCode" style="display: inline-block;"></p>
		<br>
	</div>
	<br>

	<!-- 생산지시서 조회 모달 -->
	<div id="dialog-form-manCommand" title="생산지시 조회">
		<div id="gridManCommand"></div>
	</div>

	<!-- 공정현황 그리드 -->
	<div id="gridProcess" class="col-sm-11" style="float: left;"></div>


	<script>
		var Grid = tui.Grid; //그리드 객체 생성
	
		Grid.applyTheme('striped', { //그리드 객체에 전체 옵션 주기
			cell : {
				header : {
					background : '#eef'
				},
				evenRow : {
					background : '#fee'
				}
			},
			frozenBorder : {
				border : 'red'
			}
		});
		
		
		//******************************생산지시조회 모달******************************
		//생산지시 조회 모달 설정
		let dialogCommand = $("#dialog-form-manCommand").dialog({
			autoOpen : false,
			modal : true,
			height : 500,
			width : 900,
			buttons : {
				"확인" : function() {
					console.log("확인 테스트");
					
					fetch("${pageContext.request.contextPath}/selectProcess/"+checkedCommand[0].podtCode)
					.then((response) => response.json())
					.then((data)=> {
						console.log(data.data.contents);
						//console.log(data.data.contents[0].podtCode);
						gridProcess.resetData(data.data.contents) //파싱한 결과 = data
						gridProcess.refreshLayout();
						
						let mandate = document.querySelector("#txtManDate").value; //작업일 인풋태그 입력값
						//console.log(mandate);
						
						document.getElementById("manDate").innerHTML = mandate
						document.getElementById("podtCode").innerHTML = data.data.contents[0].podtCode
						document.getElementById("podtName").innerHTML = data.data.contents[0].podtName
						document.getElementById("comCode").innerHTML = data.data.contents[0].comCode
					})
					
					dialogCommand.dialog("close");
				},

				"취소" : function() {
					dialogCommand.dialog("close");
				}
			}
		});
		
		//생산지시 조회 모달 컬럼
		const columnsCommand = [
			{
				header : '지시 번호',
				name : 'comCode'
			},
			{
				header : '제품코드',
				name : 'podtCode'
			}, 
			{
				header : '제품명',
				name : 'podtName'
			}, 
			{
				header : '작업일',
				name : 'manStartDate'
			}, 
			{
				header : '작업량',
				name : 'manGoalPerday'
			}
		]
		
		//******************************생산지시조회 그리드******************************
		//생산지시조회 버튼 클릭
		$("#btnSearchCommand").click(function(){
			let manDate = document.querySelector("#txtManDate").value; //작업일 인풋태그 입력값
			//console.log(manDate);
			
			dialogCommand.dialog("open");
			fetch("${pageContext.request.contextPath}/selCommand",{
				method: "POST",
				headers: {
					"Content-Type": "application/json" //json으로 포맷설정.
				},
				body: JSON.stringify({
					"manStartDate" : manDate //vo에 담긴 필드명 : 실제 들어갈 값
				})
			}).then((response) => response.json() )//컨트롤러에서 가져온 result를 json으로 파싱
			.then((data)=> {
				console.log(data.result);
				gridManCommand.resetData(data.result) //파싱한 결과 = data
				gridManCommand.refreshLayout();
			}); 
		})
		
		//생산지시 그리드 내용
		let gridManCommand = new Grid({
			el: document.getElementById('gridManCommand'),
			data: null,
			columns: columnsCommand,
			rowHeaders: ['checkbox']
			
		})
		
		//생산지시 조회 그리드에서 클릭된 행
		let checkedCommand;
		
		gridManCommand.on('check', function(ev){
			checkedCommand = gridManCommand.getCheckedRows();
		})
		
		
		
		//******************************공정현황 그리드******************************
		//공정현황 컬럼
		const columnsProcess = [
			{
				header : '설비코드',
				name : 'facCode'
			}, 
			{
				header : '설비명',
				name : 'facName'
			}, 
			{
				header : '공정코드',
				name : 'procCode'
			}, 
			{
				header : '공정명',
				name : 'procName'
			}, 
			{
				header : '관리자',
				name : 'procCode'
			},
			{
				header : '지시량',
				name : 'manGoalPerday'
			}, 
			{
				header : '작업완료량',
				name : 'manQnt'
			}, 
			{
				header : '시작시간',
				name : 'manStarttime'
			}, 
			{
				header : '종료시간',
				name : 'manEndtime'
			}
			
		]
		
		//공정현황 그리드 내용
		let gridProcess = new Grid({
			el : document.getElementById('gridProcess'),
			data : null,
			columns : columnsProcess,
			rowHeaders : [ 'rowNum' ]
		})
		
		
		
		//******************************공정시작 버튼******************************
		let processData;
		
		$("#btnStart").click(function(){
			console.log('공정시작버튼 클릭');
			console.log(document.getElementById("podtCode").innerHTML);
			
			$.ajax({ //시작버튼 클릭 -> 제품에 해당하는 공정 조회 -> 그 공정갯수만큼 진행공정 테이블에 insert
				url: '${pageContext.request.contextPath}/selectProc',
				method: 'POST',
				data : JSON.stringify( 
						{'podtCode' : document.getElementById("podtCode").innerHTML , 
						 'comCode': document.getElementById("comCode").innerHTML} 
						),
				dataType: 'JSON',
				contentType: 'application/json',
				success: function(datas){
					console.log("진행공정 테이블 값 추가 성공");
					resetProcess();
					
				},
				error: function(reject){
					console.log(reject)
				}
			})
			
			
		})
		
		
		//******************************생산현황 화면 reset******************************
		function resetProcess(){
			fetch('${pageContext.request.contextPath}/selectProcList',{
				method: "POST",
				headers: {
					"Content-Type": "application/json" //json으로 포맷설정.
				},
				body: JSON.stringify(
					{'comCode' : document.getElementById("comCode").innerHTML } //vo에 담긴 필드명 : 실제 들어갈 값
				)
			})
			.then((response) => response.json())
			.then((data)=> {
				console.log(data.result);
				gridProcess.resetData(data.result) //파싱한 결과 = data
				gridProcess.refreshLayout();
				resetProcess(); //재귀함수
			})
			
			
		}
		
		
	</script>

</body>
</html>