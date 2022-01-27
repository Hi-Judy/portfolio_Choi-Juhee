package egov.mes.Employee.dao;

import lombok.Data;

@Data
public class EmployeeVO {
	
	String empId;			//사원번호(사원ID)
	String empName;			//사원이
	String deptName;		//부서명
	String positionName;	//직책명
	String etc;				//비고

}
