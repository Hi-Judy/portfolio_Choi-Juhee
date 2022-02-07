package egov.mes.manufacture.movement.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ManMovementMapper")
public interface ManMovementMapper {

	//생산지시서 조회
	List<ManMovementVO> selectCommand(ManMovementVO movementVO);
	
	//공정이동표 
	List<ManMovementVO> selectMovement(ManMovementVO movementVO);
	
	//공정이동표에서 자재 조회
	List<ManMovementVO> selectResLot(ManMovementVO movementVO);
	
	//선택된 지시 정보 
	List<ManMovementVO> selectComInfo(ManMovementVO movementVO);
}
