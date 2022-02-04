<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="board_wrap">
<script>

	var index = 0;
	window.addEventListener('load', function() {
		slideShow();
	});

	function slideShow() {
		var i;
		var x = document.getElementsByClassName("slide1");
		for (i = 0; i < x.length; i++) {
			x[i].style.display = "none";
		}
		index++;
		if (index > x.length) {
			index = 1;
		}
		x[index - 1].style.display = "block";
		setTimeout(slideShow, 1500);

	}
</script>
   
<div align="center">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/1.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/2.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/3.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/4.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/5.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/6.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/7.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/8.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/9.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/10.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/11.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/12.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
  <img class="slide1" src="<c:url value='/images/egovframework/com/main/13.png'/>" style="width: 1300px; height: auto; border-radius: 7px;">
</div>
</div>
