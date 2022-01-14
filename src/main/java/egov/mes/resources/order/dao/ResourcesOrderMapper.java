package egov.mes.resources.order.dao;

import java.util.List;
import java.util.Map;

public interface ResourcesOrderMapper {
	List<ResourcesOrderVO> findResourcesOrder(ResourcesOrderVO vo);	//발주리스트 검색
	List<Map> searchRec(ResourcesOrderVO vo);			//자재명 검색(모달창)
	List<Map> searchSuc(ResourcesOrderVO vo);			//업체명 검색(모달창)
	int ResourcesOrder(ResourcesOrderVO vo);				//자재 발주 
}
