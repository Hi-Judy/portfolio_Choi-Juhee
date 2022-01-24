package egov.mes.Proc.dao;

import lombok.Data;

@Data
public class ProcessControlVO {
	
	String procCode; 	//공정코드
	String codeName;	//공정명(코드구분에서 가져온다)
	String procFlag;	//공정구분(카테고리 느낌)
	String procEmpId;	//공정관리자ID
	
	String empId;		//사원ID
	String empName;		//사원이름
	String etc;			//비고
	
	String facOutput;	//공정별 평균생산량
	String facRuntime;	//공정별 시간 기준량
	
	String codeEtc;


}
