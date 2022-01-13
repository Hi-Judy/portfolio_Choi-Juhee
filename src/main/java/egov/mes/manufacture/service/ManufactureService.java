package egov.mes.manufacture.service;

import java.util.List;

import egov.mes.manufacture.dao.ManufacturePlanVO;
import egov.mes.manufacture.dao.ModifyVO;


public interface ManufactureService {
	//생산계획 조회
	List<ManufacturePlanVO> selectManPlan(ManufacturePlanVO mPlanVo);
	
	//생산계획 추가
	int insertPlan(ModifyVO<ManufacturePlanVO> list);
	
	//자재조회
	List<ManufacturePlanVO> selectRes(ManufacturePlanVO mPlanVo);

	//미계획 조회
	List<ManufacturePlanVO> selectPlan(ManufacturePlanVO mPlanVO);
}
