package egov.mes.manufacture.process.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manProcessMapper")
public interface ManProcessMapper {
	
	//공정조회
	List<ManProcessVO> selectProcess(ManProcessVO processVO);

	//생산지시서 조회
	List<ManProcessVO> selectCommand(ManProcessVO processVO);
	
	
	
	
	
}
