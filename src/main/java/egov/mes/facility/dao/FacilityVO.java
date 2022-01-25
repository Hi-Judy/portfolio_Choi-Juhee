package egov.mes.facility.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class FacilityVO {
	String facNo ;
	String facCode ;
	String facStatus ;
	String facCause ;
	String facCheckdate ;
	String checkDatestart ;
	String checkDateend ;
	String facOutput ;
	String facRuntime ;
	
	String prosCode ;
	
	String facInfono ;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date facCausedate ;
	
	String codeName ;
	
	String code ;
}
