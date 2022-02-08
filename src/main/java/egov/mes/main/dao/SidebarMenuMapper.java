package egov.mes.main.dao;

import java.util.List;

public interface SidebarMenuMapper {
	List<SidebarMenuVO> selectsideList(String uid);
}
