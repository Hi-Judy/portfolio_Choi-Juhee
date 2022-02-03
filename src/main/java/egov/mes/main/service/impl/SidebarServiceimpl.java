package egov.mes.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.main.dao.SidebarMenuMapper;
import egov.mes.main.dao.SidebarMenuVO;
import egov.mes.main.service.SidebarService;

@Service("SidebarService")
public class SidebarServiceimpl implements SidebarService {

	@Autowired
	private SidebarMenuMapper mapper;
	
	@Override
	public List<SidebarMenuVO> selectsideList() {
		return mapper.selectsideList();
	}

}
