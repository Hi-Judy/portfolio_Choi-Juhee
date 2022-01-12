package egov.mes.resources.order.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
@Data
public class ResourcesCheckVO {

	String storeNo;
	String rscCode;
	String istFlag;
	String rscLot;
	String istCnt;
	String ostCnt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date storeDate;
	String storeFlag;
	String field;
}
