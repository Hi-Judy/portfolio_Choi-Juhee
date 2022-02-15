package egov.mes.manufacture.movement.service;

import java.util.List;

import egov.mes.manufacture.movement.dao.ManMovementVO;

public interface ManMovementService {
	
	//생산지시서 조회
	List<ManMovementVO> findCommand(ManMovementVO movementVO);
	
	//공정이동표 그리드 채우기
	List<ManMovementVO> selectMovement(ManMovementVO movementVO);
	
	//공정이동표에서 자재 조회
	List<ManMovementVO> selectResLot(ManMovementVO movementVO);
	
	//선택된 지시 정보 
	List<ManMovementVO> selectComInfo(ManMovementVO movementVO);
}
