<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<div class="article_top" style="width:700px;">
		<h2 class="tit_h2">게시판1_MVC</h2>
		<div class="area_rgt" >
			<ul class="btn_list">
				<!-- <li><a href="#" class="btn_type2"><span class="btn_add">글작성</span></a></li> -->
				<!-- <li><a href="#" class="btn_type2"><span class="btn_del">삭제</span></a></li>
				<li><a href="#" class="btn_type2"><span class="btn_sav">저장</span></a></li> -->
			</ul>
		</div>
</div>
<!-- 게시판 리스트 -->
<div class="board_wrap">
	<table class="brd_list brd_chk" style="width:700px;">
		<thead>
			<tr>
				<th rowspan="2">No</th>
				<th rowspan="3"><strong>제목</strong></th>
				<th rowspan="2"><strong>작성자</strong></th>
				<th rowspan="2"><strong>작성일</strong></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td>안녕하세요. 첫 게시글 입니다.</td>
				<td class="txt_ct">홍길동</td>
				<td class="txt_ct">2018년 12월 16일</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- //게시판 리스트 -->