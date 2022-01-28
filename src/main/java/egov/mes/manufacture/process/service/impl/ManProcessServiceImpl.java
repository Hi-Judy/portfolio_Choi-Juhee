package egov.mes.manufacture.process.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.process.dao.ManProcessMapper;
import egov.mes.manufacture.process.dao.ManProcessVO;
import egov.mes.manufacture.process.service.ManProcessService;

@Service("manProcessService")
public class ManProcessServiceImpl implements ManProcessService {
	
	@Autowired
	private ManProcessMapper mapper;

	//생산지시서 조회
	@Override
	public List<ManProcessVO> selectCommand(ManProcessVO processVO) {
	return mapper.selectCommand(processVO);
	}

	
	//공정 조회
	@Override
	public List<ManProcessVO> selectProcess(ManProcessVO processVO) {
		return mapper.selectProcess(processVO);
	}

}
