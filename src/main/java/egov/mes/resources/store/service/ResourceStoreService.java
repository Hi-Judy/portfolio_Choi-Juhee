package egov.mes.resources.store.service;

import java.util.List;

import egov.mes.resources.store.dao.ResourcesStoreVO;

public interface ResourceStoreService {
	List<ResourcesStoreVO> findResourcesStore(ResourcesStoreVO vo);

}
