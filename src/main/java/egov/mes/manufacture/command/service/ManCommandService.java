package egov.mes.manufacture.command.service;

import java.util.List;

import egov.mes.manufacture.command.dao.ManCommandVO;

public interface ManCommandService {

	//생산계획 조회(생산지시 관리 페이지)
	List<ManCommandVO> selectManPlan(ManCommandVO commandVO);
}
