package egov.mes.resources.rtngd.service;

import java.util.List;

import egov.mes.resources.rtngd.dao.ResourcesRtngdVO;

public interface ResourcesRtngdService {
	List<ResourcesRtngdVO> findResourcesRtngd(ResourcesRtngdVO vo);
}
