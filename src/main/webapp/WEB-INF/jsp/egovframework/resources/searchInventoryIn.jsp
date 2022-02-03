<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="gridInvIn"></div>
<script type="text/javascript">

	//그리드(자재 발주 페이지에서 사용)
	var columnsInvIn = [
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
			 header: '자재 LOT',
			 name: 'rscLot'
			},
			 {
			   header: '입고량',
			   name: 'istCnt'
			}
			];
				
	//ajax(api)로 값 받아오는 거 
	var dataSourceInvIn = {
		  api: {
		    readData: { 
		    	url: 'resourcesInventoryInList', 
		    	method: 'GET'
		    	}
		  },
		  contentType: 'application/json'
		};
	

	var gridInvIn = new Grid({
		  el: document.getElementById('gridInvIn'),
		  data: dataSourceInvIn,
		  columns: columnsInvIn
		});
	
	
	//리스트에서 선택한 값 가지고 오기
	gridInvIn.on("dblclick", (ev) => {
			grid.appendRow({});
			grid.setValue(grid.getRowCount()-1, "rscCode", gridInvIn.getValue(ev["rowKey"],'rscCode'), false)
			grid.setValue(grid.getRowCount()-1, "rscName", gridInvIn.getValue(ev["rowKey"],'rscName'), false)
			grid.setValue(grid.getRowCount()-1, "rscLot", gridInvIn.getValue(ev["rowKey"],'rscLot'), false)
			grid.setValue(grid.getRowCount()-1, "rscUnit", gridInvIn.getValue(ev["rowKey"],'rscUnit'), false)
			dialoginventory.dialog("close");
	});


</script>
</body>
</html>