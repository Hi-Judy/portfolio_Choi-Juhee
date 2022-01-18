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
	
	<div class = "writeDate">
		<p style="display:inline-block;">작성일자</p>
		<input id = "writeFromDate" type="date" name="from" style="display:inline-block;">
		
		<p style="display:inline-block;"> ~ </p>
		<input id = "writeToDate" type="date" name="to" style="display:inline-block;">
	</div>
	
	<div>
		<p style="display:inline-block;">생산지시명</p>
		<input id = "txtCommandName" style="display:inline-block;">
	</div>
	<br>
	
	<div>
		
		<p style="display:inline-block;">계획기간</p>
		<input id = "planFromDate" type="date" name="from" style="display:inline-block;">
	
		<p style="display:inline-block;"> ~ </p>
		<input id = "planToDate" type="date" name="to" style="display:inline-block;">
		
		<button type="button" id="btnSearchManPlan">생산계획 조회</button><br>
		<br>
		
		<!-- 생산계획 조회 모달 -->
		<div id = "dialog-form-manPlan" title="생산계획 조회">
			<div id="gridManPlan"></div>
		</div>
		
		
		
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
		
		
		//******************************모달 설정******************************
		//생산계획 모달 설정
		let dialogManPlan = $("#dialog-form-manPlan").dialog({
			autoOpen: false, 
			modal: true,
			height: 500,
		    width: 900
		    /* buttons: {
				"확인" : //goCommand, //확인 버튼 눌렀을 때 체크된 값에 해당하는 데이터를 gridMain에 뿌려준다.
						function(){
							console.log("확인 테스트");
						},		
				"취소" : function(){
					dialogPlan.dialog("close");
				}
			} */	
		});
		
		
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
				header:'주문량',
				name: 'ordQnt'
			},
			{
				header: '납기일자',
				name: 'ordDuedate'
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
			console.log('생산계획조회 테스트');
			
			let writeFromDate = document.getElementById('writeFromDate').value;
			let writeToDate = document.getElementById('writeToDate').value;
			
			console.log(writeFromDate);
			console.log(writeToDate);
			
			dialogManPlan.dialog("open");
			$.ajax({
				url: '${pageContext.request.contextPath}/selectManPlan',
				method: 'POST',
				data: {'writeStartDate' : writeFromDate, 'writeEndDate': writeToDate },
				data: 'JSON',
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
		let checkedManPlan;
		
		//생산계획 그리드에서 체크된 계획의 행을 가져온다.
		gridManPlan.on('check', function(ev){
			checkedManPlan = gridManPlan.getCheckedRows();
		})
		
		function goCommand(){
			
		}
		
	</script>
</body>
</html>