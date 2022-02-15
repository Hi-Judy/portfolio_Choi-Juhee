<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산실적관리</title>
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
	<div style="width : 1500px ;">
		<span style="float: right;">
			<button type="button" id="helpBtn" style="border : none; background-color : #f2f7ff; color : #007b88; float : right ;">
			<i class="bi bi-question-circle"></i>
			</button>
		</span>
		<h4 style="margin-left: 10px">생산실적조회</h4>
	</div>
	
	<!-- 생산실적관리 조회 기준 -->
	<div id="top" style="height: 55px;">
		<form id = "findPerformance">
			<div style="margin-top: 8px; margin-left: 5px;">
				<label for="podtCode">제품별</label> 	
				<input type="radio" id="podt" name="performanceSort" value="podtCode" >
				
				<label for="manMonth" style=" margin-left: 10px;">월별</label> 	
				<input type="radio" id="month" name="performanceSort" value="monthCode" >
				
				<button class="btn" type="button" id="btnPerformance"
					style="display: inline-block; margin-left: 10px;">조회</button>
			</div>
		</form>
	</div>
	<br>
	
	<!-- 월별 생산 실적 그리드 -->
	<div id="OverallSize" >
		<div id="gridPerformance" style="border-top: 3px solid #168; margin-left: 10px; width: 1500px;" ></div>
	</div>
	
	
		<!--  --------------- 도움말 --------------- -->
	<div id="helpModal" title="도움말">
		<hr>
		제품별로 실적을 조회할지 월별로 조회할지 상태를 선택합니다.<br><br>
		조회버튼을 클릭하면 선택값에 따른 생산지시가 조회됩니다. <br><br>
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
		
		
		//******************************월별 생산 실적 그리드******************************
		//생산실적조회 버튼 클릭
		$("#btnPerformance").click(function(){
			console.log("실적조회 클릭테스트");
			
			$.ajax({
				url: '${pageContext.request.contextPath}/findPerformance',
				method: 'POST',
				data: $("#findPerformance").serialize(),
				success: function(datas){
					data = JSON.parse(datas);
					console.log(data);
					console.log(data.result);
					gridPerformance.resetData(data.result);
					gridPerformance.refreshLayout();
				},
				error: function(reject){
					console.log('reject: '+ reject);
				}
				
			})
			
		
		})
		
		//생산 실적 그리드 컬럼
		const columnsPerformance = [
			{
				header : '월',
				name : 'monthCode',
				align : 'center'
			},
			{
				header : '제품코드',
				name : 'podtCode',
				align : 'center'
			},
			{
				header : '제품명',
				name : 'podtName',
				align : 'center'
			},
			{
				header : '지시수량',
				name : 'manGoalqnt',
				align : 'center'
			},
			{
				header : '작업완료량',
				name : 'manQnt',
				align : 'center'
			},
			{
				header : '불량량',
				name : 'defQnt',
				align : 'center'
			},
			{
				header : '불량율',
				name : 'defPercentage',
				align : 'center',
				formatter(value) {
	               if(value.value != null && value.value != '' ){
	                    return value.value.toString().replace('.','0.') + '%';
	               }else{
	                  return value.value ;
	               }
		        }
			}
			
		]
		
		//생산 실적 그리드 내용
		let gridPerformance = new Grid({
			el: document.getElementById('gridPerformance'),
			data: null,
			columns: columnsPerformance,
			rowHeaders : [ 'rowNum' ],
	        bodyHeight: 500
		})
		
		gridPerformance.on('click' , (ev) => {
	    	//선택한값 색상 넣고 뺴기
	    	gridPerformance.setSelectionRange({
	        	start: [ev.rowKey, 0],
	        	end: [ev.rowKey, gridPerformance.getColumns().length-1]
	        });
		});
		
		//------------ 도움말 버튼 이벤트 ---------------
	 	 helpBtn.addEventListener('mouseover' , () => {
	 	 	helpModal.dialog("open") ;
	 	 })
		
		tui.Grid.applyTheme('default', themesOptions);			
	</script>
</body>
</html>