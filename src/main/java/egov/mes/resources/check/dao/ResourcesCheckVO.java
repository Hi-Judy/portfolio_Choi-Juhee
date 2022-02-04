package egov.mes.resources.check.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
@Data
public class ResourcesCheckVO {
	String rscTstNo;		//자재입고검사번호
	String ordrNo;			//발주번호
	String rscIstCnt;		//입고량
	String rscTstCnt;		//검사량
	String rscPassCnt;		//합격량
	String rscDefCnt;		//불량량
	String defCode;
	String tstFlag;			//검사유무(Y/N)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date rscExpirationDate;		//유통기한
	
	String rscCode;		//자재코드(자재발주 테이블)
	String rscSt;		//자재상태(자재발주 테이블)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date ordeDate;		//발주일(자재발주 테이블)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date istReqDate;		//입고요청일(자재발주 테이블)
	
	String rscPrc;		//자재단가(자재 테이블)
	String rscName;		//자재명(자재 테이블)
	String rscUnit;		//자재단위(자재 테이블)
	String rscCnt;		//발주수량(자재 테이블)
	
	String rtngdNo;		//반품번호
	String rtngdCnt;	//반품량
	String rtngdDate; 	//반품일
	String rscTotal;

}
