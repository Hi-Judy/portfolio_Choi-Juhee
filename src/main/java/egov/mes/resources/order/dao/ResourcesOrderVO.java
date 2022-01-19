package egov.mes.resources.order.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ResourcesOrderVO {
	String ordrNo;
	String rscCode;
	String rscCnt;
	String rscTotal;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date ordeDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date ordeDate2;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date istReqDate;	

	String sucCode;
	String rscUnit;
	String rscName;
	String sucName;
	String rscPassCnt;
	String rscDefCnt;
	String rscPrc;
	String code;
	String codeName;
	
}
