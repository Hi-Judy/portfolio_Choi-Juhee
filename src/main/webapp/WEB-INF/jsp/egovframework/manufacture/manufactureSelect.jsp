<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<div id="title" style="margin-left : 10px;"><h3 style="color : #054148; font-weight : bold">생산계획서 조회</h3></div>
	
	<div id="top" style="height : 160px; padding : 10px;">
	
		<div class = "selectPlan">
			<!-- 계획일자별로 조회 -->
			<p style="display:inline-block; margin-left : 20px; margin-top : 10px;">계획일자</p>
			<input id = "txtManDate" type="date" name="from" style="display:inline-block;">
			<br>			
			
			<!-- 제품코드별로 조회 -->
			<p style="display:inline-block; margin-left : 20px; margin-top : 10px;">제품코드</p>
			<input id = "txtPdotCode" style="display: inline-block; margin-left : 10px;">
			<br>
			
			<!-- 버튼모음 -->
			<button type="button" id="btnInit" class="btn" style="float : right; margin : 5px;">초기화</button>
			<button type="button" id="btnSearchManPlan" class="btn" style="float : right; margin : 5px;">생산계획조회</button>
		</div>
		
	</div>
	
	<div id="OverallSize" style="margin-left : 10px;">
		<!-- 메인화면 그리드 -->
		<div id = "gridMain"></div>
		<br>
		
		<!-- 자재조회 그리드 -->
		<div>자재조회</div>
		<div id="gridResource"></div>
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
		
		
		//생산계획조회 버튼 클릭이벤트
		$('#btnSearchManPlan').click(function(){
			console.log('생산계획 조회');
			
			let manDate = document.querySelector('#txtManDate').value;
			let podtCode = document.querySelector('#txtPdotCode').value;
			
			console.log(manDate);
			console.log(podtCode);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/manufacture/selectManufacturePlan',
				method: 'POST',
				data: {'manPlanDate' : manDate, 'podtCode': podtCode },
				dataType: 'JSON',
				success: function(datas){
					console.log(datas);
					
					gridMain.resetData(datas.result);
					gridMain.refreshLayout();
				}
			})
		})
		
		
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
			
			fetch("${pageContext.request.contextPath}/manufacture/resource/"
					+checkedMain[0].podtCode )
			.then((response) => response.json())
			.then((data)=> {
				console.log(checkedMain);
				console.log(checkedMain[0].podtCode);
				
				console.log(data.data.contents);
				gridResource.resetData(data.data.contents);
				
			})
		})
		
		
			
		//******************************자재 조회 그리드******************************
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
		
		
		//******************************초기화 버튼 이벤트******************************
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