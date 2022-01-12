package egov.mes.manufacture.service;

import java.util.List;

import egov.mes.manufacture.dao.ManufacturePlanVO;

public interface ManufactureService {

	//미계획 조회
	List<ManufacturePlanVO> selectPlan(ManufacturePlanVO mPlanVO);
	
	//자재조회
	List<ManufacturePlanVO> selectRes(ManufacturePlanVO mPlanVo);
}
