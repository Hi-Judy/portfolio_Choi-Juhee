package egov.mes.Proc.dao;

import lombok.Data;

@Data
public class ProcessControlVO {
	
	String procCode; 	//공정코드
	String codeName;	//공정명(코드구분에서 가져온다)
	String procFlag;	//공정구분(카테고리 느낌)
	String procEmpId;	//공정관리자ID


}
