package egov.mes.manufacture.command.dao;

import lombok.Data;

@Data
public class ManCommandVO {
	
	String podtCode;
	String podtName;
	String ordQnt;
	String ordDuedate;
	String manPlanDate;
	String manPlanName;
	
	String writeStartDate; //작성일자
	String writeEndDate;   //작성일자
	
	
}
