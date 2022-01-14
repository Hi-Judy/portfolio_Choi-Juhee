package egov.mes.resources.order.dao;

import java.util.List;

public interface ResourcesCheckMapper {
	List<ResourcesCheckVO> findResourcesCheck(ResourcesCheckVO vo);
	int insertResourcesCheck(ResourcesCheckVO vo);
	int insertResourceStore(ResourcesCheckVO vo);
	int insertResourcesRtngd(ResourcesCheckVO vo);
	int updateResourcesOrder(ResourcesCheckVO vo);
}
