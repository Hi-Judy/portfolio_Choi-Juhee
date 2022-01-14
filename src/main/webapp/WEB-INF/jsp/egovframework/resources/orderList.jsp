<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
	<h2>발주조회</h2>
	<hr>
	발주일자  <input id="txtOrde1" type="date" data-role="datebox" data-options='{"mode": "calbox"}'>
	~ 		<input id="txtOrde2" type="date" data-role="datebox" data-options='{"mode": "calbox"}'><br>
	발주업체  <input id="txtSuc"><button id="btnFindSuc">돋보기</button><br>
	자재명   <input id="txtRsc"><button id="btnFindRsc">돋보기</button><br>
	<div id="dialog-form-rsc" title="자재 검색"></div>
	<div id="dialog-form-suc" title="업체 검색"></div>
	<br>
	<button id="btnSelect">조회</button>
	<button id="btn_reset" type="reset">초기화</button>

	<button>엑셀</button>
	<hr>	
	<div id="grid"></div>
	
<script type="text/javascript">

	//발주일자 초기값 
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('txtOrde1').value = nd.toISOString().slice(0, 10);
	document.getElementById('txtOrde2').value = d.toISOString().slice(0, 10);
	
	//초기화 버튼
	$("#btn_reset").on("click", function(){
		$("#txtOrde1").val('');
		$("#txtOrde2").val('');
		$("#txtSuc").val('');
		$("#txtRsc").val('');
	})
	
	
	//모달창(자재조회)
	function clickRsc(rsc){
		$("#txtRsc").val(rsc);
		dialog1.dialog("close");
	};

	let dialog1 = $( "#dialog-form-rsc" ).dialog({
			autoOpen: false,
			modal: true
		});
	
	$("#btnFindRsc").on("click", function(){
			dialog1.dialog("open");
		$("#dialog-form-rsc").load("recList",
				function(){console.log("로드됨")})
		});

	//모달창(업체조회)
	function clickSuc(suc){
		$("#txtSuc").val(suc);
		dialog2.dialog("close");
	};

	let dialog2 = $("#dialog-form-suc").dialog({
			autoOpen: false,
			modal: true
		});
	
	$("#btnFindSuc").on("click", function(){
			dialog2.dialog("open");
		$("#dialog-form-suc").load("sucList",
				function(){console.log("로드됨")})
		});

	//그리드 
	var Grid = tui.Grid;
	Grid.applyTheme('striped', {
		  cell: {
		    header: {
		      background: '#ebedef'
		    }

		  },
		  frozenBorder: {
			    border: '#ff0000'
			  }
		});
	
	const columns = [
		  		{
			    header: '발주일',
			    name: 'ordeDate'
			  },
			  {
			    header: '발주번호',
			    name: 'ordrNo',
			  },
			  {
			    header: '자재코드',
			    name: 'rscCode'
			  },
			  {
				header: '자재명',
				name: 'rscName'
			  },
			  {
				header: '단위',
				name: 'rscUnit'
			   },
			  {
				header: '발주량',
				name: 'rscCnt'
			   },
			   {
				 header: '입고량',
				 name: 'rscPassCnt'
				},
				{
				  header: '불량량',
				  name: 'rscDefCnt'
				},
				{
				  header: '업체',
				  name: 'sucName'
				},
				{
				  header: '입고요청일',
				  name: 'istReqDate'
				}
						
			];
			
	//ajax(api)로 값 받아오는 거 
	let dataSource = {
		  api: {
		    readData: { 
		    	url: 'resourcesOrder', 
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
			var rscName = $("#txtRsc").val();
			var sucName = $("#txtSuc").val();
			var ordeDate = $("#txtOrde1").val();
			var ordeDate2 = $("#txtOrde2").val();
			console.log(ordeDate);
			console.log(typeof(ordeDate));
			console.log(ordeDate2);
			$.ajax({
				url :'resourcesOrder',
				data: {'rscName' : rscName, 'sucName': sucName, 'ordeDate':ordeDate, 'ordeDate2':ordeDate2 },
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