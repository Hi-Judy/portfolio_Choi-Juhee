package egov.mes.manufacture.dao;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ManufacturePlanVO {

	String ordCode;
	String ordDuedate;
	String ordStatus;
	String ordQnt;
	String cusCode;
	
	String podtCode;
	String podtName;
	String resCode;
	String resUsage;
	String 재고량;
	String rscCode;
	
	String manPlanNo;
	String manPlanName;
	
	String manPlanDate;
	String planNoDetail;
	String planStartDate;
	
	String planPeriod;
	String planComplete;
	String manPerday;
	String planEtc;
	
	String startDate;
	String endDate;
	
}
