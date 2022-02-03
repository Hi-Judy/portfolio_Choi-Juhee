package egov.mes.manufacture.process.dao;

import lombok.Data;

@Data
public class ManProcessVO {

	//생산지시
	String podtCode; //제품코드
	String podtName; //제품명
	String manStartDate; //작업일
	String manGoalPerday; //작업량(지시량)
	String comCode; //지시번호
	
	//공정
	String procCode; //공정코드 
	String procName; //공정명
	String manStarttime; //작업시작시간
	String manEndtime; //작업종료시간
	String defQnt; //불량갯수
	String manQnt; //작업 완료량(현시점까지 완료한 갯수)
	String manNo; //작업번호
	String qntPer10Second; //10초당 생산량
	String manGoalqnt; //지시량
	String procIndex; //작업순서
	
	//설비
	String facCode; //설비코드
	String facName; //설비명
}
