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
	<h2>생산계획서 조회</h2><br>
	
	<div class = "planDate">
		<p style="display:inline-block;">계획일자</p>
		<input id = "txtFromDate" type="date" name="from" style="display:inline-block;">
		
		<p style="display:inline-block;"> ~ </p>
		<input id = "txtToDate" type="date" name="to" style="display:inline-block;">
	</div>
	
	<div>
		<p style="display:inline-block;">제품코드</p>
		<input id = "txtPodtCode" style="display:inline-block;">
		
		<button type="button" id="btnSearchManPlan">생산계획 조회</button><br>
		<button type="button" id="btnSearchRes">자재 조회</button><br>
		
		<!-- 생산계획 모달 -->
		<div id = "dialog-form-manPlan" title="생산계획 조회" > 
			<div id="gridManPlan"></div>
		</div>
		
		<!-- 자재조회 모달 -->
		<div id = "dialog-form-resource" title="자재 조회">
			<div id="gridResource"></div>
		</div>
	</div>
	
	<!-- 메인화면 그리드 -->
	<div id = "gridMain"></div>
	<br>
	
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
		
		//******************************모달 설정******************************
		//생산계획 조회 모달 설정해주기
		let dialogManPlan = $("#dialog-form-manPlan").dialog({
			autoOpen: false, 
			modal: true,
			height: 500,
		    width: 900,
		    buttons: {
				"확인" : function(){
					console.log('확인완료');
					console.log(checkedManPlan[0].manPlanNo);
					$.ajax({
						url: '${pageContext.request.contextPath}/manufacture/selectManDetail/'+checkedManPlan[0].manPlanNo,
						method:'GET', 
						dataType: 'JSON',
						success: function(datas){
							//console.log(datas); 
							//확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
							gridMain.resetData(datas.data.contents);
						}
					})
					dialogManPlan.dialog("close");
				},
				"취소" : function(){
					//console.log('취소');
					dialogPlan.dialog("close");
				}
			}		
		})
		
		//자재 모달 설정해주기
		let dialogResource = $("#dialog-form-resource").dialog({
			autoOpen: false, 
			modal: true,
			height: 400,
		    width: 600
		})
		
		
		//******************************모달 컬럼******************************
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
				header:'주문코드',
				name: 'ordCode'
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
				header: '재고량',
				name: '재고량'
			}
		]
		
		
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
				header:'생산계획명',
				name: 'cusCode',
				hidden: true
			},
			{
				header:'계획일자',
				name: 'manPlanName',
				hidden: false
			},
			{
				header:'주문코드',
				name: 'ordCode'
			},
			{
				header: '납기일자',
				name: 'ordDuedate'
			},
			{
				header: '예상작업기간',
				name: 'planPeriod',
				editor: 'text'
			},
			{
				header: '예상작업시작일',
				name: 'planStartDate',
				editor: 'datePicker'
			},
			{
				header: '생산량',
				name: 'manPerday',
				editor: 'text'
			},
			{
				header: '비고',
				name: 'planEtc',
				editor: 'text'
			}
		]
		
		
		//******************************자재조회 그리드******************************
		//자재조회 그리드
		const dataSourceResource = {
			api: {
				readData: { url: '${pageContext.request.contextPath}/manufacture/selectResource', 
						    method: 'POST'
				}
			},
			contentType: 'application/x-www-form-urlencoded;charset=UTF-8' 
		};
		
		//자재조회 그리드 내용
		const gridResource = new Grid({
			el: document.getElementById('gridResource'),
			data: dataSourceResource,
			columns: columnsResource,
			rowHeaders: ['rowNum']
		})
			
		//자재 조회 버튼 눌렀을 때 모달창 띄우기
		$("#btnSearchRes").on("click", function(){
			console.log("자재조회!")
			let txtPodt = document.querySelector('#txtPodtCode').value;
			dialogResource.dialog("open");
			gridResource.readData(1, {'podtCode': txtPodt}, true )//검색한 다음에 첫번째 페이지 보여준다.// 파라미터 // 값 불러온 다음에 새로고침 유무
			gridResource.refreshLayout();
		})
		
	
		//******************************생산계획 그리드******************************
		let data ;
		
		//생산계획 조회 버튼 클릭
		$('#btnSearchManPlan').click(function(){
			//console.log('생산계획조회 테스트');
			let dateFrom = document.getElementById('txtFromDate');
			let dateTo = document.getElementById('txtToDate');
			let txtPodt = document.querySelector('#txtPodtCode').value;
			
			dateFrom = dateFrom.value;
			dateTo = dateTo.value;
			
			//console.log(dateFrom);
			//console.log(dateTo);
			//console.log(txtPodt);

			
			dialogManPlan.dialog("open");
			$.ajax({
				url: '${pageContext.request.contextPath}/manufacture/selectManufacturePlan',
				method: 'POST',
				data: {'startDate' : dateFrom, 'endDate': dateTo, 'podtCode': txtPodt  },
				dataType: 'JSON',
				success: function(datas){
					data = datas;
					gridManPlan.resetData(data.result);
					gridManPlan.resetOriginData();
					gridManPlan.refreshLayout();
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
		let checkedManPlan;
		
		//생산계획 그리드에서 체크된 계획의 행을 가져온다.
		gridManPlan.on('check', function(ev){
			checkedManPlan = gridManPlan.getCheckedRows();
			console.log(checkedManPlan);
			console.log(checkedManPlan[0].manPlanNo);
		})
		
		
		//******************************메인 그리드******************************
		//메인 그리드
		const dataSourceMain = {
				api : {
					readData : {url: '.', 
							   method: 'GET'},
				},
				contentType : 'application/json;charset=UTF-8', 
		};  
		
		//메인 그리드
		var gridMain = new Grid({
			el : document.getElementById('gridMain'),
			data : dataSourceMain, 
			columns : columnsMain,
			rowHeaders : ['checkbox'],
			sortable: true
		});
		
	
	</script>
</body>
</html>