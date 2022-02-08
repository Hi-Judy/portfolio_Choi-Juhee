<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<!--  --------------- 달력 --------------- -->
<script src="https://cdn.jsdelivr.net/combine/npm/fullcalendar@5.10.1/main.min.js,npm/fullcalendar@5.10.1,npm/fullcalendar@5.10.1/locales-all.min.js,npm/fullcalendar@5.10.1/locales-all.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/combine/npm/fullcalendar@5.10.1/main.min.css,npm/fullcalendar@5.10.1/main.min.css">
<!--  --------------- 달력 --------------- -->

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"> </script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

<style>
.'tui-datepicker'{
	document.getElementsByClassName('tui-datepicker')[0].style = "position: relative";
	document.getElementsByClassName('tui-datepicker')[0].style = " z-index:100000"; 
}
</style>
</head>

<body>
	<div id="title" style="margin-left : 10px;"><h3 style="color : #054148; font-weight : bold">생산계획서 작성</h3></div>
	
	<div id="top" style="height : 200px; padding : 10px;">
	
		<!-- 계획일자 입력 -->
		<div class = "planDate">
			<p style="display:inline-block; margin-left : 20px; margin-top : 10px;">계획일자</p>
			<input id = "txtManDate" type="date" name="from" style="display:inline-block; margin-left : 27px;">
		</div>
	
		<!-- 계획명 입력 -->
		<div class="planName">
			<p style="display:inline-block; margin-left : 20px;">생산계획명</p>
			<input id = "txtPlanName" style="display:inline-block; margin-left : 10px;">
		</div>	
			
		<!-- 미계획 모달 -->
		<div id = "dialog-form-plan" title="미계획 내역 조회" > 
			<div id="gridPlan"></div>
		</div>

		<!-- 버튼 모음 -->
		<button type="button" id="btnSearchPlan" class="btn" style="float : left; margin : 5px;">미계획 조회</button>
		<button type="button" id="btnSearchManPlan" class="btn" style="float : left; margin : 5px;">생산계획 조회</button>
		<button type="button" id="btnInit" class="btn" style="float : right; margin : 5px;">초기화</button>
		<!-- <button type="button" id="btnDeletePlan" class="btn" style="float : right; margin : 5px;">삭제</button> -->
		<button type="button" id="btnSavePlan" class="btn" style="float : right; margin : 5px;">저장</button>
		<button type="button" id="btnCal" class="btn" style="float : right; margin : 5px;">달력테스트</button>
	</div>

	<!-- 작성된 생산계획 조회 모달 -->
	<div id="dialog-form-manPlan" title="생산계획 조회">
		
		<!-- 조회할 계획 기간 입력 -->
		<input id = "txtFromDate" type="date" name="from" style="display:inline-block; margin-left : 27px;">
		<p style="display:inline-block;"> ~ </p>
		<input id = "txtToDate" type="date" name="to" style="display:inline-block;">

		<button type="button" id="btnFindManPlan" class="btn" >생산계획 조회</button>
		<div id="gridManPlan"></div>
	
	</div>
	<br>
	
	<div id="OverallSize" style="margin-left : 10px;">
		<!-- 메인화면 그리드 -->
		<div id = "gridMain"></div>
		<br>
		
		<!-- 자재조회 그리드 -->
		<h5 style="color : #007b88;">자재조회</h5>
		<div id="gridResource" style = " z-index:1; position: relative"></div>
	</div>
	
	<!--  --------------- 달력 --------------- -->
	<div id="cal">
		<div id='calendar'></div>
	</div>
	<!--  --------------- 달력 --------------- -->
	
	<script> 
		tui.Grid.setLanguage('ko'); 
		var Grid = tui.Grid; //그리드 객체 생성
		
		// --------------- 달력 ---------------		
		let dialogCal = $("#cal").dialog({
			autoOpen : false ,
			modal : true ,
			height : 910,
			width : 1000,
			buttons : {
				"닫기" : function() {
					dialogCal.dialog("close") ;
				} 
			}
		})
		
		$("#btnCal").on('click' , function() {
			dialogCal.dialog("open") ;
			var calendarEl = document.getElementById('calendar');
	        var calendar = new FullCalendar.Calendar(calendarEl, {
	          initialView: 'dayGridMonth'
	        });
	        calendar.render();
	        $.ajax({
      		  url : 'selectCal' ,
      		  dataType : 'json' ,
      		  async : false ,
      		  success : function(datas) {
      			  let list = [] ;
      			  list = datas.calList ; 
      			  
      			  let calendarEl = document.getElementById('calendar') ;
      			  
      			  console.log(list) ;
      			  console.log(typeof list) ;
      			  
      			  let events = list.map(function(item) {
      				  return {
      					  title : item.comCode ,
      					  start : item.manStartdate ,
      					  end : item.ordDuedate
      				  }
      			  }) ;	
      			  
      			  let calendar = new FullCalendar.Calendar(calendarEl, {
      				  events : events
      			  })
      			  
   				calendar.render() ;
      		  } , 
      		  error : function(reject) {
      			  console.log(reject) ;
      		  }
      		  
      	  })
		})
		// --------------- 달력 ---------------
		
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
		
		
		
		//******************************미계획 모달******************************
		//미계획 모달 설정해주기
		let dialogPlan = $("#dialog-form-plan").dialog({
			autoOpen: false, 
			modal: true,
			height: 500,
		    width: 900,
			buttons: {
				"확인" : goPlan, //확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
				"취소" : function(){
					dialogPlan.dialog("close");
				}
			}		    
		});
		
		//미계획 모달 컬럼
		const columnsPlan = [
			{
				header:'주문코드',
				name: 'ordCode'
			},
			{
				header:'주문량',
				name: 'ordQnt'
			},
			{
				header:'고객코드',
				name: 'cusCode',
				hidden: true
			},
			{
				header: '납기일자',
				name: 'ordDuedate'
			},
			{
				header: '제품코드',
				name: 'podtCode'
			},
			{
				header: '제품명',
				name: 'podtName'
			}
		]
		
		
		//******************************미계획 그리드******************************
		//미계획 조회 버튼 눌렀을 때 모달창 띄우기
		$("#btnSearchPlan").on("click", function(){
			dialogPlan.dialog("open");
			gridPlan.readData(); //그리드에 데이터 읽어주기
			gridPlan.refreshLayout(); //Refresh the layout view. Use this method when the view was rendered while hidden.
		});
		
		//미계획 조회 그리드
		const dataSourcePlan = {
				api: {
					//컨트롤러 plan 찾아가기
					readData: {url: '${pageContext.request.contextPath}/manufacture/plan', 
							   method: 'GET',
					 		   initParams: { ordStatus : '미진행'} 
					}
				},
				contentType: 'application/json' //보낼때 json타입으로 보낸다.
				//initialRequest:false
		};
		
		//미계획 그리드 내용. 
		let gridPlan = new Grid({
			el: document.getElementById('gridPlan'),
			data: dataSourcePlan, //컨트롤러에서 리턴된 결과를 dataSource에 담아서 보여준다.
			columns: columnsPlan,
			rowHeaders: ['checkbox']
		})
		
		//미계획 모달에서 체크 박스 선택 후 확인 버튼 눌렀을 때 가는 function
		function goPlan(){
			console.log('확인완료');
			
			let a = gridPlan.getCheckedRows();

			//console.log(checkedPlan[0].podtCode);
			$.ajax({
				url: '${pageContext.request.contextPath}/manufacture/manPlanDetailByPlan',
				method:'POST', 
				dataType: 'JSON',
				data: JSON.stringify(a),
				contentType: 'application/json',
				success: function(datas){
					//data2 = datas
					console.log(datas);
					//확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
					gridMain.resetData(datas.data.contents);
					
					dialogPlan.dialog("close");
				}
			})
			
			let txtPlanDate = document.querySelector('#txtManDate').value;
			console.log(txtPlanDate);
			txtPlanDate.value = '';
		};

		let checkedPlan;
		
		//미계획 그리드에서 체크된 한 행
		gridPlan.on('check', function(ev){
			checkedPlan=gridPlan.getCheckedRows();
			checkedOrd = gridPlan.getValue(ev.rowKey, 'ordCode'); //체크된 row의 주문코드
			//console.log(gridPlan.getValue(ev.rowKey, 'podtCode')); //그리드에서 제품코드 가져오기
		});
		
		
		
		//******************************생산계획 모달******************************
		//생산계획 조회 모달 설정해주기
		let dialogManPlan = $("#dialog-form-manPlan").dialog({
			autoOpen: false, 
			modal: true,
			height: 500,
		    width: 900,
		    buttons: {
				"확인" : function(){

					console.log('확인완료');
					//console.log(checkedManPlan[0].podtCode);
					//console.log(checkedManPlan[0].manPlanNo);
					
					fetch("${pageContext.request.contextPath}/manufacture/manPlanDetail/"
							+checkedManPlan[0].manPlanNo+"/"+checkedManPlan[0].podtCode)
					.then((response) => response.json())
					.then((data)=>{
						console.log(data.data.contents);
						
						//확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
						gridMain.resetData(data.data.contents);
					
					})
				
					dialogManPlan.dialog("close");
				},
				"취소" : function(){
					//console.log('취소');
					dialogManPlan.dialog("close");
				}
			}		
		})
		
		//생산계획조회 컬럼
		const columnsManPlan = [
			{
				header:'생산계획번호',
				name: 'manPlanNo'
			},
			{
				header:'생산계획명',
				name: 'manPlanName'
			},
			{
				header:'계획일자',
				name: 'manPlanDate'
			},
			{
				header:'제품코드',
				name: 'podtCode'
			},
			{
				header:'제품명',
				name: 'podtName'
			}
			
		] 
		
		//******************************생산계획 그리드******************************
		let data ;
		//생산계획 조회 버튼 클릭
		$('#btnSearchManPlan').click(function(){
			console.log('생산계획조회 테스트');
			
			dialogManPlan.dialog("open");
			gridManPlan.refreshLayout();
			
			//생산계획 조회 모달안에서 생산계획 조회
			$('#btnFindManPlan').click(function(){
				
				let dateFrom = document.getElementById('txtFromDate');
				let dateTo = document.getElementById('txtToDate');
				
				dateFrom = dateFrom.value;
				dateTo = dateTo.value;
				
				$.ajax({
					url: '${pageContext.request.contextPath}/manufacture/manPlan',
					method: 'POST',
					data: {'startDate' : dateFrom, 'endDate': dateTo  },
					dataType: 'JSON',
					success: function(datas){
						console.log("생산계획 조회 모달안에서 생산계획 조회");
						data = datas;
						console.log(data);
						gridManPlan.resetData(data.result);
						gridManPlan.resetOriginData();
						gridManPlan.refreshLayout();
					},
					error: function(reject){
						console.log('reject: '+ reject);
					}
				})
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
		let checkedManPlan;
		
		//생산계획 그리드에서 체크된 계획의 행을 가져온다.
		gridManPlan.on('check', function(ev){
			checkedManPlan = gridManPlan.getCheckedRows();
		})
		
		
		
		//******************************메인 그리드******************************
		//메인화면 컬럼
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
				header:'주문코드',
				name: 'ordCode'
			},
			{
				header:'주문상태',
				name: 'ordStatus',
				hidden: true
			},
			{
				header:'고객코드',
				name: 'cusCode',
				hidden: true
			},
			{
				header:'계획일자',
				name: 'manPlanDate',
				hidden: false
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
				header: '작업기간',
				name: 'planPeriod',
				editor: 'text'
			},
			{
				header: '작업시작일',
				name: 'planStartDate',
				editor: 'datePicker'
			},
			{
				header: '작업종료일',
				name: 'planComplete',
				editor: 'datePicker'
			},
			{
				header: '일생산량(UPH*12)',
				name: 'manPerday',
				editor: 'text'
			},
			{
				header: '비고',
				name: 'planEtc',
				editor: 'text'
			}
		]
		
		
		//메인 그리드
		const dataSourceMain = {
			api : {
				readData : {url: '.', 
						   method: 'GET'},
				//API를 사용하기 위해, 각 요청에 대한 url과 method를 등록
				modifyData : { url: '${pageContext.request.contextPath}/manufacture/main', 
							  method: 'POST' },
			},
			contentType : 'application/json;charset=UTF-8', //보낼때 json타입으로 보낸다.
			//initialRequest : false
		};  
		
		//메인 그리드
		var gridMain = new Grid({
			el : document.getElementById('gridMain'),
			data : dataSourceMain, //컨트롤러에서 리턴된 결과를 dataSource에 담아서 보여준다.
			columns : columnsMain,
			rowHeaders : ['checkbox']
		});
		
		//메인 그리드에서 체크된 계획
		let checkedMain;
		
		//메인 그리드에서 클릭된 계획의 행을 가져온다.
		gridMain.on('click', function(ev){
			checkedMain = gridMain.getCheckedRows();
			console.log(checkedMain);
			
			fetch("${pageContext.request.contextPath}/manufacture/resource/"
					+checkedMain[0].podtCode)
			.then((response) => response.json())
			.then((data)=> {
				console.log(checkedMain);
				console.log(checkedMain[0].podtCode);
				
				console.log(data.data.contents);
				gridResource.resetData(data.data.contents);
				
			})
		})
		
		
		
		//******************************자재조회 그리드******************************
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
				name: 'rscCode'
			},
			{
				header:'소요량',
				name: 'resUsage'
			},
			{
				header: '재고량',
				name: 'rscCnt'
			}
		]

		//자재조회 그리드 내용
		const gridResource = new Grid({
			el: document.getElementById('gridResource'),
			data: null,
			columns: columnsResource,
			rowHeaders: ['rowNum']
		})
			
	/* 	//자재 조회 버튼 눌렀을 때 모달창 띄우기
		$("#btnSearchRes").on("click", function(){
			let txtPodt = document.querySelector('#txtPodt').value;
			//dialogResource.dialog("open");
			gridResource.readData(1, {'podtCode': txtPodt}, true )//검색한 다음에 첫번째 페이지 보여준다.// 파라미터 // 값 불러온 다음에 새로고침 유무
			gridResource.refreshLayout();
		}) */
		
	
		
		//******************************버튼이벤트 모음******************************
		//저장 버튼 이벤트
		btnSavePlan.addEventListener("click", function(){
			let txtPlanDate = document.getElementById('txtManDate');
			let txtPlanName = document.getElementById('txtPlanName');
			console.log(txtPlanDate.value);
			console.log(txtPlanName.value);
			//console.log(txtPlanDate.type);
		
 			if(txtPlanDate.value == null || txtPlanDate.value == ""){
				alert("계획일자를 입력해주세요.");
				//gridMain.request('modifyData');
			} 
 			if(txtPlanName.value == null || txtPlanName.value == ""){
				alert("계획명을 입력해주세요.");
				//gridMain.request('modifyData'); 
			} 
 			
 			let updateDatas = gridMain.getModifiedRows() ;
 	        let updateData = updateDatas.updatedRows ;
 	      
 		 	for(let i=0; i< updateData.length; i++){
 		 		let planStartDate = updateData[i].planStartDate ;
 		 		let planComplete = updateData[i].planComplete ;

 		 		if(gridMain.getValue(i, "planStartDate") == null){
					alert("작업시작일을 입력해주세요.");
					return;
					//gridMain.request('modifyData'); 					
				} else if(gridMain.getValue(i, "planComplete") == null){
					alert("작업종료일을 입력해주세요.");
					return;
					//gridMain.request('modifyData'); 		
				} else{
					gridMain.request('modifyData'); 		
				}
			} 
 			
			let a = gridMain.getCheckedRows();
			console.log(a);
			
			for(i of a){
				console.log(i);
				gridMain.setValue(i.rowKey, 'manPlanDate', txtPlanDate.value);
				gridMain.setValue(i.rowKey, 'manPlanName', txtPlanName.value);
				console.log(gridMain.getValue(i.rowKey,'manPlanDate'));
				console.log(gridMain.getValue(i.rowKey,'manPlanName'));
			}
			
			//console.log("!!SAVE!!")
			gridMain.blur();
			//gridMain에서 modifyData 요청 -> dataSourceMain의 modifyData 안의 url로 간다.
			
		
			
		});
		
		
/* 		//삭제 버튼 이벤트
		btnDeletePlan.addEventListener("click", function(){
			gridMain.removeCheckedRows(true); //저절로 modify안에 deletedRows에 들어간다.
		}); */
		
		//초기화 버튼 이벤트
		btnInit.addEventListener("click", function(){
			let txtPlanDate = document.getElementById('txtFromDate');
			let txtPlanTo = document.getElementById('txtToDate');
			let txtPlanName = document.getElementById('txtPlanName');
			
			txtPlanDate.value = '';
			txtPlanTo.value = '';
			txtPlanName.value ='';
			
		})
		
	
	</script>
</body>
</html>