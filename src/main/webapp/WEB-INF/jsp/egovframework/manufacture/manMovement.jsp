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
	<div style="width : 1500px ;">
		<span style="float: right;">
			<button type="button" id="helpBtn" style="border : none; background-color : #f2f7ff; color : #007b88; float : right ;">
			<i class="bi bi-question-circle"></i>
			</button>
		</span>
		<h4 style="margin-left: 10px">공정이동표</h4>
	</div>
	
	<!-- 생산지시서 조회 -->
	<div id="top" style="height: 55px;">
		<form id = "findCommand">
			<div style="margin-top: 8px; margin-left: 5px;">
			
				<p style="display: inline-block;">작업일자</p>
				<input id="txtManStartDate" type="date" name="manDate" style="display: inline-block;">
					
				<label for="ing" style=" margin-left: 10px;">생산중</label> 	
				<input type="radio" id="ing" name="comEtc" value="procIng" >
				
				<label for="done" style=" margin-left: 10px;">생산완료</label> 	
				<input type="radio" id="done" name="comEtc" value="procDone" >
				
				<button class="btn" type="button" id="btnSearchCommand"
					style="display: inline-block; margin-left: 10px;">조회</button>
					
				<button class="btn" type="button" id="btnInit"
				style="display: inline-block; margin-left: 10px;">초기화</button>
			</div>
		</form>
	</div>
	
	
	<br>
	<div id="OverallSize" style="margin-bottom: 0px;height: 300px; margin-left:10px;">
		<div style="float: left; width: 50% ;">	
			<!-- 선택된 지시 그리드 -->
			<h5 style="color: #25396f;">지시 기본 정보</h5>
			<div id="gridSelCommand"   style=" border-top: 3px solid #168;"></div>
		</div>
			
		<div style="float: right; width: 45% ;">
			<!-- 자재 LOT 조회 그리드 -->
			<h5 style="color: #25396f;">자재정보</h5>
			<div id="gridResLot"    style="border-top: 3px solid #168;"></div>
		</div>
		<br>
	
	</div>
	
	<br>		
	<!---- 공정이동 그리드 ---->
	<h5 style="color: #25396f; margin-left:10px;">공정정보</h5>
	<div id="gridMovement"   style="width:1500px; margin-left:10px; border-top: 3px solid #168;"></div>
	
	<!-- 생산지시서 조회 모달 -->
	<div id="dialog-form-manCommand" title="생산지시 조회" >
		<div id="gridManCommand" style="margin-top: 15px;"></div>
	</div>
	
	<!--  --------------- 도움말 --------------- -->
	<div id="helpModal" title="도움말">
		<hr>
		작업일자나 생산상태를 선택하고 조회버튼을 클릭합니다. <br><br>
		원하는 지시를 선택하면 해당 지시의 공정 정보를 확인할 수 있습니다.<br><br>
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
	
	
		
		//******************************생산지시조회 모달******************************
		//생산지시 조회 모달 설정
		let dialogCommand = $("#dialog-form-manCommand").dialog({
			autoOpen : false,
			modal : true,
			height : 700,
			width : 900,
			buttons : {
				"확인" : function() {
					console.log("확인 테스트");
					
					//공정이동표
				 	fetch("${pageContext.request.contextPath}/selectMovement/"+checkedCommand[0].comCode)
					.then((response) => response.json())
					.then((data)=> {
						console.log(data.data.contents);
						
						gridMovement.resetData(data.data.contents);
						gridMovement.refreshLayout();
					}) 
					
					//공정이동표에서 자재 조회
					$.ajax({
						url: '${pageContext.request.contextPath}/selectResLot/'+checkedCommand[0].comCode,
						method : 'GET',
						dataType : 'JSON',
						success : function(datas){
							console.log(datas)
							gridResLot.resetData(datas.data.contents); //파싱한 결과 = data
							gridResLot.refreshLayout();
						}
					})
					
					//선택된 지시 정보 
					fetch("${pageContext.request.contextPath}/selectComInfo/"+checkedCommand[0].comCode)
					.then((response) => response.json())
					.then((data)=> {
						console.log(data.data.contents);

						gridSelCommand.resetData(data.data.contents); //파싱한 결과 = data
						gridSelCommand.refreshLayout();

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
				name : 'comCode',
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
				header : '작업일',
				name : 'manStartdate',
				align : 'center'
			}, 
			{
				header : '상태',
				name : 'comEtc',
				align : 'center'
			}
		]
		
		//******************************생산지시조회 그리드******************************
		//생산지시조회 버튼 클릭
		$("#btnSearchCommand").click(function(){
			let manStartDate = document.querySelector("#txtManStartDate").value; //작업일 인풋태그 입력값
			console.log(manStartDate);
			
			let findCommand = document.querySelector("#findCommand").value;
			
			dialogCommand.dialog("open");
			$.ajax({
				url : '${pageContext.request.contextPath}/findCommand',
				method : 'POST',
				data : $('#findCommand').serialize(), //직렬화된 방식으로(바이트 단위로 끊어서) 데이터를 보낸다.
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
			rowHeaders: ['checkbox'],
	         bodyHeight: 500
			
		})
		
		//생산지시 조회 그리드에서 클릭된 행
		let checkedCommand;
		
		gridManCommand.on('check', function(ev){
			checkedCommand = gridManCommand.getCheckedRows();
		})
		
		
		
		//******************************선택된 지시 그리드******************************
		//선택된 지시 그리드 컬럼
		const columnsSelCommand = [
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
				header : '작업일',
				name : 'manStartdate',
				align : 'center'
			},
			{
				header : '지시수량',
				name : 'manGoalperday',
				align : 'center',
				formatter(value) { return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") ;}
			}
		]
		
		//선택된 지시 그리드 내용
		let gridSelCommand = new Grid({
			el: document.getElementById('gridSelCommand'),
			data: null,
			columns: columnsSelCommand,
			rowHeaders : [ 'rowNum' ],
	         bodyHeight: 230
		})
		
		
		
		//******************************자재 LOT 그리드******************************
		//자재 LOT 그리드 컬럼
		const columnsResLot = [
			{
				header : '자재코드',
				name : 'rscCode',
				align : 'center'
			},
			{
				header : '자재명',
				name : 'rscName',
				align : 'center'
			},
			{
				header : '자재로트',
				name : 'rscLot',
				align : 'center'
			},
			{
				header : '출고량',
				name : 'ostCnt',
				align : 'center'
			}
		]
		
		//자재 LOT 그리드 내용
		let gridResLot = new Grid({
			el: document.getElementById('gridResLot'),
			data: null,
			columns: columnsResLot,
			rowHeaders : [ 'rowNum' ],
			scrollY:true,
		      minBodyHeight : 230,
		      bodyHeight : 230,
		})
		
		
	
		//******************************공정이동표 그리드******************************
		//공정이동표 그리드 컬럼
		const columnsMovement = [
			{
				header : '공정코드',
				name : 'podtCode',
				align : 'center'
			}, 
			{
				header : '공정명',
				name : 'procName',
				align : 'center'
			}, 
			{
				header : '관리자',
				name : 'empId',
				align : 'center'
			},
			{
				header : '관리자명',
				name : 'empName',
				align : 'center'
			},
			{
				header : '작업완료량',
				name : 'manQnt',
				align : 'center',
				formatter(value) { return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") ;}
			},
			{
				header : '불량량',
				name : 'defQnt',
				align : 'center',
				formatter(value) { 
		        	if(value.value != null && value.value != '' && value.value != "null"){
		        		return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") ;
		        	}else{
		        		return value.value ;  
		        	}
	        	}
			} 
		]
		
		//공정이동표 그리드 내용
		let gridMovement = new Grid({
			el: document.getElementById('gridMovement'),
			data: null,
			columns: columnsMovement,
			rowHeaders: ['rowNum'],
	         bodyHeight: 290
			
		})
		//------------ 도움말 버튼 이벤트 ---------------
	 	 helpBtn.addEventListener('mouseover' , () => {
	 	 	helpModal.dialog("open") ;
	 	 })
		
		
		//******************************초기화 버튼 이벤트******************************
		btnInit.addEventListener("click", function(){
			let txtManStartDate = document.getElementById('txtManStartDate');
			
			txtManStartDate.value = '';
			
			gridSelCommand.resetData([{}]);
			gridResLot.resetData([{}]);
			gridMovement.resetData([{}]);
			
		})
		
		
	tui.Grid.applyTheme('default', themesOptions);			
	</script>
</body>
</html>