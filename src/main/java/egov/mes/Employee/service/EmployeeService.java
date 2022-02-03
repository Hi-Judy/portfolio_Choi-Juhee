package egov.mes.Employee.service;

import java.util.List;

import egov.mes.Employee.dao.EmployeeVO;

public interface EmployeeService {	
	
	List<EmployeeVO> EmpAllFind();	//사워정보 조회
	List<EmployeeVO> IdFind( EmployeeVO empVO );  //사원ID 조건 조회
	
	void EmpAddData ( EmployeeVO empVO );		//사원정보 입력
	void UpdateDatas( List<EmployeeVO> empVO );		//사원정보 수정
}
