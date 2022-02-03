package egov.mes.manufacture.process.service;

import java.util.List;

import egov.mes.manufacture.process.dao.ManProcessVO;

public interface ManProcessService {
	
	//첫 번째 공정만 시작시간을 sysdate로 업데이트
	int updateFirstProc(ManProcessVO processVO);
	
	//작업완료량 합계
	List<ManProcessVO> selectSumManQnt(ManProcessVO processVO);
	
	//지시된 제품에 해당하는 공정 조회
	List<ManProcessVO> selectProcess(ManProcessVO processVO);

	//생산지시서 조회
	List<ManProcessVO> selectCommand(ManProcessVO processVO);
	
	//제품에 해당하는 공정 조회
	ManProcessVO selectProc(ManProcessVO processVO);
	
	
}