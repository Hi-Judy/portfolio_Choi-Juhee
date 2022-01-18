package egov.mes.resources.store.dao;

import java.util.List;

public interface ResourceStoreMapper {
	List<ResourcesStoreVO> findResourcesStore(ResourcesStoreVO vo);
	int insertResourcesStore(ResourcesStoreVO vo);
}
