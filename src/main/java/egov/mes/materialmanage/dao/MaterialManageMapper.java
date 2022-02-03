package egov.mes.materialmanage.dao;

import java.util.List;

public interface MaterialManageMapper {
	
	List<MaterialManageVO> MaterialListAllFind();	//자재 간략정보 조회
	MaterialManageVO resSearch( String RscCode );	//자재 테이블에서 단건조회
	List<MaterialManageVO> resStListSearch( String RscCode );	//자재입 출고 테이블 조건 검색
	List<MaterialManageVO> EmpFind();				//사원조회(자재반장만)
	List<MaterialManageVO> ClientFind();			//입고업체 조회
	
	void AddMat (MaterialManageVO matVO );	//자재 신규등록
	void AddCommon (MaterialManageVO matVO );	//코드구분 신규자재 등록
	
	void UpdateMat (MaterialManageVO matVO );	//자재 정보 수정





}
