package egov.mes.manufacture.process.dao;

import lombok.Data;

@Data
public class ManProcessVO {

	//생산지시
	String podtCode; //제품코드
	String podtName; //제품명
	String manStartDate; //작업일
	String manGoalPerday; //작업량
	String comCode; //지시번호
	
	//공정
	String procCode; //공정코드 
	String procName; //공정명
	String manStartTime; //작업시작시간
	String manEndTime; //작업종료시간
	String defQnt; //불량갯수
	
	//설비
	String facCode; //설비코드
	String facName; //설비명
}
