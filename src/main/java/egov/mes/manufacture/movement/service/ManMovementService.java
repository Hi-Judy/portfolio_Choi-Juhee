package egov.mes.manufacture.movement.service;

import java.util.List;

import egov.mes.manufacture.movement.dao.ManMovementVO;

public interface ManMovementService {
	
	//생산지시서 조회
	List<ManMovementVO> selectCommand(ManMovementVO movementVO);
}
