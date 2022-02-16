<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<div style="width : 1500px ;">
		<span style="float: right;">
			<button type="button" id="helpBtn" style="border : none; background-color : #f2f7ff; color : #007b88; float : right ;">
			<i class="bi bi-question-circle"></i>
			</button>
		</span>
		<h4 style="margin-left: 10px">생산 현황</h4>
	</div>	
	
	<div id="top" style="height : 150px; padding : 10px;">
		<!-- 생산지시서 조회 -->
		<div >
			<p style="display: inline-block; margin-left : 5px; margin-top : 10px;">작업일</p>
	
			<input id="txtManDate" type="date" name="manDate"
				style="display: inline-block; margin-left : 10px;">
			<button type="button" id="btnSearchCommand" class="btn"
				style="display: inline-block; margin-left: 10px;">조회</button>
			
			<div>


				<p style="display: inline-block; margin-left : 5px;">제품코드 : </p>
				<p id="podtCode" style="display: inline-block;"></p>
		
				<p style="display: inline-block; margin-left : 100px;">제품명 : </p>
				<p id="podtName" style="display: inline-block;"></p>
				
				<p style="display: inline-block; margin-left : 100px;">생산지시번호 : </p>
				<p id="comCode" style="display: inline-block;"></p>
				
				<button type="button" id="btnInit" class="btn" style="display: inline-block; float : right; margin : 5px;">초기화</button>
				<button type="button" id="btnReStart" class="btn" style="display: inline-block; float : right; margin : 5px;">재시작</button>
				<button type="button" id="btnStop" class="btn" style="display: inline-block; float : right; margin : 5px;">중지</button>
				<button type="button" id="btnStart" class="btn" style="display: inline-block; float : right; margin : 5px;">시작</button>
			</div>
			
			</div>
			
		</div>
	</div>
	<br>

	<div id="OverallSize" style="height: 525px; margin-left : 10px;">
	
		<!-- 공정현황 그리드 -->
		<div id="gridProcess" style=" border-top: 3px solid #168;"></div>
		
		<div id="image" align="center">
			<img id="stopImg" src="<c:url value='/images/egovframework/com/process/04.jpg'/>" style="width : 800px; height : auto; display: block;">
			<img id="moveImg" src="<c:url value='/images/egovframework/com/process/03.gif'/>" style="width : 800px; height : auto; display: none;">
		</div>
	</div>

	<!-- 생산지시서 조회 모달 -->
	<div id="dialog-form-manCommand" title="생산지시 조회">
		<div id="gridManCommand" style="margin-top: 15px ; border-top: 3px solid #168;"></div>
	</div>
	
	<!--  --------------- 도움말 --------------- -->
	<div id="helpModal" title="도움말">
		<hr>
		작업일을 입력하고 조회버튼을 눌러 원하는 생산지시를 선택합니다.<br><br>
		지시완료인 공정을 선택하면 시작버튼을 눌러 공정을 시작합니다. <br><br>
		생산중이거나 생산완료인 지시는 시작버튼을 누를 수 없습니다. <br>
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
		
		
		//******************************작업일자 기본값******************************
		document.getElementById('txtManDate').value = new Date().toISOString().substring(0, 10);
		
		
		//******************************생산지시조회 모달******************************
		//생산지시 조회 모달 설정
		let dialogCommand = $("#dialog-form-manCommand").dialog({
			autoOpen : false,
			modal : true,
			height : 500,
			width : 900,
			buttons : {
				"확인" : function() {
					//console.log("확인 테스트");
					//console.log(checkedCommand[0].podtCode);
					//console.log(checkedCommand[0].comCode);
					//console.log(checkedCommand[0].comEtc);
					
					if(checkedCommand[0].comEtc == "지시완료"){
						
						fetch("${pageContext.request.contextPath}/selectProcess/"
								+checkedCommand[0].podtCode+ "/" +checkedCommand[0].comCode + "/" +checkedCommand[0].comEtc )
												
						.then((response) => response.json())
						.then((data)=> {
							//console.log(data.data.contents);
							//console.log(data.data.contents[0].podtCode);
							//console.log(data.data.contents[0].comCode);
							gridProcess.resetData(data.data.contents) //파싱한 결과 = data
							gridProcess.refreshLayout();
							
							let mandate = document.querySelector("#txtManDate").value; //작업일 인풋태그 입력값
							//console.log(mandate);
							
							document.getElementById("podtCode").innerHTML = data.data.contents[0].podtCode
							document.getElementById("podtName").innerHTML = data.data.contents[0].podtName
							document.getElementById("comCode").innerHTML = data.data.contents[0].comCode
						
						})
					} else{
						fetch("${pageContext.request.contextPath}/findProcess/"
								+checkedCommand[0].podtCode+ "/" +checkedCommand[0].comCode + "/" +checkedCommand[0].comEtc )
												
						.then((response) => response.json())
						.then((data)=> {
							//console.log(data.data.contents);
							//console.log(data.data.contents[0].podtCode);
							//console.log(data.data.contents[0].comCode);
							gridProcess.resetData(data.data.contents) //파싱한 결과 = data
							gridProcess.refreshLayout();
							
							let mandate = document.querySelector("#txtManDate").value; //작업일 인풋태그 입력값
							//console.log(mandate);
							
							document.getElementById("podtCode").innerHTML = data.data.contents[0].podtCode
							document.getElementById("podtName").innerHTML = data.data.contents[0].podtName
							document.getElementById("comCode").innerHTML = data.data.contents[0].comCode
						})
					}
					
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
				header : '작업량',
				name : 'manGoalPerday'
			}, 
			{
				header : '상태',
				name : 'comEtc'
			}
		]
		
		//******************************생산지시조회 그리드******************************
		//생산지시조회 버튼 클릭
		$("#btnSearchCommand").click(function(){
			let manDate = document.querySelector("#txtManDate").value; //작업일 인풋태그 입력값
			//console.log(manDate);
			
			if(manDate == null || manDate == ""){
				alert("작업일을 입력해주세요.");
			}else{
				
				fetch("${pageContext.request.contextPath}/selCommand",{
					method: "POST",
					headers: {
						"Content-Type": "application/json" //json으로 포맷설정.
					},
					body: JSON.stringify({
						"manStartDate" : manDate //vo에 담긴 필드명 : 실제 들어갈 값
					})
				}).then((response) => response.json() )//컨트롤러에서 가져온 result를 json으로 파싱
				.then((data)=> {
					//console.log(data.result);
					
					if(data.result.length == 0){
						alert("상응하는 정보가 없습니다.");
						return;
					}else{
						dialogCommand.dialog("open");
						
						gridManCommand.resetData(data.result) //파싱한 결과 = data
						gridManCommand.refreshLayout();
						
						resetProcess();
						
					}
					
				}); 
			}
			
		})
		
		//생산지시 그리드 내용
		let gridManCommand = new Grid({
			el: document.getElementById('gridManCommand'),
			data: null,
			columns: columnsCommand,
			rowHeaders: ['checkbox'],
	        bodyHeight: 300
			
		})
		
		//생산지시 조회 그리드에서 클릭된 행
		let checkedCommand;
		
		gridManCommand.on('check', function(ev){
			checkedCommand = gridManCommand.getCheckedRows();
		})
		
		//******************************공정현황 그리드******************************
		//공정현황 컬럼
		const columnsProcess = [
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
				name : 'procName'
			}, 
			{
				header : '관리자',
				name : 'empId'
			},
			{
				header : '관리자명',
				name : 'empName'
			},
			{
				header : '지시량',
				name : 'manGoalPerday'
			}, 
			{
				header : '작업완료량',
				name : 'manQnt'
			}, 
			{
				header : '시작시간',
				name : 'manStarttime'
			}, 
			{
				header : '종료시간',
				name : 'manEndtime'
			}, 
			{
				header : '불량량',
				name : 'defQnt'
			}
			
		]
		
		//공정현황 그리드 내용
		let gridProcess = new Grid({
			el : document.getElementById('gridProcess'),
			data : null,
			columns : columnsProcess,
			rowHeaders : [ 'rowNum' ],
	        bodyHeight: 430
		})
		
		let btnStart = document.getElementById("btnStart");
		
		gridProcess.on('onGridUpdated', function(){
			for(let i=0; i<gridProcess.getRowCount(); i++){
				if(gridProcess.getValue(i, 'manQnt') != null){
					btnStart.disabled = true;
				}else{
					btnStart.disabled = false;
				}
			}
			
			let def = 0;
			
		   for(let j=0; j<gridProcess.getData().length; j++){
				let manQnt = gridProcess.getValue(j, 'manQnt'); 
				let defQnt = gridProcess.getValue(j, 'defQnt'); 
				let procCode = gridProcess.getValue(j, 'procCode'); 
				let manGoalPerday = gridProcess.getValue(j, 'manGoalPerday') ; 
				
				let procCode2 = gridProcess.getValue(j-1, 'procCode'); 
				let defQnt2 = gridProcess.getValue(j-1, 'defQnt'); 
				
				let prevQnt = gridProcess.getValue(j-1,'manQnt') ; 
				
				if (defQnt != null) {
		               if (procCode == 'PROC001') {
		                  gridProcess.setValue(j, 'manQnt', ( (manGoalPerday*1) - (defQnt*1) ) );
		               } else if ( procCode >= 'PROC002') {
		                  gridProcess.setValue(j, 'manQnt', ( (prevQnt*1) - (defQnt*1) ) );
		                  if (procCode >= 'PROC008') {
		                     gridProcess.setValue(j, 'manQnt', prevQnt );
		                  }
		               }
	            } else {
	               if (procCode == 'PROC001') {
	                  gridProcess.setValue(j, 'manQnt', ( (manGoalPerday*1) - 0 ) );
	               } else if ( procCode >= 'PROC002') {
	                  gridProcess.setValue(j, 'manQnt', ( (prevQnt*1) - 0 ) );
	                  if (procCode >= 'PROC008') {
	                     gridProcess.setValue(j, 'manQnt', prevQnt );
	                  }
	               }
	            }
				
			} 

		})
		 		
		
		let processData;
		
		$("#btnStart").click(function(){
			
			$.ajax({ 
				url: '${pageContext.request.contextPath}/selectProc',
				method: 'POST',
				data : JSON.stringify( 
						{'podtCode' : document.getElementById("podtCode").innerHTML , 
						 'comCode': document.getElementById("comCode").innerHTML} 
						),
				dataType: 'JSON',
				contentType: 'application/json',
				success: function(datas){
					resetProcess();
					
				},
				error: function(reject){
					console.log(reject)
				}
			})
			
			$("#stopImg").css("display","none") ;
			$("#moveImg").css("display","block") ;
			
		})

		
		function resetProcess(){
			fetch('${pageContext.request.contextPath}/selectProcList',{
				method: "POST",
				headers: {
					"Content-Type": "application/json" 
				},
				body: JSON.stringify(
					{'comCode' : document.getElementById("comCode").innerHTML } 
				)
			})
			.then((response) => response.json())
			.then((data)=> {
				gridProcess.resetData(data.result) 
				gridProcess.refreshLayout();
				if(data.result[data.result.length-1].manEndtime != null){
					$("#stopImg").css("display","block") ;
					$("#moveImg").css("display","none") ;					
				}
				resetProcess(); 
			})
			
		}
		
		
		//******************************초기화 버튼******************************
		btnInit.addEventListener("click", function(){
			let txtManDate = document.getElementById('txtManDate');
			txtManDate.value = '';
			
			$("#podtCode").empty();
			$("#podtName").empty();
			$("#comCode").empty();
			
			gridProcess.resetData([{}]);
			$("#stopImg").css("display","block") ;
			$("#moveImg").css("display","none") ;					
		})
		
		
		
		//******************************중지 버튼******************************
		btnStop.addEventListener('click', function(){
			
			let pLIST = gridProcess.getData();
			let arr = [];
			
			let sumDef = 0;
			
			for( i of pLIST){
				
				if( (i.manGoalPerday*1) != (i.manQnt*1) + (i.sumDef*1) ){
					arr.push( i );
				}
				
				sumDef = sumDef + i.defQnt;
			}
		
			$.ajax({
				url: '${pageContext.request.contextPath}/changeStop',
				method: 'POST',
				data : JSON.stringify( arr ),
				dataType: 'JSON',
				contentType: 'application/json',
				success: function(datas){
					//console.log("진행공정 테이블 값 추가 성공");
					resetProcess();
					
				},
				error: function(reject){
					console.log(reject)
				}
			})
			
		})
		
		
		
		//------------ 도움말 버튼 이벤트 ---------------
	 	 helpBtn.addEventListener('mouseover' , () => {
	 	 	helpModal.dialog("open") ;
	 	 })
			
	tui.Grid.applyTheme('default', themesOptions);		
		
	</script>

</body>
</html>