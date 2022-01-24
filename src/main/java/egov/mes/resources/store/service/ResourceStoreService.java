package egov.mes.resources.store.service;

import java.util.List;

import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.store.dao.ResourcesStoreVO;

public interface ResourceStoreService {
	List<ResourcesStoreVO> findResourcesStore(ResourcesStoreVO vo);
	List<ResourcesStoreVO> ResourcesStoreIn(ResourcesStoreVO vo);
	List<ResourcesStoreVO> ResourcesStoreOut(ResourcesStoreVO vo);
	List<ResourcesStoreVO> searchResourcesStoreIn(ResourcesStoreVO vo);
	List<ResourcesStoreVO> searchResourcesStoreOut(ResourcesStoreVO vo);
	List<ResourcesStoreVO> findResourcesInventory(ResourcesStoreVO vo);
	void modifyStore(ModifyVO<ResourcesStoreVO> mvo);
}
