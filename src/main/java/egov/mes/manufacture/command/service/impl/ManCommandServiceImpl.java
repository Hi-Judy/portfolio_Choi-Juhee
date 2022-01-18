package egov.mes.manufacture.command.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.command.dao.ManCommandMapper;
import egov.mes.manufacture.command.dao.ManCommandVO;
import egov.mes.manufacture.command.service.ManCommandService;

@Service("manCommandService")
public class ManCommandServiceImpl implements ManCommandService{

	@Autowired
	private ManCommandMapper mapper;
	
	//생산계획 조회(생산지시 관리 페이지)
	@Override
	public List<ManCommandVO> selectManPlan(ManCommandVO commandVO) {
		return mapper.selectManPlan(commandVO);
	}

}
