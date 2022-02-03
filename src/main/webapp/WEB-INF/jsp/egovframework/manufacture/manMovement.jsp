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
	<div class="podtToday">
		<p style="display: inline-block;">제품코드</p>

		<input id="txtPodtCode" type="text" name="manDate" style="display: inline-block;">
			
		<button type="button" id="btnSearchCommand"
			style="display: inline-block;">조회</button>
	</div>
	<br>
	
	<!-- 생산지시서 조회 모달 -->
	<div id="dialog-form-manCommand" title="생산지시 조회">
		<div id="gridManCommand"></div>
	</div>
	
	<!-- 공정이동 그리드 -->
	<div id="gridMovement" class="col-sm-11" style="float: left;"></div>
	
	
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
					
					fetch("${pageContext.request.contextPath}/selectMovement/"+checkedCommand[0].comCode)
					.then((response) => response.json())
					.then((data)=> {
						console.log(data.data.contents);
						//console.log(data.data.contents[0].podtCode);
						gridProcess.resetData(data.data.contents) //파싱한 결과 = data
						gridProcess.refreshLayout();
						
						let mandate = document.querySelector("#txtManDate").value; //작업일 인풋태그 입력값
						//console.log(mandate);
						
						document.getElementById("manDate").innerHTML = mandate
						document.getElementById("podtCode").innerHTML = data.data.contents[0].podtCode
						document.getElementById("podtName").innerHTML = data.data.contents[0].podtName
						document.getElementById("comCode").innerHTML = data.data.contents[0].comCode
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
				name : 'manStartDate'
			}, 
			{
				header : '상태',
				name : 'comEtc'
			}
		]
		
		//******************************생산지시조회 그리드******************************
		//생산지시조회 버튼 클릭
		$("#btnSearchCommand").click(function(){
			let podtCode = document.querySelector("#txtPodtCode").value; //작업일 인풋태그 입력값
			console.log(podtCode);
			
			dialogCommand.dialog("open");
			$.ajax({
				url : '${pageContext.request.contextPath}/findCommand',
				method : 'POST',
				data : {
					'podtCode' : podtCode
				},
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
		
		
	
	</script>
	

</body>
</html>