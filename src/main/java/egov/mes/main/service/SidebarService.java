package egov.mes.main.service;

import java.util.List;

import egov.mes.main.dao.SidebarMenuVO;

public interface SidebarService {
	List<SidebarMenuVO> selectsideList(String uid);
}
