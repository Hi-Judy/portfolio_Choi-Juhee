package egov.mes.resources.check.service;

import java.util.List;

import egov.mes.resources.check.dao.ResourcesCheckVO;
import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.rtngd.dao.ResourcesRtngdVO;

public interface ResourcesCheckService {
	List<ResourcesCheckVO> findResourcesCheck(ResourcesCheckVO vo);
	List<ResourcesRtngdVO> searchRtngd(ResourcesRtngdVO vo);
	void modifyCheck(ModifyVO<ResourcesCheckVO> mvo);
}
