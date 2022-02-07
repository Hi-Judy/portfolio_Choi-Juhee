package egov.mes.resources.order.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.order.dao.ResourcesOrderMapper;
import egov.mes.resources.order.dao.ResourcesOrderVO;
import egov.mes.resources.order.service.ResourcesOrderService;

@Service
public class ResourcesOrderServiceImpl implements ResourcesOrderService {
	@Autowired
	ResourcesOrderMapper mapper;

	@Override
	public List<ResourcesOrderVO> findResourcesOrder(ResourcesOrderVO vo) {
		return mapper.findResourcesOrder(vo);
	}
	
	@Override
	public List<Map> searchResourcesOrder(ResourcesOrderVO vo) {
		return mapper.searchResourcesOrder(vo);
	}
	
	@Override
	public List<Map> searchRec(ResourcesOrderVO vo) {
		return mapper.searchRec(vo);
	}

	@Override
	public List<Map> searchSuc(ResourcesOrderVO vo) {
		return mapper.searchSuc(vo);
	}

	@Override
	public void modifyOrder(ModifyVO<ResourcesOrderVO> mvo) {
		if (mvo.getCreatedRows() != null) {
			for (ResourcesOrderVO vo : mvo.getCreatedRows()) {
				if(!vo.getOrdrNo().equals(null)) {
					mapper.updateResourcesOrder(vo);
				}else {
					mapper.insertResourcesOrder(vo);
				}
					
			}
		}
		if (mvo.getUpdatedRows() != null) {
			for (ResourcesOrderVO vo : mvo.getUpdatedRows()) {
				mapper.updateResourcesOrder(vo);
			}
		}
		if (mvo.getDeletedRows() != null) {
			for (ResourcesOrderVO vo : mvo.getDeletedRows()) {
				mapper.deleteResourcesOrder(vo);
			}
		}
	}
}