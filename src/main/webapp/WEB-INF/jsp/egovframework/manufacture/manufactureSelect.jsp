<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산계획 상세조회</title>
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
		<h4 style="margin-left: 10px">생산계획 상세조회</h4>
	</div>
	
	<div id="top" style="height : 110px; padding : 10px;">
		
		<div>
		<!-- 계획일자별로 조회 -->
		<p style="display:inline-block; margin-left : 5px; margin-top : 5px;">계획일자</p>
		
		<!-- 조회할 계획 기간 입력 -->
			<input id = "txtFromDate" type="date" name="from" style="margin-left:10px; display:inline-block; ">
			<p style="display:inline-block;"> ~ </p>
			<input id = "txtToDate" type="date" name="to" style="display:inline-block;">
		</div>	
			
		<div>	
			 <!-- 제품코드별로 조회 -->
		 	<p style="display:inline-block; margin-left : 5px; ">제품코드</p>
			<input id = "txtPdotCode" style="display: inline-block; margin-left : 10px; width: 165px;"> 
			
			<!-- 버튼모음 -->
			<button type="button" id="btnInit" 			class="btn" style="float : right; margin : 5px;">초기화</button>
			<button type="button" id="btnSearchManPlan" class="btn" style="float : right; margin : 5px;">생산계획조회</button>
		</div>
		
	</div>
	<br>
	<div id="OverallSize" style="margin-left : 10px;">
		<!-- 메인화면 그리드 -->
		<div id = "gridMain" style=" border-top: 3px solid #168;"></div>
		<br>
		
		<!-- 자재조회 그리드 -->
		<h5 style="color: #25396f;">자재조회</h5>
		<div id="gridResource" style=" border-top: 3px solid #168;"></div>
	</div>	
	
	<!--  --------------- 도움말 --------------- -->
	<div id="helpModal" title="도움말">
		<hr>
		계획일자나 제품코드를 입력한 후 생산계획조회 버튼을 클릭합니다.<br><br>
		조회된 계획 중 한 건을 클릭하여 해당 제품의 소요 자재를 확인합니다. <br><br>
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
		
		
		//******************************계획기간 기본값******************************
	    var d = new Date();
	    var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	    document.getElementById('txtFromDate').value = nd.toISOString().slice(0, 10);
	    document.getElementById('txtToDate').value = d.toISOString().slice(0, 10);
		
		
		//******************************메인 그리드******************************
		//메인화면 컬럼
		let columnsMain = [
			{
				header:'제품코드',
				name: 'podtCode',
				align : 'center' ,
				width: 100
			},
			{
				header: '제품명',
				name: 'podtName',
				align : 'center' ,
				width: 200
			},
			{
				header:'주문코드',
				name: 'ordCode',
				align : 'center' 
			},
			{
				header:'주문상태',
				name: 'ordStatus',
				hidden: true,
				align : 'center' 
			},
			{
				header:'고객코드',
				name: 'cusCode',
				hidden: true,
				align : 'center' 
			},
			{
				header:'계획일자',
				name: 'manPlanDate',
				hidden: false,
				align : 'center' 
			},
			{
				header:'주문량',
				name: 'ordQnt',
				align : 'center',
				width: 100
			},
			{
				header: '납기일자',
				name: 'ordDuedate',
				align : 'center',
				width: 150
			},
			{
				header: '작업기간',
				name: 'planPeriod',
				align : 'center' 
			},
			{
				header: '작업시작일',
				name: 'planStartDate',
				align : 'center' 
			},
			{
				header: '작업종료일',
				name: 'planComplete',
				align : 'center' 
			},
			{
				header: '일생산량(UPH*12)',
				name: 'manPerday',
				align : 'center' 
			},
			{
				header: '비고',
				name: 'planEtc',
				align : 'center' 
			}
		]
		
		//생산계획조회 버튼 클릭이벤트
		$('#btnSearchManPlan').click(function(){
			console.log('생산계획 조회');
			let startDate = document.querySelector('#txtFromDate').value;
			let endDate = document.querySelector('#txtToDate').value;
			
			let podtCode = document.querySelector('#txtPdotCode').value;
			
			console.log(startDate);
			console.log(endDate);
			console.log(podtCode);
			
			if(startDate == "" && podtCode == "" ){
				alert("계획일자나 제품코드를 입력해주세요.");
			}
			else{
				$("#div_load_image").show();
				$.ajax({
					url: '${pageContext.request.contextPath}/manufacture/selectManufacturePlan',
					method: 'POST',
					data: {'startDate' : startDate, 'endDate': endDate, 'podtCode': podtCode },
					dataType: 'JSON',
					success: function(datas){
						console.log(datas);
						document.querySelector('#div_load_image').style='display:none;'
						
						gridMain.resetData(datas.result);
						gridMain.refreshLayout();
						
						if(datas.result.length == 0 ){
							alert("상응하는 정보가 없습니다.");
						}
					}
				})
				
			}
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
			rowHeaders : ['checkbox'],
	    bodyHeight: 230
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
			rowHeaders: ['rowNum'],
	         bodyHeight: 240
		})
		
		gridResource.on('onGridUpdated', function(){
			
			//let resList = gridResource.getData(); //자재그리드 전체 데이터
			//console.log(resList);
			
			console.log(checkedMain[0].ordQnt);
			for(let i=0; i<gridResource.getRowCount(); i++ ){
				//console.log(i)
				let resUsage = gridResource.getValue(i,'resUsage');
				//console.log(resUsage);
				
				gridResource.setValue(i, 'resUsage', (resUsage*1*checkedMain[0].ordQnt)/100);
			}	
			
		});
		
		
		//******************************초기화 버튼 이벤트******************************
		btnInit.addEventListener("click", function(){
			let txtManDate = document.getElementById('txtManDate');
			let txtPdotCode = document.getElementById('txtPdotCode');
			
			txtManDate.value = '';
			txtPdotCode.value = '';
			
			gridMain.resetData([{}]);
			gridResource.resetData([{}]);
			
		})
				
	//------------ 도움말 버튼 이벤트 ---------------
 	 helpBtn.addEventListener('mouseover' , () => {
 	 	helpModal.dialog("open") ;
 	 })
		
tui.Grid.applyTheme('default', themesOptions);	
	</script>
</body>
</html>