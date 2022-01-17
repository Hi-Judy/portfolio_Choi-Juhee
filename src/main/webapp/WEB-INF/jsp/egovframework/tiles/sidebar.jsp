<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="sidebar" class="active">
	<div class="sidebar-wrapper active" style="padding-right:0px">
		<div class="sidebar-header">
			<div class="d-flex justify-content-between">
				<div class="logo">
					<a href="index.html"><img src="assets/images/logo/logo.png"
						alt="Logo" srcset=""></a>
				</div>
				<div class="toggler">
					<a href="#" class="sidebar-hide d-xl-none d-block"><i
						class="bi bi-x bi-middle"></i></a>
				</div>
			</div>
		</div>
		<div class="sidebar-menu">
			<ul class="menu">
				<li class="sidebar-title">Menu</li>
				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-stack"></i> <span>기준정보
							관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="CommonGroup">공통 자료 관리</a></li>
						<li class="submenu-item "><a href="ProductBom">제품 BOM 관리</a></li>
						<li class="submenu-item "><a href="#">공정 관리</a></li>
						<li class="submenu-item "><a href="#">사원 정보 관리</a></li>
					</ul></li>

				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-collection-fill"></i> <span>영업관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="customerInfo">고객 관리</a></li>
						<li class="submenu-item "><a href="orderManagement">주문 관리</a></li>
						<li class="submenu-item "><a href="noManReleaseInfo">미생산 출하 조회</a></li>
						<li class="submenu-item "><a href="productInfo">제품 입/출고 관리</a></li>
					</ul></li>

				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-grid-1x2-fill"></i> <span>생산관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="manufacture/manufacture">생산 계획 관리</a></li>
						<li class="submenu-item "><a href="manufacture/manufactureSelect">생산 계획 상세 조회</a></li>
						<li class="submenu-item "><a href="manufacture/manCommand">생산 지시 관리</a></li>
						<li class="submenu-item "><a href="#">생산 지시 상세 조회</a></li>
						<li class="submenu-item "><a href="#">생산 현황 조회</a></li>
						<li class="submenu-item "><a href="#">공장 실적 관리</a></li>
						<li class="submenu-item "><a href="#">생산 실적 조회</a></li>
					</ul></li>
				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-grid-1x2-fill"></i> <span>설비관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="facilityManagement">설비 관리</a></li>
					</ul></li>
				<li class="sidebar-item  has-sub"><a href="#"
					class='sidebar-link'> <i class="bi bi-grid-1x2-fill"></i> <span>자재관리</span>
				</a>
					<ul class="submenu ">
						<li class="submenu-item "><a href="orderInsert">자재 발주</a></li>
						<li class="submenu-item "><a href="resourceorderList">자재 발주 조회</a></li>
						<li class="submenu-item "><a href="resourcesCheck">자재입고검사 관리</a></li>
						<li class="submenu-item "><a href="ResourcesStoreList">자재 입고 관리</a></li>
						<li class="submenu-item "><a href="#">자재 입/출고 조회</a></li>
						<li class="submenu-item "><a href="#">자재 반품 조회</a></li>
						<li class="submenu-item "><a href="#">자재 LOT재고 조정 관리</a></li>
						<li class="submenu-item "><a href="#">자재 LOT재고 조정 조회</a></li>
						<li class="submenu-item "><a href="#">자재 재고 조회</a></li>
					</ul></li>
			</ul>
		</div>
		<button class="sidebar-toggler btn x">
			<i data-feather="x"></i>
		</button>
	</div>
</div>