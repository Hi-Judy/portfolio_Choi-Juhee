package egov.mes.common.dao;

import lombok.Data;

@Data
public class CommonGroupVO {
	//공통그룹 조회
	String groupCode;
	String groupName;
	
	//코드구분 조회
	String code;
	String codeName;
	String codeDesct;
	String codeFlag;
	String codeEtc;
	

}
