package egov.mes.manufacture.service;

import java.util.List;
import java.util.Map;

import egov.mes.manufacture.dao.ManufacturePlanVO;
import egov.mes.manufacture.dao.ModifyVO;


public interface ManufactureService {
	
	//생산계획 디테일 조회(조회페이지)
	List<ManufacturePlanVO> selectManufactureDetail(ManufacturePlanVO planVo);
	
	//생산계획 조회(조회페이지)
	List<ManufacturePlanVO> selectManufacturePlan(ManufacturePlanVO PlanVo);
	
	//생산계획 조회
	List<Map<String, String>> selectManPlan(ManufacturePlanVO planVo);
	
	//생산계획 디테일 조회
	List<ManufacturePlanVO> selectManPlanDetail(ManufacturePlanVO planVo);
	
	//자재조회
	List<ManufacturePlanVO> selectRes(ManufacturePlanVO planVo);

	//미계획 조회
	List<ManufacturePlanVO> selectPlan(ManufacturePlanVO planVo);

	//생산계획 추가
	int insertPlan(ModifyVO<ManufacturePlanVO> list);
	


}
