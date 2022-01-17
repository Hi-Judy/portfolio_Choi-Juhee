package egov.mes.resources.check.dao;

import java.util.List;

public interface ResourcesCheckMapper {
	List<ResourcesCheckVO> findResourcesCheck(ResourcesCheckVO vo);
	int insertResourcesCheck(ResourcesCheckVO vo);
	int updateResourcesCheck(ResourcesCheckVO vo);
}
