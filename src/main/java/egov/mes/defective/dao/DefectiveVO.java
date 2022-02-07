package egov.mes.defective.dao;

import lombok.Data;

@Data
public class DefectiveVO {
	String podtCode ;
	String codeName ;
	String manDate ;
	String ordQnt ;
	String procCode ;
	String defCode ;
	String defQnt ;
	String defEtc ;
	String empId ;
	
	String fromDate ;
	String toDate ;
	
	String procName ;
	String podtName ;
	String defName ;
	
	String podtInput ;
	String comCode ;
	String manQnt ;
}
