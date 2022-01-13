package egov.mes.BOM.dao;

import lombok.Data;

@Data
public class ProductBomVO {
	
	//코드구분 테이블 
	String codeName;
	
	
	
	//제품 테이블(Product)
	String pName;		//제품이름
	String podtCode;	//제품코드
	String podtUnit;	//관리단위
	String podtFlag;	//제품분류
	String manFlag;		//생산구분
	
	
	//제품BOM(자재)(Prdt_bom_res)
//	String podtCode;(제품FK)
	String mName;		//자재이름
	String resCode;		//자재코드
	String resUsage;	//자재소모량
	String resEtc;		//자재비고
	
	
	//공정흐름(process_flowInfo)
//	String podtCode;(제품FK)	
	String fName;		//공정이름
	String procCode;	//공정코드
	String field;		//공정그룹코드
	String procIndex;	//공정순서
	


}
