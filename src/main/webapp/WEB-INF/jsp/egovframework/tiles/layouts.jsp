<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<link href="<c:url value='/images/egovframework/com/Logo/logo.png' />" rel="shortcut icon" type="image/x-icon">
<link type="text/css" rel="stylesheet"
	href="<c:url value='/css/egovframework/com/app.css' />">
<link type="text/css" rel="stylesheet"
	href="<c:url value='/css/egovframework/com/bootstrap.css' />">
</head>
<body>
	<tiles:insertAttribute name="tiles_side_bar" />
	<div id="wraper" class="margin3">
		<div id="header">
			<tiles:insertAttribute name="tiles_header" />
			<tiles:insertAttribute name="tiles_nav" />
		</div>
		<div id="contents">
			<tiles:insertAttribute name="tiles_content" />
		</div>
	</div>
</body>
<footer>
	<div id="wrap">
		<div id="footer" class="margin3">
			<tiles:insertAttribute name="tiles_footer" />
		</div>
	</div>
</footer>
<script src="<c:url value='/js/bootstrap.bundle.min.js' />"></script>
<script src="<c:url value='/js/main.js' />"></script>
</html>