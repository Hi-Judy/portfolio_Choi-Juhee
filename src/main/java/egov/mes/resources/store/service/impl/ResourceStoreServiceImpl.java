package egov.mes.resources.store.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.store.dao.ResourceStoreMapper;
import egov.mes.resources.store.dao.ResourcesStoreVO;
import egov.mes.resources.store.service.ResourceStoreService;
@Service
public class ResourceStoreServiceImpl implements ResourceStoreService{
	@Autowired ResourceStoreMapper mapper;
	
	@Override
	public List<ResourcesStoreVO> ResourcesStoreIn(ResourcesStoreVO vo) {
		return mapper.ResourcesStoreIn(vo);
	}

	@Override
	public List<ResourcesStoreVO> ResourcesStoreOut(ResourcesStoreVO vo) {
		return mapper.ResourcesStoreOut(vo);
	}
	
	@Override
	public List<ResourcesStoreVO> findResourcesStore(ResourcesStoreVO vo) {
		return mapper.findResourcesStore(vo);
	}

	@Override
	public void modifyStore(ModifyVO<ResourcesStoreVO> mvo) {
		if(mvo.getUpdatedRows() != null) {
			for(ResourcesStoreVO vo :mvo.getUpdatedRows()) {
				mapper.insertResourcesStore(vo);
				mapper.updateResourcesStore(vo);
			}
		}
	}
}
