package egov.mes.manufacture.perfomance.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ManPerformanceMapper")
public interface ManPerformanceMapper {

	//제품별 불량율 조회
	List<ManPerformanceVO> selectPodtDef(ManPerformanceVO performanceVO);
	
	//월별 불량율 조회
	List<ManPerformanceVO> selectMonthDef(ManPerformanceVO performanceVO);
}
