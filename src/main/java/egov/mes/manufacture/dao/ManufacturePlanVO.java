package egov.mes.manufacture.dao;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

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
	@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate manPlanDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate planNoDetail;
	@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate planStartDate;
	String planPeriod;
	String planComplete;
	String manPerday;
	String planEtc;
	
	
}
