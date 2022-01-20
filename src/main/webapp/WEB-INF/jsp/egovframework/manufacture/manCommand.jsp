<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"> </script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

</head>
<body>
	<h2>생산지시서 작성</h2><br>
	
	<!-- 작성일자, 지시명 입력 -->
	<div class = "writeDate">
		<p style="display:inline-block;">작성일자</p>
		
		<input id = "writeFromDate" type="date" name="from" style="display:inline-block;">
	</div>
	
	<div class = "commandName">
		<p style="display:inline-block;">생산지시명</p>
		<input id = "txtCommandName" style="display:inline-block;">
	</div>
	<br>
	
	<!-- 생산계획 조회 -->
	<div class = "planDate">
		<p style="display:inline-block;">계획기간</p>
		<input id = "planFromDate" type="date" name="from" style="display:inline-block;">
	
		<p style="display:inline-block;"> ~ </p>
		<input id = "planToDate" type="date" name="to" style="display:inline-block;">
		
		<button type="button" id="btnSearchManPlan" style="display:inline-block;">생산계획 조회</button><br>
		
		<!-- 생산계획 조회 모달 -->
		<div id = "dialog-form-manPlan" title="생산계획 조회">
			<div id="gridManPlan"></div>
		</div>
	</div>
	<br>
	
	<!-- 자재조회 -->
	<div>
		<p style="display:inline-block;"> 제품코드 </p>
		<input id="txtPodt"> 
		<button type="button" id="btnSelectRes">자재 조회</button>
		<button type="button" id="btnSelectFac">설비 조회</button>
	</div>
	
	<!-- 메인화면 그리드 -->
	<div id = "gridMain" ></div>
	<br>
	
	<!-- 자재조회 모달 -->
	<div id="gridResource" class="col-sm-6"></div>
	<br>
	
	<!-- 설비조회 모달 -->
	<div id="gridFacility" class="col-sm-9"></div>
	<br>
	
	<div style="float:right;">
		<button type="button" id="btnSelectCommand">조회</button>
		<button type="button" id="btnSaveCommand">저장</button>
		<button type="button" id="btnDeleteCommand">삭제</button>
		<button type="button" id="btnInit">초기화</button>
	</div>
	
	
	<script>
		
		var Grid = tui.Grid; //그리드 객체 생성
		
		Grid.applyTheme('striped', { //그리드 객체에 전체 옵션 주기
				  cell: {
				      header: {
				      background: '#eef'
				    },
				    evenRow: {
				      background: '#fee'
				    }
				  },
				  frozenBorder: {
					  border: 'red'
				  }
		});
		
		
		//******************************생산계획 모달******************************
		//생산계획 모달 설정
		let dialogManPlan = $("#dialog-form-manPlan").dialog({
			autoOpen: false, 
			modal: true,
			height: 500,
		    width: 900,
		    buttons: {
				"확인" : function(){ //확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
							//console.log("확인 테스트");
							//console.log(checkedPlanDetail[0].planNoDetail);
							$.ajax({
								url: '${pageContext.request.contextPath}/selectManPlanDetail/'+ checkedPlanDetail[0].planNoDetail,
								method: 'GET',
								dataType: 'JSON',
								success: function(datas){
									//console.log(datas);
									gridMain.resetData(datas.data.contents);
								}
							})
						dialogManPlan.dialog("close");
				},		
						
				"취소" : function(){
					dialogManPlan.dialog("close");
				}
			 } 
		});
		
		
		//생산계획 모달 컬럼
		const columnsManPlan = [
			{
				header: '제품코드',
				name: 'podtCode'
			},
			{
				header: '제품명',
				name: 'podtName'
			},
			{
				header:'계획일자',
				name: 'manPlanDate'
			},
			{
				header:'생산계획명',
				name: 'manPlanName'
			}
		]
		
		
		//******************************생산계획 그리드******************************
		let data;
		
		//생산계획 조회 버튼 클릭
		$('#btnSearchManPlan').click(function(){
			//console.log('생산계획조회 테스트');
			
			let planFromDate = document.querySelector('#planFromDate').value;
			let planToDate = document.querySelector('#planToDate').value;
			
			//console.log(planFromDate);
			//console.log(planToDate);
			
			dialogManPlan.dialog("open");
			$.ajax({
				url: '${pageContext.request.contextPath}/selectManPlan',
				method: 'POST',
				data: {'planFromDate' : planFromDate, 'planToDate': planToDate },
				dataType: 'JSON',
				success: function(datas){
					data = datas;
					gridManPlan.resetData(data.result);
					gridManPlan.resetOriginData();
				},
				error: function(reject){
					console.log('reject: '+ reject);
				}
			})
		})
		
		//생산계획 그리드 내용
		let gridManPlan = new Grid({
			el: document.getElementById('gridManPlan'),
			data: data,
			columns: columnsManPlan,
			rowHeaders: ['checkbox']
		})
		
		//생산계획 그리드에서 체크된 계획
		let checkedPlanDetail;
		
		//생산계획 그리드에서 체크된 계획의 행을 가져온다.
		gridManPlan.on('check', function(ev){
			checkedPlanDetail = gridManPlan.getCheckedRows();
		})
		
		
		//******************************메인 그리드******************************
		//메인 그리드 컬럼
		let columnsMain = [
			{
				header:'제품코드',
				name: 'podtCode'
			},
			{
				header: '제품명',
				name: 'podtName'
			},
			{
				header:'주문량',
				name: 'ordQnt'
			},
			{
				header: '납기일자',
				name: 'ordDuedate'
			},
			{
				header: '작업일',
				name: 'manStartDate',
				editor: 'datePicker'
			},
			{
				header: '일 생산량',
				name: 'manGoalPerday',
				editor: 'text'
			},
			{
				header: '사번',
				name: 'empId',
				editor: 'text'
			},
			{
				header: '비고',
				name: 'manEtc',
				editor: 'text'
			}
		]
		
		//메인 그리드 데이터
		const dataSourceMain = {
			api: {
				readData: { url: '.',
						    method: 'GET' },
				modifyData: { url: '${pageContext.request.contextPath}/main',
							  method: 'POST' }
			},
			contentType : 'application/json;charset=UTF-8'
		};
		
		//메인 그리드 내용
		let gridMain = new Grid({
			el: document.getElementById('gridMain'),
			data: dataSourceMain,
			columns: columnsMain,
			rowHeaders: ['rowNum']
		});
		
		
		//******************************자재조회 그리드******************************
		//자재 모달 설정해주기
	/* 	let dialogResource = $("#dialog-form-resource").dialog({
			autoOpen: false, 
			modal: true,
			height: 500,
		    width: 900
		}) */
		
		//자재 조회 모달 컬럼
		const columnsResource = [
			{
				header:'제품코드',
				name: 'podtCode'
			},
			{
				header: '제품명',
				name: 'podtName'
			},
			{
				header:'자재코드',
				name: 'resCode'
			},
			{
				header:'소요량',
				name: 'resUsage'
			},
			{
				header: '공정코드',
				name: 'procCode'
			},
			{
				header: '공정명',
				name: 'procName'
			},
			{
				header: '자재확보유무',
				name: 'resObtain'
			}
		]
		
		let resData;
	
		//자재조회 버튼 클릭 이벤트
		$('#btnSelectRes').click(function(){
			//console.log('자재조회 테스트');
			
			let podtCode = document.querySelector('#txtPodt').value;
			
			//console.log(podtCode);
			
			//dialogResource.dialog("open");
			gridResource.refreshLayout();
			$.ajax({
				url: '${pageContext.request.contextPath}/selectRes',
				method: 'POST',
				data: {'podtCode' : podtCode },
				dataType: 'JSON',
				success: function(datas){
					resData = datas;
					gridResource.resetData(resData.result);
					gridResource.resetOriginData();
				},
				error: function(reject){
					console.log(reject);
				}
			})
		})
		
		//자재조회 그리드 내용
		let gridResource = new Grid({
			el: document.getElementById('gridResource'),
			data: resData,
			columns: columnsResource,
			rowHeaders: ['rowNum']
		})
		
		
		//******************************설비 그리드******************************
		const columnsFac = [
			{
				header:'작업번호',
				name: 'facNo'
			},
			{
				header:'설비코드',
				name: 'facCode'
			},
			{
				header:'설비명',
				name: 'facName'
			},
			{
				header:'공정코드',
				name: 'procCode'
			},
			{
				header:'공정명',
				name: 'procCode'
			},
			{
				header:'가동유무',
				name: 'facStatus'
			},
			{
				header:'설비 일 생산량',
				name: 'outputDay'
			}
		]
		
		let facData;
		
		//설비조회 버튼 클릭 이벤트
		$('#btnSelectFac').click(function(){
			console.log('설비조회 테스트');
			
			let podtCode = document.querySelector('#txtPodt').value;
			console.log(podtCode);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/selectFac',
				method: 'POST',
				data: {'podtCode' : podtCode },
				dataType: 'JSON',
				success: function(datas){
					facData = datas;
					gridFacility.resetData(facData.result);
					gridFacility.resetOriginData();
				},
				error: function(reject){
					console.log(reject);
				}
			})
		})
		
		//설비조회 그리드 내용
		let gridFacility = new Grid({
			el: document.getElementById('gridFacility'),
			data: facData,
			columns: columnsFac,
			rowHeaders: ['rowNum']
		})
		
	</script>
</body>
</html>