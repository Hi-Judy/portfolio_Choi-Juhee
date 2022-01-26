package egov.mes.resources.store.dao;

import java.util.List;

public interface ResourceStoreMapper {
	List<ResourcesStoreVO> findResourcesStore(ResourcesStoreVO vo);
	List<ResourcesStoreVO> ResourcesStoreIn(ResourcesStoreVO vo);
	List<ResourcesStoreVO> ResourcesStoreOut(ResourcesStoreVO vo);
	List<ResourcesStoreVO> searchResourcesStoreIn(ResourcesStoreVO vo);
	List<ResourcesStoreVO> searchResourcesStoreOut(ResourcesStoreVO vo);
	List<ResourcesStoreVO> findResourcesInventory(ResourcesStoreVO vo);
	List<ResourcesStoreVO> resourceStoreInventory(ResourcesStoreVO vo);
	int insertResourcesStore(ResourcesStoreVO vo);
	int updateResourcesStore(ResourcesStoreVO vo);
	int insertResourcesInventoryIn(ResourcesStoreVO vo);
	int insertResourcesInventoryOut(ResourcesStoreVO vo);

}
