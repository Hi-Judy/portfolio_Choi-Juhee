package egov.mes.Proc.dao;

import java.util.List;

public interface ProcessControlMapper {
	
	List<ProcessControlVO> AllFind();	 	//공정 전체조회
	List<ProcessControlVO> EmpFind(); 		//사원조회(반장만)
	List<ProcessControlVO> FacFind(); 		//설비목록 전체조회
	List<ProcessControlVO> SelectedFac(String ProcCode); 	//선택중인 설비목록 보기
	int ProcDelete (ProcessControlVO oneData);		 //process 테이블데이터 단건삭제
	int CommonDelete (ProcessControlVO oneData);	 //common_code 테이블 단건삭제
	void FacDataDelt (ProcessControlVO oneData);	 //facility_process 선택적 삭제
	
	int ProcAddData (ProcessControlVO procVO);		 //process 테이블 데이터 추가
	int CommonAddData (ProcessControlVO procVO);	 //common_code 테이블 데이터 추가
	
	void FacProcInput (ProcessControlVO procVO);	 //facility_process 테이블 데이터 추가

	void ProcChangeData (ProcessControlVO procVO); 	 //process 테이블 데이터 수정
	void CommonChangeData (ProcessControlVO procVO); //common_code 테이블 데이터 수정
}
