<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
	<h2>자재반품 조회</h2>
	<hr>
	반품일자  <input id="txtOrde1" type="date" data-role="datebox" data-options='{"mode": "calbox"}'>
	~ 		<input id="txtOrde2" type="date" data-role="datebox" data-options='{"mode": "calbox"}'><br>
	업체코드  <input id="txtSuc1">  <button id="btnFindSuc">돋보기</button>  업체명 <input id="txtSuc2" readonly><br>
	자재코드  <input id="txtRsc1">  <button id="btnFindRsc">돋보기</button>  자재명 <input id="txtRsc2" readonly><br>
	<div id="dialog-form-rsc" title="자재 검색"></div>
	<div id="dialog-form-suc" title="업체 검색"></div>
	<br>
	<button id="btnSelect">조회</button>
	<button id="btn_reset" type="reset">초기화</button>
	<button>엑셀</button>
	<hr>	
	<div id="grid"></div>
	<hr>
	
<script type="text/javascript">

	//발주일자 초기값 
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('txtOrde1').value = nd.toISOString().slice(0, 10);
	document.getElementById('txtOrde2').value = d.toISOString().slice(0, 10);
	
	//초기화 버튼
	$("#btn_reset").on("click", function(){
		document.getElementById('txtOrde1').value = nd.toISOString().slice(0, 10);
		document.getElementById('txtOrde2').value = d.toISOString().slice(0, 10);
		$("#txtSuc1").val('');
		$("#txtSuc2").val('');
		$("#txtRsc1").val('');
		$("#txtRsc2").val('');
	})
	
	//모달창(자재조회)
	function clickRsc(rscCode, rscName){
		$("#txtRsc1").val(rscCode);
		$("#txtRsc2").val(rscName);
		dialog1.dialog("close");
	};

	let dialog1 = $( "#dialog-form-rsc" ).dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
		});
	
	$("#btnFindRsc").on("click", function(){
			dialog1.dialog("open");
		$("#dialog-form-rsc").load("recList2",
				function(){console.log("로드됨")})
		});

	//모달창(업체조회)
	function clickSuc(sucCode, sucName){
		
		console.log(sucCode);
		console.log(sucName);
		$("#txtSuc1").val(sucCode);
		$("#txtSuc2").val(sucName);
		dialog2.dialog("close");
	};

	let dialog2 = $("#dialog-form-suc").dialog({
			autoOpen: false,
			modal: true,
			heigth : 500,
			width : 900,
		});
	
	$("#btnFindSuc").on("click", function(){
			dialog2.dialog("open");
		$("#dialog-form-suc").load("sucList",
				function(){console.log("로드됨")})
		});

	//그리드 
	var Grid = tui.Grid;
	Grid.applyTheme('default');
	
	const columns = [
				{
		    	header: '반품일자',
		    	name: 'rtngdDate',
		    	sortable: true,
		    	sortingType: 'desc'
		  		},
  				{
		    	header: '반품번호',
		    	name: 'rtngdNo',
		    	sortable: true,
		    	sortingType: 'desc'
		  		},
  				{
			     header: '자재입고검사번호',
			     name: 'rscTstNo',
			     sortable: true,
			     sortingType: 'desc'
			  	},
			  {
			    header: '자재코드',
			    name: 'rscCode',
			    sortable: true,
			    sortingType: 'desc'
			  },
			  {
				header: '자재명',
				name: 'rscName',
			    sortable: true,
			    sortingType: 'desc'
			  },
			  {
				header: '단위',
				name: 'rscUnit'
			   },
			   {
				 header: '단가',
				 name: 'rscPrc'
				},
				{
				 header: '합계',
				 name: 'rscTotal'
				},
			  {
				header: '반품량',
				name: 'rtngdCnt'
			   },
				{
				  header: '불량코드',
				  name: 'defCode'
				},
				{
				  header: '불량명',
				  name: 'defName'
				}
			];
			
	//ajax(api)로 값 받아오는 거 
	let dataSource = {
		  api: {
		    readData: { 
		    	url: 'resourcesRtngd', 
		    	method: 'GET'
		    	}
		  },
		  //initialRequest: false,
		  contentType: 'application/json'
		};
	
	const grid = new Grid({
		  el: document.getElementById('grid'),
		  data: null,
		  columns
		});

	//조회버튼 클릭시 값 가지고 오는 거
	$("#btnSelect").on("click", function(){
			var rscCode = $("#txtRsc1").val();
			var sucCode = $("#txtSuc1").val();
			var ordeDate = $("#txtOrde1").val();
			var ordeDate2 = $("#txtOrde2").val();
			console.log(ordeDate);
			console.log(typeof(ordeDate));
			console.log(ordeDate2);
			
			$.ajax({
				url :'resourcesRtngd',
				data: {'rscCode' : rscCode, 'sucCode': sucCode, 'ordeDate':ordeDate, 'ordeDate2':ordeDate2 },
				contentType: 'application/json; charset=UTF-8'
			}).done(function(da){
				var datalist = JSON.parse(da);
				console.log(datalist);
				grid.resetData(datalist["data"]["contents"]);
			})
					
		})
	
	
</script>
	
</body>
</html>