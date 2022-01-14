package egov.mes.BOM.dao;

import lombok.Data;

@Data
public class ProductBomVO {
	
	//코드구분 테이블 
	String codeName;
	
	//자재코드
	String rscCode;
	
	
	
	//제품 테이블(Product)
	String podtCode;	//제품코드
	String podtUnit;	//관리단위
	String podtFlag;	//제품분류
	String manFlag;		//생산구분
	
	
	//제품BOM(자재)(Prdt_bom_res)
	String resCode;		//자재코드
	String resUsage;	//자재소모량
	String resEtc;		//자재비고
	
	
	//공정흐름(process_flowInfo)
	String procCode;	//공정코드
	String field;		//공정그룹코드
	String procIndex;	//공정순서
	


}
