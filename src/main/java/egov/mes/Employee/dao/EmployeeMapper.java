package egov.mes.Employee.dao;

import java.util.List;

public interface EmployeeMapper {
	
	List<EmployeeVO> EmpAllFind();	//사워정보 조회
	List<EmployeeVO> IdFind(EmployeeVO empVO);  //사원ID 조건 조회
	
	void EmpAddData ( EmployeeVO empVO );		//사원정보 입력
	void UpdateDatas( EmployeeVO empVO );		//사원정보 수정

}
