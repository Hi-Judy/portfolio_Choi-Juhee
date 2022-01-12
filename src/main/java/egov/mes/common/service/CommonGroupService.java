package egov.mes.common.service;

import java.util.List;

import org.springframework.stereotype.Service;

import egov.mes.common.dao.CommonGroupVO;

@Service
public interface CommonGroupService {
	
	
	
	List<CommonGroupVO> find();
	List<CommonGroupVO> findSelect(String groupCode);
}
