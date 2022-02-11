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
	
	//자재발주 페이지에서 생산계획 조회
	@Override
	public List<ResourcesStoreVO> findResourcesPlan(ResourcesStoreVO vo) {
		return mapper.findResourcesPlan(vo);
	}

	@Override
	public void modifyStore(ModifyVO<ResourcesStoreVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(ResourcesStoreVO vo :mvo.getCreatedRows()) {
				System.out.println(vo.getStoreFlag());
				if(vo.getStoreFlag()==null) {
					System.out.println("여긴 아님");
					mapper.insertResourcesStore(vo);
					mapper.updateResourcesStore(vo);
				}else {
				if(vo.getStoreFlag().equals("정산입고")) {
					System.out.println("정산입고");
					mapper.insertResourcesInventoryIn(vo);
				}else if(vo.getStoreFlag().equals("정산출고")) {
					System.out.println("정산출고");
					mapper.insertResourcesInventoryOut(vo);
				}}
					
				
			}
		}
	}



}
