package egov.mes.Proc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.Proc.dao.ProcessControlMapper;
import egov.mes.Proc.dao.ProcessControlVO;
import egov.mes.Proc.service.ProcessControlService;

@Service
public class ProcessControlServiceImpl implements ProcessControlService {
	
	@Autowired ProcessControlMapper mapper;
	
	
	//공정전체조회
	@Override
	public List<ProcessControlVO> AllFind() {
		
		return mapper.AllFind();
	}

}
