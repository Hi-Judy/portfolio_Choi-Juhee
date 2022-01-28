package egov.mes.manufacture.process.service;

import java.util.List;

import egov.mes.manufacture.process.dao.ManProcessVO;

public interface ManProcessService {
	
	//공정조회
	List<ManProcessVO> selectProcess(ManProcessVO processVO);

	//생산지시서 조회
	List<ManProcessVO> selectCommand(ManProcessVO processVO);
	
	
}
