package egov.mes.manufacture.plan.dao;

import lombok.Data;

@Data
public class ManufacturePlanVO {

	String ordCode; //주문코드
	String ordDuedate; //납기일자
	String ordStatus; //주문상태
	String ordQnt; //주문량
	String cusCode; //고객코드
	
	String podtCode; //제품코드
	String podtName; //제품명
	String resCode; //자재코드
	String resUsage; //자재소요량
	String 재고량;
	String rscCode;
	
	String manPlanNo; //계획번호
	String manPlanName; //계획명
	String manPlanDate; //계획일자
	
	String planNoDetail; //계획디테일 번호
	String planStartDate; //작업시작일
	String planPeriod; //작업기간
	String planComplete; //작업종료일
	
	String manPerday; //일 생산량
	String planEtc; //비고
	
	String startDate; //계획기간조회 
	String endDate; //계획기간조회
	
	String facOutput; //설비당 생산량
	String facRuntime; //설비당 소요시간
	String outputDay; //일 생산량
	
}
