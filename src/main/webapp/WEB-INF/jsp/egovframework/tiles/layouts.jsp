<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<tiles:insertAttribute name="tiles_header" />
</head>
<body>
	<div id="wrap">
		<div id="header">
			<tiles:insertAttribute name="tiles_nav" />
		</div>
		<div id="contents">
			<tiles:insertAttribute name="tiles_content" />
		</div>
	</div>
</body>
<footer>
	<div id="wrap">
		<div id="footer">
			<tiles:insertAttribute name="tiles_footer" />
		</div>
	</div>
</footer>
</html>