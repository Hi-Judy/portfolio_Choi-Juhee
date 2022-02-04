package egov.mes.materialmanage.dao;

import java.util.List;

import lombok.Data;

@Data
public class MaterialManageVO {
	//자자테이블
	String rscCode;		//자재코드
	String rscUnit;		//자재관리단위
	String rscPrc;		//자재단가
	String rscManCode;	//자재 관지자 코드
	String suplcomCode;	//구매업체코드
	String rscFlag;		//자재 사용여부
	
	//코드구분 테이블
	String rscName;		//자재명
	String suplcomName;	//구매업체명
	
	//자재입/출고 테이블
	String storeNo;		//자재 입/출고 번호
	String rscLot;		//입고된 자재 LOT
	String istCnt;		//자재 입고량
	String ostCnt; 		//자재 출고량
	String storeEtc;	//비고
	
	//사원테이블
	String empId;		//사원아이디
	String empName;		//사원이름
	String etc;			//사원비고
	
	//입고업체 조회
	String code;		//업체코드
	String codeName;	//업체명
	String codeEtc;		//업체 비고
	
	//자재 월별재고 조회 관련
	String month;		//월
	String carryOver;	//이월량
	String matInto;		//입고
	String matOut;		//출고	
	String checkInto;	//정산입고
	String checkOut;	//정산출고
	String matReturn;	//반품
	String matSum;		//현재고량
	String pmonth;
	List<Integer> list;

}
