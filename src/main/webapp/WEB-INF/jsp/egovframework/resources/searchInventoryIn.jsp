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

	var code2;
	$(function(){
		code2=code;
		gridInvIn.readData(1,{'rscCode':code2},true);
		console.log(code2);
	});
	
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
								name: 'istCnt',
								formatter(value) {
									if(value.value != null && value.value != '' ){
										  return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
									}else{
										return value.value ;
									}
					            }
							},
							{
								header: '출고량',
								name: 'ostCnt',
								formatter(value) {
									if(value.value != null && value.value != '' ){
										  return value.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
									}else{
										return value.value ;
									}
					            }
							}
						];
				
	//메인 그리드 api
	var dataSourceInvIn = {
		  api: {
		    readData: { 
		    	url: 'resourcesInventoryInList', 
		    	method: 'GET'
		    	
		    	}
		  },
		  initalRequest : false,
		  contentType: 'application/json'
		};
	

	var gridInvIn = new Grid({
		  el: document.getElementById('gridInvIn'),
		  data: dataSourceInvIn,
		  columns: columnsInvIn,
		  pageOptions: {
			    useClient: true,
			    perPage: 15
			} 
		});
	
	
	//리스트에서 선택한 값 가지고 오기
	gridInvIn.on("dblclick", (ev) => {
			grid.setValue(grid.getRowCount()-1, "rscLot", gridInvIn.getValue(ev["rowKey"],'rscLot'), false)
			dialoginventory.dialog("close");
	});


</script>
</body>
</html>