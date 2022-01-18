package egov.mes.manufacture.command.dao;

import lombok.Data;

@Data
public class ManCommandVO {
	
	//생산계획
	String podtCode;
	String podtName;
	String ordQnt; //주문량
	String ordDuedate; //납기일자
	
	String manPlanNo; //계획번호
	String manPlanDate; //계획일자
	String manPlanName; //계획명
	
	String planFromDate; //계획일자
	String planToDate;   //계획일자
	
	String planNoDetail; //계획 디테일 번호

	
	//생산지시
	String comCode; //지시번호
	String comDate; //지시일
	String comName; //지시명
	
	String comNoDetail;//지시 디테일번호
	String manStartDate; //작업일
	String manGoalPerday; //하루 생산량
	String manEtc; //비고
	
	
}
