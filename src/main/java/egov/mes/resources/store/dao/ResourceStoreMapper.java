package egov.mes.resources.store.dao;

import java.util.List;

public interface ResourceStoreMapper {
	List<ResourcesStoreVO> findResourcesStore(ResourcesStoreVO vo);
	List<ResourcesStoreVO> ResourcesStoreIn(ResourcesStoreVO vo);
	List<ResourcesStoreVO> ResourcesStoreOut(ResourcesStoreVO vo);
	int insertResourcesStore(ResourcesStoreVO vo);
	int updateResourcesStore(ResourcesStoreVO vo);
}
