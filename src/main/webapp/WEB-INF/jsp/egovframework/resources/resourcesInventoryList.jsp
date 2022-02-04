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
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />

<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
	<h2>자재 LOT재고 조정 조회</h2>
	<div class="card bg-light text-dark">
		<div class="card-body">
	조정일자  <input id="txtInven1" type="date" data-role="datebox" data-options='{"mode": "calbox"}'>
	~ 		<input id="txtInven2" type="date" data-role="datebox" data-options='{"mode": "calbox"}'><br>
	자재코드  <input id="txtRsc1">  <button id="btnFindRsc">돋보기</button>  자재명 <input id="txtRsc2" readonly><br>
	<div id="dialog-form-rsc" title="자재 검색"></div>
	<br>
	<button id="btnSelect">조회</button>
	<button id="btn_reset" type="reset">초기화</button>

	<button>엑셀</button>
	</div>
	</div>	
	<div id="grid"></div>
	
<script type="text/javascript">
	//조정일자 초기값 
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('txtInven1').value = nd.toISOString().slice(0, 10);
	document.getElementById('txtInven2').value = d.toISOString().slice(0, 10);
	
	//초기화 버튼
	$("#btn_reset").on("click", function(){
		document.getElementById('txtInven1').value = nd.toISOString().slice(0, 10);
		document.getElementById('txtInven2').value = d.toISOString().slice(0, 10);
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
	
	//그리드 
	var Grid = tui.Grid;
	Grid.applyTheme('default');
	
	const columns = [
			  {
			    header: '구분',
			    name: 'storeFlag',
			    sortable: true,
			    sortingType: 'desc'
			  },
			  {
				header: '조정일자',
				name: 'storeDate',
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
				 header: '입고량',
				 name: 'istCnt'
				},
				{
				  header: '출고량',
				  name: 'ostCnt'
				},
				{
				  header: '자재LOT',
				  name: 'rscLot',
				  sortable: true,
				  sortingType: 'desc'
				},
				{
				  header: '비고',
				  name: 'storeEtc'
			   }
			];
	
	//ajax(api)로 값 받아오는 거 
	let dataSource = {
		  api: {
		    readData: { 
		    	url: 'resourcesInven', 
		    	method: 'GET'
		    	}
		  },
		  contentType: 'application/json'
		};
	
	const grid = new Grid({
		  el: document.getElementById('grid'),
		  data: null,
		  columns: columns,
		  pageOptions: {
			    useClient: true,
			    perPage: 15
			},
			summary: {
			    position: 'bottom',
			    height: 40, 
			    columnContent: {
			    	istCnt: {
			        template(summary) {
			        	console.log(summary);
			        	return '입고량: ' + (summary.sum*1).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			        }
			      },
			      ostCnt: {
				        template(summary) {
				        	console.log(summary);
				        	return '출고량: ' + (summary.sum*1).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
				        }
				      },
			    	}
			  },
		});

	//조회버튼 클릭시 값 가지고 오는 거
	$("#btnSelect").on("click", function(){
			var rscCode = $("#txtRsc1").val();
			var storeDate = $("#txtInven1").val();
			var storeDate2 = $("#txtInven2").val();
	
			$.ajax({
				url :'resourcesInven',
				data: {'rscCode' : rscCode, 'storeDate':storeDate, 'storeDate2' : storeDate2 },
				contentType: 'application/json; charset=UTF-8'
			}).done(function(da){
				var datalist = JSON.parse(da);
				grid.resetData(datalist["data"]["contents"]);
			})
					
		})
	
	
	
	
</script>
</body>
</html>