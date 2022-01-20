package egov.mes.manufacture.command.service;

import java.util.List;

import egov.mes.manufacture.command.dao.ManCommandVO;

public interface ManCommandService {

	//지시가 없는 생산계획 조회(생산지시 관리 페이지)
	List<ManCommandVO> selectManPlan(ManCommandVO commandVO);
	
	//생산계획 디테일 상세 조회(생산지시서 관리 페이지)
	List<ManCommandVO> selectManPlanDetail(ManCommandVO commandVO);
	
	//제품 코드 입력했을 때 필요한 공정별 자재 조회
	List<ManCommandVO> selectRes(ManCommandVO commandVO);

	
	//제품 만드는데 필요한 공정에 해당하는 설비 조회
	List<ManCommandVO> selectFac(ManCommandVO commandVO);

}
