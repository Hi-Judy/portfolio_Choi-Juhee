package egov.mes.Proc.dao;

import java.util.List;

public interface ProcessControlMapper {
	
	List<ProcessControlVO> AllFind(); //공정 전체조회
	List<ProcessControlVO> EmpFind(); //사원조회(반장만)
	int ProcDelete (ProcessControlVO oneData);		 //process 테이블데이터 단건삭제
	int CommonDelete (ProcessControlVO oneData);	 //common_code 테이블 단건삭제
	
	int ProcAddData (ProcessControlVO procVO);		 //process 테이블 데이터 추가
	int CommonAddData (ProcessControlVO procVO);	 //common_code 테이블 데이터 추가

	void ProcChangeData (ProcessControlVO procVO); 	 //process 테이블 데이터 수정
	void CommonChangeData (ProcessControlVO procVO); //common_code 테이블 데이터 수정
}
