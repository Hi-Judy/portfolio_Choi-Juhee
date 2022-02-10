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
	public List<ResourcesStoreVO> searchResourcesStoreIn(ResourcesStoreVO vo) {
		return mapper.searchResourcesStoreIn(vo);
	}
	
	@Override
	public List<ResourcesStoreVO> searchResourcesStoreOut(ResourcesStoreVO vo) {
		return mapper.searchResourcesStoreOut(vo);
	}
	
	@Override
	public List<ResourcesStoreVO> findResourcesInventory(ResourcesStoreVO vo) {
		return mapper.findResourcesInventory(vo);
	}
	
	@Override
	public List<ResourcesStoreVO> resourceStoreInventory(ResourcesStoreVO vo) {
		return mapper.resourceStoreInventory(vo);
	}
	
	@Override
	public List<ResourcesStoreVO> rscStoreInv(ResourcesStoreVO vo) {
		return mapper.rscStoreInv(vo);
	}

	@Override
	public void modifyStore(ModifyVO<ResourcesStoreVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(ResourcesStoreVO vo :mvo.getCreatedRows()) {
				if(vo.getIstCnt() != "" && vo.getRscLot() == "") {
					mapper.insertResourcesInventoryIn(vo);
				}else if(vo.getOstCnt() != "" && vo.getRscLot() == "") {
					mapper.insertResourcesInventoryOut(vo);
				}else if(vo.getRscLot() != "") {
					mapper.insertResourcesStore(vo);
					mapper.updateResourcesStore(vo);
				}
			}
		}
	}

}
