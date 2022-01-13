package egov.mes.common.service;

import java.util.List;

import org.springframework.stereotype.Service;

import egov.mes.common.dao.CommonGroupVO;

@Service
public interface CommonGroupService {
	
	
	
	List<CommonGroupVO> find(); //All 조회
	List<CommonGroupVO> findSelect(String groupCode); //단건조회
	int DataAdd( List<CommonGroupVO> cgVO); //추가
	int dataUpdate ( List<CommonGroupVO> cgVO ); //수정
}
