package egov.mes.manufacture.movement.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ManMovementMapper")
public interface ManMovementMapper {

	//생산지시서 조회
	List<ManMovementVO> selectCommand(ManMovementVO movementVO);
}
