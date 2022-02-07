package egov.mes.manufacture.movement.dao;

import lombok.Data;

@Data
public class ManMovementVO {

	//생산지시
	String podtCode; //제품코드
	String podtName; //제품명
	String manStartdate; //지시일
	String comCode; //지시번호
	String comEtc; //상태
	String manGoalperday; //지시수량
	
	
	//공정
	String manQnt; //작업완료량
	String prodCode; //공정코드
	String procName; //공정명
	String empId; //사번
	String empName; //사원명
	String defQnt; //불량량
	
	
	//자재
	String rscCode; //자재코드
	String rscName; //자재명
	String rscLot; //자재로트
}
