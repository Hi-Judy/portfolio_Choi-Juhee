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
	<h2>공정이동표</h2>
	<br>
	
	<!-- 생산지시서 조회 -->
	<form id = "findCommand">
		<p style="display: inline-block;">작업일자</p>

		<input id="txtManStartDate" type="date" name="manDate" style="display: inline-block;">
			
		<label for="ing">생산중</label> 	
		<input type="radio" id="ing" name="comEtc" value="procIng" >
		
		<label for="done">생산완료</label> 	
		<input type="radio" id="done" name="comEtc" value="procDone" >
		
		<button type="button" id="btnSearchCommand"
			style="display: inline-block;">조회</button>
	
	</form>
	<br>
	
	<!-- 생산지시서 조회 모달 -->
	<div id="dialog-form-manCommand" title="생산지시 조회">
		<div id="gridManCommand"></div>
	</div>
	
	<div style="margin-bottom: 180px;">
		<!-- 선택된 지시 그리드 -->
		<div id="gridSelCommand" class="col-sm-5" style="float: left; margin-right: 10px;"></div>
		
		<!-- 자재 LOT 조회 그리드 -->
		<div id="gridResLot"  class="col-sm-5" style="float: left;"></div>
	</div>
	<br>
	<!-- 공정이동 그리드 -->
	<div id="gridMovement" class="col-sm-9" style="float: left;"></div>
	
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
					
					//공정이동표
				 	fetch("${pageContext.request.contextPath}/selectMovement/"+checkedCommand[0].comCode)
					.then((response) => response.json())
					.then((data)=> {
						console.log(data.data.contents);
						
						gridMovement.resetData(data.data.contents);
						gridMovement.refreshLayout();
					}) 
					
					//공정이동표에서 자재 조회
					$.ajax({
						url: '${pageContext.request.contextPath}/selectResLot/'+checkedCommand[0].comCode,
						method : 'GET',
						dataType : 'JSON',
						success : function(datas){
							console.log(datas)
							gridResLot.resetData(datas.data.contents); //파싱한 결과 = data
							gridResLot.refreshLayout();
						}
					})
					
					//선택된 지시 정보 
					fetch("${pageContext.request.contextPath}/selectComInfo/"+checkedCommand[0].comCode)
					.then((response) => response.json())
					.then((data)=> {
						console.log(data.data.contents);

						gridSelCommand.resetData(data.data.contents); //파싱한 결과 = data
						gridSelCommand.refreshLayout();

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
				name : 'manStartdate'
			}, 
			{
				header : '상태',
				name : 'comEtc'
			}
		]
		
		//******************************생산지시조회 그리드******************************
		//생산지시조회 버튼 클릭
		$("#btnSearchCommand").click(function(){
			let manStartDate = document.querySelector("#txtManStartDate").value; //작업일 인풋태그 입력값
			console.log(manStartDate);
			
			let findCommand = document.querySelector("#findCommand").value;
			
			dialogCommand.dialog("open");
			$.ajax({
				url : '${pageContext.request.contextPath}/findCommand',
				method : 'POST',
				data : $('#findCommand').serialize(), //직렬화된 방식으로(바이트 단위로 끊어서) 데이터를 보낸다.
				dataType : 'JSON',
				success : function(datas) {
					data = datas;
					gridManCommand.resetData(data.result);
					gridManCommand.resetOriginData();
					gridManCommand.refreshLayout();
				},
				error : function(reject) {
					console.log('reject: ' + reject);
				}
			})
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
		
		
		
		//******************************선택된 지시 그리드******************************
		//선택된 지시 그리드 컬럼
		const columnsSelCommand = [
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
				name : 'manStartdate'
			},
			{
				header : '지시수량',
				name : 'manGoalperday'
			}
		]
		
		//선택된 지시 그리드 내용
		let gridSelCommand = new Grid({
			el: document.getElementById('gridSelCommand'),
			data: null,
			columns: columnsSelCommand,
			rowHeaders : [ 'rowNum' ]
		})
		
		
		
		//******************************자재 LOT 그리드******************************
		//자재 LOT 그리드 컬럼
		const columnsResLot = [
			{
				header : '자재코드',
				name : 'rscCode'
			},
			{
				header : '자재명',
				name : 'rscName'
			},
			{
				header : '자재로트',
				name : 'rscLot'
			}
		]
		
		//자재 LOT 그리드 내용
		let gridResLot = new Grid({
			el: document.getElementById('gridResLot'),
			data: null,
			columns: columnsResLot,
			rowHeaders : [ 'rowNum' ],
			scrollY:true,
		      minBodyHeight : 230,
		      bodyHeight : 230,
		})
		
		
	
		//******************************공정이동표 그리드******************************
		//공정이동표 그리드 컬럼
		const columnsMovement = [
			{
				header : '공정코드',
				name : 'podtCode'
			}, 
			{
				header : '공정명',
				name : 'procName'
			}, 
			{
				header : '관리자',
				name : 'empId'
			},
			{
				header : '관리자명',
				name : 'empName'
			},
			{
				header : '작업완료량',
				name : 'manQnt'
			},
			{
				header : '불량량',
				name : 'defQnt'
			} 
		]
		
		//공정이동표 그리드 내용
		let gridMovement = new Grid({
			el: document.getElementById('gridMovement'),
			data: null,
			columns: columnsMovement,
			rowHeaders: ['rowNum']
			
		})
		
		
	</script>
	

</body>
</html>