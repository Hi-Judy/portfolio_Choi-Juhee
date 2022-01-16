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
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date facCheckdate ;
	String checkDatestart ;
	String checkDateend ;
	String facOutput ;
	
	String prosCode ;
	
	String facInfono ;
	Date facCuasedate ;
}
