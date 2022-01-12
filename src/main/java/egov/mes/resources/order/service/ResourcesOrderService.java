package egov.mes.resources.order.service;

import java.util.List;
import java.util.Map;

import egov.mes.resources.order.dao.ResourcesOrderVO;

public interface ResourcesOrderService {
	List<ResourcesOrderVO> find(ResourcesOrderVO vo);
	List<Map> searchRec(ResourcesOrderVO vo);
	int insertOrder(ResourcesOrderVO vo);
}
