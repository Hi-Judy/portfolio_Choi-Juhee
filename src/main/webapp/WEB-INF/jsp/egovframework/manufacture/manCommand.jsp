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

<style>
.'tui-datepicker'{
	document.getElementsByClassName('tui-datepicker')[0].style = "position: relative";
	document.getElementsByClassName('tui-datepicker')[0].style = " z-index:100000"; 
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
		<h4 style="margin-left: 10px">생산지시서 작성</h4>
	</div>

	<!-- 작성일자, 지시명 입력 -->
	<div id="top" style="height : 110px; padding : 10px;">
		
		<!-- 생산계획 조회 -->
		<div class="planDate" style="float: left; display: inline-block;">
			<p style="display: inline-block;">계획기간</p>
			<input id="planFromDate" type="date" name="from"
				style="display: inline-block;">
	
			<p style="display: inline-block;">~</p>
			<input id="planToDate" type="date" name="to"
				style="display: inline-block;">
	
			<button class="btn" type="button" id="btnSearchManPlan"
				style="
				display: inline-block;
				margin-left: 10px;
				width: 80px;
				height: 28px;
				padding-bottom: 0px;
				padding-top: 0px;
				padding-left: 0px;
				padding-right: 0px;">
				계획조회</button>	
		</div>
		<br><br>
		
		<div style="margin-top: 5px;">
			<div style="width: 600px; float: left;">
				<p style="display: inline-block;">작성일자</p>
				<input id="writeFromDate" type="date" name="from"
					style="display: inline-block;">
		
<!-- 				<p style="display: inline-block; margin-left: 20px;">생산지시명</p>
				<input id="txtCommandName" style="display: inline-block;"> -->
			</div>


			<div style="float: right; ">
				<button class="btn" type="button" id="btnSelectCommand">조회</button>
				<button class="btn" type="button" id="btnSaveCommand">저장</button>
				<button class="btn" type="button" id="btnDeleteCommand">삭제</button>
				<button class="btn" type="button" id="btnInit">초기화</button>
			</div>
			
		</div>
		

	</div>
	<br>	

	<div id="OverallSize" style="margin-left : 10px; height: 1220px;" >
		<!-- 이전 생산 지시 그리드 -->
		<h5 style="color: #25396f;">생산 지시 내역</h5>
		<div id="gridPreCommand" style="border-top: 3px solid #168;"></div>
		<br>
	
		<!-- 메인화면 그리드 -->
		<h5 style="color: #25396f;">생산지시서 작성</h5>
		<div id="gridMain" style="border-top: 3px solid #168;"></div>
		<br>
	
		<div style="width: 1500px; height: 250px;">
			<!-- 자재조회 그리드 -->
			<span style="float: left; width: 50%;">
				<h5 style="color: #25396f;">자재사용 목록</h5>
				<div id="gridResource" style="border-top: 3px solid #168;"></div>
			</span>
			
			<!-- 자재LOT 조회 그리드 -->
			<span style="float: right; width: 45%;">
			<h5 style="color: #25396f;">자재LOT 목록</h5>
			<div id="gridResLOT" style=" border-top: 3px solid #168;"></div>
			</span>
		</div>
		<br>
	
		<!-- 설비조회 그리드 -->
		<div style="margin-top: 55px; ">

			<h5 style="color: #25396f;">필요 설비 목록</h5>
			<div id="gridFacility" class="col-sm-12" style="border-top: 3px solid #168;"></div>
		</div>
	</div>



	<!-- 생산계획 조회 모달 -->
	<div id="dialog-form-manPlan" title="생산계획 조회">
		<div id="gridManPlan" style="margin-top: 15px;"></div>
	</div>

	<!-- 사번 조회 모달 -->
	<div id="dialog-form-emp" title="사번 조회">
		<div id="gridEmp" style="margin-top: 15px;"></div>
	</div>


	<!-- 생산 지시 히든 그리드 -->
	<div id="gridInsertCommand" style="display: none;"></div>

	<!-- 생산 지시 히든 그리드 -->
	<div id="gridInsertCommandDetail" style="display: none;"></div>

	<!-- 계획디테일 테이블에 '생산지시중'으로 변경 히든 그리드 -->
	<div id="girdUpdatePlanStatus" style="display: none;"></div>

	<!-- 자재 테이블에 출고량, 생산지시디테일 번호 추가 히든 그리드 -->
	<div id="gridUpdateRes" style="display: none;"></div>

	<!-- 생산 자재 LOT 테이블에 값 추가 히든 그리드 -->
	<div id="gridInsertLot" style="display: none;"></div>


	<!--  --------------- 도움말 --------------- -->
	<div id="helpModal" title="도움말">
		<hr>
		돋보기 버튼을 눌러서 제품코드를 조회 후 클릭하면 선택이 됩니다.<br><br>
		관리단위 : 제품이 공정전체를 돌아서 한번 나오는양 <br><br>
		공정흐름관리 : 왼쪽끝 점들을 클릭드로우 하여 위치를이동할수있고<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		위치가 이동되면 공정들의 순서를 변경할수 있습니다.<br><br>
		BOM삭제 : 선택된 제품코드 를 기준으로 등록된 "사용자재" , "공정흐름"<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		들의 데이터들을 초기화 할수있습니다.<br>
	</div>
	
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
	                editable: { background: '#ffffff' },//  <-편집가능한 셀들의 색상을 주는영역
	                selectedHeader: { background: '#eee' },//  <- 선택한 셀의 백그라룬드	
	                disabled: { text: '#b0b0b0' }// <- 편집할수없는(비활성화된) 셀들에 대한 스타일 조절
	            }
	};	
	
	
		tui.Grid.setLanguage('ko'); 
		var Grid = tui.Grid; //그리드 객체 생성
		
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
		let PreCommandData; //이전 생산 지시 데이터
		
		//생산계획 모달 설정
		let dialogManPlan = $("#dialog-form-manPlan").dialog({
			autoOpen : false,
			modal : true,
			height : 600,
			width : 900,
			buttons : {
				"확인" : function(ev) { //확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
							
					console.log('확인완료');
					//console.log(checkedPlanDetail[0].podtCode);
					//console.log(checkedPlanDetail[0].planNoDetail);
					
					//메인그리드
					fetch("${pageContext.request.contextPath}/selectManPlanDetail/"
							+checkedPlanDetail[0].planNoDetail+"/"+checkedPlanDetail[0].podtCode)
					.then((response) => response.json())
					.then((data)=>{
						//console.log(data.data.contents);
						
						//확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
						gridMain.resetData(data.data.contents);
						gridInsertCommand.resetData(data.data.contents);
						girdUpdatePlanStatus.resetData(data.data.contents);
					
					})
					
					
					//이전 생산 지시 그리드
					let podtCode = gridManPlan.getValue(ev.rowKey, 'podtCode');
					let planNoDetail = gridManPlan.getValue(ev.rowKey, 'planNoDetail');
					
					//console.log(gridManPlan.getValue(ev.rowKey, 'podtCode'));
					//console.log(gridManPlan.getValue(ev.rowKey, 'planNoDetail'));
					
					fetch("${pageContext.request.contextPath}/selectPreCommand/"
							+checkedPlanDetail[0].planNoDetail+"/"+checkedPlanDetail[0].podtCode)
					.then((response) => response.json())
					.then((data)=>{
						console.log(data.data.contents);
						
						//확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
						gridPreCommand.resetData(data.data.contents);
						gridPreCommand.resetOriginData();
					
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
			} ,
			{
				header : '생산계획디테일번호',
				name : 'planNoDetail'
				
			} 
		]

		
		
		//******************************생산계획 그리드******************************
		let data;
		
		//계획일자 초기값 
	    var d = new Date();
	    var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	    document.getElementById('planFromDate').value = nd.toISOString().slice(0, 10);
	    document.getElementById('planToDate').value = d.toISOString().slice(0, 10);

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
					
					if(data.result.length == 0){
						alert("계획기간에 상응하는 정보가 없습니다.");
					}
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
			rowHeaders : [ 'checkbox' ],
	         bodyHeight: 385
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
				header : '기지시량',
				name : 'pileQnt'
			}, 
			{
				header : '미지시량',
				name : 'pendingQnt'
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
				name : 'planStartdate',
				editor : 'datePicker'
			}, 
			{
				header : '사번',
				name : 'empId',
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
			
			let manGoalPerday = gridMain.getValue(0,'manGoalPerday'); //메인 그리드의 일 목표 생산량의 값

			for (i of r){
				gridResource.setValue(i.rowKey, 'resUsage', (i.resUsage*1*manGoalPerday)/100);
			}
			
		})
		
		let resData; //자재데이터
		let facData; //설비데이터
		
		//메인 그리드에서 한 행 클릭 이벤트
		gridMain.on('click', function(ev){
			
			let podtCode = gridMain.getValue(ev.rowKey, 'podtCode');
			//console.log(gridMain.getValue(ev.rowKey, 'podtCode'));
			
			//자재조회
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
			
			
			//설비조회
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
					
					let facList = gridFacility.getData(); //설비 그리드 전체 데이터(배열형태)
					//console.log(facList);
					
					for (i of facList){
						console.log(i);
						
						let facStatus1 = gridFacility.getValue(i.rowKey,'facStatus');
						
						if( facStatus1 == 'N'){
							gridFacility.setValue(i.rowKey, 'facStatus', null);
						}
					}
				},
				error : function(reject) {
					console.log(reject);
				}
			})
			
			
			//사원컬럼 클릭
			//console.log(gridMain.getValue(ev["rowKey"], "empId"));
			
			if(ev["columnName"] == "empId" && gridMain.getValue(ev["rowKey"], "empId") == null){
				dialogEmp.dialog("open");
			}
			
			fetch("${pageContext.request.contextPath}/selectEmp")
			.then((response) => response.json())
			.then((data)=>{
				//console.log(data.data.contents);
				
				gridEmp.resetData(data.data.contents)
				gridEmp.refreshLayout();
			
			})
		
		})
		
		//******************************사원조회 모달******************************
		//사원조회 모달 설정
		let dialogEmp = $("#dialog-form-emp").dialog({
			autoOpen : false,
			modal : true,
			height : 500,
			width : 700,
			buttons : {
				"확인" : function() { //확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
					console.log("확인 테스트");
					//console.log(checkedEmp);
					//console.log(checkedEmp[0].empId);
					gridMain.setValue(0, 'empId', checkedEmp[0].empId)
					dialogEmp.dialog("close");
				},
							
				"취소" : function() {
					dialogEmp.dialog("close");
				}
			}
		})
		
		//사원조회 모달 컬럼
		const columnsEmp = [
			{
				header : '사번',
				name : 'empId'
			}, 
			{
				header : '이름',
				name : 'empName'
			}, 
			{
				header : '부서',
				name : 'etc'
			}
		]		
		
		//사원조회 그리드 내용
		let gridEmp = new Grid({
			el : document.getElementById('gridEmp'),
			data : null,
			columns : columnsEmp,
			rowHeaders : [ 'checkbox' ],
	         bodyHeight: 290
		})
		
		//사원조회 그리드에서 체크된 계획
		let checkedEmp;
		
		//사원조회 그리드에서 체크된 행
		gridEmp.on('check', function(ev) {
			checkedEmp = gridEmp.getCheckedRows();
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


		//자재조회 그리드 내용
		let gridResource = new Grid({
			el : document.getElementById('gridResource'),
			data : resData,
			columns : columnsResource,
			rowHeaders : [ 'rowNum' ],
		      bodyHeight : 230
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
				header : '자재명',
				name : 'rscName'
			}, 
			{
				header : '자재LOT',
				name : 'rscLot'
			}, 
			{
				header : '재고량',
				name : 'rscCnt'
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
			//console.log('자재 LOT 테스트');
			checkedResLot = gridResLOT.getCheckedRows();
			//console.log(gridResource.getValue(ev.rowKey, 'resCode'));
			
			let podtCode = gridResource.getValue(ev.rowKey, 'podtCode');
			
			$.ajax({
				url : '${pageContext.request.contextPath}/selectResLot',
				method : 'POST',
				data : {
					'podtCode' : podtCode
				},
				dataType : 'JSON',
				success : function(datas) {
					resLotData = datas;
					gridResLOT.resetData(resLotData.result);
					gridResLOT.resetOriginData();
					gridUpdateRes.resetData(resLotData.result);
					gridInsertLot.resetData(resLotData.result);

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
			rowHeaders : [ 'rowNum' ],
			scrollY:true,
		      minBodyHeight : 230,
		      bodyHeight : 230,
		})
		
		//LOT 그리드에서 출고량에 값 입력한 후 이벤트(자재소요량이랑 출고량이랑 수 안맞을 때 alert)	
		gridResLOT.on('editingFinish', (ev) => { // 
			gridUpdateRes.resetData(gridResLOT.getData());
			
			let r = gridResource.getData(); //자재 그리드 전체 데이터(배열형태)
			let l = gridResLOT.getData();
			let flag = false;
			let sumCnt=0;
			for(i of r){
				let resCode1 = gridResource.getValue(i.rowKey, 'resCode'); //자재 그리드의 자재코드
				let resUsage = gridResource.getValue(i.rowKey, 'resUsage'); //자재 그리드의 소요량
				
				for(j of l){
					let resCode2 = gridResLOT.getValue(j.rowKey, 'resCode'); //자재 그리드의 자재코드
					let ostCnt = gridResLOT.getValue(j.rowKey, 'ostCnt'); //자재 LOT 그리드의 출고량
					let rscCnt = gridResLOT.getValue(j.rowKey, 'rscCnt'); //자재 LOT 그리드의 재고량
					
					if(resCode1 == resCode2){
						sumCnt=sumCnt*1+j.rscCnt*1;
						if(j.rscCnt<j.ostCnt){
							gridResLOT.setValue(j.rowKey,'ostCnt','');
							alert("해당 LOT의 자재가 부족합니다. 다음 LOT를 이용해주세요.");
						}
					}
					
				}
				if(resUsage > sumCnt){
					flag = true;
				}
				sumCnt=0;
			}
			if(flag){
				alert("해당 자재가 부족합니다. 일 목표 생산량을 확인해주세요.");
			}
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
				name : 'manGoalPerday'
			}, 
			{
				header : '작업일',
				name : 'manStartDate'
			}, 
			{
				header : '사번',
				name : 'empId'
			}, 
			{
				header : '비고',
				name : 'comEtc'
			},
			{
				header : '비고',
				name : 'planEtc',
				hidden : true
			}
			
		]



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
				name : 'planStartdate'
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
				header : '사원',
				name : 'empId'
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
				header : '자재코드',
				name : 'resCode'
			},
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
		
		
		
		//******************************자재 LOT 테이블에 값 추가 히든 그리드******************************
		//자재 LOT 테이블 값 추가 히든그리드 컬럼
		let columnsInsertLot = [
			{
				header : '생산지시번호',
				name : 'comCode'
			},
			{
				header : '자재코드',
				name : 'rscLot'
			},
			{
				header : '자재 LOT',
				name : 'resCode'
			}
			
		]
		
		//자재LOT 테이블 값추가 히든그리드 내용
		let gridInsertLot = new Grid({
			el : document.getElementById('gridInsertLot'),
			data : null,
			columns : columnsInsertLot,
			rowHeaders : [ 'rowNum' ]
		})
		
		

		//******************************버튼 클릭 이벤트******************************
		//초기화 버튼 이벤트
		btnInit.addEventListener("click", function() {
			let writeFromDate = document.getElementById('writeFromDate');
			let txtCommandName = document.getElementById('txtCommandName');
			
			writeFromDate.value = '';
			txtCommandName.value = '';
			
			gridMain.resetData([{}]);
			gridResource.resetData([{}]);
			gridFacility.resetData([{}]);
			gridPreCommand.resetData([{}]);
			gridResLOT.resetData([{}]);
		})
		
		
		//저장버튼 이벤트
		btnSaveCommand.addEventListener("click", function(){
			
			//******************************입력값 체크******************************
			let writeFromDate2 = document.getElementById('writeFromDate'); //작성일자
			if(writeFromDate2.value == null || writeFromDate2.value == ""){
				alert("작성일자를 입력해주세요.");
				return;
			}
			
			if(gridMain.getValue(0,"manGoalPerday") == null){
				alert("일목표 생산량을 입력해주세요.");
				return;
			}
			if(gridMain.getValue(0, "planStartdate") == null){
				alert("작업일을 입력해주세요.");
				return;
			}
			if(gridMain.getValue(0, "empId") == null){
				alert("사번을 입력해주세요.");
				return;
			}
			
			let manGoalPerday = gridMain.getValue(0,'manGoalPerday'); //메인 그리드의 일 목표 생산량의 값
			let manPerday = gridMain.getValue(0, 'manPerday'); //메인그리드의 일생산량(하루 생산 가능한 수량)
					
			console.log(manGoalPerday);
			console.log(manPerday);
			
			if(manPerday < manGoalPerday){
				alert("하루 생산가능한 수량이 초과했습니다.");
				return;
			}
			
			let writeFromDate = document.getElementById('writeFromDate').value;
			//let commandName = document.getElementById('txtCommandName').value;
			//console.log(writeFromDate);
			//console.log(commandName);
			
			gridInsertCommand.setValue(0, 'comDate', writeFromDate);
			//gridInsertCommand.setValue(0, 'comName', commandName);
			//console.log(gridInsertCommand.getValue(0, 'comDate'));
			//console.log(gridInsertCommand.getValue(0, 'comName'));
			
				
			//******************************자재*****************************
			let r = gridResource.getData(); //자재 그리드 전체 데이터(배열형태)
			let l = gridResLOT.getData(); //자재 Lot 그리드 전체 데이터(배열형태)
			let resUsage;
			let ostCnt;
			let resCode2;
			let sumCnt=0;
			let ostSum = 0; //출고량 합계
			let flag = false;
			for(i of r){
				let resCode1 = gridResource.getValue(i.rowKey, 'resCode'); //자재 그리드의 자재코드
				resUsage = gridResource.getValue(i.rowKey, 'resUsage'); //자재 그리드의 소요량

				for(k of l){
					resCode2 = gridResLOT.getValue(k.rowKey, 'resCode'); //자재 LOT 그리드의 자재코드
					ostCnt = gridResLOT.getValue(k.rowKey, 'ostCnt'); //자재 LOT 그리드의 출고량
					
					if(resCode1 == resCode2 && ostCnt != null){ //자재그리드의 자재코드 = 자재LOT그리드의 자재코드
																//자재 LOT 그리드의 출고량에 값이 있을 때
							ostSum = ostSum*1+ ostCnt*1; 
						
					}
				}
				//console.log('ostSum : '+ostSum);
				//console.log('resUsage : '+resUsage);
				//console.log('');
				if(resUsage != ostSum){ //자재소요량이 출고량 합계와 같지 않을 경우
					flag=true;
				}
				ostSum = 0;
			}
			if(flag){
				alert("자재소요량과 출고량 합계가 맞지 않습니다.");
			}
			
			let a = {}; //a 객체 만들기
			a.command = gridInsertCommand.getData(); //a 객체에 command라는 키로 gridInsertCommand 데이터 넣기.
			a.commandDetail = gridInsertCommandDetail.getData();
			a.res = gridUpdateRes.getData();
			a.plan = girdUpdatePlanStatus.getData();
			a.resLot = gridInsertLot.getData();
			
			//console.log(a);
			
 			
			//******************************설비******************************
			let facList = gridFacility.getData(); //설비 그리드 전체 데이터(배열형태)
			console.log(facList);
			let aaa = 0;

			for (i of facList){
				var j = i.rowKey*1+1;
				if(i.rowKey == facList.length-1){
					break;
				}				
				let facCode1 = gridFacility.getValue(i.rowKey,'facCode');
				let facStatus1 = gridFacility.getValue(i.rowKey,'facStatus');
				let facCode2 = gridFacility.getValue(j,'facCode');
				let facStatus2 = gridFacility.getValue(j,'facStatus');
				console.log('fcode1 : '+facCode1);
				console.log('fcode2 : '+facCode2);
				console.log('fstatus : '+facStatus1);
				console.log('fstatus : '+facStatus2);
				if( facCode1 == facCode2
					&& 	
					facStatus1 == facStatus2 
					&& 
					facStatus1 == null
					&&
					facStatus2 == null
				){
					aaa = 1;	
				}
			}
			if(aaa == 1){
				alert ("지시를 못내립니다. 설비부족");
			}else{
				$.ajax({
					url: '${pageContext.request.contextPath}/hidden',
					dataType: 'JSON',
					method: 'POST',
					data: JSON.stringify(a), //a데이터를 넘겨준다.
					contentType: 'application/json',
					success: function(){
						
						alert("생산지시서가 저장되었습니다.");
					}
				})
			}
			
		})
		
				
		//------------ 도움말 버튼 이벤트 ---------------
 	 helpBtn.addEventListener('mouseover' , () => {
 	 	helpModal.dialog("open") ;
 	 })
		
tui.Grid.applyTheme('default', themesOptions);	
		
	</script>

</body>
</html>