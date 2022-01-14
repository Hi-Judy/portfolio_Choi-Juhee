package egov.mes.resources.check.service;

import java.util.List;

import egov.mes.resources.check.dao.ResourcesCheckVO;
import egov.mes.resources.order.dao.ModifyVO;

public interface ResourcesCheckService {
	List<ResourcesCheckVO> findResourcesCheck(ResourcesCheckVO vo);
	void modifyCheck(ModifyVO<ResourcesCheckVO> mvo);
}
