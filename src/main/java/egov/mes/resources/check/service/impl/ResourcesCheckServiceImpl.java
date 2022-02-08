package egov.mes.resources.check.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.resources.check.dao.ResourcesCheckMapper;
import egov.mes.resources.check.dao.ResourcesCheckVO;
import egov.mes.resources.check.service.ResourcesCheckService;
import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.rtngd.dao.ResourcesRtngdVO;
@Service
public class ResourcesCheckServiceImpl implements ResourcesCheckService{
	@Autowired ResourcesCheckMapper mapper;
	
	@Override
	public List<ResourcesCheckVO> findResourcesCheck(ResourcesCheckVO vo) {
		return mapper.findResourcesCheck(vo);
	}

	@Override
	public List<ResourcesRtngdVO> searchRtngd(ResourcesRtngdVO vo) {
		return mapper.searchRtngd(vo);
	}
	
	@Override
	public void modifyCheck(ModifyVO<ResourcesCheckVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(ResourcesCheckVO vo :mvo.getCreatedRows()) {
					mapper.insertResourcesCheck(vo);
					mapper.updateResourcesCheck(vo);
				if(!vo.getRscDefCnt().equals("0")) {
					mapper.insertResourcesRtngd(vo);	
				}
			}
		}
	}


	
}
