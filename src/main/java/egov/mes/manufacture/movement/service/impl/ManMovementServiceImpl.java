package egov.mes.manufacture.movement.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.movement.dao.ManMovementMapper;
import egov.mes.manufacture.movement.dao.ManMovementVO;
import egov.mes.manufacture.movement.service.ManMovementService;

@Service("ManMovementService")
public class ManMovementServiceImpl implements ManMovementService {

	@Autowired
	private ManMovementMapper mapper;

	//생산지시서 조회
	@Override
	public List<ManMovementVO> selectCommand(ManMovementVO movementVO) {
		return mapper.selectCommand(movementVO);
	}

	//공정이동표
	@Override
	public List<ManMovementVO> selectMovement(ManMovementVO movementVO) {
		return mapper.selectMovement(movementVO);
	}

	//공정이동표에서 자재 조회
	@Override
	public List<ManMovementVO> selectResLot(ManMovementVO movementVO) {
		return mapper.selectResLot(movementVO);
	}

	//선택된 지시 정보 
	@Override
	public List<ManMovementVO> selectComInfo(ManMovementVO movementVO) {
		return mapper.selectComInfo(movementVO);
	}
	
	
	
	
}
