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
	<div style="width : 1500px ;">
		<span style="float: right;">
			<button type="button" id="helpBtn" style="border : none; background-color : #f2f7ff; color : #007b88; float : right ;">
			<i class="bi bi-question-circle"></i>
			</button>
		</span>
		<h4 style="margin-left: 10px">생산지시서 상세조회</h4>
	</div>
	<div id="top" style="height : 160px; padding : 10px;">
		<div class = "selectCommand">
			<div style="">
			<!-- 작업일자별로 조회 -->
			<p style="display:inline-block; margin-left : 20px; margin-top : 10px;">작업일자</p>
			
			<!-- 조회할 작업 기간 입력 -->
				<input id = "txtFromDate" type="date" name="from" style="margin-left:10px; display:inline-block; ">
				<p style="display:inline-block;"> ~ </p>
				<input id = "txtToDate" type="date" name="to" style="display:inline-block;">
			</div>	
			
			<!-- 제품코드별로 조회 -->
			<p style="margin-top:5px; display: inline-block; margin-left : 20px;">제품코드</p>
			<input id="txtPodtCode" style="display: inline-block; margin-left : 10px; width: 163px;">
			<br>
			<button type="button" id="btnInit" class="btn" style="float : right; margin : 5px;">초기화</button>
			<button type="button" id="searchCommand" class="btn" style="float : right; margin : 5px;">생산지시조회</button>
		</div>
	</div>
	<br>
	
	<div id="OverallSize" style="margin-left : 10px;">
		<!-- 생산지시 조회 그리드 -->
		<div id="gridCommand" style="border-top: 3px solid #168;"></div>
		<br>
		
		<!-- 자재조회 그리드 -->
		<h5 style="color: #25396f;">자재조회</h5>
		<div id="gridResource" style=" border-top: 3px solid #168;"></div>
		
	</div>
	
	<!--  --------------- 도움말 --------------- -->
	<div id="helpModal" title="도움말">
		<hr>
		작업일자나 제품코드를 입력한 후 생산지시조회 버튼을 클릭합니다. <br><br>
		조회된 지시 중 한 건을 클릭하여 해당 지시의 소요 자재를 확입합니다. <br><br>
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
		
		
		//******************************작업기간 기본값******************************
	    var d = new Date();
	    var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	    document.getElementById('txtFromDate').value = nd.toISOString().slice(0, 10);
	    document.getElementById('txtToDate').value = d.toISOString().slice(0, 10);
		
		
		//******************************생산지시 조회 그리드******************************
		//생산지시 조회 모달 컬럼
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
				header: '사번',
				name: 'empId'
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
		
		//생산지시 조회 버튼 클릭 이벤트
		$('#searchCommand').click(function(){
			console.log('생산지시 조회');
			
			let startDate = document.querySelector('#txtFromDate').value;
			let endDate = document.querySelector('#txtToDate').value;
			
			let podtCode = document.querySelector('#txtPodtCode').value;
			
			console.log(startDate);
			console.log(endDate);
			console.log(podtCode);
			
			
			if(startDate == "" && podtCode == "" ){
				alert("작성일자나 제품코드를 입력해주세요.");
			
			}else if(startDate != "" || podtCode != ""){
				//gridCommand.readData(1, {'manStartDate': manDate, 'podtCode': podtCode}, true );
				gridCommand.refreshLayout();
				
				$.ajax({
					url: '${pageContext.request.contextPath}/selectCommand',
					method: 'POST',
					data: {'startDate' : startDate, 'endDate': endDate, 'podtCode': podtCode },
					success: function(datas){
						data = JSON.parse(datas);
						console.log(data);
						//console.log((JSON.parse(datas)).result);
						gridCommand.resetData(data.result);
						gridCommand.refreshLayout();
						
						if(data.result.length == 0 ){
							alert("상응하는 정보가 없습니다.");
						}
					},
					error: function(reject){
						console.log('reject: '+ reject);
					}
				})
			}
		})
		
		
		//생산지시 조회 그리드 내용
		let gridCommand = new Grid({
			el: document.getElementById('gridCommand'),
			data: null,
			columns: columnsCommand,
			rowHeaders: ['checkbox']
		})
		
		
		//메인 그리드에서 체크된 계획
		let checkedCommand;
		
		//메인 그리드에서 클릭된 계획의 행을 가져온다.
		gridCommand.on('click', function(ev){
			checkedCommand = gridCommand.getCheckedRows();
			
			console.log(checkedCommand[0].podtCode);
			console.log(checkedCommand[0].comCode);
			
			fetch("${pageContext.request.contextPath}/findResource/"
					+checkedCommand[0].podtCode + "/" + checkedCommand[0].comCode )
			.then((response) => response.json())
			.then((data)=> {
				
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
				header:'자재코드',
				name: 'resCode'
			},
			{
				header: '자재명',
				name: 'rscName'
			},
			{
				header:'소요량',
				name: 'resUsage'
			},
			{
				header: '출고량',
				name: 'ostCnt'
			}
		]
		
		
		//자재조회 그리드 내용
		const gridResource = new Grid({
			el: document.getElementById('gridResource'),
			data: null,
			columns: columnsResource,
			rowHeaders: ['rowNum'],
	         bodyHeight: 240
		})
		
		gridResource.on('onGridUpdated', function(){
			
			//let resList = gridResource.getData(); //자재그리드 전체 데이터
			//console.log(resList);
			
			checkedCommand = gridCommand.getCheckedRows();
			console.log(checkedCommand[0].manGoalPerday);
			for(let i=0; i<gridResource.getRowCount(); i++ ){
				//console.log(i)
				let resUsage = gridResource.getValue(i,'resUsage');
				//console.log(resUsage);
				
				gridResource.setValue(i, 'resUsage', (resUsage*1*checkedCommand[0].manGoalPerday)/100);
			}	
			
		});
		
		
		
		//******************************초기화 버튼 클릭******************************
		btnInit.addEventListener("click", function(){
			gridCommand.resetData([{}]);
			

			let txtManDate = document.getElementById('txtManDate');
			let txtPodtCode = document.getElementById('txtPodtCode');
			
			txtManDate.value = '';
			txtPodtCode.value = '';

		})
		
		
	//------------ 도움말 버튼 이벤트 ---------------
 	 helpBtn.addEventListener('mouseover' , () => {
 	 	helpModal.dialog("open") ;
 	 })
		
tui.Grid.applyTheme('default', themesOptions);
	</script>
</body>
</html>