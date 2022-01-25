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
	<h2>생산지시서 작성</h2>
	<br>

	<!-- 작성일자, 지시명 입력 -->
	<div class="writeDate">
		<p style="display: inline-block;">작성일자</p>

		<input id="writeFromDate" type="date" name="from"
			style="display: inline-block;">
	</div>

	<div class="commandName">
		<p style="display: inline-block;">생산지시명</p>
		<input id="txtCommandName" style="display: inline-block;">
	</div>
	<br>

	<!-- 생산계획 조회 -->
	<div class="planDate">
		<p style="display: inline-block;">계획기간</p>
		<input id="planFromDate" type="date" name="from"
			style="display: inline-block;">

		<p style="display: inline-block;">~</p>
		<input id="planToDate" type="date" name="to"
			style="display: inline-block;">

		<button type="button" id="btnSearchManPlan"
			style="display: inline-block;">생산계획 조회</button>
		<br>

		<!-- 생산계획 조회 모달 -->
		<div id="dialog-form-manPlan" title="생산계획 조회">
			<div id="gridManPlan"></div>
		</div>
	</div>
	<br>

	<!-- 자재&설비 조회 -->
	<div>
		<p style="display: inline-block;">제품코드</p>
		<input id="txtPodt">
		<button type="button" id="btnSelectRes">자재 조회</button>
		<button type="button" id="btnSelectFac">설비 조회</button>
		<button type="button" id="btnPreCommand">이전 생산지시 조회</button>
	</div>

	<!-- 이전 생산 지시 그리드 -->
	<br>
	<div>생산 지시 내역</div>
	<div id = "gridPreCommand"></div>
	<br>

	<!-- 메인화면 그리드 -->
	<div>생산지시서 작성</div>
	<div id="gridMain"></div>
	<br>

	<!-- 자재조회 그리드 -->
	<div>자재</div>
	<div id="gridResource" class="col-sm-6" style="float: left; margin-right: 2%"></div>

	<!-- 자재LOT 조회 그리드 -->
	<div id="gridResLOT" class="col-sm-5" style="float: left; margin-right: 6%"></div>


	<!-- 설비조회 그리드 -->
	<div style="margin-top: 10%;">설비</div>
	<div id="gridFacility" class="col-sm-12"></div>


	<div style="float: right;">
		<button type="button" id="btnSelectCommand">조회</button>
		<button type="button" id="btnSaveCommand">저장</button>
		<button type="button" id="btnDeleteCommand">삭제</button>
		<button type="button" id="btnInit">초기화</button>
	</div>
	
	
	<!-- 생산 지시 히든 그리드 -->
	<div id="gridInsertCommand"></div>
	
	<!-- 생산 지시 히든 그리드 -->
	<div id="gridInsertCommandDetail"></div>

	<!-- 계획디테일 테이블에 '생산지시중'으로 변경 히든 그리드 -->
	<div id="girdUpdatePlanStatus"></div>
	
	<!-- 자재 테이블에 출고량, 생산지시디테일 번호 추가 히든 그리드 -->
	<div id="gridUpdateRes"></div>

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

		
		
		//******************************생산계획 모달******************************
		//생산계획 모달 설정
		let dialogManPlan = $("#dialog-form-manPlan").dialog({
			autoOpen : false,
			modal : true,
			height : 500,
			width : 900,
			buttons : {
				"확인" : function() { //확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
					//console.log("확인 테스트");
					//console.log(checkedPlanDetail[0].planNoDetail);
					$
							.ajax({
								url : '${pageContext.request.contextPath}/selectManPlanDetail/'
										+ checkedPlanDetail[0].planNoDetail,
								method : 'GET',
								dataType : 'JSON',
								success : function(datas) {
									//console.log(datas);
									gridMain.resetData(datas.data.contents);
									gridInsertCommand.resetData(datas.data.contents);
									girdUpdatePlanStatus.resetData(datas.data.contents);
								}
							})
					dialogManPlan.dialog("close");
				},

				"취소" : function() {
					dialogManPlan.dialog("close");
				}
			}
		});

		//생산계획 모달 컬럼
		const columnsManPlan = [ 
			{
				header : '제품코드',
				name : 'podtCode'
			}, 
			{
				header : '제품명',
				name : 'podtName'
			}, 
			{
				header : '계획일자',
				name : 'manPlanDate'
			}, 
			{
				header : '생산계획명',
				name : 'manPlanName'
			} 
		]

		
		
		//******************************생산계획 그리드******************************
		let data;

		//생산계획 조회 버튼 클릭
		$('#btnSearchManPlan').click(function() {
			//console.log('생산계획조회 테스트');

			let planFromDate = document.querySelector('#planFromDate').value;
			let planToDate = document.querySelector('#planToDate').value;

			//console.log(planFromDate);
			//console.log(planToDate);

			dialogManPlan.dialog("open");
			$.ajax({
				url : '${pageContext.request.contextPath}/selectManPlan',
				method : 'POST',
				data : {
					'planFromDate' : planFromDate,
					'planToDate' : planToDate
				},
				dataType : 'JSON',
				success : function(datas) {
					data = datas;
					gridManPlan.resetData(data.result);
					gridManPlan.resetOriginData();
					gridManPlan.refreshLayout();
				},
				error : function(reject) {
					console.log('reject: ' + reject);
				}
			})
		})

		//생산계획 그리드 내용
		let gridManPlan = new Grid({
			el : document.getElementById('gridManPlan'),
			data : data,
			columns : columnsManPlan,
			rowHeaders : [ 'checkbox' ]
		})

		//생산계획 그리드에서 체크된 계획
		let checkedPlanDetail;

		//생산계획 그리드에서 체크된 계획의 행을 가져온다.
		gridManPlan.on('check', function(ev) {
			checkedPlanDetail = gridManPlan.getCheckedRows();
		})

		
		
		//******************************메인 그리드******************************
		//메인 그리드 컬럼
		let columnsMain = [ 
			{
				header : '제품코드',
				name : 'podtCode'
			}, 
			{
				header : '제품명',
				name : 'podtName'
			}, 
			{
				header : '주문량',
				name : 'ordQnt'
			}, 
			{
				header : '납기일자',
				name : 'ordDuedate'
			}, 
			{
				header: '작업기간',
				name: 'planPeriod'
			},
			{
				header : '일 생산량',
				name : 'manPerday'
			}, 
			{
				header : '일 목표 생산량',
				name : 'manGoalPerday',
				editor : 'text'
			}, 
			{
				header : '작업일',
				name : 'manStartDate',
				editor : 'datePicker'
			}, 
			{
				header : '사번',
				name : 'empId',
				editor : 'text'
			}, 
			{
				header : '비고',
				name : 'manEtc',
				editor : 'text'
			} 
		]

		//메인 그리드 데이터
		const dataSourceMain = {
			api : {
				readData : {
					url : '.',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/main',
					method : 'POST'
				}
			},
			contentType : 'application/json;charset=UTF-8'
		};

		//메인 그리드 내용
		let gridMain = new Grid({
			el : document.getElementById('gridMain'),
			data : dataSourceMain,
			columns : columnsMain,
			rowHeaders : [ 'rowNum' ]
		});
		
		//메인 그리드에서 일 목표 생산량에 값 입력한 후 이벤트(자재소요량에 곱셈 실행& 히든그리드 값 추가)	
		gridMain.on('editingFinish', (ev) => { 
			gridInsertCommandDetail.resetData(gridMain.getData());
			
			let r = gridResource.getData(); //자재 그리드 전체 데이터(배열형태)
			
			let a = gridMain.getValue(0,'manGoalPerday'); //메인 그리드의 일 목표 생산량의 값

			for (i of r){
				gridResource.setValue(i.rowKey, 'resUsage', i.resUsage*1*a);
			}
			
			
		})

		
		
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
				header : '제품코드',
				name : 'podtCode'
			}, 
			{
				header : '제품명',
				name : 'podtName'
			}, 
			{
				header : '자재코드',
				name : 'resCode'
			}, 
			{
				header : '소요량',
				name : 'resUsage'
			}, 
			{
				header : '공정코드',
				name : 'procCode'
			}, 
			{
				header : '공정명',
				name : 'procName'
			}
		]

		let resData;

		//자재조회 버튼 클릭 이벤트
		$('#btnSelectRes').click(function() {
			//console.log('자재조회 테스트');

			let podtCode = document.querySelector('#txtPodt').value;

			//console.log(podtCode);

			//dialogResource.dialog("open");
			gridResource.refreshLayout();
			$.ajax({
				url : '${pageContext.request.contextPath}/selectRes',
				method : 'POST',
				data : {
					'podtCode' : podtCode
				},
				dataType : 'JSON',
				success : function(datas) {
					resData = datas;
					gridResource.resetData(resData.result);
					gridResource.resetOriginData();
				},
				error : function(reject) {
					console.log(reject);
				}
			})
		})

		//자재조회 그리드 내용
		let gridResource = new Grid({
			el : document.getElementById('gridResource'),
			data : resData,
			columns : columnsResource,
			rowHeaders : [ 'rowNum' ]
		})

		
		
		//******************************설비 그리드******************************
		const columnsFac = [ 
			{
				header : '작업번호',
				name : 'facNo'
			}, 
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
				name : 'procCode'
			}, 
			{
				header : '가동유무',
				name : 'facStatus'
			}, 
			{
				header : '설비 일 생산량',
				name : 'outputDay'
			} 
		]

		let facData;

		//설비조회 버튼 클릭 이벤트
		$('#btnSelectFac').click(function() {
			console.log('설비조회 테스트');

			let podtCode = document.querySelector('#txtPodt').value;
			console.log(podtCode);

			$.ajax({
				url : '${pageContext.request.contextPath}/selectFac',
				method : 'POST',
				data : {
					'podtCode' : podtCode
				},
				dataType : 'JSON',
				success : function(datas) {
					facData = datas;
					gridFacility.resetData(facData.result);
					gridFacility.resetOriginData();
				},
				error : function(reject) {
					console.log(reject);
				}
			})
		})

		//설비조회 그리드 내용
		let gridFacility = new Grid({
			el : document.getElementById('gridFacility'),
			data : facData,
			columns : columnsFac,
			rowHeaders : [ 'rowNum' ]
		})

		
		
		//******************************자재LOT 그리드******************************
		//자재 LOT 모달 컬럼
		const columnsResLOT = [ 
			{
				header : '자재코드',
				name : 'resCode'
			}, 
			{
				header : '자재LOT',
				name : 'rscLot'
			}, 
			{
				header : '입고량',
				name : 'istCnt'
			}, 
			{
				header : '출고량',
				name : 'ostCnt',
				editor: 'text'
			} 
		]

		let resLotData;
		let checkedResLot; //자재 LOT 그리드에서 체크된 계획

		//자재 그리드에서 한 행 클릭
		gridResource.on('click', function(ev) {
			console.log('자재 LOT 테스트');
			checkedResLot = gridResLOT.getCheckedRows();
			console.log(gridResource.getValue(ev.rowKey, 'resCode'));

			let resCode = gridResource.getValue(ev.rowKey, 'resCode');
			//dialogResLOT.dialog("open");

			$.ajax({
				url : '${pageContext.request.contextPath}/selectResLot',
				method : 'POST',
				data : {
					'resCode' : resCode
				},
				dataType : 'JSON',
				success : function(datas) {
					resLotData = datas;
					console.log(resLotData);
					gridResLOT.resetData(resLotData.result);
					gridResLOT.resetOriginData();
					gridUpdateRes.resetData(resLotData.result);
					console.log(resLotData.result);
				},
				error : function(reject) {
					console.log('reject: ' + reject);
				}
			})
		})

		//자재 LOT 그리드 내용
		let gridResLOT = new Grid({
			el : document.getElementById('gridResLOT'),
			data : resLotData,
			columns : columnsResLOT,
			rowHeaders : [ 'rowNum' ]
		})
		
		gridResLOT.on('editingFinish', (ev) => { 
			gridUpdateRes.resetData(gridResLOT.getData());
		});
			
		
		
		
		//******************************이전 생산 지시 그리드******************************
		let columnsPreCommand = [ 
			{
				header : '제품코드',
				name : 'podtCode'
			}, 
			{
				header : '제품명',
				name : 'podtName'
			}, 
			{
				header : '주문량',
				name : 'ordQnt'
			}, 
			{
				header : '납기일자',
				name : 'ordDuedate'
			}, 
			{
				header: '작업기간',
				name: 'planPeriod'
			},
			{
				header : '일 생산량',
				name : 'manPerday'
			}, 
			{
				header : '일 목표 생산량',
				name : 'manGoalPerday',
				editor : 'text'
			}, 
			{
				header : '작업일',
				name : 'manStartDate',
				editor : 'datePicker'
			}, 
			{
				header : '사번',
				name : 'empId',
				editor : 'text'
			}, 
			{
				header : '비고',
				name : 'manEtc',
				editor : 'text'
			},
			{
				header : '비고',
				name : 'planEtc',
				hidden : true
			}
			
		]
		
		
		let PreCommandData;

		//이전 생산지시조회 버튼 클릭 이벤트
		$('#btnPreCommand').click(function() {
			console.log('이전 생산지시조회 테스트');

			let podtCode = document.querySelector('#txtPodt').value;
			console.log(podtCode);

			$.ajax({
				url : '${pageContext.request.contextPath}/selectPreCommand',
				method : 'POST',
				data : {'podtCode' : podtCode},
				dataType : 'JSON',
				success : function(datas) {
					PreCommandData = datas;
					console.log(PreCommandData);
					gridPreCommand.resetData(PreCommandData.result);
					gridPreCommand.resetOriginData();
				},
				error : function(reject) {
					console.log(reject);
				}
			})
		})

		//이전 생산지시조회 그리드 내용
		let gridPreCommand = new Grid({
			el : document.getElementById('gridPreCommand'),
			data : PreCommandData,
			columns : columnsPreCommand,
			rowHeaders : [ 'rowNum' ]
		})
		
		
		//******************************생산지시 추가 히든 그리드******************************
		//생산지시 추가 히든그리드 컬럼
		let columnsInsertCommand = [
			{
				header : '지시번호',
				name : 'comCode'
			}, 
			{
				header : '계획번호',
				name : 'manPlanNo'
			}, 
			{
				header : '작성일',
				name : 'comDate'
			}, 
			{
				header : '지시명',
				name : 'comName'
			}
		]
		
		//생산지시 추가 히든그리드 내용
		let gridInsertCommand = new Grid({
			el : document.getElementById('gridInsertCommand'),
			data : null,
			columns : columnsInsertCommand,
			rowHeaders : [ 'rowNum' ]
		})
		
		
		
		//******************************생산지시 디테일 추가 히든 그리드******************************
		//생산지시디테일 추가 히든그리드 컬럼
		let columnsInsertCommandDetail = [
			{
				header : '지시디테일번호',
				name : 'comNoDetail'
			}, 
			{
				header : '지시번호',
				name : 'comCode'
			}, 
			{
				header : '제품코드',
				name : 'podtCode'
			}, 
			{
				header : '작업일',
				name : 'manStartDate'
			},
			{
				header : '일 목표 생산량',
				name : 'manGoalPerday'
			},
			{
				header : '주문량',
				name : 'ordQnt'
			},
			{
				header : '납기일자',
				name : 'ordDuedate'
			},
			{
				header : '비고',
				name : 'manEtc'
			}
		]
		
		//생산지시디테일 추가 히든그리드 내용
		let gridInsertCommandDetail = new Grid({
			el : document.getElementById('gridInsertCommandDetail'),
			data : null,
			columns : columnsInsertCommandDetail,
			rowHeaders : [ 'rowNum' ]
		})
		
		
		
		//******************************자재 테이블에 값 추가 히든 그리드******************************
		//자재테이블 값 추가 히든 그리드 컬럼
		let columnsUpdateRes = [
			{
				header : '자재로트',
				name : 'rscLot'
			},
			{
				header : '출고량',
				name : 'ostCnt'
			}, 
			{
				header : '비고(지시디테일번호)',
				name : 'comNoDetail'
			}
		]
		
		//자재테이블 값 추가 히든 그리드 내용
		let gridUpdateRes = new Grid({
			el : document.getElementById('gridUpdateRes'),
			data : null,
			columns : columnsUpdateRes,
			rowHeaders : [ 'rowNum' ]
		})
		
		
		
		//******************************계획 디테일 테이블에 값 추가 히든 그리드******************************
		//계획디테일 테이블 값추가 히든그리드 컬럼
		let columnsUpdatePlanStatus = [
			{
				header : '계획 비고(생산 상태)',
				name : 'planEtc'
			},
			{
				header : '계획 디테일 번호',
				name : 'planNoDetail'
			}
		]
		
		//계획디테일 테이블 값추가 히든그리드 내용
		let girdUpdatePlanStatus = new Grid({
			el : document.getElementById('girdUpdatePlanStatus'),
			data : null,
			columns : columnsUpdatePlanStatus,
			rowHeaders : [ 'rowNum' ]
		})
		
		
		

		//******************************버튼 클릭 이벤트******************************
		//초기화 버튼 이벤트
		btnInit.addEventListener("click", function() {
			gridMain.resetData([{}]);
			gridResource.resetData([{}]);
			gridFacility.resetData([{}]);
		})
		
		
		//저장버튼 이벤트
		btnSaveCommand.addEventListener("click", function(){
			let writeFromDate = document.getElementById('writeFromDate').value;
			let commandName = document.getElementById('txtCommandName').value;
			//console.log(writeFromDate);
			//console.log(commandName);
			
			gridInsertCommand.setValue(0, 'comDate', writeFromDate);
			gridInsertCommand.setValue(0, 'comName', commandName);
			//console.log(gridInsertCommand.getValue(0, 'comDate'));
			//console.log(gridInsertCommand.getValue(0, 'comName'));
			
			let a = {}; //a 객체 만들기
			a.command = gridInsertCommand.getData(); //a 객체에 command라는 키로 gridInsertCommand 데이터 넣기.
			a.commandDetail = gridInsertCommandDetail.getData();
			a.res = gridUpdateRes.getData();
			a.plan = girdUpdatePlanStatus.getData();
			
			console.log(a);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/hidden',
				dataType: 'JSON',
				method: 'POST',
				data: JSON.stringify(a), //a데이터를 넘겨준다.
				contentType: 'application/json',
				success: function(){
					alert("완료");
				}
			})
			
		})
		
	</script>
	
</body>
</html>