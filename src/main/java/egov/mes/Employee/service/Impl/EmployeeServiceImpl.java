package egov.mes.Employee.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.Employee.dao.EmployeeMapper;
import egov.mes.Employee.dao.EmployeeVO;
import egov.mes.Employee.service.EmployeeService;


@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired EmployeeMapper mapper;
	
	//사원정보 전체조회
	@Override
	public List<EmployeeVO> EmpAllFind() {
		
		return mapper.EmpAllFind();
	}
	
	//사원ID 조건 조회
	@Override
	public List<EmployeeVO> IdFind( EmployeeVO empVO ) {
		
		return mapper.IdFind(empVO);
	}
	
	//사원정보 입력
	@Override	
	public void EmpAddData(EmployeeVO empVO) {
		mapper.EmpAddData(empVO);
		
	}
	
	//사원정보 수정
	@Override
	public void UpdateDatas(List<EmployeeVO> empVO) {
		for(EmployeeVO EmpVO : empVO) {
			System.out.println(EmpVO);
			mapper.UpdateDatas(EmpVO);
		}
		
	}

}
