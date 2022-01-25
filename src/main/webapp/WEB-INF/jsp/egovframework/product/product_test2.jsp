<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
	<div id="printTarget">
		<img id="image" src="">
	</div>
	<script>
	
		function printCall() {
			window.print() ;
		}
		
		function image() {
			// 집 192.168.0.8
			// 학원 192.168.0.60
			// 우리조서버 52.86.104.126:8080
			let code = '${code}' ;			
			//let url = "http://192.168.0.8/yedam_final2/viewQR/" + code ;
			let url = "http://192.168.0.8/yedamfinal2/viewQR/" + code ;
			$("#image").attr("src","https://zxing.org/w/chart?cht=qr&chs=350x350&chld=L&choe=UTF-8&chl=" + url) ;	
		}
		
		window.onclick = function() {
			printCall() ;
		}
		
		image() ;
	</script>
</body>
</html>