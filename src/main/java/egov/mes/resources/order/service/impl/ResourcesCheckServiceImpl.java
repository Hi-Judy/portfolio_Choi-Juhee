package egov.mes.resources.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.order.dao.ResourcesCheckMapper;
import egov.mes.resources.order.dao.ResourcesCheckVO;
import egov.mes.resources.order.service.ResourcesCheckService;
@Service
public class ResourcesCheckServiceImpl implements ResourcesCheckService{
	@Autowired ResourcesCheckMapper mapper;
	@Override
	public List<ResourcesCheckVO> findResourcesCheck(ResourcesCheckVO vo) {
		return mapper.findResourcesCheck(vo);
	}

	@Override
	public void modifyCheck(ModifyVO<ResourcesCheckVO> mvo) {
	
		
	}

}
