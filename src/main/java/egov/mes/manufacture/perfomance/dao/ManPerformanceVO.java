package egov.mes.manufacture.perfomance.dao;

import lombok.Data;

@Data
public class ManPerformanceVO {

	String monthCode; //월별
	String podtCode; //제품코드
	String podtName; //제품명
	String manGoalqnt; //지시수량
	String manQnt; //작업완료량
	String defQnt; //불량량
	String defPercentage; //불량율
	String performanceSort; //실적 조회 기준
}
