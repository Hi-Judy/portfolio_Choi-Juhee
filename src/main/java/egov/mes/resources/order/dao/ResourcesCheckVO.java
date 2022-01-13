package egov.mes.resources.order.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
@Data
public class ResourcesCheckVO {
	String rscTstNo;
	String rscCode;
	String ordrNo;
	String rscIstCnt;
	String rscTstCnt;
	String rscPassCnt;
	String rscDefCnt;
	String tstFlag;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date rscExpirationDate;
	
	String rscSt;
	
}
