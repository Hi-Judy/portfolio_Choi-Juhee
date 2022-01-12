package egov.mes.resources.order.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.resources.order.dao.ResourcesOrderMapper;
import egov.mes.resources.order.dao.ResourcesOrderVO;
import egov.mes.resources.order.service.ResourcesOrderService;

@Service
public class ResourcesOrderServiceImpl implements ResourcesOrderService{
	@Autowired ResourcesOrderMapper mapper;

	@Override
	public List<ResourcesOrderVO> find(ResourcesOrderVO vo) {
		return mapper.find(vo);
	}

	@Override
	public List<Map> searchRec(ResourcesOrderVO vo) {
		return mapper.searchRec(vo);
	}

	@Override
	public int insertOrder(ResourcesOrderVO vo) {
		return mapper.insertOrder(vo);
	}
	
	
}
