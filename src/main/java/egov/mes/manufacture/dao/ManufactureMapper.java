package egov.mes.manufacture.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("manufactureMapper")
public interface ManufactureMapper {
	//미계획조회
	List<ManufacturePlanVO> selectPlan(ManufacturePlanVO mPlanVo) ;
	
	//자재 조회
	List<ManufacturePlanVO> selectRes(ManufacturePlanVO mPlanVo);

	//생산계획 추가
	int insertPlan(ManufacturePlanVO palnVO);
	
	//생산계획 디테일 추가
	int insertPlanDetail(ManufacturePlanVO palnVO);
}
