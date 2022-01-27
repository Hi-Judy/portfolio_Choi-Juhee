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

	@Override
	public List<EmployeeVO> EmpAllFind() {
		
		return mapper.EmpAllFind();
	}

}
