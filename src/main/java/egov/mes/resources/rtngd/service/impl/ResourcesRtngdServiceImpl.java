package egov.mes.resources.rtngd.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.resources.rtngd.dao.ResourcesRtngdMapper;
import egov.mes.resources.rtngd.dao.ResourcesRtngdVO;
import egov.mes.resources.rtngd.service.ResourcesRtngdService;

@Service
public class ResourcesRtngdServiceImpl implements ResourcesRtngdService{
	@Autowired ResourcesRtngdMapper mapper;
	
	@Override
	public List<ResourcesRtngdVO> findResourcesRtngd(ResourcesRtngdVO vo) {
		return mapper.findResourcesRtngd(vo);
	}

}
