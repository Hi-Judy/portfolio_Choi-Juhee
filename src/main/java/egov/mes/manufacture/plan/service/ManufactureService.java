package egov.mes.manufacture.plan.service;

import java.util.List;
import java.util.Map;

import egov.mes.manufacture.plan.dao.ManufacturePlanVO;
import egov.mes.manufacture.plan.dao.ModifyVO;


public interface ManufactureService {
	
	//계획 삭제 후 계획 다시 작성
	int updatePlan(ManufacturePlanVO planVo);
	
	//생산계획 삭제
	int deletePlan(ManufacturePlanVO palnVO);
	
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
	
	//미계획 내역 메인화면에 넣어주기
	List<ManufacturePlanVO> selectPlanToMain(List<ManufacturePlanVO> planVo);

	//생산계획 추가
	int insertPlan(ModifyVO<ManufacturePlanVO> list);
	
	//달력용
	List<ManufacturePlanVO> selectCal(ManufacturePlanVO planVo) ;

}
