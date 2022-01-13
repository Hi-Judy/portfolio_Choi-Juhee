package egov.mes.common.dao;

import java.util.List;

public interface CommonGroupMapper {
	
	List<CommonGroupVO> find(); //전체조회
	List<CommonGroupVO> findSelect(String groupCode); //단건조회
	int DataAdd( CommonGroupVO rsts ); //추가
	int dataUpdate ( CommonGroupVO rsts ); //수정
}
