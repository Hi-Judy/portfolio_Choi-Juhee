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
		<input type="text" id="comCode"><button type="button" id="btn">전송</button>
	</div>
	
	<script>
		$("#btn").on("click" , function() {
			let comCode = $("#comCode").val() ;
			
			$.ajax({
				url : 'productTest' ,
				dataType : 'json' ,
				data : {
					comCode : comCode
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