package egov.mes.common.dao;

import java.util.List;

public interface CommonGroupMapper {
	
	List<CommonGroupVO> find();
	List<CommonGroupVO> findSelect(String groupCode);
}
