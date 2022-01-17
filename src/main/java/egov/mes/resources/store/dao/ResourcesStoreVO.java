package egov.mes.resources.store.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
@Data
public class ResourcesStoreVO {

	String storeNo;			//자재입출고번호
	String rscCode;			//자재코드
	String istFlag;			//입고유무 Y/N
	String rscLot;			//자재LOT
	String istCnt;			//입고량
	String ostCnt;			//출고량
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date storeDate;			//입,출고 날짜
	String storeFlag;		//입/출고 구분 
	String field;			//비고
	
	String rscName;			//자재명
	String rscUnit;			//자재단위
	String rscIstCnt;		//자재 입고량
	String rscPassCnt;		//자재 합격량
	String rscPrc;			//자재 단가
	String rscTstCnt;		//입고유무
}
