package egov.mes.order.dao;

import java.time.LocalDate;

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
	@JsonFormat(pattern = "yyyy-MM-dd")
	LocalDate ordDate ;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	LocalDate ordDuedate ;
	
	String ordNo ;
	String podtCode ;
	String ordQnt ;
}
