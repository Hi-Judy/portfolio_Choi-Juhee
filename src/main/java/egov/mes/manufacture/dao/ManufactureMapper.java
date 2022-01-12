package egov.mes.manufacture.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manufactureMapper")
public interface ManufactureMapper {
	//미계획조회
	List<ManufacturePlanVO> selectPlan(ManufacturePlanVO mPlanVo) ;
	
	//자재 조회
	List<ManufacturePlanVO> selectRes(ManufacturePlanVO mPlanVo);

}
