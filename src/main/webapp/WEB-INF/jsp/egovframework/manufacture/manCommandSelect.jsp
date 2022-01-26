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
	<h2>생산지시서 조회</h2><br>
	
	<div class = "selectCommand">
		<!-- 작업일자별로 조회 -->
		<p style="display:inline-block;">작업일자</p>
		<input id = "txtManDate" type="date" name="manDate" style="display:inline-block;">

		<!-- 제품코드별로 조회 -->
		<p style="display: inline-block;">제품코드</p>
		<input id="txtPodtCode" style="display: inline-block;">
	</div>

	<div>	

		<button type="button" id="searchCommand">생산지시조회</button>
		
		<button type="button" id="btnInit">초기화</button>
	</div>


	<br>
	
	<!-- 생산지시 조회 그리드 -->
	<div id="gridCommand"></div>
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
		
		
		//******************************생산지시 조회 그리드******************************
		//작업 일자별 생산지시 조회 모달 컬럼
		const columnsCommand = [
			{
				header: '지시번호',
				name: 'comCode'
			},
			{
				header: '작업일',
				name: 'manStartDate'
			},
			{
				header: '생산지시명',
				name: 'comName'
			},
			{
				header: '제품코드',
				name: 'podtCode'
			},
			{
				header: '제품명',
				name: 'podtName'
			},
			{
				header: '작업량',
				name: 'manGoalPerday'
			},
			{
				header: '주문량',
				name: 'ordQnt'
			},
			{
				header: '비고(사번)',
				name: 'manEtc'
			}
			
		]
		
		/* const dataCommand = {
			api: {
				readData: {url: '${pageContext.request.contextPath}/selectCommand',
						   method: 'POST'
				}
			},
			contentType: 'application/x-www-form-urlencoded;charset=UTF-8' 
		}; */
		
		//#
		let commandData;
		
		//작업일자별로 생산지시 조회 버튼 클릭 이벤트
		$('#searchCommand').click(function(){
			console.log('작업일자별로 생산지시 조회');
			
			let manDate = document.querySelector('#txtManDate').value;
			let podtCode = document.querySelector('#txtPodtCode').value;
			
			console.log(manDate);
			console.log(podtCode);
			
			//gridCommand.readData(1, {'manStartDate': manDate, 'podtCode': podtCode}, true );
			gridCommand.refreshLayout();
			
			$.ajax({
				url: '${pageContext.request.contextPath}/selectCommand',
				method: 'POST',
				data: {'manStartDate' : manDate, 'podtCode': podtCode },
				dateType: 'JSON',
				success: function(datas){
					//commandData = datas;
					
					console.log((JSON.parse(datas)).result);
					//console.log(commandData);
					//console.log(manDateData.result);
				/* 	console.log(commandData.result);
					console.log(commandData.data);
					console.log(commandData.data.contents); */
					gridCommand.resetData((JSON.parse(datas)).result);
					gridCommand.refreshLayout();
				},
				error: function(reject){
					console.log('reject: '+ reject);
				}
			})
		})
		
		
		//작업 일자별 생산지시 조회 그리드 내용
		let gridCommand = new Grid({
			el: document.getElementById('gridCommand'),
			data: null,
			columns: columnsCommand,
			rowHeaders: ['rowNum']
		})
		
		
		//******************************초기화 버튼 클릭******************************
		btnInit.addEventListener("click", function(){
			gridCommand.resetData([{}]);
			

			let txtManDate = document.getElementById('txtManDate');
			let txtPodtCode = document.getElementById('txtPodtCode');
			
			txtManDate.value = '';
			txtPodtCode.value = '';

		})
		
	</script>
</body>
</html>