package egov.mes.resources.order.service;

import java.util.List;

import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.order.dao.ResourcesCheckVO;

public interface ResourcesCheckService {
	List<ResourcesCheckVO> findResourcesCheck(ResourcesCheckVO vo);
	void modifyCheck(ModifyVO<ResourcesCheckVO> mvo);
}
