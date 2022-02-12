package egov.mes.order.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class OrderVO {
	String ordCode ;
	String cusCode ;
	String ordStatus ;
	String codeName ;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date ordDate ;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date ordDuedate ;
	String ordDatestart ;
	String ordDateend ;
	String ordDuedatestart ;
	String ordDuedateend ;
	
	String ordNo ;
	String podtCode ;
	String ordQnt ;
	String podtQnt ;
	String manDate ;
	String podtLot ;
}
