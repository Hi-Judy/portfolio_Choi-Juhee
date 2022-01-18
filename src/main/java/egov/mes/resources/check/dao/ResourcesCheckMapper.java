package egov.mes.resources.check.dao;

import java.util.List;

import egov.mes.resources.rtngd.dao.ResourcesRtngdVO;

public interface ResourcesCheckMapper {
	List<ResourcesCheckVO> findResourcesCheck(ResourcesCheckVO vo);
	List<ResourcesRtngdVO> searchRtngd(ResourcesRtngdVO vo);
	int insertResourcesCheck(ResourcesCheckVO vo);
	int updateResourcesCheck(ResourcesCheckVO vo);
}
