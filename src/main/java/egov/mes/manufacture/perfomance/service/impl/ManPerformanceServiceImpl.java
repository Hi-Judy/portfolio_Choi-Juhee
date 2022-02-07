package egov.mes.manufacture.perfomance.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.perfomance.dao.ManPerformanceMapper;
import egov.mes.manufacture.perfomance.service.ManPerformanceService;

@Service("ManPerformanceService")
public class ManPerformanceServiceImpl implements ManPerformanceService {
	
	@Autowired 
	private ManPerformanceMapper mapper;

}
