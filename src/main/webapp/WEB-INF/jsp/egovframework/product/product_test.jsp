<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<span>지시번호</span>
		<input type="text" id="comCode">
		<span>지시디테일번호</span>
		<input type="text" id="comNoDetail">
		<span>제품코드</span>
		<input type="text" id="podtCode">
		<span>입고량</span>
		<input type="text" id="podtInput">
		<span>출고량</span>
		<input type="text" id="podtOutput">
		<button type="button" id="btn">전송</button>
	</div>
	
	<script>
		$("#btn").on("click" , function() {
			let comCode = $("#comCode").val() ;
			let comNoDetail = $("#comNoDetail").val() ;
			let podtCode = $("#podtCode").val() ;
			let podtInput = $("#podtInput").val() ;
			let podtOutput = $("#podtOutput").val() ;
			
			$.ajax({
				url : 'productTest' ,
				dataType : 'json' ,
				data : {
					comCode : comCode ,
					comNoDetail : comNoDetail ,
					podtCode : podtCode ,
					podtInput : podtInput ,
					podtOutput : podtOutput
				} ,
				async : false ,
				success : function(result) {
					console.log(result) ;
				} ,
				error : function(reject) {
					console.log(reject) ;
				}
				
			})
		})
	</script>
</body>
</html>