<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="sidebar" class="active">
	<div class="sidebar-wrapper active"
		style="padding-right: 0px; resize: horizontal;">
		<div class="sidebar-header">
			<div class="d-flex justify-content-between">
				<div class="logo">
					<a href="index.jsp"><img
						src="<c:url value='/images/egovframework/com/Logo/logo.png' />"
						alt="Logo" srcset="" style="width: 200px; height: 100px;"></a>
				</div>
				<div class="toggler">
					<a href="#" class="sidebar-hide d-xl-none d-block"><i
						class="bi bi-x bi-middle"></i></a>
				</div>
			</div>
		</div>
		<div class="sidebar-menu">
			<ul class="menu"><!-- 
				<li class="sidebar-title">Menu</li>
				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-collection-fill"></i> <span>egov test</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="/sec/ram/EgovAuthorList.do">권한 관리</a></li>
						<li class="submenu-item "><a href="/sec/rgm/EgovAuthorGroupList.do">권한 그룹 관리</a></li>
						<li class="submenu-item "><a href="/sec/gmt/EgovGroupList.do">그룹 관리</a></li>
						<li class="submenu-item "><a href="/sec/rmt/EgovRoleList.do">롤 관리</a></li>
						<li class="submenu-item "><a href="/sym/mnu/mpm/EgovMenuListSelect.do">메뉴리스트관리</a></li>
						<li class="submenu-item "><a href="/sym/mnu/mpm/EgovMenuManageSelect.do">메뉴관리리스트</a></li>
						<li class="submenu-item "><a href="/sym/mnu/mcm/EgovMenuCreatManageSelect.do">메뉴생성관리</a></li>
						<li class="submenu-item "><a href="/sym/mnu/stm/EgovSiteMapng.do">사이트맵</a></li>
					</ul></li>
				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-stack"></i> <span>기준정보
							관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="../CommonGroup">공통 자료 관리</a></li>
						<li class="submenu-item "><a href="MaterialManagement">자재정보 관리</a></li>
						<li class="submenu-item "><a href="ProductBom">제품 BOM 관리</a></li>
						<li class="submenu-item "><a href="ProcessControl">공정 관리</a></li>
						<li class="submenu-item "><a href="EmployeeView">사원 정보 관리</a></li>
					</ul></li>

				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-collection-fill"></i> <span>영업관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="customerInfo">고객 관리</a></li>
						<li class="submenu-item "><a href="orderManagement">주문 관리</a></li>
						<li class="submenu-item "><a href="noManReleaseInfo">미생산
								출하 조회</a></li>
						<li class="submenu-item "><a href="productInfo">제품 입/출고
								관리</a></li>
					</ul></li>

				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-grid-1x2-fill"></i> <span>생산관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="manufacture">생산 계획 관리</a></li>
						<li class="submenu-item "><a href="manufactureSelect">생산 계획 상세 조회</a></li>
						<li class="submenu-item "><a href="manCommand">생산 지시 관리</a></li>
						<li class="submenu-item "><a href="manCommandSelect">생산 지시 상세 조회</a></li>

						<li class="submenu-item "><a href="manProcess">생산 현황 관리</a></li>
						<li class="submenu-item "><a href="manMovement">공정이동표</a></li>
						<li class="submenu-item "><a href="checkProduct">불량 검사</a></li>
						<li class="submenu-item "><a href="manPerformance">생산실적조회</a></li>
								

					</ul></li>
				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-grid-1x2-fill"></i> <span>설비관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="facilityManagement">설비
								관리</a></li>
					</ul></li>
				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-grid-1x2-fill"></i> <span>자재관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="orderInsert">자재 발주 관리</a></li>
						<li class="submenu-item "><a href="resourceorderList">자재
								발주 조회</a></li>
						<li class="submenu-item "><a href="resourcesCheck">자재입고검사
								관리</a></li>
						<li class="submenu-item "><a href="resourcesStore">자재 입고
								관리</a></li>
						<li class="submenu-item "><a href="resourceStoreInOut">자재
								입/출고 조회</a></li>
						<li class="submenu-item "><a href="resourcesRtngdList">자재
								반품 조회</a></li>
						<li class="submenu-item "><a href="resourcesInventory">자재
								LOT재고 조정 관리</a></li>
						<li class="submenu-item "><a href="resourcesInventoryList">자재
								LOT재고 조정 조회</a></li>
						<li class="submenu-item "><a href="resourcesInvenList">자재
								재고 조회</a></li>
					</ul></li> -->
			</ul>
		</div>
		<button class="sidebar-toggler btn x">
			<i data-feather="x"></i>
		</button>
	</div>
</div>