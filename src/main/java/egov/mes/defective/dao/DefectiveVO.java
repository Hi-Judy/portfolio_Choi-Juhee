package egov.mes.defective.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class DefectiveVO {
	String podtCode ;
	String codeName ;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date manDate ;
	String ordQnt ;
	String procCode ;
	String defCode ;
	String defQnt ;
	String defEtc ;
	String empId ;
	
	String fromDate ;
	String toDate ;
}
