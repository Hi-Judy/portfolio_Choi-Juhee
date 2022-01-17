package egov.mes.resources.order.dao;

import java.util.List;
import java.util.Map;

public interface ResourcesOrderMapper {
	List<ResourcesOrderVO> findResourcesOrder(ResourcesOrderVO vo);			//발주리스트 검색
	List<Map> searchResourcesOrder(ResourcesOrderVO vo);	//발주했으나 미입고인 품목들 불러와서 수정,삭제 가능하게
	List<Map> searchRec(ResourcesOrderVO vo);								//자재명 검색(모달창)
	List<Map> searchSuc(ResourcesOrderVO vo);								//업체명 검색(모달창)
	int insertResourcesOrder(ResourcesOrderVO vo);							//자재 발주 insert
	int updateResourcesOrder(ResourcesOrderVO vo);							//자재 발주 update					
	int deleteResourcesOrder(ResourcesOrderVO vo);							//자재 발주 delete
}
