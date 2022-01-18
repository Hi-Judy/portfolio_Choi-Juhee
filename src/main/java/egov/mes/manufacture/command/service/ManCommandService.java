package egov.mes.manufacture.command.service;

import java.util.List;

import egov.mes.manufacture.command.dao.ManCommandVO;

public interface ManCommandService {

	//생산계획 조회(생산지시 관리 페이지)
	List<ManCommandVO> selectManPlan(ManCommandVO commandVO);
	
	//생산계획 디테일 상세 조회(생산지시서 관리 페이지)
	List<ManCommandVO> selectManPlanDetail(ManCommandVO commandVO);
}
