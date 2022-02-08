package egov.mes.manufacture.perfomance.service;

import java.util.List;

import egov.mes.manufacture.perfomance.dao.ManPerformanceVO;

public interface ManPerformanceService {
	
	//불량율 조회
	List<ManPerformanceVO> selectDef(ManPerformanceVO performanceVO);
	
	//월별 불량율 조회
	//List<ManPerformanceVO> selectMonthDef(ManPerformanceVO performanceVO);

}
