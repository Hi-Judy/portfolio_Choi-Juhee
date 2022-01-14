package egov.mes.manufacture.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("manufactureMapper")
public interface ManufactureMapper {
	
	//생산계획 삭제
	int deletePlan(ManufacturePlanVO palnVO);
	
	//생산계획 조회
	List<Map<String, String>> selectManPlan(ManufacturePlanVO mPlanVo);
	
	//생산계획 추가
	int insertPlan(ManufacturePlanVO palnVO);
	
	//생산계획 디테일 추가
	int insertPlanDetail(ManufacturePlanVO palnVO);
	
	//자재 조회
	List<ManufacturePlanVO> selectRes(ManufacturePlanVO planVo);
	
	//미계획조회
	List<ManufacturePlanVO> selectPlan(ManufacturePlanVO planVo) ;
	
}
