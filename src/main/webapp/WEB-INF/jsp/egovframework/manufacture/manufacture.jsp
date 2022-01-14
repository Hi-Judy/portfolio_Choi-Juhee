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
	<h2>생산계획서 작성</h2><br>
	<div class = "planDate">
		<p style="display:inline-block;">계획일자</p>
		<input id = "txtFromDate" type="date" name="from" style="display:inline-block;">
		
		<p style="display:inline-block;"> ~ </p>
		<input id = "txtToDate" type="date" name="to" style="display:inline-block;">
	</div>

	<div>
		<p style="display:inline-block;">생산지시명</p>
		<input id = "txtPlanName" style="display:inline-block;">
	</div>
	<br>
	
	<div> 
		<button type="button" id="btnSearchPlan">미계획 조회</button><br>
		
		<input id="txtPodt"> 
		<button type="button" id="btnSearchRes">자재 조회</button>
		
		<!-- 미계획 모달 -->
		<div id = "dialog-form-plan" title="미계획 내역 조회" > 
			<div id="gridPlan"></div>
		</div>
		
		<!-- 자재조회 모달 -->
		<div id = "dialog-form-resource" title="자재 조회">
			<div id="gridResource"></div>
		</div>
	</div>
	<br>
	
	<div id = "gridMain"></div>
	<br>
	
	<div style="float:right;">
		<button type="button" id="btnSelectPlan">조회</button>
		<button type="button" id="btnSavePlan">저장</button>
		<button type="button" id="btnDeletePlan">삭제</button>
	</div>
	
	
	<script> 
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
		 
		
		//자재 모달 설정해주기. 
		let dialogResource = $("#dialog-form-resource").dialog({
			autoOpen: false, 
			modal: true,
			height: 400,
		    width: 600
		})

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
		const columnsMain = [
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
				header:'고객코드',
				name: 'cusCode',
				hidden: true
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
				header: '예상작업종료일',
				name: 'planComplete',
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
		
		//미계획 조회 버튼 눌렀을 때 모달창 띄우기
		$("#btnSearchPlan").on("click", function(){
			dialogPlan.dialog("open");
			gridPlan.readData(); //그리드에 데이터 읽어주기
			gridPlan.refreshLayout(); //Refresh the layout view. Use this method when the view was rendered while hidden.
		});
		
		
		//자재조회 그리드
		const dataSourceResource = {
			api: {
				//컨트롤러 resource를 POST 방식으로 찾아가기
				readData: { url: '${pageContext.request.contextPath}/manufacture/resource', 
						    method: 'POST'
						    /* initParams: { podtCode : txtPodt} */ 
				}
			},
			contentType: 'application/x-www-form-urlencoded;charset=UTF-8' //POST 방식으로 보낼 때 contentType.
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
			let txtPodt = document.querySelector('#txtPodt').value;
			dialogResource.dialog("open");
			gridResource.readData(1, {'podtCode': txtPodt}, true )//검색한 다음에 첫번째 페이지 보여준다.// 파라미터 // 값 불러온 다음에 새로고침 유무
			gridResource.refreshLayout();
		})
		
		
		//생산계획 조회 그리드
		const dataSourceMain = {
				api : {
					readData : {url: '${pageContext.request.contextPath}/manufacture/manufacture', 
							   method: 'GET'},
					//API를 사용하기 위해, 각 요청에 대한 url과 method를 등록
					modifyData : { url: '${pageContext.request.contextPath}/manufacture/main', 
								  method: 'POST' },
				},
				contentType : 'application/json;charset=UTF-8', //보낼때 json타입으로 보낸다.
				initialRequest : false
		};  
		
		
		//생산계획 그리드 내용. 
		var gridMain = new Grid({
			el : document.getElementById('gridMain'),
			data : dataSourceMain, //컨트롤러에서 리턴된 결과를 dataSource에 담아서 보여준다.
			columns : columnsMain,
			rowHeaders : ['checkbox']
		});
		
		let checkedPlan;
		
		gridPlan.on('check', function(ev){
				checkedPlan=gridPlan.getCheckedRows();

				checkedOrd = gridPlan.getValue(ev.rowKey, 'ordCode'); //체크된 row의 주문코드
				//console.log(gridPlan.getValue(ev.rowKey, 'podtCode')); //그리드에서 제품코드 가져오기
		});
		
		//미계획 모달에서 체크 박스 선택 후 확인 버튼 눌렀을 때 가는 function
		function goPlan(){
			gridMain.resetData(checkedPlan); //gridMain에 기존에 들어있는 데이터를 checkedPlan 로 리셋.
			//gridMain.appendRows(checkedPlan);
			dialogPlan.dialog("close");
		};
		
		//조회 버튼 이벤트
		$('#btnSelectPlan').click(function(){
			let dateFrom = document.getElementById('txtFromDate'); //시작일
			let dateTo = document.getElementById('txtToDate');	//종료일
			
			dateFrom = dateFrom.value;
			dateTo = dateTo.value;
		
			let data;
			$.ajax({
				url: '${pageContext.request.contextPath}/manufacture/selectPlan',
				method: 'POST',
				data:{'startDate' : dateFrom, 'endDate': dateTo  },
				dataType: 'JSON',
				async: false
			}).done(function(datas){
				data = datas;
				console.log("data")
				console.log(data);
				gridMain.resetData(data.result);
			}).fail(function(reject){
				console.log(reject);
			});
		}); 
		
		//저장 버튼 이벤트
		btnSavePlan.addEventListener("click", function(){
			console.log("!!SAVE!!")
			gridMain.blur();
			//gridMain에서 modifyData 요청 -> dataSourceMain의 modifyData 안의 url로 간다.
			gridMain.request('modifyData'); 
		});
		
		//삭제 버튼 이벤트
		btnDeletePlan.addEventListener("click", function(){
			gridMain.removeCheckedRows(true); //저절로 modify안에 deletedRows에 들어간다.
		});
		
	</script>
</body>
</html>