package egov.mes.manufacture.movement.dao;

import lombok.Data;

@Data
public class ManMovementVO {

	//생산지시
	String podtCode; //제품코드
	String podtName; //제품명
	String manStartDate; //작업일
	String comCode; //지시번호
	String comEtc; //상태
}
